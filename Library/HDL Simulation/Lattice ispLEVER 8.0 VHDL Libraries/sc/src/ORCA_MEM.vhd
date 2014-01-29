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
-- Simulation Library File for SC
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca5/src/RCS/ORCA_MEM.vhd,v 1.12 2005/05/19 20:34:46 pradeep Exp $ 
--

 
--
----- package mem1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE mem1 IS
--   TYPE mem_type_1 IS array (natural range <>) OF std_logic_vector(0 downto 0);
   TYPE mem_type_2 IS array (natural range <>) OF std_logic_vector(1 downto 0);
   TYPE mem_type_4 IS array (natural range <>) OF std_logic_vector(3 downto 0);
   function hex2bin_2 (hex: Character) return STD_LOGIC_VECTOR;
   FUNCTION hex2bin_4 (hex: character) RETURN std_logic_vector;
   FUNCTION init_ram (hex: string) RETURN mem_type_4;
   FUNCTION init_ram (hex: string) RETURN mem_type_2;
END mem1;
 
PACKAGE BODY mem1 IS
   function hex2bin_2 (hex: Character) return STD_LOGIC_VECTOR is
        variable result : STD_LOGIC_VECTOR (1 downto 0);
   begin
        case hex is
          when '0' =>
             result := "00";
          when '1' =>
             result := "01";
          when '2' =>
             result := "10";
          when '3' =>
             result := "11";
          when '4' =>
             result := "00";
          when '5' =>
             result := "01";
          when '6' =>
             result := "10";
          when '7' =>
             result := "11";
          when '8' =>
             result := "00";
          when '9' =>
             result := "01";
          when 'A'|'a' =>
             result := "10";
          when 'B'|'b' =>
             result := "11";
          when 'C'|'c' =>
             result := "00";
          when 'D'|'d' =>
             result := "01";
          when 'E'|'e' =>
             result := "10";
          when 'F'|'f' =>
             result := "11";
          when others =>
             null;
        end case;
        return result;
   end;

   FUNCTION hex2bin_4 (hex: character) RETURN std_logic_vector IS
        VARIABLE result : std_logic_vector (3 downto 0);
   BEGIN
        CASE hex IS
          WHEN '0' => 
             result := "0000";
          WHEN '1' => 
             result := "0001";
          WHEN '2' => 
             result := "0010";
          WHEN '3' => 
             result := "0011";
          WHEN '4' => 
             result := "0100";
          WHEN '5' => 
             result := "0101";
          WHEN '6' => 
             result := "0110";
          WHEN '7' => 
             result := "0111";
          WHEN '8' => 
             result := "1000";
          WHEN '9' => 
             result := "1001";
          WHEN 'A'|'a' => 
             result := "1010";
          WHEN 'B'|'b' => 
             result := "1011";
          WHEN 'C'|'c' => 
             result := "1100";
          WHEN 'D'|'d' => 
             result := "1101";
          WHEN 'E'|'e' => 
             result := "1110";
          WHEN 'F'|'f' => 
             result := "1111";
          WHEN others =>
             NULL;
        END CASE;
        RETURN result;
   END; 
 
   FUNCTION init_ram (hex: string) RETURN mem_type_4 IS
	-- skip 0x OF hex string
        CONSTANT length : integer := hex'length - 2;
        VARIABLE result : mem_type_4 (length-1 downto 0);
   BEGIN
        FOR i in 0 to length-1 LOOP
           result (length-1-i) := hex2bin_4 (hex(i+3));
        END LOOP;
        RETURN result;
   END;

   FUNCTION init_ram (hex: string) RETURN mem_type_2 IS
        -- skip 0x OF hex string
        CONSTANT length : integer := hex'length - 2;
        VARIABLE result : mem_type_2 (length-1 downto 0);
   BEGIN
        FOR i in 0 to length-1 LOOP
           result (length-1-i) := hex2bin_2 (hex(i+3));
        END LOOP;
        RETURN result;
   END;

END mem1;



--
----- PACKAGE mem2 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
package mem2 is
   function hex2bin (hex: String) return STD_LOGIC_VECTOR;
   function hex2bin (hex: Character) return STD_LOGIC_VECTOR;
end mem2;
 
