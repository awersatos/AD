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
-- Simulation Library File for XP2
--
-- $Header:  
--
 
--
----- package mem1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE mem1 IS
   TYPE mem_type_1 IS array (natural range <>) OF std_logic;
   TYPE mem_type_2 IS array (natural range <>) OF std_logic_vector(1 downto 0);
   TYPE mem_type_4 IS array (natural range <>) OF std_logic_vector(3 downto 0);
   function hex2bin_2 (hex: Character) return STD_LOGIC_VECTOR;
   FUNCTION hex2bin_4 (hex: character) RETURN std_logic_vector;
   FUNCTION init_ram (hex: string) RETURN mem_type_4;
   FUNCTION init_ram (hex: string) RETURN mem_type_2;
   FUNCTION init_ram_1 (hex: string) RETURN mem_type_1;
END mem1;
 
PACKAGE BODY mem1 IS

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

   FUNCTION init_ram_1 (hex: string) RETURN mem_type_1 IS
        -- skip 0x OF hex string
        CONSTANT length : integer := hex'length - 2;
        VARIABLE result : mem_type_1 ((4*length)-1 downto 0);
        VARIABLE result1 : std_logic_vector((4*length)-1 downto 0);
   BEGIN
        FOR i in 0 to length-1 LOOP
           result1 ((4*(length-i))-1 downto (4*(length-1-i))) := hex2bin_4 (hex(i+3));

           FOR j in 0 to 3 LOOP
             result(((4*length)-1)-j-(4*i)) := result1(((4*length)-1)-j-(4*i)); 
           END LOOP;

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
           result ((length-i)*4-1 downto (length-i-1)*4) := hex2bin(hex(i+3));
        end loop;
        return result;
   end;
 
end mem2;

--
----- package mem3 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

PACKAGE mem3 IS
   TYPE mem_type_5 IS array (Integer range <>) OF std_logic_vector(17 downto 0);
   TYPE mem_type_6 IS array (Integer range <>) OF std_logic_vector(15 downto 0);
   FUNCTION hex2bin (hex: character) RETURN std_logic_vector;
   FUNCTION str3_slv12 (hex: string) RETURN std_logic_vector;
   FUNCTION data2data (data_w: integer) RETURN integer;
   FUNCTION data2addr_w (data_w: integer) RETURN integer;
   FUNCTION data2data_w (data_w: integer) RETURN integer;
   FUNCTION init_ram (hex: string) RETURN std_logic_vector;
   FUNCTION init_ram1 (hex: string) RETURN mem_type_6;
   FUNCTION str2slv (str: in string) RETURN std_logic_vector;
   FUNCTION Valid_Address (IN_ADDR : in std_logic_vector) return boolean;
