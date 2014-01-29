-- -------------------------------------------------------------------- 
-- >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<< 
-- -------------------------------------------------------------------- 
-- Copyright (c) 2001 by Lattice Semiconductor Corporation 
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
---------------------------------------------------------------------------
------------------------ JEDEC TO VHDL PRIMITIVES -------------------------
------------------------------- VERSION 1.30c -----------------------------
---------------------------------------------------------------------------
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE std.textio.all;

PACKAGE j2svlib IS

function g_delay (
		  data: STD_LOGIC;
		  tphl, tplh: TIME) 
		return TIME;

--
--
procedure g_bufif0 (
	        signal dout :  out STD_LOGIC;
	        signal data   :  in  STD_LOGIC;
	        signal enable :  in  STD_LOGIC;
             	tpLH   :  in  TIME;
	     	tpHL   :  in  TIME);
--
--
procedure g_bufif1 (
	        signal dout :  out STD_LOGIC;
	        signal data   :  in  STD_LOGIC;
	        signal enable :  in  STD_LOGIC;
             	tpLH   :  in  TIME;
	     	tpHL   :  in  TIME);
--
--
procedure g_notif0 (
	        signal dout_b :  out STD_LOGIC;
	        signal data   :  in  STD_LOGIC;
	        signal enable :  in  STD_LOGIC;
             	tpLH   :  in  TIME;
	     	tpHL   :  in  TIME);
--
--
procedure g_notif1 (
	        signal dout_b :  out STD_LOGIC;
	        signal data   :  in  STD_LOGIC;
	        signal enable :  in  STD_LOGIC;
             	tpLH   :  in  TIME;
	     	tpHL   :  in  TIME);
--
--
-- D type flip flop
--    positive edge triggered
--    async. clear  preset(active high) 
--
   PROCEDURE g_dff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;   
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;   
      t_clkout	        :  in  	 TIME);
--
--
-- D type flip flop
--    positive edge triggered
--    async. clear (active high)
--
   PROCEDURE g_dff_spar (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      SIGNAL   din      :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;
      SIGNAL   clear    :  IN    STD_LOGIC;
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;
      t_clkout          :  in    TIME;
      t_reset           :  in    TIME);
--
--
-- D type flip flop
--    positive edge triggered
--    async. clear and preset (active high)
--
   PROCEDURE g_dffpc (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;
      SIGNAL   clear    :  IN    STD_LOGIC;
      SIGNAL   pwrupstate    :  IN    STD_LOGIC);
--
--
   PROCEDURE g_dffa (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;
      SIGNAL   clear    :  IN    STD_LOGIC;
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;
      t_clkout          :  in    TIME);
--
--
-- JK flip flop
--    positive edge triggered
--    async. clear and preset (active high)
--
   PROCEDURE g_jkff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      SIGNAL   j        :  IN    STD_LOGIC;
      SIGNAL   k        :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;
      SIGNAL   clear    :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;
      t_clkout          :  in    TIME);
--
--
-- T flip flop
--    positive edge triggered
--    async. clear and preset (active high)
--
   PROCEDURE g_tff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      SIGNAL   t        :  IN    STD_LOGIC;   
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;   
      t_clkout	        :  in  	 TIME);
--
--
-- RS flip flop
--    negative edge triggered
--    async. clear and preset (active high)
--
   PROCEDURE g_rsff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      SIGNAL   s        :  IN    STD_LOGIC;
      SIGNAL   r        :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;
      SIGNAL   clear    :  IN    STD_LOGIC;
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;
      t_clkout          :  in    TIME);
--
--
   PROCEDURE g_maxff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;
      SIGNAL   clear    :  IN    STD_LOGIC;
      SIGNAL   pwrupstate :  IN  STD_LOGIC;
      t_clkout          :  IN    TIME);
--
--
   PROCEDURE g_lff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;   
      SIGNAL   gate     :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate :  IN  STD_LOGIC;   
      t_clkout	        :  in  	 TIME);
--
--
   PROCEDURE g_lffa (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;   
      SIGNAL   gate     :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate :  IN  STD_LOGIC;   
      t_clkout	        :  in  	 TIME);
--
--
   PROCEDURE g_lffh (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;
      SIGNAL   gate     :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;
      SIGNAL   clear    :  IN    STD_LOGIC;
      SIGNAL   pwrupstate :  IN  STD_LOGIC;
      t_clkout          :  in    TIME);
--
--
   PROCEDURE g_raff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;
      SIGNAL   clear    :  IN    STD_LOGIC;
      SIGNAL   pwrupstate :  IN  STD_LOGIC;
      t_clkout          :  IN    TIME);
--
--
function g_smux2 (
                signal i0   : STD_LOGIC;
                signal i1   : STD_LOGIC;
                signal s0   : STD_LOGIC;
                tpLH   :  TIME;
                tpHL   :  TIME)
                RETURN STD_LOGIC;
 
--
--
procedure g_smux (
                signal dout :  out STD_LOGIC;
                signal i0   :  in  STD_LOGIC;
                signal i1   :  in  STD_LOGIC;
                signal i2   :  in  STD_LOGIC;
                signal i3   :  in  STD_LOGIC;
                signal s0   :  in  STD_LOGIC;
                signal s1   :  in  STD_LOGIC;
                tpLH   :  in  TIME;
                tpHL   :  in  TIME);
--
--
procedure g_jkdff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      SIGNAL   ji       :  IN    STD_LOGIC;
      SIGNAL   ki       :  IN    STD_LOGIC;
      SIGNAL   jf       :  IN    STD_LOGIC;
      SIGNAL   kf       :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   ld       :  IN    STD_LOGIC;
      SIGNAL   sel      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;
      SIGNAL   clear    :  IN    STD_LOGIC;
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;
      t_clkout          :  in    TIME);