package body mem2 is
 
   function hex2bin (hex: Character) return STD_LOGIC_VECTOR is
        variable result : STD_LOGIC_VECTOR (3 downto 0);
   begin
        case hex is
          when '0' =>
             result := "0000";
          when '1' =>
             result := "0001";
          when '2' =>
             result := "0010";
          when '3' =>
             result := "0011";
          when '4' =>
             result := "0100";
          when '5' =>
             result := "0101";
          when '6' =>
             result := "0110";
          when '7' =>
             result := "0111";
          when '8' =>
             result := "1000";
          when '9' =>
             result := "1001";
          when 'A'|'a' =>
             result := "1010";
          when 'B'|'b' =>
             result := "1011";
          when 'C'|'c' =>
             result := "1100";
          when 'D'|'d' =>
             result := "1101";
          when 'E'|'e' =>
             result := "1110";
          when 'F'|'f' =>
             result := "1111";
          when others =>
             null;
        end case;
        return result;
   end;
 
   function hex2bin (hex: String) return STD_LOGIC_VECTOR is
        -- skip 0x of hex string
        constant length : Integer := hex'length - 2;
        variable result : STD_LOGIC_VECTOR (4*length-1 downto 0);
   begin
        for i in 0 to length-1 loop
           result ((length-i)*4-1 downto (length-i-1)*4) := hex2bin(hex(i+3))
;
        end loop;
        return result;
   end;
 
end mem2;





--
----- cell rom256x1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem2.all;
 
-- entity declaration --
ENTITY rom256x1 IS
  GENERIC (
        initval : string := "0x0000000000000000000000000000000000000000000000000000000000000000");
 
  port (ad0  : IN   std_logic;
        ad1  : IN   std_logic;
        ad2  : IN   std_logic;
        ad3  : IN   std_logic;
        ad4  : IN   std_logic;
        ad5  : IN   std_logic;
        ad6  : IN   std_logic;
        ad7  : IN   std_logic;
        do0   : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom256x1 : ENTITY IS TRUE;
 
END rom256x1;
 
-- architecture body --
ARCHITECTURE v OF rom256x1 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
BEGIN
 
   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ad0, ad1, ad2, ad3, ad4, ad5, ad6, ad7)
 
     VARIABLE memory   : std_logic_vector((2**8)-1 downto 0) := hex2bin(initval);
 
BEGIN

   ------------------------
   -- functionality section
   ------------------------

      do0 <= VitalMUX (data => memory,
                         dselect => (ad7, ad6, ad5, ad4, ad3, ad2, ad1, ad0));


   end process;
 
end V; 
 

--
----- cell rom128x1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem2.all;
 
-- entity declaration --
ENTITY rom128x1 IS
  GENERIC (
        initval : string := "0x00000000000000000000000000000000");
 
  port (ad0  : IN   std_logic;
        ad1  : IN   std_logic;
        ad2  : IN   std_logic;
        ad3  : IN   std_logic;
        ad4  : IN   std_logic;
        ad5  : IN   std_logic;
        ad6  : IN   std_logic;
        do0   : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom128x1 : ENTITY IS TRUE;
 
END rom128x1;
 
-- architecture body --
ARCHITECTURE v OF rom128x1 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
BEGIN
 
   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ad0, ad1, ad2, ad3, ad4, ad5, ad6)
 
     VARIABLE memory   : std_logic_vector((2**7)-1 downto 0) := hex2bin(initval);
 
BEGIN

   ------------------------
   -- functionality section
   ------------------------

      do0 <= VitalMUX (data => memory,
                         dselect => (ad6, ad5, ad4, ad3, ad2, ad1, ad0));

   end process;
 
end V; 
 


--
----- cell rom64x1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem2.all;
 
-- entity declaration --
ENTITY rom64x1 IS
  GENERIC (
        initval : string := "0x0000000000000000");
 
  port (ad0  : IN   std_logic;
        ad1  : IN   std_logic;
        ad2  : IN   std_logic;
        ad3  : IN   std_logic;
        ad4  : IN   std_logic;
        ad5  : IN   std_logic;
        do0   : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom64x1 : ENTITY IS TRUE;
 
END rom64x1;
 
-- architecture body --
ARCHITECTURE v OF rom64x1 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
BEGIN
 
   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ad0, ad1, ad2, ad3, ad4, ad5)
 
     VARIABLE memory   : std_logic_vector((2**6)-1 downto 0) := hex2bin(initval);
 