END mem3;
PACKAGE BODY mem3 IS

   FUNCTION hex2bin (hex: character) RETURN std_logic_vector IS
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
          WHEN 'X'|'x' =>
             result := "XXXX";
          WHEN others =>
             NULL;
        END CASE;
        RETURN result;
   END;

   FUNCTION str5_slv18 (s : string(5 downto 1)) return std_logic_vector is
        VARIABLE result : std_logic_vector(17 downto 0);
   BEGIN
       FOR i in 0 to 3 LOOP
          result(((i+1)*4)-1 downto (i*4)) := hex2bin(s(i+1));
       END LOOP;
          result(17 downto 16) := hex2bin(s(5))(1 downto 0);
       RETURN result;
   END;

   FUNCTION str4_slv16 (s : string(4 downto 1)) return std_logic_vector is
        VARIABLE result : std_logic_vector(15 downto 0);
   BEGIN
       FOR i in 0 to 3 LOOP
          result(((i+1)*4)-1 downto (i*4)) := hex2bin(s(i+1));
       END LOOP;
       RETURN result;
   END;

   FUNCTION str3_slv12 (hex: string) return std_logic_vector is
        VARIABLE result : std_logic_vector(11 downto 0);
   BEGIN
       FOR i in 0 to 2 LOOP
          result(((i+1)*4)-1 downto (i*4)) := hex2bin(hex(i+1));
       END LOOP;
       RETURN result;
   END;

   FUNCTION data2addr_w (data_w : integer) return integer is
        VARIABLE result : integer;
   BEGIN
        CASE data_w IS
          WHEN 1 =>
             result := 14;
          WHEN 2 =>
             result := 13;
          WHEN 4 =>
             result := 12;
          WHEN 9 =>
             result := 11;
          WHEN 18 =>
             result := 10;
          WHEN 36 =>
             result := 9;
          WHEN others =>
             NULL;
        END CASE;
       RETURN result;
   END;

   FUNCTION data2data_w (data_w : integer) return integer is
        VARIABLE result : integer;
   BEGIN
        CASE data_w IS
          WHEN 1 =>
             result := 1;
          WHEN 2 =>
             result := 2;
          WHEN 4 =>
             result := 4;
          WHEN 9 =>
             result := 9;
          WHEN 18 =>
             result := 18;
          WHEN 36 =>
             result := 18;
          WHEN others =>
             NULL;
        END CASE;
       RETURN result;
   END;

   FUNCTION data2data (data_w : integer) return integer is
        VARIABLE result : integer;
   BEGIN
        CASE data_w IS
          WHEN 1 =>
             result := 8;
          WHEN 2 =>
             result := 4;
          WHEN 4 =>
             result := 2;
          WHEN 9 =>
             result := 36864;
          WHEN 18 =>
             result := 36864;
          WHEN 36 =>
             result := 36864;
          WHEN others =>
             NULL;
        END CASE;
       RETURN result;
   END;


   FUNCTION init_ram (hex: string) RETURN std_logic_vector IS
        CONSTANT length : integer := hex'length;
        VARIABLE result1 : mem_type_5 (0 to ((length/5)-1));
        VARIABLE result : std_logic_vector(((length*18)/5)-1 downto 0);
   BEGIN
       FOR i in 0 to ((length/5)-1) LOOP
         result1(i) := str5_slv18(hex((i+1)*5 downto (i*5)+1));
       END LOOP;
       FOR j in 0 to 1023 LOOP
         result(((j*18) + 17) downto (j*18)) := result1(j)(17 downto 0);
       END LOOP;
       RETURN result;
   END;

   FUNCTION init_ram1 (hex: string) RETURN mem_type_6 IS
        CONSTANT length : integer := hex'length;
        VARIABLE result : mem_type_6 (0 to ((length/4)-1));
   BEGIN
       FOR i in 0 to ((length/4)-1) LOOP
         result(i) := str4_slv16(hex((i+1)*4 downto (i*4)+1));
       END LOOP;
       RETURN result;
   END;