--
--
procedure g_vxff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      SIGNAL   din      :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;
      SIGNAL   clear    :  IN    STD_LOGIC;
      SIGNAL   qsel     :  IN    STD_LOGIC;
      SIGNAL   osel     :  IN    STD_LOGIC;
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;
      t_clkout          :  in    TIME);
--
--
   PROCEDURE p_chksuho (
      SIGNAL   data     :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      t_setup           :  IN     TIME;
      t_hold            :  IN     TIME;
      t_clk             :  INOUT  TIME;
      t_data            :  INOUT  TIME;
      setname           :  IN     STRING);
--
--
   PROCEDURE p_chksuho_hl (
      SIGNAL   data     :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      t_setup           :  IN     TIME;
      t_hold            :  IN     TIME;
      t_clk             :  INOUT  TIME;
      t_data            :  INOUT  TIME;
      setname           :  IN     STRING);
--
--
function bitunknown(
		  data: STD_LOGIC)
		return BOOLEAN;
--
--
function bitz(
	   s: STD_LOGIC)
		return BOOLEAN;
--
--
function bitx(
	   data: STD_LOGIC)
		return BOOLEAN;
--
--
function pchanging(
	    signal s: STD_LOGIC)
	  return BOOLEAN;

--
-----------------------------------------------------------------------
-----------------------------------------------------------------------
---
   procedure put              (s: in string);
---
   procedure putline          (s: in string);
---
   procedure put              (s: in string; t: in time);
---
   procedure putline          (s: in string; t: in time);
---
   procedure put              (s: in string; st: in string);
---
   procedure putline          (s: in string; st: in string);
---
PROCEDURE jedsim(
      VARIABLE SIMERR	:  OUT   BOOLEAN;
      CONSTANT SILENT_MODE	:  IN   BOOLEAN;
      SIGNAL ports      :  INOUT std_logic_vector;
      variable l	:  IN line);

END j2svlib;
------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------
--
--
PACKAGE BODY j2svlib IS
--
--
procedure g_bufif0 (
	        signal dout   :  out STD_LOGIC;
   	     	signal data   :  in  STD_LOGIC;
	        signal enable :  in  STD_LOGIC;
             	tpLH   :  in  TIME;
	     	tpHL   :  in  TIME)
   is
   begin
       case (enable) is
         when '1' => dout <= 'Z' AFTER g_delay (data,tpLH,tpHL);
         when '0' => dout <= data AFTER g_delay (data,tpLH,tpHL);
         when others => dout <= 'X' AFTER g_delay (data,tpLH,tpHL);
       end case;

end g_bufif0;
--
procedure g_bufif1 (
	        signal dout   :  out STD_LOGIC;
   	     	signal data   :  in  STD_LOGIC;
	        signal enable :  in  STD_LOGIC;
             	tpLH   :  in  TIME;
	     	tpHL   :  in  TIME)
   is
   begin
       case (enable) is
         when '0' => dout <= 'Z' AFTER g_delay (data,tpLH,tpHL);
         when '1' => dout <= data AFTER g_delay (data,tpLH,tpHL);
         when others => dout <= 'X' AFTER g_delay (data,tpLH,tpHL);
       end case;

end g_bufif1;
--
procedure g_notif1 (
	        signal dout_b :  out STD_LOGIC;
   	     	signal data   :  in  STD_LOGIC;
	        signal enable :  in  STD_LOGIC;
             	tpLH   :  in  TIME;
	     	tpHL   :  in  TIME)
   is
   begin
dout_b <= NOT(data) AFTER g_delay (data,tpLH,tpHL);
       case (enable) is
         when '0' => dout_b <= 'Z' AFTER g_delay (data,tpLH,tpHL);
         when '1' => dout_b <= (NOT(data)) AFTER g_delay (data,tpLH,tpHL);
         when others => dout_b <= 'X';-- AFTER g_delay (data,tpLH,tpHL);
       end case;

end g_notif1;
--
--
procedure g_notif0 (
	        signal dout_b :  out STD_LOGIC;
   	     	signal data   :  in  STD_LOGIC;
	        signal enable :  in  STD_LOGIC;
             	tpLH   :  in  TIME;
	     	tpHL   :  in  TIME)
   is
   begin
       case (enable) is
         when '1' => dout_b <= 'Z' AFTER g_delay (data,tpLH,tpHL);
         when '0' => dout_b <= not(data) AFTER g_delay (data,tpLH,tpHL);
         when others => dout_b <= 'X';-- AFTER g_delay (data,tpLH,tpHL);
       end case;

end g_notif0;
--
--
function g_delay (
		data: STD_LOGIC; 
		tphl, tplh: TIME) 
   RETURN TIME IS
      VARIABLE delay: TIME:= 0 ns;
      BEGIN
         if (data = '1') then delay := tphl;
         else delay := tplh;
         end if;
      return delay;