BEGIN

   ------------------------
   -- functionality section
   ------------------------

      do0 <= VitalMUX (data => memory,
                         dselect => (ad5, ad4, ad3, ad2, ad1, ad0));

   end process;
 
end V; 
 


--
----- cell rom32x1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem2.all;
 
-- entity declaration --
ENTITY rom32x1 IS
  GENERIC (
        initval : string := "0x00000000");
 
  port (ad0  : IN   std_logic;
        ad1  : IN   std_logic;
        ad2  : IN   std_logic;
        ad3  : IN   std_logic;
        ad4  : IN   std_logic;
        do0   : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom32x1 : ENTITY IS TRUE;
 
END rom32x1;
 
-- architecture body --
ARCHITECTURE v OF rom32x1 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
BEGIN
 
   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ad0, ad1, ad2, ad3, ad4)
 
     VARIABLE memory   : std_logic_vector((2**5)-1 downto 0) := hex2bin(initval);
 
BEGIN

   ------------------------
   -- functionality section
   ------------------------

      do0 <= VitalMUX (data => memory,
                         dselect => (ad4, ad3, ad2, ad1, ad0));

   end process;
 
end V; 
 


--
----- cell rom16x1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem2.all;
 
-- entity declaration --
ENTITY rom16x1 IS
  GENERIC (
        initval : string := "0x0000");
 
  port (ad0  : IN   std_logic;
        ad1  : IN   std_logic;
        ad2  : IN   std_logic;
        ad3  : IN   std_logic;
        do0   : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom16x1 : ENTITY IS TRUE;
 
END rom16x1;

-- architecture body --
ARCHITECTURE v OF rom16x1 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
BEGIN
 
   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ad0, ad1, ad2, ad3)
 
     VARIABLE memory   : std_logic_vector((2**4)-1 downto 0) := hex2bin(initval);
 
BEGIN
 
   ------------------------
   -- functionality section
   ------------------------
 
      do0 <= VitalMUX (data => memory,
                         dselect => (ad3, ad2, ad1, ad0));
 
   end process;
 
end V;


--
----- cell rom32x4 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem1.all;
USE work.global.gsrnet;
USE work.global.purnet;