-- String to std_logic_vector

  FUNCTION str2slv (
      str : in string
  ) return std_logic_vector is

  variable j : integer := str'length;
  variable slv : std_logic_vector (str'length downto 1);

  begin
      for i in str'low to str'high loop
          case str(i) is
              when '0' => slv(j) := '0';
              when '1' => slv(j) := '1';
              when 'X' => slv(j) := 'X';
              when 'U' => slv(j) := 'U';
              when others => slv(j) := 'X';
          end case;
          j := j - 1;
      end loop;
      return slv;
  end str2slv;

function Valid_Address (
    IN_ADDR : in std_logic_vector
 ) return boolean is

    variable v_Valid_Flag : boolean := TRUE;

begin

    for i in IN_ADDR'high downto IN_ADDR'low loop
        if (IN_ADDR(i) /= '0' and IN_ADDR(i) /= '1') then
            v_Valid_Flag := FALSE;
        end if;
    end loop;

    return v_Valid_Flag;
end Valid_Address;

END mem3 ;

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
----- cell dpr16x4a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem1.all;

-- entity declaration --
ENTITY dpr16x4a IS

  port (di0  : IN std_logic;
        di1  : IN std_logic;
        di2  : IN std_logic;
        di3  : IN std_logic;
        wck  : IN std_logic;
        wre  : IN std_logic;
        rad0 : IN std_logic;
        rad1 : IN std_logic;
        rad2 : IN std_logic;
        rad3 : IN std_logic;
        wad0 : IN std_logic;
        wad1 : IN std_logic;
        wad2 : IN std_logic;
        wad3 : IN std_logic;
        do0 : OUT std_logic;
        do1 : OUT std_logic;
        do2 : OUT std_logic;
        do3 : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF dpr16x4a : ENTITY IS TRUE;

END dpr16x4a;


-- architecture body --
ARCHITECTURE v OF dpr16x4a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (wck, wre, wad0, wad1, wad2, wad3, rad0, rad1, rad2, rad3,
                            di0, di1, di2, di3)

     VARIABLE memory : mem_type_4 ((2**4)-1 downto 0);
     VARIABLE radr_reg, wadr_reg : std_logic_vector(3 downto 0) := "0000";
     VARIABLE din_reg : std_logic_vector(3 downto 0) := "0000";
     VARIABLE wre_reg : std_logic := '0';
     VARIABLE rindex, windex : integer := 0;
     VARIABLE set_reset : std_logic := '1';

     -- functionality results
     VARIABLE violation : x01 := '0';
     VARIABLE results   : std_logic_vector (3 downto 0) := (others => 'X');
     ALIAS do0_zd       : std_ulogic IS results(0);
     ALIAS do1_zd       : std_ulogic IS results(1);
     ALIAS do2_zd       : std_ulogic IS results(2);
     ALIAS do3_zd       : std_ulogic IS results(3);

   BEGIN

   ------------------------
   -- functionality section
   ------------------------

   IF (is_x(wre) and (set_reset='1')) THEN
      if (wck'event and wck = '1') then
         assert FALSE
           report "dpr16x4a memory hazard write enable unknown!"
           severity warning;
         results := (others => 'X');
      end if;
   ELSIF (is_x(rad0) or is_x(rad1) or is_x(rad2) or is_x(rad3)) THEN
--      assert FALSE
--        report "dpr16x4a memory hazard read address unknown!"
--        severity warning;
      results := (others => 'X');
   ELSIF ((is_x(wad0) or is_x(wad1) or is_x(wad2) or is_x(wad3)) and (set_reset='1')) THEN
      if (wck'event and wck = '1') then
         assert FALSE
           report "dpr16x4a memory hazard write address unknown!"
           severity warning;
         results := (others => 'X');
      end if;
   ELSE
      -- register the write address, write enables and data but not the
      -- read address
      IF ((wck'event and wck = '1') and (set_reset= '1')) THEN
         wre_reg := (wre);
         din_reg := (di3, di2, di1, di0);
         wadr_reg := (wad3, wad2, wad1, wad0);
      END IF;
      windex := conv_integer(wadr_reg);
      radr_reg := (rad3, rad2, rad1, rad0);
      rindex := conv_integer(radr_reg);

      IF (wre_reg = '1') THEN
         IF (wck'event and wck = '1') THEN
             memory(windex) := din_reg;
         END IF;
      END IF;

      -- asynchronous reads
      IF (violation = '0') THEN
         results(3 downto 0) := memory(rindex);
      ELSE
         results := (others => 'X');
      END IF;

   END IF;

   do0 <= do0_zd;
   do1 <= do1_zd;
   do2 <= do2_zd;
   do3 <= do3_zd;

   END PROCESS;

END v;


--
----- cell spr16x4a -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem1.all;

-- entity declaration --
ENTITY spr16x4a IS

  port (di0  : IN std_logic;
        di1  : IN std_logic;
        di2  : IN std_logic;
        di3  : IN std_logic;
        ck  : IN std_logic;
        wre  : IN std_logic;
        ad0 : IN std_logic;
        ad1 : IN std_logic;
        ad2 : IN std_logic;
        ad3 : IN std_logic;
        do0 : OUT std_logic;
        do1 : OUT std_logic;
        do2 : OUT std_logic;
        do3 : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF spr16x4a : ENTITY IS TRUE;

END spr16x4a;


-- architecture body --
ARCHITECTURE v OF spr16x4a IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ck, wre, ad0, ad1, ad2, ad3, di0, di1, di2, di3)

     VARIABLE memory : mem_type_4 ((2**4)-1 downto 0);
     VARIABLE radr_reg, wadr_reg : std_logic_vector(3 downto 0) := "0000";
     VARIABLE din_reg : std_logic_vector(3 downto 0) := "0000";
     VARIABLE wre_reg : std_logic := '0';
     VARIABLE rindex, windex : integer := 0;
     VARIABLE set_reset : std_logic := '1';

     -- functionality results
     VARIABLE violation : x01 := '0';
     VARIABLE results   : std_logic_vector (3 downto 0) := (others => 'X');
     ALIAS do0_zd       : std_ulogic IS results(0);
     ALIAS do1_zd       : std_ulogic IS results(1);
     ALIAS do2_zd       : std_ulogic IS results(2);
     ALIAS do3_zd       : std_ulogic IS results(3);

   BEGIN

   ------------------------
   -- functionality section
   ------------------------

   IF (is_x(wre) and (set_reset='1')) THEN
      if (ck'event and ck = '1') then
         assert FALSE
           report "spr16x4a memory hazard write enable unknown!"
           severity warning;
         results := (others => 'X');
      end if;
   ELSIF (is_x(ad0) or is_x(ad1) or is_x(ad2) or is_x(ad3)) THEN
--      assert FALSE
--        report "spr16x4a memory hazard read address unknown!"
--        severity warning;
      results := (others => 'X');
   ELSE
      -- register the write address, write enables and data but not the
      -- read address
      IF ((ck'event and ck = '1') and (set_reset= '1')) THEN
         wre_reg := (wre);
         din_reg := (di3, di2, di1, di0);
         wadr_reg := (ad3, ad2, ad1, ad0);
      END IF;
      windex := conv_integer(wadr_reg);
      radr_reg := (ad3, ad2, ad1, ad0);
      rindex := conv_integer(radr_reg);

      IF (wre_reg = '1') THEN
         IF (ck'event and ck = '1') THEN
             memory(windex) := din_reg;
         END IF;
      END IF;

      -- asynchronous reads
      IF (violation = '0') THEN
         results(3 downto 0) := memory(rindex);
      ELSE
         results := (others => 'X');
      END IF;

   END IF;

   do0 <= do0_zd;
   do1 <= do1_zd;
   do2 <= do2_zd;
   do3 <= do3_zd;

   END PROCESS;

END v;


--
----- cell dpr16x4b -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem1.all;

-- entity declaration --
ENTITY dpr16x4b IS
  GENERIC (

        initval : string := "0x0000000000000000"
  );

  port (di0  : IN std_logic;
        di1  : IN std_logic;
        di2  : IN std_logic;
        di3  : IN std_logic;
        wck  : IN std_logic;
        wre  : IN std_logic;
        rad0 : IN std_logic;
        rad1 : IN std_logic;
        rad2 : IN std_logic;
        rad3 : IN std_logic;
        wad0 : IN std_logic;
        wad1 : IN std_logic;
        wad2 : IN std_logic;
        wad3 : IN std_logic;
        do0 : OUT std_logic;
        do1 : OUT std_logic;
        do2 : OUT std_logic;
        do3 : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF dpr16x4b : ENTITY IS TRUE;

END dpr16x4b;


-- architecture body --
ARCHITECTURE v OF dpr16x4b IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (wck, wre, wad0, wad1, wad2, wad3, rad0, rad1, rad2, rad3,
                            di0, di1, di2, di3)

     VARIABLE memory : mem_type_4 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : std_logic_vector(3 downto 0) := "0000";
     VARIABLE din_reg : std_logic_vector(3 downto 0) := "0000";
     VARIABLE wre_reg : std_logic := '0';
     VARIABLE rindex, windex : integer := 0;
     VARIABLE set_reset : std_logic := '1';

     -- functionality results
     VARIABLE violation : x01 := '0';
     VARIABLE results   : std_logic_vector (3 downto 0) := (others => 'X');
     ALIAS do0_zd       : std_ulogic IS results(0);
     ALIAS do1_zd       : std_ulogic IS results(1);
     ALIAS do2_zd       : std_ulogic IS results(2);
     ALIAS do3_zd       : std_ulogic IS results(3);

   BEGIN

   ------------------------
   -- functionality section
   ------------------------

   IF (is_x(wre) and (set_reset='1')) THEN
      if (wck'event and wck = '1') then
         assert FALSE
           report "dpr16x4b memory hazard write enable unknown!"
           severity warning;
         results := (others => 'X');
      end if;
   ELSIF (is_x(rad0) or is_x(rad1) or is_x(rad2) or is_x(rad3)) THEN
--      assert FALSE
--        report "dpr16x4b memory hazard read address unknown!"
--        severity warning;
      results := (others => 'X');
   ELSIF ((is_x(wad0) or is_x(wad1) or is_x(wad2) or is_x(wad3))
			and (set_reset='1')) THEN
      if (wck'event and wck = '1') then
         assert FALSE
           report "dpr16x4b memory hazard write address unknown!"
           severity warning;
         results := (others => 'X');
      end if;
   ELSE
      -- register the write address, write enables and data but not the
      -- read address
      IF ((wck'event and wck = '1') and (set_reset= '1')) THEN
         wre_reg := (wre);
         din_reg := (di3, di2, di1, di0);
         wadr_reg := (wad3, wad2, wad1, wad0);
      END IF;
      windex := conv_integer(wadr_reg);
      radr_reg := (rad3, rad2, rad1, rad0);
      rindex := conv_integer(radr_reg);

      IF (wre_reg = '1') THEN
         IF (wck'event and wck = '1') THEN
             memory(windex) := din_reg;
         END IF;
      END IF;

      -- asynchronous reads
      IF (violation = '0') THEN
         results(3 downto 0) := memory(rindex);
      ELSE
         results := (others => 'X');
      END IF;

   END IF;

   do0 <= do0_zd;
   do1 <= do1_zd;
   do2 <= do2_zd;
   do3 <= do3_zd;

   END PROCESS;

END v;


--
----- cell spr16x4b -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem1.all;

-- entity declaration --
ENTITY spr16x4b IS
  GENERIC (

        initval : string := "0x0000000000000000"
);

  port (di0  : IN std_logic;
        di1  : IN std_logic;
        di2  : IN std_logic;
        di3  : IN std_logic;
        ck  : IN std_logic;
        wre  : IN std_logic;
        ad0 : IN std_logic;
        ad1 : IN std_logic;
        ad2 : IN std_logic;
        ad3 : IN std_logic;
        do0 : OUT std_logic;
        do1 : OUT std_logic;
        do2 : OUT std_logic;
        do3 : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF spr16x4b : ENTITY IS TRUE;

END spr16x4b;


-- architecture body --
ARCHITECTURE v OF spr16x4b IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ck, wre, ad0, ad1, ad2, ad3, di0, di1, di2, di3) 

     VARIABLE memory : mem_type_4 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : std_logic_vector(3 downto 0) := "0000";
     VARIABLE din_reg : std_logic_vector(3 downto 0) := "0000";
     VARIABLE wre_reg : std_logic := '0';
     VARIABLE rindex, windex : integer := 0;
     VARIABLE set_reset : std_logic := '1';

     -- functionality results
     VARIABLE violation : x01 := '0';
     VARIABLE results   : std_logic_vector (3 downto 0) := (others => 'X');
     ALIAS do0_zd       : std_ulogic IS results(0);
     ALIAS do1_zd       : std_ulogic IS results(1);
     ALIAS do2_zd       : std_ulogic IS results(2);
     ALIAS do3_zd       : std_ulogic IS results(3);

   BEGIN

   ------------------------
   -- functionality section
   ------------------------

   IF (is_x(wre) and (set_reset='1')) THEN
      if (ck'event and ck = '1') then
         assert FALSE
           report "spr16x4b memory hazard write enable unknown!"
           severity warning;
         results := (others => 'X');
      end if;
   ELSIF (is_x(ad0) or is_x(ad1) or is_x(ad2) or is_x(ad3)) THEN
--      assert FALSE
--        report "spr16x4b memory hazard read address unknown!"
--        severity warning;
      results := (others => 'X');
   ELSE
      -- register the write address, write enables and data but not the
      -- read address
      IF ((ck'event and ck = '1') and (set_reset= '1')) THEN
         wre_reg := (wre);
         din_reg := (di3, di2, di1, di0);
         wadr_reg := (ad3, ad2, ad1, ad0);
      END IF;
      windex := conv_integer(wadr_reg);
      radr_reg := (ad3, ad2, ad1, ad0);
      rindex := conv_integer(radr_reg);

      IF (wre_reg = '1') THEN
         IF (ck'event and ck = '1') THEN
             memory(windex) := din_reg;
         END IF;
      END IF;

      -- asynchronous reads
      IF (violation = '0') THEN
         results(3 downto 0) := memory(rindex);
      ELSE
         results := (others => 'X');
      END IF;

   END IF;

   do0 <= do0_zd;
   do1 <= do1_zd;
   do2 <= do2_zd;
   do3 <= do3_zd;

   END PROCESS;

END v;