END g_delay;
--
--
--
-- D type flip flop
--    positive edge triggered
--    sync. preset (active high) 
--    async. clear (active high) 
--
   PROCEDURE g_dff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;   
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;   
      t_clkout	        :  in  	 TIME)
   IS 
	
   BEGIN

      IF (not( now > 0 ns) ) THEN
	q <= pwrupstate; -- Power up state
      END IF;

      ASSERT not( rising_edge(clk) and pchanging(clear))
         REPORT "On g_dff: Clk and Clear both changing - Clk action suppressed";

      ASSERT not( rising_edge(clk) and pchanging(preset))
         REPORT "On g_dff: Clk and preset both changing - Clk action suppressed";

      IF (clear) = '1' THEN
         q <= '0';
      ELSIF (preset) = '1' THEN
         q <= '1';
      ELSIF bitunknown(clear) and not(q = '0') THEN
         q <= 'X';
      ELSIF bitunknown(preset) and not(q = '1') THEN
         q <= 'X';
      ELSIF (bitunknown(clk) and not(q = data)) THEN
         q <= 'X';
      ELSIF (rising_edge(clk) and not(pchanging(clear)) and not(pchanging(preset))) THEN
         q <= (data and data) after t_clkout;
            -- NOTE: The AND in the above lines handles the case where 
            --       data is a Z.  We want Q to be assigned to X.

      END IF;
      qb <= not(q);
      --
   END g_dff;
--
--
--
-- D type flip flop
--    positive edge triggered
--    async. clear and preset (active high)
--
   PROCEDURE g_dffpc (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb        :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;   
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate    :  IN    STD_LOGIC)   
   IS 

   BEGIN
      ASSERT not( rising_edge(clk) and pchanging(preset))
         REPORT "On g_dffpc: Clk and Preset both changing - Clk action suppressed";

      ASSERT not( rising_edge(clk) and pchanging(clear))
         REPORT "On g_dffpc: Clk and Clear both changing - Clk action suppressed";

--      ASSERT not( falling_edge(clear) and falling_edge(preset))
--         REPORT "On g_dffpc: Preset and clear both released at same time";

      IF (rising_edge(pwrupstate)) THEN
	 q <= '0';
      ELSIF (clear) /= '0' AND (preset) /= '0' THEN 
         q <= 'X';
      ELSIF (preset) = '1' AND (clear) = '0' THEN
         q <= '1';
      ELSIF (clear) = '1' AND (preset) = '0' THEN
         q <= '0';
--    ELSIF (falling_edge(clear) and falling_edge(preset)) THEN
--       q <= 'X';
      ELSIF (bitunknown(preset) and not(q = '1')) THEN
         q <= 'X';
      ELSIF (bitunknown(clear) and not(q = '0')) THEN
         q <= 'X';
      ELSIF (bitunknown(clk) and not(q = data)) THEN
         q <= 'X';
      ELSIF bitz(clk) THEN
         q <= (data and data);
      ELSIF (rising_edge(clk) and not(pchanging(clear) or pchanging(preset))) THEN
         q <= (data and data);
            -- NOTE: The AND in the above lines handles the case where 
            --       data is a Z.  We want Q to be assigned to X.
      END IF;
      qb <= not(q);
END g_dffpc;
--
--
-- D type flip flop
--    positive edge triggered
--    sync. preset (active high) 
--    async. clear (active high) 
--
   PROCEDURE g_dff_spar (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      SIGNAL   din      :  IN    STD_LOGIC;   
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;   
      t_clkout	        :  in  	 TIME;
      t_reset		:  in	 TIME)
   IS 
	
   variable data   : STD_LOGIC;

   BEGIN

      IF (not( now > 0 ns) ) THEN
	q <= pwrupstate; -- Power up state
      END IF;

      ASSERT not( rising_edge(clk) and pchanging(clear))
         REPORT "On g_dff_spar: Clk and Clear both changing - Clk action suppressed";
      IF (clear = '1') THEN
         q <= '0' after t_reset;
      ELSIF (bitx(clear) and not(q = '0')) THEN
         q <= 'X';
      ELSIF (bitx(clk) and not(q = data)) THEN
         q <= 'X';
      ELSIF bitz(clk) THEN
         data := din OR preset;
      ELSIF (rising_edge(clk) and not(pchanging(clear))) THEN
         data := din OR preset;
         q <= (data and data) after t_clkout;
            -- NOTE: The AND in the above lines handles the case where 
            --       data is a Z.  We want Q to be assigned to X.

      END IF;
      Qb <= not(q);
      --
   END g_dff_spar;
--
--
--
   PROCEDURE g_dffa (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb        :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;   
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate :  IN  STD_LOGIC;  
      t_clkout	        :  in  	 TIME)
   IS 

   BEGIN
      ASSERT not( rising_edge(clk) and pchanging(preset))
         REPORT "On g_dffpc: Clk and Preset both changing - Clk action suppressed";

      ASSERT not( rising_edge(clk) and pchanging(clear))
         REPORT "On g_dffpc: Clk and Clear both changing - Clk action suppressed";

--      ASSERT not( falling_edge(clear) and falling_edge(preset))
--         REPORT "On g_dffpc: Preset and clear both released at same time";

      IF (rising_edge(pwrupstate)) THEN
	 q <= '0';
      ELSIF clear /= '0' AND preset /= '0' THEN 
         q <= 'X';
      ELSIF preset = '1' AND clear = '0' THEN
         q <= '1';
      ELSIF clear = '1' AND preset = '0' THEN
         q <= '0';
--    ELSIF (falling_edge(clear) and falling_edge(preset)) THEN
--       q <= 'X';
      ELSIF (bitunknown(preset) and not(q = '1')) THEN
         q <= 'X';
      ELSIF (bitunknown(clear) and not(q = '0')) THEN
         q <= 'X';
      ELSIF (bitunknown(clk) and not(q = data)) THEN
         q <= 'X';
      ELSIF bitz(clk) THEN
         q <= (data and data) after t_clkout;
      ELSIF (rising_edge(clk) and not(pchanging(clear) or pchanging(preset))) THEN
         q <= (data and data) after t_clkout;
            -- NOTE: The AND in the above lines handles the case where 
            --       data is a Z.  We want Q to be assigned to X.
      END IF;
      qb <= not(q);