-- entity declaration --
ENTITY rom32x4 IS
  GENERIC (
        gsr    : string := "ENABLED";
        initval : string := "0x00000000000000000000000000000000");

  port (ad0  : IN std_logic;
        ad1  : IN std_logic;
        ad2  : IN std_logic;
        ad3  : IN std_logic;
        ad4  : IN std_logic;
        ck   : IN std_logic;
        do0  : OUT std_logic;
        do1  : OUT std_logic;
        do2  : OUT std_logic;
        do3  : OUT std_logic;
        qdo0 : OUT std_logic;
        qdo1 : OUT std_logic;
        qdo2 : OUT std_logic;
        qdo3 : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF rom32x4 : ENTITY IS TRUE;

END rom32x4;


-- architecture body --
ARCHITECTURE v OF rom32x4 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (purnet, gsrnet, ck, ad0, ad1, ad2, ad3, ad4)

     VARIABLE memory : mem_type_4 ((2**5)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg : std_logic_vector(4 downto 0) := "00000";
     VARIABLE rindex : integer := 0;
     VARIABLE set_reset : std_logic := '1';

     -- functionality results
     VARIABLE violation : x01 := '0';
     VARIABLE results   : std_logic_vector (7 downto 0) := (others => 'X');
     ALIAS do0_zd       : std_ulogic IS results(0);
     ALIAS do1_zd       : std_ulogic IS results(1);
     ALIAS do2_zd       : std_ulogic IS results(2);
     ALIAS do3_zd       : std_ulogic IS results(3);
     ALIAS qdo0_zd      : std_ulogic IS results(4);
     ALIAS qdo1_zd      : std_ulogic IS results(5);
     ALIAS qdo2_zd      : std_ulogic IS results(6);
     ALIAS qdo3_zd      : std_ulogic IS results(7);

   BEGIN

   ------------------------
   -- functionality section
   ------------------------
    IF (gsr =  "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

   IF (set_reset= '0') THEN
      results(7 downto 4) := "0000";
   END IF;

   IF (is_x(ad0) or is_x(ad1) or is_x(ad2)
        or is_x(ad3) or is_x(ad4)) THEN
      assert FALSE
        report "rom32x4 memory hazard address unknown!"
        severity warning;
      results := (others => 'X');
   ELSE
      -- calculate the read address
      radr_reg := (ad4, ad3, ad2, ad1, ad0);
      rindex := conv_integer(radr_reg);

      -- asynchronous and synchronous reads
      IF (violation = '0') THEN
         results(3 downto 0) := memory(rindex);
         IF ((ck'event and ck = '1') and (set_reset='1')) THEN
            results(7 downto 4) := memory(rindex);
         END IF;
      ELSE
         results := (others => 'X');
      END IF;

   END IF;

   qdo0 <= qdo0_zd;
   qdo1 <= qdo1_zd;
   qdo2 <= qdo2_zd;
   qdo3 <= qdo3_zd;
   do0 <= do0_zd;
   do1 <= do1_zd;
   do2 <= do2_zd;
   do3 <= do3_zd;

   END PROCESS;

END v;



--
----- cell dpr16x2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem1.all;
USE work.global.gsrnet;
USE work.global.purnet;

-- entity declaration --
ENTITY dpr16x2 IS
  GENERIC (
        gsr           : String := "ENABLED";
        initval : string := "0x0000000000000000");

  port (di0  : IN std_logic;
        di1  : IN std_logic;
        wck  : IN std_logic;
        wre  : IN std_logic;
        wpe  : IN std_logic;
        rad0 : IN std_logic;
        rad1 : IN std_logic;
        rad2 : IN std_logic;
        rad3 : IN std_logic;
        wad0 : IN std_logic;
        wad1 : IN std_logic;
        wad2 : IN std_logic;
        wad3 : IN std_logic;
        wdo0 : OUT std_logic;
        wdo1 : OUT std_logic;
        rdo0 : OUT std_logic;
        rdo1 : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF dpr16x2 : ENTITY IS TRUE;

END dpr16x2;


-- architecture body --
ARCHITECTURE v OF dpr16x2 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (wck, wre, wpe, wad0,
     wad1, wad2, wad3, rad0, rad1, rad2,
     rad3, di0, di1, gsrnet, purnet)

     VARIABLE memory : mem_type_2 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg, wadr_reg1 : std_logic_vector(3 downto 0) := "0000";
     VARIABLE din_reg : std_logic_vector(1 downto 0) := "00";
     VARIABLE wre_reg : std_logic := '0';
     VARIABLE rindex, windex, windex1 : integer := 0;
     VARIABLE set_reset : std_logic := '1';

     -- functionality results
     VARIABLE violation : x01 := '0';
     VARIABLE results   : std_logic_vector (3 downto 0) := (others => 'X');
     ALIAS wdo0_zd       : std_ulogic IS results(0);
     ALIAS wdo1_zd       : std_ulogic IS results(1);
     ALIAS rdo0_zd       : std_ulogic IS results(2);
     ALIAS rdo1_zd       : std_ulogic IS results(3);

   BEGIN

   ------------------------
   -- functionality section
   ------------------------
    IF (gsr =  "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

   IF (set_reset= '0') THEN
      wre_reg := '0';
      wadr_reg := "0000";
   END IF;


   IF ((is_x(wre) or is_x(wpe)) and (set_reset='1')) THEN
      assert FALSE
        report "dpr16x2 memory hazard write enable unknown!"
        severity warning;
      results := (others => 'X');
   ELSIF (is_x(rad0) or is_x(rad1) or is_x(rad2)
        or is_x(rad3)) THEN
      assert FALSE
        report "dpr16x2 memory hazard read address unknown!"
        severity warning;
      results := (others => 'X');
   ELSIF ((is_x(wad0) or is_x(wad1) or is_x(wad2)
        or is_x(wad3)) and (set_reset='1')) THEN
      assert FALSE
        report "dpr16x2 memory hazard write address unknown!"
        severity warning;
      results := (others => 'X');
   ELSE
      -- register the write address, write enables and data but not the
      -- read address
      IF ((wck'event and wck = '1') and (set_reset= '1')) THEN
         wre_reg := (wre and wpe);
         din_reg := (di1, di0);
         wadr_reg := (wad3, wad2, wad1, wad0);
      END IF;
      windex := conv_integer(wadr_reg);
      radr_reg := (rad3, rad2, rad1, rad0);
      rindex := conv_integer(radr_reg);
      wadr_reg1 := (wad3, wad2, wad1, wad0);
      windex1 := conv_integer(wadr_reg1);

      -- at the falling edge of wck, write to memory at address
      IF (wre_reg = '1') THEN
         IF (wck'event and wck = '0') THEN
             memory(windex) := din_reg;
         END IF;
      END IF;

      -- asynchronous and synchronous reads
      IF (violation = '0') THEN
         results(3 downto 2) := memory(rindex);
         results(1 downto 0) := memory(windex1);
      ELSE
         results := (others => 'X');
      END IF;
 
   END IF;

   wdo0 <= wdo0_zd;
   wdo1 <= wdo1_zd;
   rdo0 <= rdo0_zd;
   rdo1 <= rdo1_zd;

   END PROCESS;

END v;



--
----- cell spr16x2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem1.all;
USE work.global.gsrnet;
USE work.global.purnet;

-- entity declaration --
ENTITY spr16x2 IS
  GENERIC (
        gsr           : String := "ENABLED";
        initval : string := "0x0000000000000000");

  port (di0  : IN std_logic;
        di1  : IN std_logic;
        ck   : IN std_logic;
        wre  : IN std_logic;
        wpe  : IN std_logic;
        ad0  : IN std_logic;
        ad1  : IN std_logic;
        ad2  : IN std_logic;
        ad3  : IN std_logic;
        do0  : OUT std_logic;
        do1  : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF spr16x2 : ENTITY IS TRUE;

END spr16x2;


-- architecture body --
ARCHITECTURE v OF spr16x2 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ck, wre, wpe, ad0,
     ad1, ad2, ad3, di0, di1, gsrnet, purnet)

     VARIABLE memory : mem_type_2 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : std_logic_vector(3 downto 0) := "0000";
     VARIABLE din_reg : std_logic_vector(1 downto 0) := "00";
     VARIABLE wre_reg : std_logic := '0';
     VARIABLE rindex, windex : integer := 0;
     VARIABLE set_reset : std_logic := '1';

     -- functionality results
     VARIABLE violation : x01 := '0';
     VARIABLE results   : std_logic_vector (1 downto 0) := (others => 'X');
     ALIAS do0_zd       : std_ulogic IS results(0);
     ALIAS do1_zd       : std_ulogic IS results(1);

   BEGIN

   ------------------------
   -- functionality section
   ------------------------
    IF (gsr =  "DISABLED") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

   IF (set_reset= '0') THEN
      wre_reg := '0';
      wadr_reg := "0000";
   END IF;


   IF ((is_x(wre) or is_x(wpe)) and (set_reset='1')) THEN
      assert FALSE
        report "spr16x2 memory hazard write enable unknown!"
        severity warning;
      results := (others => 'X');
   ELSIF (is_x(ad0) or is_x(ad1) or is_x(ad2)
        or is_x(ad3)) THEN
      assert FALSE
        report "spr16x2 memory hazard read address unknown!"
        severity warning;
      results := (others => 'X');
   ELSE
      -- register the write address, write enables and data but not the
      -- read address
      IF ((ck'event and ck = '1') and (set_reset= '1')) THEN
         wre_reg := (wre and wpe);
         din_reg := (di1, di0);
         wadr_reg := (ad3, ad2, ad1, ad0);
      END IF;
      windex := conv_integer(wadr_reg);
      radr_reg := (ad3, ad2, ad1, ad0);
      rindex := conv_integer(radr_reg);

      -- at the falling edge of ck, write to memory at address
      IF (wre_reg = '1') THEN
         IF (ck'event and ck = '0') THEN
             memory(windex) := din_reg;
         END IF;
      END IF;

      -- asynchronous and synchronous reads
      IF (violation = '0') THEN
         results(1 downto 0) := memory(rindex);
      ELSE
         results := (others => 'X');
      END IF;
 
   END IF;

   do0 <= do0_zd;
   do1 <= do1_zd;

   END PROCESS;

END v;