END g_dffa;
--
-- JK flip flop
--    positive edge triggered
--    async. clear and preset (active high)
--
   PROCEDURE g_jkff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      SIGNAL   j        :  IN    STD_LOGIC;   
      SIGNAL   k        :  IN    STD_LOGIC;   
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;   
      t_clkout	        :  in  	 TIME)
   IS 

   BEGIN

      IF (not( now > 0 ns) ) THEN
	q <= pwrupstate; -- Power up state
      END IF;
      ASSERT not( rising_edge(clk) and pchanging(preset))
         REPORT "On g_jkff: Clk and Preset both changing - Clk action suppressed";

      ASSERT not( rising_edge(clk) and pchanging(clear))
         REPORT "On g_jkff: Clk and Clear both changing - Clk action suppressed";

--    ASSERT not( falling_edge(preset) and falling_edge(clear))
--       REPORT "On g_jkff: Preset and Clear both released at same time";

      IF preset /= '0' AND clear /= '0' THEN
         q <= 'X';
      ELSIF preset = '1' THEN
         q <= '1';
      ELSIF clear = '1' THEN
         q <= '0';
      ELSIF bitunknown(clk) THEN
         q <= 'X' AFTER t_clkout;
      ELSIF (bitunknown(preset) and not(q = '1')) THEN
         q <= 'X' AFTER t_clkout;
      ELSIF (bitunknown(clear) and not(q = '0')) THEN
         q <= 'X' AFTER t_clkout;
      ELSIF (rising_edge(clk) and not(pchanging(clear) or pchanging(preset))) THEN
         IF (j = '1' AND k = '1') THEN
            q <= NOT q AFTER t_clkout;
         ELSIF (j = '1' AND k = '0') THEN
            q <= '1' AFTER t_clkout;
         ELSIF (j = '0' AND k = '1') THEN
            q <= '0' AFTER t_clkout;
         ELSIF (bitunknown(j)  OR bitunknown(k)) THEN
            q <= 'X' AFTER t_clkout;
         END IF;
      END IF;
      qb <= not(q);
   END g_jkff;
--
--
--
-- T flip flop
--    positive edge triggered
--    async. clear and preset (active high)
--
   PROCEDURE g_tff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      SIGNAL   t        :  IN    STD_LOGIC;   
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;   
      t_clkout	        :  in  	 TIME)
   IS 

   BEGIN

      IF (not( now > 0 ns) ) THEN
	q <= pwrupstate; -- Power up state
      END IF;

      ASSERT not( rising_edge(clk) and pchanging(preset))
         REPORT "On g_tff: Clk and Preset both changing - Clk action suppressed";

      ASSERT not( rising_edge(clk) and pchanging(clear))
         REPORT "On g_tff: Clk and Clear both changing - Clk action suppressed";

--    ASSERT not( falling_edge(preset) and falling_edge(clear))
--       REPORT "On g_tff: Preset and Clear both released at same time";

      IF preset /= '0' AND clear /= '0' THEN
         q <= 'X';
      ELSIF preset = '1' THEN
         q <= '1';
      ELSIF clear = '1' THEN
         q <= '0';
      ELSIF bitunknown(clk) AND (now > 0 ns) THEN
         q <= 'X' AFTER t_clkout;
      ELSIF (bitunknown(preset) and not(q = '1')) THEN
         q <= 'X' AFTER t_clkout;
      ELSIF (bitunknown(clear) and not(q = '0')) THEN
         q <= 'X' AFTER t_clkout;
      ELSIF (rising_edge(clk) and not(pchanging(clear) or pchanging(preset))) THEN
         IF (t = '1' AND q = '1') THEN
            q <= '0' AFTER t_clkout;
         ELSIF (t = '1'  AND q = '0') THEN
            q <= '1' AFTER t_clkout;
         ELSIF (t = '0') THEN
            q <= q AFTER t_clkout;
         ELSIF (bitunknown(t) ) THEN
            q <= 'X' AFTER t_clkout;
         END IF;
      END IF;
      qb <= not(q);

   END g_tff;
--
--
--
-- RS flip flop
--    negative edge triggered (H-to-L)
--    async. clear and preset (active high)
--
   PROCEDURE g_rsff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      SIGNAL   s        :  IN    STD_LOGIC;   
      SIGNAL   r        :  IN    STD_LOGIC;   
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;   
      t_clkout	        :  in  	 TIME)
   IS 

   BEGIN

      IF (not( now > 0 ns) ) THEN
	q <= pwrupstate; -- Power up state
      END IF;
      ASSERT not( falling_edge(clk) and pchanging(preset))
         REPORT "On g_rsff: Clk and Preset both changing - Clk action suppressed";

      ASSERT not( falling_edge(clk) and pchanging(clear))
         REPORT "On g_rsff: Clk and Clear both changing - Clk action suppressed";

    ASSERT not( rising_edge(preset) and rising_edge(clear))
       REPORT "On g_rsff: Preset and Clear both released at same time";

      IF preset /= '0' AND clear /= '0' THEN
         q <= 'X';
      ELSIF preset = '1' THEN
         q <= '1';
      ELSIF clear = '1' THEN
         q <= '0';
      ELSIF bitunknown(clk) THEN
         q <= 'X' AFTER t_clkout;
      ELSIF (bitunknown(preset) and not(q = '1')) THEN
         q <= 'X' AFTER t_clkout;
      ELSIF (bitunknown(clear) and not(q = '0')) THEN
         q <= 'X' AFTER t_clkout;
      ELSIF (rising_edge(clk) and not(pchanging(clear) or pchanging(preset))) THEN
         IF (s = '0' AND r = '0') THEN
            q <= q AFTER t_clkout;
         ELSIF (s = '1' AND r = '0') THEN
            q <= '1' AFTER t_clkout;
         ELSIF (s = '0' AND r = '1') THEN
            q <= '0' AFTER t_clkout;
         ELSIF (s = '1' AND r = '1') THEN
            q <= 'X' AFTER t_clkout;
         ELSIF (bitunknown(s)  OR bitunknown(r)) THEN
            q <= 'X' AFTER t_clkout;
         END IF;
      END IF;
      qb <= not(q);
   END g_rsff;
--
--
-- MAXFF type flip flop
--    positive edge triggered D ff.
--    async. clear and preset (active high)
--    If both clear and preset HIGH, it become a latch
--
   PROCEDURE g_maxff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;   
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate :  IN  STD_LOGIC;   
      t_clkout	        :  in  	 TIME)
   IS 

   BEGIN
      IF (not( now > 0 ns) ) THEN
	q <= pwrupstate; -- Power up state
      END IF;

      ASSERT not( rising_edge(clk) and pchanging(preset))
         REPORT "On g_maxff: Clk and Preset both changing - Clk action suppressed";

      ASSERT not( rising_edge(clk) and pchanging(clear))
         REPORT "On g_maxff: Clk and Clear both changing - Clk action suppressed";

--      ASSERT not( falling_edge(clear) and falling_edge(preset))
--         REPORT "On g_maxff: Preset and clear both released at same time";

      IF clear = '1' AND preset = '1' THEN 
         q <= data after t_clkout;
      ELSIF preset = '1' AND clear = '0' THEN
         q <= '1';
      ELSIF clear = '1' AND preset = '0' THEN
         q <= '0';
--    ELSIF (falling_edge(clear) and falling_edge(preset)  AND (now > 0 ns)) THEN
--       q <= 'X';
      ELSIF (bitunknown(preset) and not(q = '1') AND (now > 0 ns)) THEN
         q <= 'X';
      ELSIF (bitunknown(clear) and not(q = '0') AND (now > 0 ns)) THEN
         q <= 'X';
      ELSIF (bitunknown(clk) and not(q = data) AND (now > 0 ns)) THEN
         q <= 'X';
      ELSIF bitz(clk) THEN
         q <= (data and data) after t_clkout;
      ELSIF (rising_edge(clk) and not(pchanging(clear) or pchanging(preset))) THEN
         q <= (data and data) after t_clkout;
            -- NOTE: The AND in the above lines handles the case where 
            --       data is a Z.  We want Q to be assigned to X.
      END IF;
      qb <= not(q);
END g_maxff;
--
--
--
   PROCEDURE g_lff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;   
      SIGNAL   gate     :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate :  IN  STD_LOGIC;   
      t_clkout	        :  in  	 TIME)
   IS 

   BEGIN
      IF (not( now > 0 ns) ) THEN
	q <= pwrupstate; -- Power up state
      END IF;

      IF preset /= '0' and clear /= '0' THEN
         q <= 'X';
      ELSIF preset = '1' THEN
         q <= '1';
      ELSIF clear = '1' THEN
         q <= '0';
--      ELSIF (falling_edge(clear) and falling_edge(preset) and (gate /= '0')) THEN
--         q <= 'X';
      ELSIF (bitunknown(preset) and not(q= '1')) THEN
         q <= 'X';
      ELSIF (bitunknown(clear) and not(q= '0')) THEN
         q <= 'X';
      ELSIF (bitunknown(gate) and not(q = data)) THEN
         q <= 'X' after t_clkout;
      ELSIF bitz(gate) THEN
         q <= (data and data);
      ELSIF (bitunknown(data) and (gate = '0')) THEN
         q <= 'X' after t_clkout;
      ELSIF (gate = '0' ) THEN
         q <= (data and data) after t_clkout;
            -- NOTE: The AND in the above lines handles the case where 
            --       data is a Z.  We want Q to be assigned to X.
      END IF;
END g_lff;

--
   PROCEDURE g_lffa (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;   
      SIGNAL   gate     :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate :  IN  STD_LOGIC;   
      t_clkout	        :  in  	 TIME)
   IS 

   BEGIN
      IF (not( now > 0 ns) ) THEN
	q <= pwrupstate; -- Power up state
      END IF;

      IF preset /= '0' and clear /= '0' THEN
         q <= 'X';
      ELSIF preset = '1' THEN
         q <= '1';
      ELSIF clear = '1' THEN
         q <= '0';
      ELSIF (bitunknown(preset) and not(q = '1')) THEN
         q <= 'X';
      ELSIF (bitunknown(clear) and not(q = '0')) THEN
         q <= 'X';
      ELSIF (bitunknown(gate) and not(q = data)) THEN
         q <= 'X' after t_clkout;
      ELSIF bitz(gate) THEN
         q <= (data and data) after t_clkout;
      ELSIF (bitunknown(data) and (gate = '0')) THEN
         q <= 'X' after t_clkout;
      ELSIF (gate = '0' ) THEN
         q <= (data and data) after t_clkout;
            -- NOTE: The AND in the above lines handles the case where 
            --       data is a Z.  We want Q to be assigned to X.
      END IF;
END g_lffa;
--
--
--
   PROCEDURE g_lffh (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;   
      SIGNAL   gate     :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate :  IN  STD_LOGIC;   
      t_clkout	        :  in  	 TIME)
   IS 

   BEGIN
      IF (not( now > 0 ns) ) THEN
	q <= pwrupstate; -- Power up state
      END IF;

      IF preset /= '0' and clear /= '0' THEN
         q <= 'X';
      ELSIF preset = '1' THEN
         q <= '1';
      ELSIF clear = '1' THEN
         q <= '0';
--      ELSIF (falling_edge(clear) and falling_edge(preset) and (gate /= '0')) THEN
--         q <= 'X';
      ELSIF (bitunknown(preset) and not(q = '1')) THEN
         q <= 'X';
      ELSIF (bitunknown(clear) and not(q = '0')) THEN
         q <= 'X';
      ELSIF (bitunknown(gate) and not(q = data)) THEN
         q <= 'X' after t_clkout;
      ELSIF bitz(gate) THEN
         q <= (data and data) after t_clkout;
      ELSIF (bitunknown(data) and (gate = '1')) THEN
         q <= 'X' after t_clkout;
      ELSIF (gate = '1' ) THEN
         q <= (data and data) after t_clkout;
            -- NOTE: The AND in the above lines handles the case where 
            --       data is a Z.  We want Q to be assigned to X.
      END IF;
END g_lffh;
--
-- RAFF type flip flop
--    positive edge triggered D ff.
--    async. clear and preset (active high)
--    If both clear and preset HIGH, it become a latch
--
   PROCEDURE g_raff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      CONSTANT data     :  IN    STD_LOGIC;   
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate :  IN  STD_LOGIC;   
      t_clkout	        :  in  	 TIME)
   IS 

   BEGIN
      IF (not( now > 0 ns) ) THEN
	q <= pwrupstate; -- Power up state
      END IF;

      ASSERT not( rising_edge(clk) and pchanging(preset))
         REPORT "On g_raff: Clk and Preset both changing - Clk action suppressed";

      ASSERT not( rising_edge(clk) and pchanging(clear))
         REPORT "On g_raff: Clk and Clear both changing - Clk action suppressed";

--      ASSERT not( falling_edge(clear) and falling_edge(preset))
--         REPORT "On g_raff: Preset and clear both released at same time";

      IF clear = '1' AND preset = '1' THEN 
         q <= data;
      ELSIF preset = '1' AND clear = '0' THEN
         q <= '1';
      ELSIF clear = '1' AND preset = '0' THEN
         q <= '0';
--    ELSIF (falling_edge(clear) and falling_edge(preset)  AND (now > 0 ns)) THEN
--       q <= 'X';
      ELSIF (bitunknown(preset) and not(q = '1') AND (now > 0 ns)) THEN
         q <= 'X';
      ELSIF (bitunknown(clear) and not(q = '0') AND (now > 0 ns)) THEN
         q <= 'X';
      ELSIF (bitunknown(clk) and not(q = data) AND (now > 0 ns)) THEN
         q <= 'X';
      ELSIF bitz(clk) THEN
         q <= (data and data) after t_clkout;
      ELSIF (rising_edge(clk) and not(pchanging(clear) or pchanging(preset))) THEN
         q <= (data and data) after t_clkout;
            -- NOTE: The AND in the above lines handles the case where 
            --       data is a Z.  We want Q to be assigned to X.
      END IF;
      qb <= not(q);
END g_raff;
--
--
function g_smux2 (
                signal i0   : STD_LOGIC;
                signal i1   : STD_LOGIC;
                signal s0   : STD_LOGIC;
                tpLH   : TIME;
                tpHL   : TIME)
    RETURN STD_LOGIC IS
    BEGIN
	IF s0 = '0' THEN
         	RETURN i0;
      	ELSIF s0 = '1' THEN
         	RETURN i1;
      	END IF;
        RETURN 'X';
   END g_smux2;
--
procedure g_smux (
	        signal dout :  out STD_LOGIC;
	        signal i0   :  in  STD_LOGIC;
	        signal i1   :  in  STD_LOGIC;
	        signal i2   :  in  STD_LOGIC;
	        signal i3   :  in  STD_LOGIC;
	        signal s0   :  in  STD_LOGIC;
	        signal s1   :  in  STD_LOGIC;
             	tpLH   :  in  TIME;
	     	tpHL   :  in  TIME)
   IS

   BEGIN

      IF s0 = '0' AND s1 = '0'  THEN
         dout <= i0;
      ELSIF s0 = '0' AND s1 = '1'  THEN
         dout <= i1;
      ELSIF s0 = '1' AND s1 = '0'  THEN
         dout <= i1;
      ELSIF s0 = '1' AND s1 = '1'  THEN
         dout <= i1;
      ELSIF (bitunknown(s0) OR bitunknown(s1)) THEN
         dout <= 'X';
      END IF;
   END g_smux;
--
--
-- JKD flip flop
--    positive edge triggered
--    async. clear and preset (active high)
--
   PROCEDURE g_jkdff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      SIGNAL   ji       :  IN    STD_LOGIC;   
      SIGNAL   ki       :  IN    STD_LOGIC;   
      SIGNAL   jf       :  IN    STD_LOGIC;   
      SIGNAL   kf       :  IN    STD_LOGIC;   
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   ld       :  IN    STD_LOGIC;
      SIGNAL   sel      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;   
      SIGNAL   clear    :  IN    STD_LOGIC;   
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;   
      t_clkout	        :  in  	 TIME)
   IS 

   variable j       : STD_LOGIC;
   variable k       : STD_LOGIC;
 
   BEGIN

      IF ld = '0' THEN
         j := ji;
      ELSIF ld = '1' THEN
         j := jf;
      ELSIF bitunknown(ld) THEN
         j := 'X';
      END  IF;

      IF ld = '0' AND sel = '0' THEN
         k := ki;
      ELSIF ld = '0' AND sel = '1' THEN
         k := not(j);
      ELSIF ld = '1' AND sel = '0' THEN
         k := kf;
      ELSIF ld = '0' AND sel = '1' THEN
         k := kf;
      ELSIF bitunknown(ld) or bitunknown(sel) THEN
         k := 'X';
      END  IF;


      IF (not( now > 0 ns) ) THEN
	q <= pwrupstate; -- Power up state
      END IF;
      ASSERT not( rising_edge(clk) and pchanging(preset))
         REPORT "On g_jkdff: Clk and Preset both changing - Clk action suppressed";

      ASSERT not( rising_edge(clk) and pchanging(clear))
         REPORT "On f_jkdff: Clk and Clear both changing - Clk action suppressed";

--    ASSERT not( falling_edge(preset) and falling_edge(clear))
--       REPORT "On f_jkdff: Preset and Clear both released at same time";

      IF preset /= '0' AND clear /= '0' THEN
         q <= 'X';
      ELSIF preset = '1' THEN
         q <= '1';
      ELSIF clear = '1' THEN
         q <= '0';
      ELSIF bitunknown(clk) THEN
         q <= 'X' AFTER t_clkout;
      ELSIF (bitunknown(preset) and not(q = '1')) THEN
         q <= 'X' AFTER t_clkout;
      ELSIF (bitunknown(clear) and not(q = '0')) THEN
         q <= 'X' AFTER t_clkout;
      ELSIF (rising_edge(clk) and not(pchanging(clear) or pchanging(preset))) THEN
         IF (j = '1' AND k = '1') THEN
            q <= NOT q AFTER t_clkout;
         ELSIF (j = '1' AND k = '0') THEN
            q <= '1' AFTER t_clkout;
         ELSIF (j = '0' AND k = '1') THEN
            q <= '0' AFTER t_clkout;
         ELSIF (bitunknown(j)  OR bitunknown(k)) THEN
            q <= 'X' AFTER t_clkout;
         END IF;
      END IF;
      qb <= not(q);
   END g_jkdff;
--
--
procedure g_vxff (
      SIGNAL   q        :  INOUT STD_LOGIC;
      SIGNAL   qb       :  INOUT STD_LOGIC;
      SIGNAL   din      :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      SIGNAL   preset   :  IN    STD_LOGIC;
      SIGNAL   clear    :  IN    STD_LOGIC;
      SIGNAL   qsel     :  IN    STD_LOGIC;
      SIGNAL   osel     :  IN    STD_LOGIC;
      SIGNAL   pwrupstate    :  IN    STD_LOGIC;
      t_clkout          :  in    TIME)
   IS
      variable data     : STD_LOGIC;
      variable qout     : STD_LOGIC;
   BEGIN
      IF (not( now > 0 ns) ) THEN
        q <= pwrupstate; -- Power up state
      END IF;  

      ASSERT not( rising_edge(clk) and pchanging(clear))
         REPORT "On g_vxff: Clk and Clear both changing - Clk action suppressed";
 
      IF clear = '1' THEN
         q <= '0';
      ELSIF (bitunknown(clear) and not(q = '0')) THEN
         q <= 'X';
      ELSIF (bitunknown(clk) and not(q = data)) THEN
         q <= 'X';
      ELSIF bitz(clk) THEN
         data := din OR preset;
      ELSIF (rising_edge(clk) and not(pchanging(clear))) THEN
         data := din OR preset;
         q <= (data and data) after t_clkout;
            -- NOTE: The AND in the above lines handles the case where
            --       data is a Z.  We want Q to be assigned to X.
               
      END IF;
      IF qsel = '1' and osel = '1' THEN
 	q <= (data and data);
      END IF;
--         qout <= q;
--      ELSIF qsel = '1' and osel = '0' THEN
--         qout := qb;
--      ELSIF bitunknown(qsel) THEN
--         qout := 'X';
--      END IF;
--      IF osel = '0' THEN
--         q <= qout;
--      ELSIF osel = '1' THEN
--         q <= din;
--      ELSIF bitunknown(osel) THEN
--         q <= 'X';
--      END IF;
       qb <= not(q);
   END g_vxff;
   PROCEDURE p_chksuho (
      SIGNAL   data     :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      t_setup           :  IN     TIME;
      t_hold            :  IN     TIME;
      t_clk             :  INOUT  TIME;
      t_data            :  INOUT  TIME;
      setname           :  IN     STRING)
   IS BEGIN
         IF (rising_edge (clk)) AND (now > 0 ns) AND ((t_data + t_setup) > now) THEN
            PUT     ("Error: Setup time violation at time ",now);
            PUTLINE (" for ",setname);
            PUTLINE ("       Data last changed at ", t_data);
            PUT     ("       Setup of ",(now - t_data));
            PUTLINE (" less than required ",t_setup);
         END IF;

         IF falling_edge (clk) THEN
            t_clk := now;
         END IF;

         IF pchanging (data) THEN
            t_data := now;
            IF (now > 0 ns) AND ((t_clk + t_hold) > now) THEN
               PUT     ("Error: Hold time violation at time ",now);
               PUTLINE (" for ",setname);
               PUTLINE ("       Clock last changed at ", t_clk);
               PUT     ("       Hold of ",(now - t_clk));
               PUTLINE (" less than required ",t_hold);
            END IF;
         END IF;
   END p_chksuho;
--
--
-- 
   PROCEDURE p_chksuho_hl (
      SIGNAL   data     :  IN    STD_LOGIC;
      SIGNAL   clk      :  IN    STD_LOGIC;
      t_setup           :  IN     TIME;
      t_hold            :  IN     TIME;
      t_clk             :  INOUT  TIME;
      t_data            :  INOUT  TIME;
      setname           :  IN     STRING)
   IS BEGIN
         IF (falling_edge (clk)) AND (now > 0 ns) AND ((t_data + t_setup) > now) THEN
            PUT     ("Error: Setup time violation at time ",now);
            PUTLINE (" for ",setname);
            PUTLINE ("       Data last changed at ", t_data);
            PUT     ("       Setup of ",(now - t_data));
            PUTLINE (" less than required ",t_setup);
         END IF;

         IF rising_edge (clk) THEN
            t_clk := now;
         END IF;

         IF pchanging (data) THEN
            t_data := now;
            IF (now > 0 ns) AND ((t_clk + t_hold) > now) THEN
               PUT     ("Error: Hold time violation at time ",now);
               PUTLINE (" for ",setname);
               PUTLINE ("       Clock last changed at ", t_clk);
               PUT     ("       Hold of ",(now - t_clk));
               PUTLINE (" less than required ",t_hold);
            END IF;
         END IF;
END p_chksuho_hl;
---
---
--
function bitunknown(data: STD_LOGIC)
   return BOOLEAN is
      BEGIN
         IF (bitz(data) or bitx(data) ) THEN return TRUE;
         ELSE  return FALSE;
         END IF;
      return FALSE;
END bitunknown;
--
--
FUNCTION bitz ( s : STD_LOGIC        )
RETURN  BOOLEAN IS
BEGIN
        CASE s IS
            WHEN 'Z' => RETURN TRUE;
            WHEN OTHERS => RETURN FALSE;
        END CASE;
        RETURN FALSE;
END bitz;
--
--
function bitx(
	   data: STD_LOGIC)
   return BOOLEAN is
       BEGIN
	 IF ((data = 'X')) THEN return TRUE;
	 ELSE return FALSE;
	 END IF;
END bitx;
--
--
function pchanging (
		signal s : STD_LOGIC)
RETURN BOOLEAN IS
BEGIN
   if (rising_edge(s) or falling_edge(s)) THEN
     return TRUE;
   else 
     return FALSE;
   end if;
END pchanging;
--
--
------------------------------------------------------------------------
   procedure put              (s: in string) is
      variable l:  line;
   begin
      write (l, s);
      writeline (output, l);
   end;

------------------------------------------------------------------------
   procedure putline          (s: in string) is
   begin
      put (s);
   end;

------------------------------------------------------------------------
   procedure put              (s: in string; t: in time) is
      variable l:  line;
   begin
      write (l, s);
      write (l, t);
      writeline (output, l);
   end;
 
------------------------------------------------------------------------
   procedure putline          (s: in string; t: in time) is
   begin
      put (s, t);
   end;
 
------------------------------------------------------------------------
   procedure put              (s: in string; st: in string) is
      variable l:  line;
   begin
      write (l, s);
      write (l, st);
      writeline (output, l);
   end;
 
------------------------------------------------------------------------
   procedure putline          (s: in string; st: in string) is
   begin
      put (s, st);
   end;
 
------------------------------------------------------------------------


PROCEDURE jedsim(
      VARIABLE SIMERR	:  OUT   BOOLEAN;
      CONSTANT SILENT_MODE	:  IN   BOOLEAN;
      SIGNAL ports      :  INOUT std_logic_vector;
      variable l	:  IN line)
   IS
    VARIABLE signo : integer;
    VARIABLE out_line : line;
   BEGIN
        signo := 1;

        FOR i IN l'RANGE LOOP
        CASE l(i) IS 
            WHEN '0' => -- Drive 0
                ports(signo) <= '0';
            WHEN '1' => -- Drive 1
                ports(signo) <= '1';
            WHEN 'h' => -- Test for 1
                ASSERT ports(signo) = '1';
            WHEN 'H' => -- Test for 1
                IF (ports(signo) /= '1') THEN
	   	  SIMERR := TRUE;	
                  IF (NOT SILENT_MODE) THEN
  		  write(out_line,string'(" fails: expected H at PIN "));
		  write(out_line,signo);
		  writeline(output,out_line);
		  END IF;
		END IF;
            WHEN 'l' => -- Test for 0
                ASSERT ports(signo) = '0';
            WHEN 'L' => -- Test for 0
                IF (ports(signo) /= '0') THEN
	   	  SIMERR := TRUE;	
                  IF (NOT SILENT_MODE) THEN
		    write(out_line,string'(" fails: expected L at PIN "));
		    write(out_line,signo);
		    writeline(output,out_line);
		  END IF;
		END IF;
            WHEN 'z' => -- Test for z
                ports(signo) <= 'Z';
            WHEN 'Z' => -- Test for Z
                IF (ports(signo) /= 'Z') THEN
	   	  SIMERR := TRUE;	
                  IF (NOT SILENT_MODE) THEN
  		  write(out_line,string'(" fails: expected H at PIN "));
		  write(out_line,signo);
		  writeline(output,out_line);
		  END IF;
		END IF;
            WHEN 'x' => -- Don't care
                NULL;
            WHEN 'X' => -- Don't care
                NULL;
            WHEN 'N' => -- Don't care
                NULL;
            WHEN ' '
            | ht => -- Skip white space
                NEXT;
            WHEN OTHERS =>
                -- Illegal character
                ASSERT false
                  REPORT "Illegal character in vector file: " & l(i);
                EXIT;
        END CASE;
        signo := signo + 1;
        END LOOP;
END jedsim;

END j2svlib;
