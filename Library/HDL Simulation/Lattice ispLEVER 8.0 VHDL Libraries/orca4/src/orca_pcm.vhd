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
-- Simulation Library File for ORCA3
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca3/src/RCS/ORCA_PCM.vhd,v 1.20 2005/05/19 20:04:55 pradeep Exp $ 
--

--
----- cell dll1xb -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

-- entity declaration --
ENTITY dll1xb IS
   GENERIC (
      duty		 : Real := 50.0;
      div0		 : Integer := 1;
      disabled_gsr       : std_logic  := '0';
      TimingChecksOn	 : Boolean := TRUE;
      XOn		 : Boolean := FALSE;        
      MsgOn		 : Boolean := TRUE;
      InstancePath	 : String  := "dll1xb";
      tpd_clkin_eclk	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_sclk	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_lock	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin	 : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      clkin		 : in std_logic;
      eclk		 : out std_logic;
      sclk		 : out std_logic;
      lock		 : out std_logic);

    ATTRIBUTE Vital_Level0 OF dll1xb : ENTITY IS TRUE;
 
END dll1xb ;

-- ARCHITECTURE body --
ARCHITECTURE V OF dll1xb IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clkin_ipd  : std_logic := 'X';
    SIGNAL new_clock  : std_logic := '0';
    SIGNAL duty_tap   : integer   := 0;
    SIGNAL duty1      : Real      := 0.0;
    SIGNAL set_reset  : std_logic := '0';

BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
    duty1 <= duty;

    assert (duty > 1.5625) AND (duty < 98.4375)
       report"Duty Cycle is not valid"
       severity error;

    duty_tap <= INTEGER ((32.0*duty1)/100.0);

    P1 : PROCESS (purnet, gsrnet)
    BEGIN
      IF (disabled_gsr =  '1') THEN
         set_reset <= purnet;
      ELSE
         set_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

    P2 : PROCESS (clkin_ipd, set_reset)
    VARIABLE index : Integer := 0;
    VARIABLE first_time : boolean := true;
    BEGIN
       IF (set_reset = '0') THEN
          index := 0;
          first_time := true;
          new_clock <= '0';
       ELSE

         IF (clkin_ipd'event) THEN
            IF (first_time) THEN
               IF (clkin_ipd = '1') THEN
                  new_clock <= '1';
                  first_time := false;
                  index := 0;
               END IF; 
              ELSE
               index := index + 1;
               IF (index = div0) THEN
                  new_clock <= NOT new_clock;
                  index := 0;
               END IF;
            END IF;
         END IF;
       END IF;
    END PROCESS;

    ---------------------------------------------------
    --  Determine Input Clock Period and generate clock
    ---------------------------------------------------
    PERIOD : PROCESS (new_clock, set_reset)

    -- functionality results
    VARIABLE results : std_logic_vector(1 to 3) := (others => 'X');
    ALIAS eclk_zd : std_ulogic is results(1);
    ALIAS sclk_zd : std_ulogic is results(2);
    ALIAS lock_zd : std_ulogic is results(3);
    VARIABLE last_cycle, next_cycle, last_clock_edge : time := 0 ps;
    VARIABLE clock_delay : time := 0 ps;
 
    -- output glitch detection variables
    VARIABLE eclk_GlitchData : VitalGlitchDataType;
    VARIABLE sclk_GlitchData : VitalGlitchDataType;
    VARIABLE lock_GlitchData : VitalGlitchDataType;

    BEGIN

     IF (TimingChecksOn) THEN
     END IF;

     -----------------------------------
     -- Output Functionality Section.
     -----------------------------------
     IF (set_reset = '0') THEN
         eclk <= '0';
         sclk <= '0';
         lock <= '0';
     ELSE
       IF (new_clock'event and new_clock = '1') THEN
           last_cycle := next_cycle;
           next_cycle := NOW - last_clock_edge; 

           IF (next_cycle = last_cycle) THEN
              lock <= '1';
           ELSE
              lock <= '0';
           END IF;
 
           last_clock_edge := NOW;
           clock_delay := ((next_cycle * duty_tap)/32);

           eclk <= '1';
           sclk <= '1';
         
           eclk <= transport '0' after clock_delay;
           sclk <= transport '0' after clock_delay;

       END IF;
     END IF;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => eclk,
     OutSignalName => "eclk",
     OutTemp => eclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_eclk, TRUE)),
     GlitchData => eclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => sclk,
     OutSignalName => "sclk",
     OutTemp => sclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_sclk, TRUE)),
     GlitchData => sclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => lock,
     OutSignalName => "lock",
     OutTemp => lock_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_lock, TRUE)),
     GlitchData => lock_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;



--
----- cell dll1xt -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;

-- entity declaration --
ENTITY dll1xt IS
   GENERIC (
      duty		 : Real := 50.0;
      div0		 : Integer := 1;
      disabled_gsr       : std_logic  := '0';
      TimingChecksOn	 : Boolean := TRUE;
      XOn		 : Boolean := FALSE;        
      MsgOn		 : Boolean := TRUE;
      InstancePath	 : String  := "dll1xt";
      tpd_clkin_eclk	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_sclk	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_lock	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin	 : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      clkin		 : in std_logic;
      eclk		 : out std_logic;
      sclk		 : out std_logic;
      lock		 : out std_logic);

    ATTRIBUTE Vital_Level0 OF dll1xt : ENTITY IS TRUE;
 
END dll1xt ;

-- ARCHITECTURE body --
ARCHITECTURE V OF dll1xt IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clkin_ipd  : std_logic := 'X';
    SIGNAL new_clock  : std_logic := '0';
    SIGNAL duty_tap   : integer   := 0;
    SIGNAL duty1      : Real      := 0.0;
    SIGNAL set_reset  : std_logic := '0';

BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
    duty1 <= duty;

    assert (duty > 1.5625) AND (duty < 98.4375)
       report"Duty Cycle is not valid"
       severity error;

    duty_tap <= INTEGER ((32.0*duty1)/100.0);

    P1 : PROCESS (purnet, gsrnet)
    BEGIN
      IF (disabled_gsr =  '1') THEN
         set_reset <= purnet;
      ELSE
         set_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

    P2 : PROCESS (clkin_ipd, set_reset)
    VARIABLE index : Integer := 0;
    VARIABLE first_time : boolean := true;
    BEGIN
       IF (set_reset = '0') THEN
          index := 0;
          first_time := true;
          new_clock <= '0';
       ELSE

         IF (clkin_ipd'event) THEN
            IF (first_time) THEN
               IF (clkin_ipd = '1') THEN
                  new_clock <= '1';
                  first_time := false;
                  index := 0;
               END IF; 
              ELSE
               index := index + 1;
               IF (index = div0) THEN
                  new_clock <= NOT new_clock;
                  index := 0;
               END IF;
            END IF;
         END IF;
       END IF;
    END PROCESS;

    ---------------------------------------------------
    --  Determine Input Clock Period and generate clock
    ---------------------------------------------------
    PERIOD : PROCESS (new_clock, set_reset)

    -- functionality results
    VARIABLE results : std_logic_vector(1 to 3) := (others => 'X');
    ALIAS eclk_zd : std_ulogic is results(1);
    ALIAS sclk_zd : std_ulogic is results(2);
    ALIAS lock_zd : std_ulogic is results(3);
    VARIABLE last_cycle, next_cycle, last_clock_edge : time := 0 ps;
    VARIABLE clock_delay : time := 0 ps;
 
    -- output glitch detection variables
    VARIABLE eclk_GlitchData : VitalGlitchDataType;
    VARIABLE sclk_GlitchData : VitalGlitchDataType;
    VARIABLE lock_GlitchData : VitalGlitchDataType;

    BEGIN

     IF (TimingChecksOn) THEN
     END IF;

     -----------------------------------
     -- Output Functionality Section.
     -----------------------------------
     IF (set_reset = '0') THEN
         eclk <= '0';
         sclk <= '0';
         lock <= '0';
     ELSE
       IF (new_clock'event and new_clock = '1') THEN
           last_cycle := next_cycle;
           next_cycle := NOW - last_clock_edge; 

           IF (next_cycle = last_cycle) THEN
              lock <= '1';
           ELSE
              lock <= '0';
           END IF;
 
           last_clock_edge := NOW;
           clock_delay := ((next_cycle * duty_tap)/32);

           eclk <= '1';
           sclk <= '1';
         
           eclk <= transport '0' after clock_delay;
           sclk <= transport '0' after clock_delay;

       END IF;
     END IF;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => eclk,
     OutSignalName => "eclk",
     OutTemp => eclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_eclk, TRUE)),
     GlitchData => eclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => sclk,
     OutSignalName => "sclk",
     OutTemp => sclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_sclk, TRUE)),
     GlitchData => sclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => lock,
     OutSignalName => "lock",
     OutTemp => lock_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_lock, TRUE)),
     GlitchData => lock_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;


--
----- cell dllpdb -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.global.gsrnet;
use work.global.purnet;


-- entity declaration --
ENTITY dllpdb IS
   GENERIC (
      pdelay		 : Integer := 1;
      div0		 : Integer := 1;
      div2		 : Integer := 1;
      disabled_gsr       : std_logic  := '0';
      TimingChecksOn	 : Boolean := TRUE;
      XOn		 : Boolean := FALSE;        
      MsgOn		 : Boolean := TRUE;
      InstancePath	 : String  := "dllpdb";
      tpd_clkin_eclk	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_sclk	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_lock	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin	 : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      clkin		 : in std_logic;
      eclk		 : out std_logic;
      sclk		 : out std_logic;
      lock		 : out std_logic);

    ATTRIBUTE Vital_Level0 OF dllpdb : ENTITY IS TRUE;
 
END dllpdb ;

-- ARCHITECTURE body --
ARCHITECTURE V OF dllpdb IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clkin_ipd      : std_logic := 'X';
    SIGNAL new_clock      : std_logic := 'X';
    SIGNAL t_in_clk       : time := 0 ps;
    SIGNAL t_in_clk1      : time := 0 ps;
    SIGNAL eclk_half_time : time := 0 ps;
    SIGNAL sclk_half_time : time := 0 ps;
    SIGNAL clock_delay    : time := 0 ps;
    SIGNAL eclk_period    : time := 0 ps;
    SIGNAL clock_valid    : std_logic := '0';
    SIGNAL clock_invalid  : std_logic := '0';
    SIGNAL start_clk      : std_logic := '0';
    SIGNAL eclk_out       : std_logic := '0';
    SIGNAL sclk_out       : std_logic := '0';
    SIGNAL lock_out       : std_logic := '0';
    SIGNAL set_reset      : std_logic := '1';

BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   assert (pdelay >= 1) AND (pdelay <= 31)
      report"Delay Tap is not valid"
      severity error;

   assert (div0 >= 1) AND (div0 <= 8)
      report"Divisor div0 is not valid"
      severity error;

   assert (div2 >= 1) AND (div2 <= 8)
      report"Divisor div1 is not valid"
      severity error;

    P1 : PROCESS (purnet, gsrnet)
    BEGIN
      IF (disabled_gsr =  '1') THEN
         set_reset <= purnet;
      ELSE
         set_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

   P2 : PROCESS (clkin_ipd, set_reset)
    VARIABLE index : Integer := 0;
    VARIABLE first_time : boolean := true;
    BEGIN
       IF (set_reset = '0') THEN
          index := 0;
          first_time := true;
          new_clock <= '0';
       ELSE
         IF (clkin_ipd'event) THEN
            IF (first_time) THEN
               IF (clkin_ipd = '1') THEN
                  new_clock <= '1';
                  first_time := false;
                  index := 0;
               END IF;
            ELSE
               index := index + 1;
               IF (index = div0) THEN
                  new_clock <= NOT new_clock;
                  index := 0;
               END IF;
            END IF;
         END IF;
       END IF;
    END PROCESS;


   P3 : PROCESS (new_clock, set_reset)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   VARIABLE t_in_clk2 : time := 0 ps;
   BEGIN
      IF (set_reset = '0') THEN
         clock_invalid <= '1';
      ELSE
        IF (new_clock'event and new_clock = '1') THEN
             last_clock_edge := next_clock_edge;
             next_clock_edge := NOW;
             IF (last_clock_edge > 0 ps) THEN
                t_in_clk2 := next_clock_edge - last_clock_edge;
                IF (t_in_clk2 > 0 ps) THEN
                  IF (t_in_clk2 = t_in_clk) THEN
                     clock_invalid <= '0';
                  ELSE
                     clock_invalid <= '1';
                  END IF; 
                END IF; 
                t_in_clk <= t_in_clk2;
             END IF;

             IF (t_in_clk > 0 ps) THEN
               t_in_clk1 <= t_in_clk;
               IF (t_in_clk = t_in_clk1) THEN
                    clock_valid <= '1';
               ELSE
                    clock_valid <= '0';
               END IF;
             END IF;
         END IF; 
       END IF; 
   END PROCESS;
 
   clock_delay <= ((t_in_clk * pdelay)/32);
   eclk_period <= t_in_clk * div2;
   start_clk <= transport clock_valid after clock_delay;
   eclk_half_time <= eclk_period/2;
   sclk_half_time <= t_in_clk/2;

   P4 : PROCESS
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (first_time) THEN
        WAIT UNTIL (start_clk'event and start_clk = '1');
        sclk_out <= '1';
        first_time := false;
      ELSIF (start_clk = '1') THEN
        WAIT FOR sclk_half_time;
        sclk_out <= NOT sclk_out;
      END IF;
   END PROCESS;

   P5 : PROCESS (sclk_out)
   VARIABLE index : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (sclk_out'event) THEN
         IF (first_time) THEN
            IF (sclk_out = '1') THEN
               eclk_out <= '1';
               first_time := false;
               index := 0;
            END IF;
         ELSE
            index := index + 1;
            IF (index = div2) THEN
               eclk_out <= NOT eclk_out;
               index := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P6 : PROCESS (start_clk, clock_invalid, eclk_out, sclk_out)
   BEGIN
      IF (clock_invalid = '1') THEN
        lock_out <= '0';
      ELSE
        IF (start_clk = '1') THEN
           IF (eclk_out = '1' and sclk_out = '1') THEN
              lock_out <= '1';
           END IF; 
        END IF; 
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (eclk_out, sclk_out, lock_out, set_reset)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 3) := (others => 'X');
   ALIAS eclk_zd : std_ulogic is results(1);
   ALIAS sclk_zd : std_ulogic is results(2);
   ALIAS lock_zd : std_ulogic is results(3);

   -- output glitch detection variables
   VARIABLE eclk_GlitchData : VitalGlitchDataType;
   VARIABLE sclk_GlitchData : VitalGlitchDataType;
   VARIABLE lock_GlitchData : VitalGlitchDataType;

   BEGIN

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (set_reset = '0') THEN
       lock_zd := '0';
       eclk_zd := '0';
       sclk_zd := '0';
    ELSE
       lock_zd := lock_out;
       eclk_zd := eclk_out;
       sclk_zd := sclk_out;
    END IF;
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => eclk,
     OutSignalName => "eclk",
     OutTemp => eclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_eclk, TRUE)),
     GlitchData => eclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => sclk,
     OutSignalName => "sclk",
     OutTemp => sclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_sclk, TRUE)),
     GlitchData => sclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => lock,
     OutSignalName => "lock",
     OutTemp => lock_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_lock, TRUE)),
     GlitchData => lock_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;


--
----- cell dllpdt -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.global.gsrnet;
use work.global.purnet;


-- entity declaration --
ENTITY dllpdt IS
   GENERIC (
      pdelay		 : Integer := 1;
      div0		 : Integer := 1;
      div2		 : Integer := 1;
      disabled_gsr       : std_logic  := '0';
      TimingChecksOn	 : Boolean := TRUE;
      XOn		 : Boolean := FALSE;        
      MsgOn		 : Boolean := TRUE;
      InstancePath	 : String  := "dllpdt";
      tpd_clkin_eclk	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_sclk	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_lock	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin	 : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      clkin		 : in std_logic;
      eclk		 : out std_logic;
      sclk		 : out std_logic;
      lock		 : out std_logic);

    ATTRIBUTE Vital_Level0 OF dllpdt : ENTITY IS TRUE;
 
END dllpdt ;

-- ARCHITECTURE body --
ARCHITECTURE V OF dllpdt IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clkin_ipd      : std_logic := 'X';
    SIGNAL new_clock      : std_logic := 'X';
    SIGNAL t_in_clk       : time := 0 ps;
    SIGNAL t_in_clk1      : time := 0 ps;
    SIGNAL eclk_half_time : time := 0 ps;
    SIGNAL sclk_half_time : time := 0 ps;
    SIGNAL clock_delay    : time := 0 ps;
    SIGNAL eclk_period    : time := 0 ps;
    SIGNAL clock_valid    : std_logic := '0';
    SIGNAL clock_invalid  : std_logic := '0';
    SIGNAL start_clk      : std_logic := '0';
    SIGNAL eclk_out       : std_logic := '0';
    SIGNAL sclk_out       : std_logic := '0';
    SIGNAL lock_out       : std_logic := '0';
    SIGNAL set_reset      : std_logic := '1';

BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   assert (pdelay >= 1) AND (pdelay <= 31)
      report"Delay Tap is not valid"
      severity error;

   assert (div0 >= 1) AND (div0 <= 8)
      report"Divisor div0 is not valid"
      severity error;

   assert (div2 >= 1) AND (div2 <= 8)
      report"Divisor div1 is not valid"
      severity error;

    P1 : PROCESS (purnet, gsrnet)
    BEGIN
      IF (disabled_gsr =  '1') THEN
         set_reset <= purnet;
      ELSE
         set_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

   P2 : PROCESS (clkin_ipd, set_reset)
    VARIABLE index : Integer := 0;
    VARIABLE first_time : boolean := true;
    BEGIN
       IF (set_reset = '0') THEN
          index := 0;
          first_time := true;
          new_clock <= '0';
       ELSE
         IF (clkin_ipd'event) THEN
            IF (first_time) THEN
               IF (clkin_ipd = '1') THEN
                  new_clock <= '1';
                  first_time := false;
                  index := 0;
               END IF;
            ELSE
               index := index + 1;
               IF (index = div0) THEN
                  new_clock <= NOT new_clock;
                  index := 0;
               END IF;
            END IF;
         END IF;
       END IF;
    END PROCESS;


   P3 : PROCESS (new_clock, set_reset)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   VARIABLE t_in_clk2 : time := 0 ps;
   BEGIN
      IF (set_reset = '0') THEN
         clock_invalid <= '1';
      ELSE
        IF (new_clock'event and new_clock = '1') THEN
             last_clock_edge := next_clock_edge;
             next_clock_edge := NOW;
             IF (last_clock_edge > 0 ps) THEN
                t_in_clk2 := next_clock_edge - last_clock_edge;
                IF (t_in_clk2 > 0 ps) THEN
                  IF (t_in_clk2 = t_in_clk) THEN
                     clock_invalid <= '0';
                  ELSE
                     clock_invalid <= '1';
                  END IF; 
                END IF; 
                t_in_clk <= t_in_clk2;
             END IF;

             IF (t_in_clk > 0 ps) THEN
               t_in_clk1 <= t_in_clk;
               IF (t_in_clk = t_in_clk1) THEN
                    clock_valid <= '1';
               ELSE
                    clock_valid <= '0';
               END IF;
             END IF;
         END IF; 
       END IF; 
   END PROCESS;
 
   clock_delay <= ((t_in_clk * pdelay)/32);
   eclk_period <= t_in_clk * div2;
   start_clk <= transport clock_valid after clock_delay;
   eclk_half_time <= eclk_period/2;
   sclk_half_time <= t_in_clk/2;

   P4 : PROCESS
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (first_time) THEN
        WAIT UNTIL (start_clk'event and start_clk = '1');
        sclk_out <= '1';
        first_time := false;
      ELSIF (start_clk = '1') THEN
        WAIT FOR sclk_half_time;
        sclk_out <= NOT sclk_out;
      END IF;
   END PROCESS;

   P5 : PROCESS (sclk_out)
   VARIABLE index : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (sclk_out'event) THEN
         IF (first_time) THEN
            IF (sclk_out = '1') THEN
               eclk_out <= '1';
               first_time := false;
               index := 0;
            END IF;
         ELSE
            index := index + 1;
            IF (index = div2) THEN
               eclk_out <= NOT eclk_out;
               index := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P6 : PROCESS (start_clk, clock_invalid, eclk_out, sclk_out)
   BEGIN
      IF (clock_invalid = '1') THEN
        lock_out <= '0';
      ELSE
        IF (start_clk = '1') THEN
           IF (eclk_out = '1' and sclk_out = '1') THEN
              lock_out <= '1';
           END IF; 
        END IF; 
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (eclk_out, sclk_out, lock_out, set_reset)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 3) := (others => 'X');
   ALIAS eclk_zd : std_ulogic is results(1);
   ALIAS sclk_zd : std_ulogic is results(2);
   ALIAS lock_zd : std_ulogic is results(3);

   -- output glitch detection variables
   VARIABLE eclk_GlitchData : VitalGlitchDataType;
   VARIABLE sclk_GlitchData : VitalGlitchDataType;
   VARIABLE lock_GlitchData : VitalGlitchDataType;

   BEGIN

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (set_reset = '0') THEN
       lock_zd := '0';
       eclk_zd := '0';
       sclk_zd := '0';
    ELSE
       lock_zd := lock_out;
       eclk_zd := eclk_out;
       sclk_zd := sclk_out;
    END IF;
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => eclk,
     OutSignalName => "eclk",
     OutTemp => eclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_eclk, TRUE)),
     GlitchData => eclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => sclk,
     OutSignalName => "sclk",
     OutTemp => sclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_sclk, TRUE)),
     GlitchData => sclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => lock,
     OutSignalName => "lock",
     OutTemp => lock_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_lock, TRUE)),
     GlitchData => lock_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;



--
----- cell pllb -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.global.gsrnet;
use work.global.purnet;


-- entity declaration --
ENTITY pllb IS
   GENERIC (
      div0               : Integer := 1;
      div1               : Integer := 1;
      div2               : Integer := 1;
      fbdelay            : Time    := 0 ns;
      disabled_gsr       : std_logic  := '0';
      TimingChecksOn     : Boolean := TRUE;
      XOn                : Boolean := FALSE;
      MsgOn              : Boolean := TRUE;
      InstancePath       : String  := "pllb";
      tpd_clkin_eclk     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_sclk     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_lock     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_fb            : VitalDelayType01 := (0 ns, 0 ns));

   PORT(
      clkin              : in std_logic ;
      fb                 : in std_logic ;
      eclk               : out std_logic;
      sclk               : out std_logic;
      lock               : out std_logic);

    ATTRIBUTE Vital_Level0 OF pllb : ENTITY IS TRUE;

END pllb ;

-- ARCHITECTURE body --
ARCHITECTURE V OF pllb IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clkin_ipd          : std_logic := '0';
    SIGNAL fb_ipd             : std_logic := '0';
    SIGNAL eclk_out           : std_logic := '0';
    SIGNAL sclk_out           : std_logic := '0';
    SIGNAL t_in_clk           : time := 0 ps;
    SIGNAL t_in_clk1          : time := 0 ps;
    SIGNAL t_in_clk2          : time := 0 ps;
    SIGNAL t_in_clk3          : time := 0 ps;
    SIGNAL t_fb_clk           : time := 0 ps;
    SIGNAL total_fb_delay     : time := 0 ps;
    SIGNAL real_delay         : time := 0 ps;
    SIGNAL real_delay1        : time := 0 ps;
    SIGNAL real_delay2        : time := 0 ps;
    SIGNAL virtual_delay1     : time := 0 ps;
    SIGNAL virtual_delay2     : time := 0 ps;
    SIGNAL t_any_clock        : time := 2 ps;
    SIGNAL ha_any_clk         : time := 1 ps;
    SIGNAL t_inter_clk        : time := 2 ps;
    SIGNAL ha_inter_clk       : time := 1 ps;
    SIGNAL clkfb_per_valid    : std_logic := '0';
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL clock_invalid      : std_logic := '0';
    SIGNAL vir_eclk           : std_logic := '0';
    SIGNAL vir_sclk           : std_logic := '0';
    SIGNAL lock_all           : std_logic := '0';
    SIGNAL ratio1             : integer := 0;
    SIGNAL ratio2             : integer := 0;
    SIGNAL set_reset          : std_logic := '0';

    SIGNAL new_eclk           : std_logic := '0';
    SIGNAL new_sclk           : std_logic := '0';
    SIGNAL funky_eclk         : std_logic := '0';
    SIGNAL funky_t_eclk       : time := 0 ns;
    SIGNAL funky_sclk         : std_logic := '0';
    SIGNAL funky_t1_sclk      : time := 5 ns;
    SIGNAL funky_t_sclk       : time := 0 ns;
    SIGNAL ext_divider        : Real := 1.0 ;
    SIGNAL net_divide         : Real := 1.0 ;


BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   VitalWireDelay(fb_ipd, fb, tipd_fb);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   ---------------------------------------------
   -- Create Funky clocks
   ---------------------------------------------
   funky_t_eclk <= (2 * funky_t1_sclk * div2);
   funky_t_sclk <= (2 * funky_t1_sclk);

   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (disabled_gsr =  '1') THEN
         set_reset <= purnet;
      ELSE
         set_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

   P51 : PROCESS
   VARIABLE first_time : boolean := true;
   BEGIN
        IF (first_time) THEN
          Wait for 5 ns;
          funky_sclk <= NOT funky_sclk;
          first_time := false;
        ELSE
          funky_sclk <= NOT funky_sclk;
          Wait for funky_t1_sclk;
        END IF;
   END PROCESS;

   P52 : PROCESS
   VARIABLE funky_t1_eclk : time := 0 ns;
   VARIABLE first_time : boolean := true;
   BEGIN
        IF (first_time) THEN
          Wait for 5 ns;
          funky_eclk <= NOT funky_eclk;
          first_time := false;
        ELSE
          funky_t1_eclk := funky_t1_sclk * div2;
          funky_eclk <= NOT funky_eclk;
          Wait for funky_t1_eclk;
        END IF;
   END PROCESS;

   P54 : PROCESS (set_reset, funky_sclk, funky_eclk)
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (set_reset = '0') THEN
         new_sclk <= '0';
         new_eclk <= '0';
      ELSE
         IF (first_time) THEN
           IF (funky_eclk'event and funky_eclk = '1') THEN
             new_sclk <= '1';
             new_eclk <= '1';
             first_time := false;
           END IF;
         ELSE
           IF funky_sclk'event THEN
             new_sclk <= funky_sclk;
           END IF;
           IF funky_eclk'event THEN
             new_eclk <= funky_eclk;
           END IF;
        END IF;
      END IF;
   END PROCESS;

   ----------------------------------
   -- measure input clock and feedback clock period
   ------------------------------------------------
   PERIOD : PROCESS (clkin_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clkin_ipd'event and clkin_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF (t_in_clk = t_in_clk3) THEN
                  clock_valid <= '1';
             ELSE
                  clock_valid <= '0';
             END IF;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF (t_in_clk = t_in_clk1) THEN
                  clock_invalid <= '0';
             ELSE
                  clock_invalid <= '1';
             END IF;
           END IF;
      END IF;
   END PROCESS;

   PROCESS (fb_ipd)
   VARIABLE last_clock_edge : time := 0 ps;
   VARIABLE next_clock_edge : time := 0 ps;
   VARIABLE first_time      : Boolean := true;
   BEGIN
      IF (fb_ipd'event and fb_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
             IF (first_time) THEN
                t_fb_clk <= next_clock_edge - last_clock_edge;
                first_time := false;
             END IF;
           END IF;
      END IF;
      IF (last_clock_edge > 0 ps) THEN
           clkfb_per_valid <= '1';
      END IF;
   END PROCESS;

-------------------------------------------------
-- Assume ExpressCLK feedback (eclkfb = 1)
-------------------------------------------------
   PROCESS (t_fb_clk, funky_t_eclk)
   BEGIN
      IF (funky_t_eclk > 0 ps) THEN
         ext_divider <= (real(time'pos(t_fb_clk)) / real(time'pos(funky_t_eclk)));
      END IF;
   END PROCESS;

   ------------------------------------------------
   -- measure the feedback delay value
   ------------------------------------------------
   GENERATE_FIRST_FD_EDGE : PROCESS ( new_eclk, new_sclk, fb_ipd)
   VARIABLE new_eclk_first_time : boolean := true;
   VARIABLE new_sclk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_eclk_edge : time := 0 ps;
   VARIABLE first_sclk_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   BEGIN
      if (new_eclk'event and new_eclk'last_value = '0' and new_eclk = '1') then
         if (new_eclk_first_time) then
            first_eclk_edge := NOW;
            new_eclk_first_time := false;
         end if;
      end if;
      if (new_sclk'event and new_sclk'last_value = '0' and new_sclk = '1') then
         if (new_sclk_first_time) then
            first_sclk_edge := NOW;
            new_sclk_first_time := false;
         end if;
      end if;
      if (fb_ipd'event and fb_ipd'last_value = '0' and fb_ipd = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;
         total_fb_delay <= first_fb_edge - first_eclk_edge ;
   END PROCESS;


   DELAY1 : PROCESS (total_fb_delay, t_in_clk, ratio1, virtual_delay1)
   BEGIN
      IF ((total_fb_delay > 0 ps) and (t_in_clk > 0 ps)) THEN
          ratio1 <= total_fb_delay / t_in_clk;
          virtual_delay1 <= total_fb_delay - (t_in_clk * ratio1);
          real_delay1 <= t_in_clk - virtual_delay1 ;
      END IF;
   END PROCESS;

   DELAY2 : PROCESS (t_in_clk, ratio2, virtual_delay2)
   BEGIN
      IF (fbdelay > 0 ps and t_in_clk > 0 ps) THEN
          ratio2 <= fbdelay / t_in_clk;
          virtual_delay2 <= fbdelay - (t_in_clk * ratio2);
          real_delay2 <= t_in_clk - virtual_delay2 ;
      END IF;
   END PROCESS;

   REALDELAY : PROCESS (total_fb_delay, real_delay1, real_delay2)
   BEGIN
      IF (fbdelay = 0 ps) THEN
         IF (total_fb_delay = 0 ps) THEN
            real_delay <= 0 ps;
         ELSE
            real_delay <= real_delay1;
         END IF;
      ELSE
         real_delay <= real_delay2;
      END IF;
   END PROCESS;

   net_divide <= (real(div1) * ext_divider);

   P5 : PROCESS (net_divide, t_in_clk)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_any_clock <= ((t_in_clk * div0) / (net_divide));
      END IF;
   END PROCESS;

   ha_any_clk  <= (t_any_clock / 2);

   P6 : PROCESS (t_any_clock)
   BEGIN
      IF t_any_clock'event THEN
         t_inter_clk  <= (t_any_clock / div2);
      END IF;
   END PROCESS;

   ha_inter_clk  <= (t_inter_clk / 2);

-------------------------------------------------------
-- Generate ExpressCLK and SystemCLK
-------------------------------------------------------
   P8 : PROCESS (sclk_out)
   VARIABLE index : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (sclk_out'event) THEN
         IF (first_time) THEN
            IF (sclk_out = '1') THEN
               eclk_out <= '1';
               first_time := false;
               index := 0;
            END IF;
         ELSE
            index := index + 1;
            IF (index = div2) THEN
               eclk_out <= NOT eclk_out;
               index := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P53 : PROCESS (set_reset, eclk_out, sclk_out)
   BEGIN
      IF (set_reset = '0') THEN
         vir_eclk <= '0';
         vir_sclk <= '0';
      ELSE
         vir_eclk <= transport eclk_out after real_delay;
         vir_sclk <= transport sclk_out after real_delay;
      END IF;
   END PROCESS;

   P9 : PROCESS
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (first_time) THEN
         WAIT until (clock_valid'event and clock_valid = '1');
         sclk_out <= '1';
         first_time := false;
      ELSIF (clock_valid = '1') THEN
         WAIT FOR ha_inter_clk;
         sclk_out <= NOT sclk_out;
      END IF;
   END PROCESS;

-------------------------------------------------------
-- Generate LOCK signal
-------------------------------------------------------
   LOCK_IT : PROCESS (set_reset, vir_eclk, clock_invalid)
   VARIABLE counter : integer := 0;
   BEGIN
      IF (set_reset = '0') THEN
         lock_all <= '0';
         counter := 0;
      ELSE
        IF clock_invalid = '1' THEN
           lock_all <= '0';
           counter := 0;
        ELSE
           IF (vir_eclk'event and vir_eclk'last_value = '0' and vir_eclk = '1') THEN
              IF clock_valid = '1' THEN
                 counter := counter + 1;
                 IF (counter = 2) THEN
                    lock_all <= '1';
                    counter := 1;
                 END IF;
              END IF;
           END IF;
        END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (clock_valid, vir_eclk, vir_sclk, lock_all, new_eclk, new_sclk)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 3) := (others => '0');
   ALIAS eclk_zd : std_ulogic is results(1);
   ALIAS sclk_zd : std_ulogic is results(2);
   ALIAS lock_zd : std_ulogic is results(3);

   -- output glitch detection variables
   VARIABLE eclk_GlitchData : VitalGlitchDataType;
   VARIABLE sclk_GlitchData : VitalGlitchDataType;
   VARIABLE lock_GlitchData : VitalGlitchDataType;

   BEGIN

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (set_reset = '0') THEN
      eclk_zd := '0';
      sclk_zd := '0';
      lock_zd := '0';
    ELSE
      IF (clock_valid = '0') THEN
         eclk_zd := new_eclk;
         sclk_zd := new_sclk;
      ELSIF (clock_valid = '1') THEN
         eclk_zd := vir_eclk;
         sclk_zd := vir_sclk;
      END IF;
      lock_zd := lock_all;
    END IF;
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => eclk,
     OutSignalName => "eclk",
     OutTemp => eclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_eclk, TRUE)),
     GlitchData => eclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => sclk,
     OutSignalName => "sclk",
     OutTemp => sclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_sclk, TRUE)),
     GlitchData => sclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => lock,
     OutSignalName => "lock",
     OutTemp => lock_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_lock, TRUE)),
     GlitchData => lock_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;

--
----- cell pllt -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.global.gsrnet;
use work.global.purnet;


-- entity declaration --
ENTITY pllt IS
   GENERIC (
      div0               : Integer := 1;
      div1               : Integer := 1;
      div2               : Integer := 1;
      fbdelay            : Time    := 0 ns;
      disabled_gsr       : std_logic  := '0';
      TimingChecksOn     : Boolean := TRUE;
      XOn                : Boolean := FALSE;
      MsgOn              : Boolean := TRUE;
      InstancePath       : String  := "pllt";
      tpd_clkin_eclk     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_sclk     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_lock     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_fb            : VitalDelayType01 := (0 ns, 0 ns));

   PORT(
      clkin              : in std_logic ;
      fb                 : in std_logic ;
      eclk               : out std_logic;
      sclk               : out std_logic;
      lock               : out std_logic);

    ATTRIBUTE Vital_Level0 OF pllt : ENTITY IS TRUE;

END pllt ;

-- ARCHITECTURE body --
ARCHITECTURE V OF pllt IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clkin_ipd          : std_logic := '0';
    SIGNAL fb_ipd             : std_logic := '0';
    SIGNAL eclk_out           : std_logic := '0';
    SIGNAL sclk_out           : std_logic := '0';
    SIGNAL t_in_clk           : time := 0 ps;
    SIGNAL t_in_clk1          : time := 0 ps;
    SIGNAL t_in_clk2          : time := 0 ps;
    SIGNAL t_in_clk3          : time := 0 ps;
    SIGNAL t_fb_clk           : time := 0 ps;
    SIGNAL total_fb_delay     : time := 0 ps;
    SIGNAL real_delay         : time := 0 ps;
    SIGNAL real_delay1        : time := 0 ps;
    SIGNAL real_delay2        : time := 0 ps;
    SIGNAL virtual_delay1     : time := 0 ps;
    SIGNAL virtual_delay2     : time := 0 ps;
    SIGNAL t_any_clock        : time := 2 ps;
    SIGNAL ha_any_clk         : time := 1 ps;
    SIGNAL t_inter_clk        : time := 2 ps;
    SIGNAL ha_inter_clk       : time := 1 ps;
    SIGNAL clkfb_per_valid    : std_logic := '0';
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL clock_invalid      : std_logic := '0';
    SIGNAL vir_eclk           : std_logic := '0';
    SIGNAL vir_sclk           : std_logic := '0';
    SIGNAL lock_all           : std_logic := '0';
    SIGNAL ratio1             : integer := 0;
    SIGNAL ratio2             : integer := 0;
    SIGNAL set_reset          : std_logic := '0';

    SIGNAL new_eclk           : std_logic := '0';
    SIGNAL new_sclk           : std_logic := '0';
    SIGNAL funky_eclk         : std_logic := '0';
    SIGNAL funky_t_eclk       : time := 0 ns;
    SIGNAL funky_sclk         : std_logic := '0';
    SIGNAL funky_t1_sclk      : time := 5 ns;
    SIGNAL funky_t_sclk       : time := 0 ns;
    SIGNAL ext_divider        : Real := 1.0 ;
    SIGNAL net_divide         : Real := 1.0 ;


BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   VitalWireDelay(fb_ipd, fb, tipd_fb);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   ---------------------------------------------
   -- Create Funky clocks
   ---------------------------------------------
   funky_t_eclk <= (2 * funky_t1_sclk * div2);
   funky_t_sclk <= (2 * funky_t1_sclk);

   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (disabled_gsr =  '1') THEN
         set_reset <= purnet;
      ELSE
         set_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

   P51 : PROCESS
   VARIABLE first_time : boolean := true;
   BEGIN
        IF (first_time) THEN
          Wait for 5 ns;
          funky_sclk <= NOT funky_sclk;
          first_time := false;
        ELSE
          funky_sclk <= NOT funky_sclk;
          Wait for funky_t1_sclk;
        END IF;
   END PROCESS;

   P52 : PROCESS
   VARIABLE funky_t1_eclk : time := 0 ns;
   VARIABLE first_time : boolean := true;
   BEGIN
        IF (first_time) THEN
          Wait for 5 ns;
          funky_eclk <= NOT funky_eclk;
          first_time := false;
        ELSE
          funky_t1_eclk := funky_t1_sclk * div2;
          funky_eclk <= NOT funky_eclk;
          Wait for funky_t1_eclk;
        END IF;
   END PROCESS;

   P54 : PROCESS (set_reset, funky_sclk, funky_eclk)
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (set_reset = '0') THEN
         new_sclk <= '0';
         new_eclk <= '0';
      ELSE
         IF (first_time) THEN
           IF (funky_eclk'event and funky_eclk = '1') THEN
             new_sclk <= '1';
             new_eclk <= '1';
             first_time := false;
           END IF;
         ELSE
           IF funky_sclk'event THEN
             new_sclk <= funky_sclk;
           END IF;
           IF funky_eclk'event THEN
             new_eclk <= funky_eclk;
           END IF;
        END IF;
      END IF;
   END PROCESS;

   ----------------------------------
   -- measure input clock and feedback clock period
   ------------------------------------------------
   PERIOD : PROCESS (clkin_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clkin_ipd'event and clkin_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF (t_in_clk = t_in_clk3) THEN
                  clock_valid <= '1';
             ELSE
                  clock_valid <= '0';
             END IF;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF (t_in_clk = t_in_clk1) THEN
                  clock_invalid <= '0';
             ELSE
                  clock_invalid <= '1';
             END IF;
           END IF;
      END IF;
   END PROCESS;

   PROCESS (fb_ipd)
   VARIABLE last_clock_edge : time := 0 ps;
   VARIABLE next_clock_edge : time := 0 ps;
   VARIABLE first_time      : Boolean := true;
   BEGIN
      IF (fb_ipd'event and fb_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
             IF (first_time) THEN
                t_fb_clk <= next_clock_edge - last_clock_edge;
                first_time := false;
             END IF;
           END IF;
      END IF;
      IF (last_clock_edge > 0 ps) THEN
           clkfb_per_valid <= '1';
      END IF;
   END PROCESS;

-------------------------------------------------
-- Assume ExpressCLK feedback (eclkfb = 1)
-------------------------------------------------
   PROCESS (t_fb_clk, funky_t_eclk)
   BEGIN
      IF (funky_t_eclk > 0 ps) THEN
         ext_divider <= (real(time'pos(t_fb_clk)) / real(time'pos(funky_t_eclk)));
      END IF;
   END PROCESS;

   ------------------------------------------------
   -- measure the feedback delay value
   ------------------------------------------------
   GENERATE_FIRST_FD_EDGE : PROCESS ( new_eclk, new_sclk, fb_ipd)
   VARIABLE new_eclk_first_time : boolean := true;
   VARIABLE new_sclk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_eclk_edge : time := 0 ps;
   VARIABLE first_sclk_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   BEGIN
      if (new_eclk'event and new_eclk'last_value = '0' and new_eclk = '1') then
         if (new_eclk_first_time) then
            first_eclk_edge := NOW;
            new_eclk_first_time := false;
         end if;
      end if;
      if (new_sclk'event and new_sclk'last_value = '0' and new_sclk = '1') then
         if (new_sclk_first_time) then
            first_sclk_edge := NOW;
            new_sclk_first_time := false;
         end if;
      end if;
      if (fb_ipd'event and fb_ipd'last_value = '0' and fb_ipd = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;
         total_fb_delay <= first_fb_edge - first_eclk_edge ;
   END PROCESS;


   DELAY1 : PROCESS (total_fb_delay, t_in_clk, ratio1, virtual_delay1)
   BEGIN
      IF ((total_fb_delay > 0 ps) and (t_in_clk > 0 ps)) THEN
          ratio1 <= total_fb_delay / t_in_clk;
          virtual_delay1 <= total_fb_delay - (t_in_clk * ratio1);
          real_delay1 <= t_in_clk - virtual_delay1 ;
      END IF;
   END PROCESS;

   DELAY2 : PROCESS (t_in_clk, ratio2, virtual_delay2)
   BEGIN
      IF (fbdelay > 0 ps and t_in_clk > 0 ps) THEN
          ratio2 <= fbdelay / t_in_clk;
          virtual_delay2 <= fbdelay - (t_in_clk * ratio2);
          real_delay2 <= t_in_clk - virtual_delay2 ;
      END IF;
   END PROCESS;

   REALDELAY : PROCESS (total_fb_delay, real_delay1, real_delay2)
   BEGIN
      IF (fbdelay = 0 ps) THEN
         IF (total_fb_delay = 0 ps) THEN
            real_delay <= 0 ps;
         ELSE
            real_delay <= real_delay1;
         END IF;
      ELSE
         real_delay <= real_delay2;
      END IF;
   END PROCESS;

   net_divide <= (real(div1) * ext_divider);

   P5 : PROCESS (net_divide, t_in_clk)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_any_clock <= ((t_in_clk * div0) / (net_divide));
      END IF;
   END PROCESS;

   ha_any_clk  <= (t_any_clock / 2);

   P6 : PROCESS (t_any_clock)
   BEGIN
      IF t_any_clock'event THEN
         t_inter_clk  <= (t_any_clock / div2);
      END IF;
   END PROCESS;

   ha_inter_clk  <= (t_inter_clk / 2);

-------------------------------------------------------
-- Generate ExpressCLK and SystemCLK
-------------------------------------------------------
   P8 : PROCESS (sclk_out)
   VARIABLE index : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (sclk_out'event) THEN
         IF (first_time) THEN
            IF (sclk_out = '1') THEN
               eclk_out <= '1';
               first_time := false;
               index := 0;
            END IF;
         ELSE
            index := index + 1;
            IF (index = div2) THEN
               eclk_out <= NOT eclk_out;
               index := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P53 : PROCESS (set_reset, eclk_out, sclk_out)
   BEGIN
      IF (set_reset = '0') THEN
         vir_eclk <= '0';
         vir_sclk <= '0';
      ELSE
         vir_eclk <= transport eclk_out after real_delay;
         vir_sclk <= transport sclk_out after real_delay;
      END IF;
   END PROCESS;

   P9 : PROCESS
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (first_time) THEN
         WAIT until (clock_valid'event and clock_valid = '1');
         sclk_out <= '1';
         first_time := false;
      ELSIF (clock_valid = '1') THEN
         WAIT FOR ha_inter_clk;
         sclk_out <= NOT sclk_out;
      END IF;
   END PROCESS;

-------------------------------------------------------
-- Generate LOCK signal
-------------------------------------------------------
   LOCK_IT : PROCESS (set_reset, vir_eclk, clock_invalid)
   VARIABLE counter : integer := 0;
   BEGIN
      IF (set_reset = '0') THEN
         lock_all <= '0';
         counter := 0;
      ELSE
        IF clock_invalid = '1' THEN
           lock_all <= '0';
           counter := 0;
        ELSE
           IF (vir_eclk'event and vir_eclk'last_value = '0' and vir_eclk = '1') THEN
              IF clock_valid = '1' THEN
                 counter := counter + 1;
                 IF (counter = 2) THEN
                    lock_all <= '1';
                    counter := 1;
                 END IF;
              END IF;
           END IF;
        END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (clock_valid, vir_eclk, vir_sclk, lock_all, new_eclk, new_sclk)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 3) := (others => '0');
   ALIAS eclk_zd : std_ulogic is results(1);
   ALIAS sclk_zd : std_ulogic is results(2);
   ALIAS lock_zd : std_ulogic is results(3);

   -- output glitch detection variables
   VARIABLE eclk_GlitchData : VitalGlitchDataType;
   VARIABLE sclk_GlitchData : VitalGlitchDataType;
   VARIABLE lock_GlitchData : VitalGlitchDataType;

   BEGIN

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (set_reset = '0') THEN
      eclk_zd := '0';
      sclk_zd := '0';
      lock_zd := '0';
    ELSE
      IF (clock_valid = '0') THEN
         eclk_zd := new_eclk;
         sclk_zd := new_sclk;
      ELSIF (clock_valid = '1') THEN
         eclk_zd := vir_eclk;
         sclk_zd := vir_sclk;
      END IF;
      lock_zd := lock_all;
    END IF;
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => eclk,
     OutSignalName => "eclk",
     OutTemp => eclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_eclk, TRUE)),
     GlitchData => eclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => sclk,
     OutSignalName => "sclk",
     OutTemp => sclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_sclk, TRUE)),
     GlitchData => sclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => lock,
     OutSignalName => "lock",
     OutTemp => lock_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_lock, TRUE)),
     GlitchData => lock_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;


--
----- cell plldfb -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.global.gsrnet;
use work.global.purnet;


-- entity declaration --
ENTITY plldfb IS
   GENERIC (
      div0               : Integer := 1;
      div1               : Integer := 1;
      div2               : Integer := 1;
      fbdelay            : Time    := 0 ns;
      disabled_gsr       : std_logic  := '0';
      TimingChecksOn     : Boolean := TRUE;
      XOn                : Boolean := FALSE;
      MsgOn              : Boolean := TRUE;
      InstancePath       : String  := "plldfb";
      tpd_clkin_eclk     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_sclk     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_lock     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin         : VitalDelayType01 := (0 ns, 0 ns));

   PORT(
      clkin              : in std_logic ;
      eclk               : out std_logic;
      sclk               : out std_logic;
      lock               : out std_logic);

    ATTRIBUTE Vital_Level0 OF plldfb : ENTITY IS TRUE;

END plldfb ;

-- ARCHITECTURE body --
ARCHITECTURE V OF plldfb IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clkin_ipd          : std_logic := '0';
    SIGNAL eclk_out           : std_logic := '0';
    SIGNAL sclk_out           : std_logic := '0';
    SIGNAL t_in_clk           : time := 0 ps;
    SIGNAL t_in_clk1          : time := 0 ps;
    SIGNAL t_in_clk2          : time := 0 ps;
    SIGNAL t_in_clk3          : time := 0 ps;
    SIGNAL real_delay         : time := 0 ps;
    SIGNAL t_any_clock        : time := 2 ps;
    SIGNAL ha_any_clk         : time := 1 ps;
    SIGNAL t_inter_clk        : time := 2 ps;
    SIGNAL ha_inter_clk       : time := 1 ps;
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL clock_invalid      : std_logic := '0';
    SIGNAL vir_eclk           : std_logic := '0';
    SIGNAL vir_sclk           : std_logic := '0';
    SIGNAL lock_all           : std_logic := '0';
    SIGNAL set_reset          : std_logic := '0';
    SIGNAL ext_divider        : Real := 1.0 ;
    SIGNAL net_divide         : Real := 1.0 ;

BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (disabled_gsr =  '1') THEN
         set_reset <= purnet;
      ELSE
         set_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

   ----------------------------------
   -- measure input clock period
   ------------------------------------------------
   PERIOD : PROCESS (clkin_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clkin_ipd'event and clkin_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF (t_in_clk = t_in_clk3) THEN
                  clock_valid <= '1';
             ELSE
                  clock_valid <= '0';
             END IF;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF (t_in_clk = t_in_clk1) THEN
                  clock_invalid <= '0';
             ELSE
                  clock_invalid <= '1';
             END IF;
           END IF;
      END IF;
   END PROCESS;

   DELAY : PROCESS (t_in_clk)
   BEGIN
      IF (t_in_clk > 0 ps) THEN
         real_delay <= (t_in_clk - fbdelay);
      END IF;
   END PROCESS;

   net_divide <= (real(div1) * ext_divider);

   P5 : PROCESS (net_divide, t_in_clk)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_any_clock <= ((t_in_clk * div0) / (net_divide));
      END IF;
   END PROCESS;

   ha_any_clk  <= (t_any_clock / 2);

   P6 : PROCESS (t_any_clock)
   BEGIN
      IF t_any_clock'event THEN
         t_inter_clk  <= (t_any_clock / div2);
      END IF;
   END PROCESS;

   ha_inter_clk  <= (t_inter_clk / 2);

-------------------------------------------------------
-- Generate ExpressCLK and SystemCLK
-------------------------------------------------------
   P8 : PROCESS (sclk_out)
   VARIABLE index : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (sclk_out'event) THEN
         IF (first_time) THEN
            IF (sclk_out = '1') THEN
               eclk_out <= '1';
               first_time := false;
               index := 0;
            END IF;
         ELSE
            index := index + 1;
            IF (index = div2) THEN
               eclk_out <= NOT eclk_out;
               index := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P53 : PROCESS (set_reset, eclk_out, sclk_out)
   BEGIN
      IF (set_reset = '0') THEN
         vir_eclk <= '0';
         vir_sclk <= '0';
      ELSE
         vir_eclk <= transport eclk_out after real_delay;
         vir_sclk <= transport sclk_out after real_delay;
      END IF;
   END PROCESS;

   P9 : PROCESS
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (first_time) THEN
         WAIT until (clock_valid'event and clock_valid = '1');
         sclk_out <= '1';
         first_time := false;
      ELSIF (clock_valid = '1') THEN
         WAIT FOR ha_inter_clk;
         sclk_out <= NOT sclk_out;
      END IF;
   END PROCESS;

-------------------------------------------------------
-- Generate LOCK signal
-------------------------------------------------------
   LOCK_IT : PROCESS (set_reset, vir_eclk, clock_invalid)
   VARIABLE counter : integer := 0;
   BEGIN
      IF (set_reset = '0') THEN
         lock_all <= '0';
         counter := 0;
      ELSE
        IF clock_invalid = '1' THEN
           lock_all <= '0';
           counter := 0;
        ELSE
           IF (vir_eclk'event and vir_eclk'last_value = '0' and vir_eclk = '1') THEN
              IF clock_valid = '1' THEN
                 counter := counter + 1;
                 IF (counter = 2) THEN
                    lock_all <= '1';
                    counter := 1;
                 END IF;
              END IF;
           END IF;
        END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (clock_valid, vir_eclk, vir_sclk, lock_all)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 3) := (others => '0');
   ALIAS eclk_zd : std_ulogic is results(1);
   ALIAS sclk_zd : std_ulogic is results(2);
   ALIAS lock_zd : std_ulogic is results(3);

   -- output glitch detection variables
   VARIABLE eclk_GlitchData : VitalGlitchDataType;
   VARIABLE sclk_GlitchData : VitalGlitchDataType;
   VARIABLE lock_GlitchData : VitalGlitchDataType;

   BEGIN

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (set_reset = '0') THEN
      eclk_zd := '0';
      sclk_zd := '0';
      lock_zd := '0';
    ELSE
      IF (clock_valid = '0') THEN
         eclk_zd := '0';
         sclk_zd := '0';
      ELSIF (clock_valid = '1') THEN
         eclk_zd := vir_eclk;
         sclk_zd := vir_sclk;
      END IF;
      lock_zd := lock_all;
    END IF;
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => eclk,
     OutSignalName => "eclk",
     OutTemp => eclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_eclk, TRUE)),
     GlitchData => eclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => sclk,
     OutSignalName => "sclk",
     OutTemp => sclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_sclk, TRUE)),
     GlitchData => sclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => lock,
     OutSignalName => "lock",
     OutTemp => lock_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_lock, TRUE)),
     GlitchData => lock_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;



--
----- cell plldft -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.global.gsrnet;
use work.global.purnet;


-- entity declaration --
ENTITY plldft IS
   GENERIC (
      div0               : Integer := 1;
      div1               : Integer := 1;
      div2               : Integer := 1;
      fbdelay            : Time    := 0 ns;
      disabled_gsr       : std_logic  := '0';
      TimingChecksOn     : Boolean := TRUE;
      XOn                : Boolean := FALSE;
      MsgOn              : Boolean := TRUE;
      InstancePath       : String  := "plldft";
      tpd_clkin_eclk     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_sclk     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_lock     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin         : VitalDelayType01 := (0 ns, 0 ns));

   PORT(
      clkin              : in std_logic ;
      eclk               : out std_logic;
      sclk               : out std_logic;
      lock               : out std_logic);

    ATTRIBUTE Vital_Level0 OF plldft : ENTITY IS TRUE;

END plldft ;

-- ARCHITECTURE body --
ARCHITECTURE V OF plldft IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clkin_ipd          : std_logic := '0';
    SIGNAL eclk_out           : std_logic := '0';
    SIGNAL sclk_out           : std_logic := '0';
    SIGNAL t_in_clk           : time := 0 ps;
    SIGNAL t_in_clk1          : time := 0 ps;
    SIGNAL t_in_clk2          : time := 0 ps;
    SIGNAL t_in_clk3          : time := 0 ps;
    SIGNAL real_delay         : time := 0 ps;
    SIGNAL t_any_clock        : time := 2 ps;
    SIGNAL ha_any_clk         : time := 1 ps;
    SIGNAL t_inter_clk        : time := 2 ps;
    SIGNAL ha_inter_clk       : time := 1 ps;
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL clock_invalid      : std_logic := '0';
    SIGNAL vir_eclk           : std_logic := '0';
    SIGNAL vir_sclk           : std_logic := '0';
    SIGNAL lock_all           : std_logic := '0';
    SIGNAL set_reset          : std_logic := '0';
    SIGNAL ext_divider        : Real := 1.0 ;
    SIGNAL net_divide         : Real := 1.0 ;

BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (disabled_gsr =  '1') THEN
         set_reset <= purnet;
      ELSE
         set_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

   ----------------------------------
   -- measure input clock period
   ------------------------------------------------
   PERIOD : PROCESS (clkin_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clkin_ipd'event and clkin_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF (t_in_clk = t_in_clk3) THEN
                  clock_valid <= '1';
             ELSE
                  clock_valid <= '0';
             END IF;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF (t_in_clk = t_in_clk1) THEN
                  clock_invalid <= '0';
             ELSE
                  clock_invalid <= '1';
             END IF;
           END IF;
      END IF;
   END PROCESS;

   DELAY : PROCESS (t_in_clk)
   BEGIN
      IF (t_in_clk > 0 ps) THEN
         real_delay <= (t_in_clk - fbdelay);
      END IF;
   END PROCESS;

   net_divide <= (real(div1) * ext_divider);

   P5 : PROCESS (net_divide, t_in_clk)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_any_clock <= ((t_in_clk * div0) / (net_divide));
      END IF;
   END PROCESS;

   ha_any_clk  <= (t_any_clock / 2);

   P6 : PROCESS (t_any_clock)
   BEGIN
      IF t_any_clock'event THEN
         t_inter_clk  <= (t_any_clock / div2);
      END IF;
   END PROCESS;

   ha_inter_clk  <= (t_inter_clk / 2);

-------------------------------------------------------
-- Generate ExpressCLK and SystemCLK
-------------------------------------------------------
   P8 : PROCESS (sclk_out)
   VARIABLE index : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (sclk_out'event) THEN
         IF (first_time) THEN
            IF (sclk_out = '1') THEN
               eclk_out <= '1';
               first_time := false;
               index := 0;
            END IF;
         ELSE
            index := index + 1;
            IF (index = div2) THEN
               eclk_out <= NOT eclk_out;
               index := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P53 : PROCESS (set_reset, eclk_out, sclk_out)
   BEGIN
      IF (set_reset = '0') THEN
         vir_eclk <= '0';
         vir_sclk <= '0';
      ELSE
         vir_eclk <= transport eclk_out after real_delay;
         vir_sclk <= transport sclk_out after real_delay;
      END IF;
   END PROCESS;

   P9 : PROCESS
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (first_time) THEN
         WAIT until (clock_valid'event and clock_valid = '1');
         sclk_out <= '1';
         first_time := false;
      ELSIF (clock_valid = '1') THEN
         WAIT FOR ha_inter_clk;
         sclk_out <= NOT sclk_out;
      END IF;
   END PROCESS;

-------------------------------------------------------
-- Generate LOCK signal
-------------------------------------------------------
   LOCK_IT : PROCESS (set_reset, vir_eclk, clock_invalid)
   VARIABLE counter : integer := 0;
   BEGIN
      IF (set_reset = '0') THEN
         lock_all <= '0';
         counter := 0;
      ELSE
        IF clock_invalid = '1' THEN
           lock_all <= '0';
           counter := 0;
        ELSE
           IF (vir_eclk'event and vir_eclk'last_value = '0' and vir_eclk = '1') THEN
              IF clock_valid = '1' THEN
                 counter := counter + 1;
                 IF (counter = 2) THEN
                    lock_all <= '1';
                    counter := 1;
                 END IF;
              END IF;
           END IF;
        END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (clock_valid, vir_eclk, vir_sclk, lock_all)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 3) := (others => '0');
   ALIAS eclk_zd : std_ulogic is results(1);
   ALIAS sclk_zd : std_ulogic is results(2);
   ALIAS lock_zd : std_ulogic is results(3);

   -- output glitch detection variables
   VARIABLE eclk_GlitchData : VitalGlitchDataType;
   VARIABLE sclk_GlitchData : VitalGlitchDataType;
   VARIABLE lock_GlitchData : VitalGlitchDataType;

   BEGIN

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (set_reset = '0') THEN
      eclk_zd := '0';
      sclk_zd := '0';
      lock_zd := '0';
    ELSE
      IF (clock_valid = '0') THEN
         eclk_zd := '0';
         sclk_zd := '0';
      ELSIF (clock_valid = '1') THEN
         eclk_zd := vir_eclk;
         sclk_zd := vir_sclk;
      END IF;
      lock_zd := lock_all;
    END IF;
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => eclk,
     OutSignalName => "eclk",
     OutTemp => eclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_eclk, TRUE)),
     GlitchData => eclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => sclk,
     OutSignalName => "sclk",
     OutTemp => sclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_sclk, TRUE)),
     GlitchData => sclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => lock,
     OutSignalName => "lock",
     OutTemp => lock_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_lock, TRUE)),
     GlitchData => lock_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;


--
-----cell pcmb----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.conversion.all;
USE work.global.gsrnet;
USE work.global.purnet;


-- entity declaration --
ENTITY pcmb IS
   GENERIC (
      PCM                : PCM_MODE   := PCMBUF;
      DUTY               : real       := 50.0;
      PDELAY             : Integer    := 1;
      DIV0               : Integer    := 1;
      DIV1               : Integer    := 1;
      DIV2               : Integer    := 1;
      DISABLED_DONE      : std_logic  := '1';
      DISABLED_GSR       : std_logic  := '0';
      PWRON              : std_logic  := '1';
      FBDELAY            : Time       := 0 ps;
      TimingChecksOn     : Boolean    := TRUE;
      XOn                : Boolean    := FALSE;
      MsgOn              : Boolean    := TRUE;
      InstancePath       : String     := "pcmb";

      -- propagation delays
      tpd_clkin_eclk     : VitalDelayType01  := (0.1 ns, 0.1 ns);
      tpd_clkin_sclk     : VitalDelayType01  := (0.1 ns, 0.1 ns);
      tpd_clkin_lock     : VitalDelayType01  := (0.1 ns, 0.1 ns);
      tpd_re_do0         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do1         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do2         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do3         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do4         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do5         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do6         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do7         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

      -- setup and hold constraints
      tsetup_a0_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      thold_a0_we_noedge_negedge      : VitalDelayType := 0.01 ns;
      tsetup_a0_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      thold_a0_re_noedge_negedge      : VitalDelayType := 0.01 ns;
      tsetup_a1_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      thold_a1_we_noedge_negedge      : VitalDelayType := 0.01 ns;
      tsetup_a1_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      thold_a1_re_noedge_negedge      : VitalDelayType := 0.01 ns;
      tsetup_a2_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      thold_a2_we_noedge_negedge      : VitalDelayType := 0.01 ns;
      tsetup_a2_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      thold_a2_re_noedge_negedge      : VitalDelayType := 0.01 ns;
      tsetup_di0_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di0_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di0_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di0_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di1_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di1_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di1_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di1_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di2_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di2_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di2_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di2_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di3_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di3_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di3_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di3_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di4_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di4_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di4_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di4_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di5_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di5_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di5_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di5_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di6_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di6_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di6_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di6_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di7_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di7_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di7_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di7_re_noedge_negedge     : VitalDelayType := 0.01 ns;

      tipd_clkin         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_fb            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_we            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_re            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_a2            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_a1            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_a0            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di7           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di6           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di5           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di4           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di3           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di2           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di1           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di0           : VitalDelayType01 := (0 ns, 0 ns));

   PORT(
      clkin              : in std_logic ;
      fb                 : in std_logic ;
      we                 : in std_logic ;
      re                 : in std_logic ;
      a2                 : in std_logic ;
      a1                 : in std_logic ;
      a0                 : in std_logic ;
      di7                : in std_logic ;
      di6                : in std_logic ;
      di5                : in std_logic ;
      di4                : in std_logic ;
      di3                : in std_logic ;
      di2                : in std_logic ;
      di1                : in std_logic ;
      di0                : in std_logic ;
      do7                : out std_logic;
      do6                : out std_logic;
      do5                : out std_logic;
      do4                : out std_logic;
      do3                : out std_logic;
      do2                : out std_logic;
      do1                : out std_logic;
      do0                : out std_logic;
      eclk               : out std_logic;
      sclk               : out std_logic;
      lock               : out std_logic);

    ATTRIBUTE Vital_Level0 OF pcmb : ENTITY IS TRUE;

END pcmb ;

-- ARCHITECTURE body --
ARCHITECTURE V OF pcmb IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
--SIGNAL DECLARATIONS----
    SIGNAL clkin_ipd               : std_logic := '0';
    SIGNAL new_clock               : std_logic := '0';
    SIGNAL fb_ipd                  : std_logic := '0';
    SIGNAL we_ipd                  : std_logic := '0';
    SIGNAL re_ipd                  : std_logic := '0';
    SIGNAL DUTY1                   : Real      := 0.0;
    SIGNAL DUTY2                   : Real      := 0.0;

    SIGNAL addr                    : std_logic_vector(2 downto 0) := "000";
    SIGNAL data_in                 : std_logic_vector(7 downto 0) := "00000000";
    SIGNAL data_out                : std_logic_vector(7 downto 0) := "ZZZZZZZZ";
    SIGNAL configreg7              : std_logic_vector(7 downto 0) := "XXXXX00X";
    SIGNAL configreg6              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL configreg5              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL configreg4              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL configreg3              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL configreg2              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL configreg1              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL configreg0              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL mode                    : PCM_MODE := PCMBUF;
    SIGNAL new_mode                : PCM_MODE;
    SIGNAL frequence_reg           : real;
    SIGNAL new_frequence_reg       : real;
    SIGNAL duty_reg                : real := 0.0;
    SIGNAL duty_2x_tap1            : Integer := 0;
    SIGNAL duty_2x_tap2            : Integer := 0;
    SIGNAL new_duty_2x_tap1        : Integer := 0;
    SIGNAL new_duty_2x_tap2        : Integer := 0;
    SIGNAL duty_tap                : Integer := 0;
    SIGNAL new_duty_tap            : Integer := 0;
    SIGNAL new_duty_reg            : real := 0.0;
    SIGNAL pdelay_reg              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL pdelay_reg1             : Integer;
    SIGNAL new_pdelay_reg          : Integer;
    SIGNAL div0_reg1               : Integer := 0;
    SIGNAL div1_reg1               : Integer := 0;
    SIGNAL div2_reg1               : Integer := 0;
    SIGNAL div0_reg                : Integer := 0;
    SIGNAL div1_reg                : Integer := 0;
    SIGNAL div2_reg                : Integer := 0;
    SIGNAL done_reg                : std_logic := '0';
    SIGNAL new_done_reg            : std_logic := '0';
    SIGNAL gsr_reg                 : std_logic := '0';
    SIGNAL new_gsr_reg             : std_logic := '0';
    SIGNAL pwron_reg               : std_logic := '0';
    SIGNAL new_pwron_reg           : std_logic := '0';
    SIGNAL fbdelay_reg             : time := 0 ps;
    SIGNAL new_fbdelay_reg         : time := 0 ps;
-- Output signals
    SIGNAL eclk_buf                : std_logic := 'X';
    SIGNAL sclk_buf                : std_logic := 'X';
    SIGNAL lock_buf                : std_logic := '0';
    SIGNAL eclk_dll1x              : std_logic := 'X';
    SIGNAL sclk_dll1x              : std_logic := 'X';
    SIGNAL lock_dll1x              : std_logic := '0';
    SIGNAL eclk_dll2x              : std_logic := 'X';
    SIGNAL sclk_dll2x              : std_logic := 'X';
    SIGNAL lock_dll2x              : std_logic := '0';

    SIGNAL t_in_dllpd_clk          : time := 0 ps;
    SIGNAL t_in_dllpd_clk1         : time := 0 ps;
    SIGNAL clock_dllpd_delay       : time := 0 ps;
    SIGNAL eclk_dllpd_period       : time := 0 ps;
    SIGNAL eclk_dllpd_half_time    : time := 0 ps;
    SIGNAL sclk_dllpd_half_time    : time := 0 ps;
    SIGNAL clock_dllpd_valid       : std_logic := '0';
    SIGNAL clock_dllpd_invalid     : std_logic := '0';
    SIGNAL start_dllpd_clk         : std_logic := '0';
    SIGNAL eclk_dllpd_out1         : std_logic := '0';
    SIGNAL eclk_dllpd_out          : std_logic := '0';
    SIGNAL sclk_dllpd_out1         : std_logic := '0';
    SIGNAL sclk_dllpd_out          : std_logic := '0';
    SIGNAL lock_dllpd_out          : std_logic := '0';

    SIGNAL t_fb_pll_clk            : time := 0 ps;
    SIGNAL t_in_pll_clk            : time := 0 ps;
    SIGNAL t_in_pll_clk1           : time := 0 ps;
    SIGNAL t_in_pll_clk2           : time := 0 ps;
    SIGNAL t_in_pll_clk3           : time := 0 ps;
    SIGNAL t_fb_pll_clk1           : time := 0 ps;
    SIGNAL t_fb_pll_clk2           : time := 0 ps;
    SIGNAL t_fb_pll_clk3           : time := 0 ps;
    SIGNAL t_fb_clk                : time := 0 ps;
    SIGNAL t_any_clock             : time := 0 ps;
    SIGNAL ha_any_clk              : time := 0 ps;
    SIGNAL t_inter_clk             : time := 0 ps;
    SIGNAL ha_inter_clk            : time := 0 ps;
    SIGNAL total_fb_delay          : time := 0 ps;
    SIGNAL virtual_delay1          : time := 0 ps;
    SIGNAL virtual_delay2          : time := 0 ps;
    SIGNAL real_delay              : time := 0 ps;
    SIGNAL real_delay1             : time := 0 ps;
    SIGNAL real_delay2             : time := 0 ps;
    SIGNAL clock_pll_valid         : std_logic := '0';
    SIGNAL fbclock_pll_valid         : std_logic := '0';
    SIGNAL valid_pll_clock         : std_logic := '0';
    SIGNAL clkfb_per_valid         : std_logic := '0';
    SIGNAL clock_pll_invalid       : std_logic := '0';
    SIGNAL fbclock_pll_invalid       : std_logic := '0';
    SIGNAL eclk_pll_out            : std_logic := '0';
    SIGNAL sclk_pll_out            : std_logic := '0';
    SIGNAL lock_pll_all            : std_logic := '0';
    SIGNAL vir_eclk                : std_logic := '0';
    SIGNAL vir_sclk                : std_logic := '0';
    SIGNAL ratio1                  : integer := 0;
    SIGNAL ratio2                  : integer := 0;
    SIGNAL new_eclk                : std_logic := '0';
    SIGNAL new_sclk                : std_logic := '0';
    SIGNAL funky_eclk              : std_logic := '0';
    SIGNAL funky_t_eclk            : time := 0 ns;
    SIGNAL funky_sclk              : std_logic := '0';
    SIGNAL funky_t1_sclk           : time := 5 ns;
    SIGNAL funky_t_sclk            : time := 0 ns;
    SIGNAL ext_divider             : Real := 1.0 ;
    SIGNAL ext_divider1            : Real := 1.0 ;
    SIGNAL ext_divider_1           : Real := 1.0 ;
    SIGNAL ext_divider2            : Real := 1.0 ;
    SIGNAL ext_divider3            : Real := 1.0 ;
    SIGNAL net_divide              : Real := 1.0 ;
-- Reset signals
    SIGNAL local_dll_reset         : std_logic := '0';
    SIGNAL local_pcm_reset         : std_logic := '0';
    SIGNAL global_reset            : std_logic := '1';
    SIGNAL pwrup_reset             : std_logic := '1';
 
BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   VitalWireDelay(fb_ipd, fb, tipd_fb);
   VitalWireDelay(we_ipd, we, tipd_we);
   VitalWireDelay(re_ipd, re, tipd_re);
   VitalWireDelay(addr(2), a2, tipd_a2);
   VitalWireDelay(addr(1), a1, tipd_a1);
   VitalWireDelay(addr(0), a0, tipd_a0);
   VitalWireDelay(data_in(7), di7, tipd_di7);
   VitalWireDelay(data_in(6), di6, tipd_di6);
   VitalWireDelay(data_in(5), di5, tipd_di5);
   VitalWireDelay(data_in(4), di4, tipd_di4);
   VitalWireDelay(data_in(3), di3, tipd_di3);
   VitalWireDelay(data_in(2), di2, tipd_di2);
   VitalWireDelay(data_in(1), di1, tipd_di1);
   VitalWireDelay(data_in(0), di0, tipd_di0);
   END BLOCK;

-- Assign all the generics to signals

   DUTY1 <= DUTY;
   DUTY2 <= DUTY;

   mode <= PCM;
   duty_reg <= DUTY1;
   duty_tap <= INTEGER ((32.0*DUTY1)/100.0);
--   duty_2x_tap1 <= INTEGER ((16.0*DUTY1)/100.0);
--   duty_2x_tap2 <= INTEGER ((16.0*DUTY2)/100.0);
   pdelay_reg <= pdelay_tostd_logic_vector(PDELAY);
   pdelay_reg1 <= PDELAY;
   done_reg <= DISABLED_DONE;
   gsr_reg  <= DISABLED_GSR;
   pwron_reg <= PWRON;
   fbdelay_reg <= FBDELAY;

-- Initialization of Configuration Registers.

   P1 : PROCESS (pdelay_reg, we, addr, data_in, pwron_reg, done_reg, gsr_reg)
   BEGIN
      IF (NOW = 0 ns) THEN
        initialize (mode=>PCM, duty_tap=>duty_tap, div0_reg1=>DIV0, 
                    duty_reg=>DUTY1, div1_reg1=>DIV1, 
                    div2_reg1=>DIV2, pdelay_reg=>pdelay_reg, configreg6=>configreg6,
                    configreg5=>configreg5, configreg4=>configreg4, configreg3=>configreg3,
                    configreg2=>configreg2, configreg1=>configreg1, configreg0=>configreg0);       

        configreg7(0) <= pwron_reg; 
        configreg7(6) <= done_reg; 
        configreg7(7) <= gsr_reg; 
        configreg0(3 downto 0) <= std_logic_vector(to_unsigned(DIV0, 4)); 
        configreg1(3 downto 0) <= std_logic_vector(to_unsigned(DIV1, 4)); 
        configreg2(3 downto 0) <= std_logic_vector(to_unsigned(DIV2, 4)); 
      END IF;
      
      IF (we = '1') THEN
        CASE addr IS
            WHEN "000" => configreg0 <= data_in;
            WHEN "001" => configreg1 <= data_in;
            WHEN "010" => configreg2 <= data_in;
            WHEN "011" => configreg3 <= data_in;
            WHEN "100" => configreg4 <= data_in;
            WHEN "101" => configreg5 <= data_in;
            WHEN "110" => configreg6(7 downto 4) <= data_in(7 downto 4);
            WHEN "111" => configreg7 <= data_in;
            WHEN others => NULL;
        END CASE;
      END IF;
   END PROCESS;

   GLOBALRESET : PROCESS (gsrnet, configreg7(7))
    BEGIN
      IF (configreg7(7) =  '0') THEN
         global_reset <= gsrnet;                  -- gsrnet is active low
      ELSE
         global_reset <= '1';
      END IF;
    END PROCESS;

   POWERUPRESET : PROCESS (purnet, configreg7(6))
    BEGIN
      IF (configreg7(6) =  '0') THEN
         pwrup_reset <= purnet;                    -- purnet is active low
      ELSE
         pwrup_reset <= '1';
      END IF;
    END PROCESS;

   local_dll_reset <= (local_pcm_reset OR configreg7(2));
   local_pcm_reset <= (configreg7(1) OR (NOT(pwrup_reset)) OR (NOT(global_reset)));
-- Readback Process

   P2 : PROCESS (re, addr, configreg0, configreg1, configreg2, configreg3, configreg4, configreg5,
                 configreg6, configreg7)
   BEGIN
      IF (configreg7(0) = '0') THEN
         data_out <= "ZZZZZZZZ";
      ELSE

        IF (re = '1') THEN
          CASE addr IS
              WHEN "000" => data_out <= configreg0;
              WHEN "001" => data_out <= configreg1;
              WHEN "010" => data_out <= configreg2;
              WHEN "011" => data_out <= configreg3;
              WHEN "100" => data_out <= configreg4;
              WHEN "101" => data_out <= configreg5;
              WHEN "110" => data_out <= configreg6;
              WHEN "111" => data_out <= configreg7;
              WHEN others => NULL;
          END CASE; 
        ELSIF (re = '0') THEN
          data_out <= "ZZZZZZZZ";
        END IF;
      END IF;
   END PROCESS;

-- Mode Selection

   P3 : PROCESS (mode, configreg5, configreg6)
   BEGIN
      IF (NOW = 0 ns) THEN
        new_mode <= mode;
      END IF;

      IF (configreg5(0) = '1' and configreg5(2) = '0') THEN
        new_mode <= PLL;
      ELSIF (configreg5(0) = '0' and configreg5(4) = '1' and configreg5(2) = '1') THEN
          new_mode <= DLL1X;
      ELSIF (configreg5(0) = '0' and configreg5(4) = '0' and configreg5(2) = '1') THEN
        IF (configreg6(7 downto 4) = "101-") THEN
          new_mode <= DLLPD;
        END IF;
      ELSIF (configreg6(7 downto 4) = "0000") THEN
        new_mode <= PCMBUF;
      END IF;
   END PROCESS;

   P4 : PROCESS (div0_reg1, div1_reg1, div2_reg1, configreg0, configreg1, configreg2)
   BEGIN
      IF (NOW = 0 ns) THEN
        div0_reg <= div0_reg1;
        div1_reg <= div1_reg1;
        div2_reg <= div2_reg1;
      END IF;
      
      div0_reg <= divider_to_ratio(configreg0(3 downto 0));
      div1_reg <= divider_to_ratio(configreg1(3 downto 0));
      div2_reg <= divider_to_ratio(configreg2(3 downto 0));
   END PROCESS;
        
   P5 : PROCESS (configreg4, duty_tap)
   BEGIN
      IF (NOW = 0 ns) THEN
        new_duty_tap <= duty_tap;
      END IF;

      IF (configreg4(7) = '0') THEN
        IF (configreg4(6) = '0') THEN
          new_duty_tap <= (make_integer(configreg4(2 downto 0)) + 1); 
        ELSIF (configreg4(6) = '1') THEN
          IF (configreg4(5 downto 3) = "111") THEN
            new_duty_tap <= 16;
          ELSE
            new_duty_tap <= (make_integer(configreg4(2 downto 0)) + 9); 
          END IF;
        END IF;
      ELSIF (configreg4(7) = '1') THEN
        IF (configreg4(6) = '0') THEN
          new_duty_tap <= (make_integer(configreg4(5 downto 3)) + 17); 
        ELSIF (configreg4(6) = '1') THEN
          new_duty_tap <= (make_integer(configreg4(5 downto 3)) + 25);
        END IF;
      END IF;
   END PROCESS;

   P6 : PROCESS (configreg4, pdelay_reg1)
   BEGIN
      IF (NOW = 0 ns) THEN
        new_pdelay_reg <= pdelay_reg1;
      END IF;

      IF (configreg4(7) = '0') THEN
        IF (configreg4(6) = '0') THEN
          new_pdelay_reg <= (make_integer(configreg4(2 downto 0)) + 1);
        ELSIF (configreg4(6) = '1') THEN
          IF (configreg4(5 downto 3) = "111") THEN
            new_pdelay_reg <= 16;
          ELSE
            new_pdelay_reg <= (make_integer(configreg4(2 downto 0)) + 9);
          END IF;
        END IF;
      ELSIF (configreg4(7) = '1') THEN
        IF (configreg4(6) = '0') THEN
          new_pdelay_reg <= (make_integer(configreg4(5 downto 3)) + 17);
        ELSIF (configreg4(6) = '1') THEN
          new_pdelay_reg <= (make_integer(configreg4(5 downto 3)) + 25);
        END IF;
      END IF;
   END PROCESS;
         
    P20 : PROCESS (clkin_ipd)
    VARIABLE index : Integer := 0;
    VARIABLE first_time : boolean := true;
    BEGIN
       IF (clkin_ipd'event) THEN
          IF (first_time) THEN
             IF (clkin_ipd = '1') THEN
                new_clock <= '1';
                first_time := false;
                index := 0;
             END IF;
          ELSE
             index := index + 1;
             IF (index = div0_reg) THEN
                new_clock <= NOT new_clock;
                index := 0;
             END IF;
          END IF;
       END IF;
    END PROCESS;

------------------------------------------------------------------------------------------------
-- Clock generation for PCMBUF mode
------------------------------------------------------------------------------------------------

   P8 : PROCESS (new_mode, clkin_ipd, local_pcm_reset)
   BEGIN
      IF (local_pcm_reset = '1') THEN
         lock_buf <= '0';
         eclk_buf <= '0';
         sclk_buf <= '0';
      ELSE
      IF (new_mode = PCMBUF) THEN
        eclk_buf <= VitalBUF(clkin_ipd);
        sclk_buf <= VitalBUF(clkin_ipd);
        IF (clkin_ipd'event AND clkin_ipd = '1') THEN
          lock_buf <= '1';
        END IF;
      END IF;
      END IF;
   END PROCESS;

------------------------------------------------------------------------------------------------
-- Clock generation for DLL1X mode
------------------------------------------------------------------------------------------------
   P9 : PROCESS (new_mode, new_clock, new_duty_tap, local_dll_reset)
   VARIABLE last_cycle, next_cycle, last_clock_edge : time := 0 ps;
   VARIABLE clock_delay : time := 0 ps;
   BEGIN
      IF (local_dll_reset = '1') THEN
         lock_dll1x <= '0';
         eclk_dll1x <= '0';
         sclk_dll1x <= '0';
      ELSE
      IF (new_mode = DLL1X) THEN
        IF (new_clock'event and new_clock = '1') THEN
           last_cycle := next_cycle;
           next_cycle := NOW - last_clock_edge;

           IF (next_cycle = last_cycle) THEN
              lock_dll1x <= '1';
           ELSE
              lock_dll1x <= '0';
           END IF;

           last_clock_edge := NOW;
           clock_delay := ((next_cycle * new_duty_tap)/32);

           eclk_dll1x <= '1';
           sclk_dll1x <= '1';

           eclk_dll1x <= transport '0' after clock_delay;
           sclk_dll1x <= transport '0' after clock_delay;
        END IF;
      END IF;
      END IF;
   END PROCESS;

------------------------------------------------------------------------------------------------
-- Clock generation for DLLPD mode
------------------------------------------------------------------------------------------------
   P11 : PROCESS (new_clock, local_pcm_reset)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   VARIABLE t_in_clk2 : time := 0 ps;
   BEGIN
      IF (local_pcm_reset = '1') THEN
         clock_dllpd_invalid <= '1';
      ELSE
      IF (new_clock'event and new_clock = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
              t_in_clk2 := next_clock_edge - last_clock_edge;
              IF (t_in_clk2 > 0 ps) THEN
                IF (t_in_clk2 = t_in_dllpd_clk) THEN
                   clock_dllpd_invalid <= '0';
                ELSE
                   clock_dllpd_invalid <= '1';
                END IF;
              END IF;
              t_in_dllpd_clk <= t_in_clk2;
           END IF;

           IF (t_in_dllpd_clk > 0 ps) THEN
             t_in_dllpd_clk1 <= t_in_dllpd_clk;
             IF (t_in_dllpd_clk = t_in_dllpd_clk1) THEN
                  clock_dllpd_valid <= '1';
             ELSE
                  clock_dllpd_valid <= '0';
             END IF;
           END IF;
       END IF;
       END IF;
   END PROCESS;

   clock_dllpd_delay <= ((t_in_dllpd_clk * new_pdelay_reg)/32);
   eclk_dllpd_period <= t_in_dllpd_clk * div2_reg;
   start_dllpd_clk <= transport clock_dllpd_valid after clock_dllpd_delay;
   eclk_dllpd_half_time <= eclk_dllpd_period/2;
   sclk_dllpd_half_time <= t_in_dllpd_clk/2;
   sclk_dllpd_out <= transport sclk_dllpd_out1 after clock_dllpd_delay;

   P12 : PROCESS (sclk_dllpd_out)
   VARIABLE index : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (sclk_dllpd_out'event) THEN
         IF (first_time) THEN
            IF (sclk_dllpd_out = '1') THEN
               eclk_dllpd_out <= '1';
               first_time := false;
               index := 0;
            END IF;
         ELSE 
            index := index + 1;
            IF (index = div2_reg) THEN
               eclk_dllpd_out <= NOT eclk_dllpd_out;
               index := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P13 : PROCESS
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (first_time) THEN
          WAIT until (clock_dllpd_valid'event and clock_dllpd_valid = '1'); 
          sclk_dllpd_out1 <= '1';
          first_time := false;
      ELSIF (clock_dllpd_valid = '1') THEN
        WAIT FOR sclk_dllpd_half_time;
        sclk_dllpd_out1 <= NOT sclk_dllpd_out1;
      END IF;
   END PROCESS;

   P14 : PROCESS (start_dllpd_clk, clock_dllpd_invalid, sclk_dllpd_out, eclk_dllpd_out )
   BEGIN
      IF (clock_dllpd_invalid = '1') THEN
        lock_dllpd_out <= '0';
      ELSE
        IF (start_dllpd_clk = '1') THEN
          IF (eclk_dllpd_out ='1' and sclk_dllpd_out = '1') THEN
             lock_dllpd_out <= '1';
          END IF;
        END IF;
      END IF;
   END PROCESS;

------------------------------------------------------------------------------------------------
-- Clock generation for PLL mode
------------------------------------------------------------------------------------------------
   ---------------------------------------------
   -- Create Funky clocks
   ---------------------------------------------
   funky_t_eclk <= (2 * funky_t1_sclk * div2_reg);
   funky_t_sclk <= (2 * funky_t1_sclk);

   P51 : PROCESS 
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (first_time) THEN
        Wait for 5 ns;
        funky_sclk <= NOT funky_sclk;
        first_time := false;
      ELSE
        funky_sclk <= NOT funky_sclk;
        Wait for funky_t1_sclk;
      END IF;
   END PROCESS;

   P52 : PROCESS
   VARIABLE funky_t1_eclk : time := 0 ns;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (first_time) THEN
        Wait for 5 ns;
        funky_eclk <= NOT funky_eclk;
        first_time := false;
      ELSE
        funky_t1_eclk := funky_t1_sclk * div2_reg;
        funky_eclk <= NOT funky_eclk;
        Wait for funky_t1_eclk;
      END IF;
   END PROCESS;

   P54 : PROCESS (local_pcm_reset, funky_sclk, funky_eclk)
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (local_pcm_reset = '1') THEN
         new_sclk <= '0';
         new_eclk <= '0';
      ELSE
         IF (first_time) THEN
           IF (funky_eclk'event and funky_eclk = '1')THEN
             new_sclk <= funky_sclk;
             new_eclk <= funky_eclk;
             first_time := false;
           END IF;
         ELSE
           IF funky_eclk'event THEN
             new_eclk <= funky_eclk;
           END IF;
           IF funky_sclk'event THEN
             new_sclk <= funky_sclk;
           END IF;
         END IF;
      END IF;
   END PROCESS;

   ----------------------------------
   -- measure input clock and feedback clock period
   ------------------------------------------------

   PLL1 : PROCESS (clkin_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clkin_ipd'event and clkin_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_pll_clk <= next_clock_edge - last_clock_edge;
                t_in_pll_clk1 <= t_in_pll_clk;
                t_in_pll_clk2 <= t_in_pll_clk1;
                t_in_pll_clk3 <= t_in_pll_clk2;
           END IF;
           IF (t_in_pll_clk > 0 ps) THEN
             IF (t_in_pll_clk = t_in_pll_clk3) THEN
                  clock_pll_valid <= '1';
             ELSE
                  clock_pll_valid <= '0';
             END IF;
           END IF;
           IF (t_in_pll_clk > 0 ps) THEN
             IF (t_in_pll_clk = t_in_pll_clk1) THEN
                  clock_pll_invalid <= '0';
             ELSE
                  clock_pll_invalid <= '1';
             END IF;
           END IF;
      END IF;
   END PROCESS;

   PROCESS (fb_ipd)
   VARIABLE last_clock_edge : time := 0 ps;
   VARIABLE next_clock_edge : time := 0 ps;
   BEGIN
      IF (fb_ipd'event and fb_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_fb_clk <= next_clock_edge - last_clock_edge;
           END IF;
      END IF;
      IF (last_clock_edge > 0 ps) THEN
           clkfb_per_valid <= '1';
      END IF;
   END PROCESS;

   PLL101 : PROCESS (fb_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (fb_ipd'event and fb_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_fb_pll_clk <= next_clock_edge - last_clock_edge;
                t_fb_pll_clk1 <= t_fb_pll_clk;
                t_fb_pll_clk2 <= t_fb_pll_clk1;
                t_fb_pll_clk3 <= t_fb_pll_clk2;
           END IF;

           IF (t_fb_pll_clk > 0 ps) THEN
             IF (t_fb_pll_clk = t_fb_pll_clk2) THEN
                  fbclock_pll_valid <= '1';
             ELSE
                  fbclock_pll_valid <= '0';
             END IF;
           END IF;
           IF (t_fb_pll_clk > 0 ps) THEN
             IF (t_fb_pll_clk = t_fb_pll_clk1) THEN
                  fbclock_pll_invalid <= '0';
             ELSE
                  fbclock_pll_invalid <= '1';
             END IF;
           END IF;
      END IF;
   END PROCESS;

-------------------------------------------------
-- Assume ExpressCLK feedback (eclkfb = 1)
-------------------------------------------------
   PROCESS (new_eclk)
   BEGIN
      IF (lock_pll_all = '0') THEN
          IF ((funky_t_eclk > 0 ps) and (t_fb_clk > 0 ps)) THEN
             ext_divider1 <= (real(time'pos(t_fb_clk)) / real(time'pos(funky_t_eclk)));
             ext_divider2 <= ext_divider1;
             ext_divider3 <= ext_divider2;
          END IF;
          IF (ext_divider1 = ext_divider3) THEN
             ext_divider_1 <= ext_divider3;
          END IF;
      END IF;
   END PROCESS;

   PROCESS (vir_eclk, ext_divider_1)
   VARIABLE first_time      : Boolean := true;
   BEGIN
      IF (first_time) THEN
         ext_divider <= ext_divider_1;
         IF (vir_eclk'event and vir_eclk = '1') THEN
                ext_divider <= ext_divider_1;
                first_time := false;
         END IF;
      END IF;
   END PROCESS;

   ------------------------------------------------
   -- measure the feedback delay value
   ------------------------------------------------
   GENERATE_FIRST_FD_EDGE : PROCESS ( new_eclk, new_sclk, fb_ipd)
   VARIABLE new_eclk_first_time : boolean := true;
   VARIABLE new_sclk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_eclk_edge : time := 0 ps;
   VARIABLE first_sclk_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   BEGIN
      if (new_eclk'event and new_eclk'last_value = '0' and new_eclk = '1') then
         if (new_eclk_first_time) then
            first_eclk_edge := NOW;
            new_eclk_first_time := false;
         end if;
      end if;
      if (new_sclk'event and new_sclk'last_value = '0' and new_sclk = '1') then
         if (new_sclk_first_time) then
            first_sclk_edge := NOW;
            new_sclk_first_time := false;
         end if;
      end if;
      if (fb_ipd'event and fb_ipd'last_value = '0' and fb_ipd = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;
         total_fb_delay <= first_fb_edge - first_eclk_edge ;
   END PROCESS;

   net_divide <= (real(div1_reg) * ext_divider);

   PLL2 : PROCESS (net_divide, t_in_pll_clk, div0_reg)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_any_clock <= ((t_in_pll_clk * div0_reg) / net_divide);
      END IF;
   END PROCESS;

   ha_any_clk  <= (t_any_clock / 2);

   PLL3 : PROCESS (t_any_clock, div2_reg)
   BEGIN
      IF (t_any_clock'event or div2_reg'event) THEN
         t_inter_clk  <= (t_any_clock / div2_reg);
      END IF;
   END PROCESS;

   ha_inter_clk  <= (t_inter_clk / 2);

   PLL7 : PROCESS (total_fb_delay, t_in_pll_clk, ratio1, virtual_delay1)
   BEGIN
      IF ((total_fb_delay > 0 ps) and (t_in_pll_clk > 0 ps)) THEN
          ratio1 <= total_fb_delay / t_in_pll_clk;
          virtual_delay1 <= total_fb_delay - (t_in_pll_clk * ratio1);
          real_delay1 <= t_in_pll_clk - virtual_delay1 ;
      END IF;
   END PROCESS;

   PLL8 : PROCESS (t_in_pll_clk, ratio2, virtual_delay2)
   BEGIN
      IF (fbdelay_reg > 0 ps and t_in_pll_clk > 0 ps) THEN
          ratio2 <= fbdelay / t_in_pll_clk;
          virtual_delay2 <= fbdelay_reg - (t_in_pll_clk * ratio2);
          real_delay2 <= t_in_pll_clk - virtual_delay2 ;
      END IF;
   END PROCESS;

   PLL9 : PROCESS (total_fb_delay, real_delay1, real_delay2)
   BEGIN
      IF (fbdelay = 0 ps) THEN
         IF (total_fb_delay = 0 ps) THEN
            real_delay <= 0 ps;
         ELSE
            real_delay <= real_delay1;
         END IF;
      ELSE
         real_delay <= real_delay2;
      END IF;
   END PROCESS;

   PLL5 : PROCESS (sclk_pll_out)
   VARIABLE index : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (sclk_pll_out'event) THEN
         IF (first_time) THEN
            IF (sclk_pll_out = '1') THEN
               eclk_pll_out <= '1';
               first_time := false;
               index := 0;
            END IF;
         ELSE 
            index := index + 1;
            IF (index = div2_reg) THEN
               eclk_pll_out <= NOT eclk_pll_out;
               index := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   PLL25 : PROCESS (clock_pll_valid, ha_inter_clk)
   BEGIN
      IF (ha_inter_clk > 0 ps) THEN
         valid_pll_clock <= clock_pll_valid;
      END IF;
   END PROCESS;

   PLL10 : PROCESS
   VARIABLE first_time : boolean := true;
   BEGIN
        IF (first_time) THEN
        WAIT until (valid_pll_clock'event and valid_pll_clock = '1') ;
           sclk_pll_out <= '1';
           first_time := false;
           WAIT FOR ha_inter_clk;
        ELSIF (clock_pll_valid = '1') THEN
           sclk_pll_out <= NOT sclk_pll_out;
           WAIT FOR ha_inter_clk;
        END IF;
   END PROCESS;

   PLL13 : PROCESS (vir_eclk, clock_pll_invalid, local_pcm_reset)
   VARIABLE counter : integer := 0;
   BEGIN
      IF (local_pcm_reset = '1') THEN
         lock_pll_all <= '0';
         counter := 0;
      ELSE
      if clock_pll_invalid = '1' then
         lock_pll_all <= '0';
         counter := 0;
      else
         if (vir_eclk'event and vir_eclk'last_value = '0' and vir_eclk = '1') THEN
            if clock_pll_valid = '1' then
               counter := counter + 1;
               if (counter = 2) THEN
                  lock_pll_all <= '1';
                  counter := 1;
               end if;
            end if;
         end if;
      end if;
      END IF;
   END PROCESS;

   PLL14 : PROCESS (eclk_pll_out, sclk_pll_out, local_pcm_reset)
   BEGIN
      IF (local_pcm_reset = '1') THEN
         vir_eclk <= '0';
         vir_sclk <= '0';
      ELSE
         vir_eclk <= transport eclk_pll_out after real_delay;
         vir_sclk <= transport sclk_pll_out after real_delay;
      END IF;
   END PROCESS;

------------------------------------------------------------------------------------------------
-- Output Clock Generation 
------------------------------------------------------------------------------------------------
   VitalBehavior : PROCESS (new_mode, eclk_buf, sclk_buf, lock_buf, eclk_dll1x, sclk_dll1x, lock_dll1x, 
                   eclk_dllpd_out, sclk_dllpd_out, lock_dllpd_out, local_pcm_reset,
                   vir_eclk, vir_sclk, lock_pll_all, data_out, clock_pll_valid, new_eclk, new_sclk)

   -- functionality results
   VARIABLE violation : x01 := '0';
   VARIABLE results : std_logic_vector(11 downto 1) := (others => '0');
   ALIAS eclk_zd : std_ulogic is results(1);
   ALIAS sclk_zd : std_ulogic is results(2);
   ALIAS lock_zd : std_ulogic is results(3);
   ALIAS do0_zd  : std_ulogic is results(4);
   ALIAS do1_zd  : std_ulogic is results(5);
   ALIAS do2_zd  : std_ulogic is results(6);
   ALIAS do3_zd  : std_ulogic is results(7);
   ALIAS do4_zd  : std_ulogic is results(8);
   ALIAS do5_zd  : std_ulogic is results(9);
   ALIAS do6_zd  : std_ulogic is results(10);
   ALIAS do7_zd  : std_ulogic is results(11);

   -- timing check results
   VARIABLE tviol_a0_we   : x01 := '0';
   VARIABLE tviol_a0_re   : x01 := '0';
   VARIABLE tviol_a1_we   : x01 := '0';
   VARIABLE tviol_a1_re   : x01 := '0';
   VARIABLE tviol_a2_we   : x01 := '0';
   VARIABLE tviol_a2_re   : x01 := '0';
   VARIABLE tviol_di0_we  : x01 := '0';
   VARIABLE tviol_di0_re  : x01 := '0';
   VARIABLE tviol_di1_we  : x01 := '0';
   VARIABLE tviol_di1_re  : x01 := '0';
   VARIABLE tviol_di2_we  : x01 := '0';
   VARIABLE tviol_di2_re  : x01 := '0';
   VARIABLE tviol_di3_we  : x01 := '0';
   VARIABLE tviol_di3_re  : x01 := '0';
   VARIABLE tviol_di4_we  : x01 := '0';
   VARIABLE tviol_di4_re  : x01 := '0';
   VARIABLE tviol_di5_we  : x01 := '0';
   VARIABLE tviol_di5_re  : x01 := '0';
   VARIABLE tviol_di6_we  : x01 := '0';
   VARIABLE tviol_di6_re  : x01 := '0';
   VARIABLE tviol_di7_we  : x01 := '0';
   VARIABLE tviol_di7_re  : x01 := '0';
   VARIABLE a0_we_TimingDatash  : VitalTimingDataType;
   VARIABLE a0_re_TimingDatash  : VitalTimingDataType;
   VARIABLE a1_we_TimingDatash  : VitalTimingDataType;
   VARIABLE a1_re_TimingDatash  : VitalTimingDataType;
   VARIABLE a2_we_TimingDatash  : VitalTimingDataType;
   VARIABLE a2_re_TimingDatash  : VitalTimingDataType;
   VARIABLE di0_we_TimingDatash : VitalTimingDataType;
   VARIABLE di0_re_TimingDatash : VitalTimingDataType;
   VARIABLE di1_we_TimingDatash : VitalTimingDataType;
   VARIABLE di1_re_TimingDatash : VitalTimingDataType;
   VARIABLE di2_we_TimingDatash : VitalTimingDataType;
   VARIABLE di2_re_TimingDatash : VitalTimingDataType;
   VARIABLE di3_we_TimingDatash : VitalTimingDataType;
   VARIABLE di3_re_TimingDatash : VitalTimingDataType;
   VARIABLE di4_we_TimingDatash : VitalTimingDataType;
   VARIABLE di4_re_TimingDatash : VitalTimingDataType;
   VARIABLE di5_we_TimingDatash : VitalTimingDataType;
   VARIABLE di5_re_TimingDatash : VitalTimingDataType;
   VARIABLE di6_we_TimingDatash : VitalTimingDataType;
   VARIABLE di6_re_TimingDatash : VitalTimingDataType;
   VARIABLE di7_we_TimingDatash : VitalTimingDataType;
   VARIABLE di7_re_TimingDatash : VitalTimingDataType;

   -- output glitch detection variables
   VARIABLE eclk_GlitchData : VitalGlitchDataType;
   VARIABLE sclk_GlitchData : VitalGlitchDataType;
   VARIABLE lock_GlitchData : VitalGlitchDataType;
   VARIABLE do0_GlitchData  : VitalGlitchDataType;
   VARIABLE do1_GlitchData  : VitalGlitchDataType;
   VARIABLE do2_GlitchData  : VitalGlitchDataType;
   VARIABLE do3_GlitchData  : VitalGlitchDataType;
   VARIABLE do4_GlitchData  : VitalGlitchDataType;
   VARIABLE do5_GlitchData  : VitalGlitchDataType;
   VARIABLE do6_GlitchData  : VitalGlitchDataType;
   VARIABLE do7_GlitchData  : VitalGlitchDataType;

   BEGIN

   -----------------------
   -- timing check section
   -----------------------

    IF (TimingChecksOn) THEN

           VitalSetupHoldCheck (
                TestSignal => addr(0),
                TestSignalName => "a0",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_a0_we_noedge_negedge,
                setuplow => tsetup_a0_we_noedge_negedge,
                HoldHigh => thold_a0_we_noedge_negedge,
                HoldLow => thold_a0_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => a0_we_timingdatash,
                Violation => tviol_a0_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => addr(0),
                TestSignalName => "a0",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_a0_re_noedge_negedge,
                setuplow => tsetup_a0_re_noedge_negedge,
                HoldHigh => thold_a0_re_noedge_negedge,
                HoldLow => thold_a0_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => a0_re_timingdatash,
                Violation => tviol_a0_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => addr(1),
                TestSignalName => "a1",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_a1_we_noedge_negedge,
                setuplow => tsetup_a1_we_noedge_negedge,
                HoldHigh => thold_a1_we_noedge_negedge,
                HoldLow => thold_a1_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => a1_we_timingdatash,
                Violation => tviol_a1_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => addr(1),
                TestSignalName => "a1",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_a1_re_noedge_negedge,
                setuplow => tsetup_a1_re_noedge_negedge,
                HoldHigh => thold_a1_re_noedge_negedge,
                HoldLow => thold_a1_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => a1_re_timingdatash,
                Violation => tviol_a1_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => addr(2),
                TestSignalName => "a2",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_a2_we_noedge_negedge,
                setuplow => tsetup_a2_we_noedge_negedge,
                HoldHigh => thold_a2_we_noedge_negedge,
                HoldLow => thold_a2_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => a2_we_timingdatash,
                Violation => tviol_a2_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => addr(2),
                TestSignalName => "a2",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_a2_re_noedge_negedge,
                setuplow => tsetup_a2_re_noedge_negedge,
                HoldHigh => thold_a2_re_noedge_negedge,
                HoldLow => thold_a2_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => a2_re_timingdatash,
                Violation => tviol_a2_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(0),
                TestSignalName => "di0",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di0_we_noedge_negedge,
                setuplow => tsetup_di0_we_noedge_negedge,
                HoldHigh => thold_di0_we_noedge_negedge,
                HoldLow => thold_di0_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di0_we_timingdatash,
                Violation => tviol_di0_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(0),
                TestSignalName => "di0",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di0_re_noedge_negedge,
                setuplow => tsetup_di0_re_noedge_negedge,
                HoldHigh => thold_di0_re_noedge_negedge,
                HoldLow => thold_di0_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di0_re_timingdatash,
                Violation => tviol_di0_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(1),
                TestSignalName => "di1",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di1_we_noedge_negedge,
                setuplow => tsetup_di1_we_noedge_negedge,
                HoldHigh => thold_di1_we_noedge_negedge,
                HoldLow => thold_di1_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di1_we_timingdatash,
                Violation => tviol_di1_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(1),
                TestSignalName => "di1",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di1_re_noedge_negedge,
                setuplow => tsetup_di1_re_noedge_negedge,
                HoldHigh => thold_di1_re_noedge_negedge,
                HoldLow => thold_di1_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di1_re_timingdatash,
                Violation => tviol_di1_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(2),
                TestSignalName => "di2",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di2_we_noedge_negedge,
                setuplow => tsetup_di2_we_noedge_negedge,
                HoldHigh => thold_di2_we_noedge_negedge,
                HoldLow => thold_di2_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di2_we_timingdatash,
                Violation => tviol_di2_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(2),
                TestSignalName => "di2",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di2_re_noedge_negedge,
                setuplow => tsetup_di2_re_noedge_negedge,
                HoldHigh => thold_di2_re_noedge_negedge,
                HoldLow => thold_di2_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di2_re_timingdatash,
                Violation => tviol_di2_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(3),
                TestSignalName => "di3",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di3_we_noedge_negedge,
                setuplow => tsetup_di3_we_noedge_negedge,
                HoldHigh => thold_di3_we_noedge_negedge,
                HoldLow => thold_di3_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di3_we_timingdatash,
                Violation => tviol_di3_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(3),
                TestSignalName => "di3",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di3_re_noedge_negedge,
                setuplow => tsetup_di3_re_noedge_negedge,
                HoldHigh => thold_di3_re_noedge_negedge,
                HoldLow => thold_di3_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di3_re_timingdatash,
                Violation => tviol_di3_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(4),
                TestSignalName => "di4",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di4_we_noedge_negedge,
                setuplow => tsetup_di4_we_noedge_negedge,
                HoldHigh => thold_di4_we_noedge_negedge,
                HoldLow => thold_di4_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di4_we_timingdatash,
                Violation => tviol_di4_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(4),
                TestSignalName => "di4",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di4_re_noedge_negedge,
                setuplow => tsetup_di4_re_noedge_negedge,
                HoldHigh => thold_di4_re_noedge_negedge,
                HoldLow => thold_di4_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di4_re_timingdatash,
                Violation => tviol_di4_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(5),
                TestSignalName => "di5",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di5_we_noedge_negedge,
                setuplow => tsetup_di5_we_noedge_negedge,
                HoldHigh => thold_di5_we_noedge_negedge,
                HoldLow => thold_di5_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di5_we_timingdatash,
                Violation => tviol_di5_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(5),
                TestSignalName => "di5",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di5_re_noedge_negedge,
                setuplow => tsetup_di5_re_noedge_negedge,
                HoldHigh => thold_di5_re_noedge_negedge,
                HoldLow => thold_di5_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di5_re_timingdatash,
                Violation => tviol_di5_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(6),
                TestSignalName => "di6",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di6_we_noedge_negedge,
                setuplow => tsetup_di6_we_noedge_negedge,
                HoldHigh => thold_di6_we_noedge_negedge,
                HoldLow => thold_di6_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di6_we_timingdatash,
                Violation => tviol_di6_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(6),
                TestSignalName => "di6",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di6_re_noedge_negedge,
                setuplow => tsetup_di6_re_noedge_negedge,
                HoldHigh => thold_di6_re_noedge_negedge,
                HoldLow => thold_di6_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di6_re_timingdatash,
                Violation => tviol_di6_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(7),
                TestSignalName => "di7",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di7_we_noedge_negedge,
                setuplow => tsetup_di7_we_noedge_negedge,
                HoldHigh => thold_di7_we_noedge_negedge,
                HoldLow => thold_di7_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di7_we_timingdatash,
                Violation => tviol_di7_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(7),
                TestSignalName => "di7",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di7_re_noedge_negedge,
                setuplow => tsetup_di7_re_noedge_negedge,
                HoldHigh => thold_di7_re_noedge_negedge,
                HoldLow => thold_di7_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di7_re_timingdatash,
                Violation => tviol_di7_re,
                MsgSeverity => warning);

    END IF;
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    results(11 downto 4) := data_out(7 downto 0);
 
    IF (new_mode = PCMBUF) THEN 
       eclk_zd := eclk_buf;
       sclk_zd := sclk_buf;
       lock_zd := lock_buf;
    ELSIF (new_mode = DLL1X) THEN
       eclk_zd := eclk_dll1x;
       sclk_zd := sclk_dll1x;
       lock_zd := lock_dll1x;
    ELSIF (new_mode = DLLPD) THEN
       IF (local_pcm_reset = '1') THEN
          lock_zd := '0';
          eclk_zd := '0';
          sclk_zd := '0';
       ELSE
          eclk_zd := eclk_dllpd_out;
          sclk_zd := sclk_dllpd_out;
          lock_zd := lock_dllpd_out;
       END IF;
    ELSIF (new_mode = PLL) THEN
       IF (clock_pll_valid = '0') THEN
          eclk_zd := new_eclk;
          sclk_zd := new_sclk;
       ELSIF (clock_pll_valid = '1') THEN
          eclk_zd := vir_eclk;
          sclk_zd := vir_sclk;
          lock_zd := lock_pll_all;
       END IF;
    END IF;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => eclk,
     OutSignalName => "eclk",
     OutTemp => eclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_eclk, TRUE)),
     GlitchData => eclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => sclk,
     OutSignalName => "sclk",
     OutTemp => sclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_sclk, TRUE)),
     GlitchData => sclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => lock,
     OutSignalName => "lock",
     OutTemp => lock_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_lock, TRUE)),
     GlitchData => lock_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do0, TRUE)),
     GlitchData => do0_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do1,
     OutSignalName => "do1",
     OutTemp => do1_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do1, TRUE)),
     GlitchData => do1_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do2,
     OutSignalName => "do2",
     OutTemp => do2_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do2, TRUE)),
     GlitchData => do2_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do3,
     OutSignalName => "do3",
     OutTemp => do3_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do3, TRUE)),
     GlitchData => do3_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do4,
     OutSignalName => "do4",
     OutTemp => do4_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do4, TRUE)),
     GlitchData => do4_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do5,
     OutSignalName => "do5",
     OutTemp => do5_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do5, TRUE)),
     GlitchData => do5_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do6,
     OutSignalName => "do6",
     OutTemp => do6_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do6, TRUE)),
     GlitchData => do6_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do7,
     OutSignalName => "do7",
     OutTemp => do7_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do7, TRUE)),
     GlitchData => do7_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;



--
-----cell pcmt----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.conversion.all;
USE work.global.gsrnet;
USE work.global.purnet;


-- entity declaration --
ENTITY pcmt IS
   GENERIC (
      PCM                : PCM_MODE   := PCMBUF;
      DUTY               : real       := 50.0;
      PDELAY             : Integer    := 1;
      DIV0               : Integer    := 1;
      DIV1               : Integer    := 1;
      DIV2               : Integer    := 1;
      DISABLED_DONE      : std_logic  := '1';
      DISABLED_GSR       : std_logic  := '0';
      PWRON              : std_logic  := '1';
      FBDELAY            : Time       := 0 ps;
      TimingChecksOn     : Boolean    := TRUE;
      XOn                : Boolean    := FALSE;
      MsgOn              : Boolean    := TRUE;
      InstancePath       : String     := "pcmt";

      -- propagation delays
      tpd_clkin_eclk     : VitalDelayType01  := (0.1 ns, 0.1 ns);
      tpd_clkin_sclk     : VitalDelayType01  := (0.1 ns, 0.1 ns);
      tpd_clkin_lock     : VitalDelayType01  := (0.1 ns, 0.1 ns);
      tpd_re_do0         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do1         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do2         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do3         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do4         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do5         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do6         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_re_do7         : VitalDelayType01Z := (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

      -- setup and hold constraints
      tsetup_a0_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      thold_a0_we_noedge_negedge      : VitalDelayType := 0.01 ns;
      tsetup_a0_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      thold_a0_re_noedge_negedge      : VitalDelayType := 0.01 ns;
      tsetup_a1_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      thold_a1_we_noedge_negedge      : VitalDelayType := 0.01 ns;
      tsetup_a1_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      thold_a1_re_noedge_negedge      : VitalDelayType := 0.01 ns;
      tsetup_a2_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      thold_a2_we_noedge_negedge      : VitalDelayType := 0.01 ns;
      tsetup_a2_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      thold_a2_re_noedge_negedge      : VitalDelayType := 0.01 ns;
      tsetup_di0_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di0_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di0_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di0_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di1_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di1_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di1_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di1_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di2_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di2_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di2_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di2_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di3_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di3_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di3_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di3_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di4_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di4_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di4_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di4_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di5_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di5_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di5_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di5_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di6_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di6_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di6_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di6_re_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di7_we_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di7_we_noedge_negedge     : VitalDelayType := 0.01 ns;
      tsetup_di7_re_noedge_negedge    : VitalDelayType := 0.01 ns;
      thold_di7_re_noedge_negedge     : VitalDelayType := 0.01 ns;

      tipd_clkin         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_fb            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_we            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_re            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_a2            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_a1            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_a0            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di7           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di6           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di5           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di4           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di3           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di2           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di1           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_di0           : VitalDelayType01 := (0 ns, 0 ns));

   PORT(
      clkin              : in std_logic ;
      fb                 : in std_logic ;
      we                 : in std_logic ;
      re                 : in std_logic ;
      a2                 : in std_logic ;
      a1                 : in std_logic ;
      a0                 : in std_logic ;
      di7                : in std_logic ;
      di6                : in std_logic ;
      di5                : in std_logic ;
      di4                : in std_logic ;
      di3                : in std_logic ;
      di2                : in std_logic ;
      di1                : in std_logic ;
      di0                : in std_logic ;
      do7                : out std_logic;
      do6                : out std_logic;
      do5                : out std_logic;
      do4                : out std_logic;
      do3                : out std_logic;
      do2                : out std_logic;
      do1                : out std_logic;
      do0                : out std_logic;
      eclk               : out std_logic;
      sclk               : out std_logic;
      lock               : out std_logic);

    ATTRIBUTE Vital_Level0 OF pcmt : ENTITY IS TRUE;

END pcmt ;

-- ARCHITECTURE body --
ARCHITECTURE V OF pcmt IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
--SIGNAL DECLARATIONS----
    SIGNAL clkin_ipd               : std_logic := '0';
    SIGNAL new_clock               : std_logic := '0';
    SIGNAL fb_ipd                  : std_logic := '0';
    SIGNAL we_ipd                  : std_logic := '0';
    SIGNAL re_ipd                  : std_logic := '0';
    SIGNAL DUTY1                   : Real      := 0.0;
    SIGNAL DUTY2                   : Real      := 0.0;

    SIGNAL addr                    : std_logic_vector(2 downto 0) := "000";
    SIGNAL data_in                 : std_logic_vector(7 downto 0) := "00000000";
    SIGNAL data_out                : std_logic_vector(7 downto 0) := "ZZZZZZZZ";
    SIGNAL configreg7              : std_logic_vector(7 downto 0) := "XXXXX00X";
    SIGNAL configreg6              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL configreg5              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL configreg4              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL configreg3              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL configreg2              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL configreg1              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL configreg0              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL mode                    : PCM_MODE := PCMBUF;
    SIGNAL new_mode                : PCM_MODE;
    SIGNAL frequence_reg           : real;
    SIGNAL new_frequence_reg       : real;
    SIGNAL duty_reg                : real := 0.0;
    SIGNAL duty_2x_tap1            : Integer := 0;
    SIGNAL duty_2x_tap2            : Integer := 0;
    SIGNAL new_duty_2x_tap1        : Integer := 0;
    SIGNAL new_duty_2x_tap2        : Integer := 0;
    SIGNAL duty_tap                : Integer := 0;
    SIGNAL new_duty_tap            : Integer := 0;
    SIGNAL new_duty_reg            : real := 0.0;
    SIGNAL pdelay_reg              : std_logic_vector(7 downto 0) := "XXXXXXXX";
    SIGNAL pdelay_reg1             : Integer;
    SIGNAL new_pdelay_reg          : Integer;
    SIGNAL div0_reg1               : Integer := 0;
    SIGNAL div1_reg1               : Integer := 0;
    SIGNAL div2_reg1               : Integer := 0;
    SIGNAL div0_reg                : Integer := 0;
    SIGNAL div1_reg                : Integer := 0;
    SIGNAL div2_reg                : Integer := 0;
    SIGNAL done_reg                : std_logic := '0';
    SIGNAL new_done_reg            : std_logic := '0';
    SIGNAL gsr_reg                 : std_logic := '0';
    SIGNAL new_gsr_reg             : std_logic := '0';
    SIGNAL pwron_reg               : std_logic := '0';
    SIGNAL new_pwron_reg           : std_logic := '0';
    SIGNAL fbdelay_reg             : time := 0 ps;
    SIGNAL new_fbdelay_reg         : time := 0 ps;
-- Output signals
    SIGNAL eclk_buf                : std_logic := 'X';
    SIGNAL sclk_buf                : std_logic := 'X';
    SIGNAL lock_buf                : std_logic := '0';
    SIGNAL eclk_dll1x              : std_logic := 'X';
    SIGNAL sclk_dll1x              : std_logic := 'X';
    SIGNAL lock_dll1x              : std_logic := '0';
    SIGNAL eclk_dll2x              : std_logic := 'X';
    SIGNAL sclk_dll2x              : std_logic := 'X';
    SIGNAL lock_dll2x              : std_logic := '0';

    SIGNAL t_in_dllpd_clk          : time := 0 ps;
    SIGNAL t_in_dllpd_clk1         : time := 0 ps;
    SIGNAL clock_dllpd_delay       : time := 0 ps;
    SIGNAL eclk_dllpd_period       : time := 0 ps;
    SIGNAL eclk_dllpd_half_time    : time := 0 ps;
    SIGNAL sclk_dllpd_half_time    : time := 0 ps;
    SIGNAL clock_dllpd_valid       : std_logic := '0';
    SIGNAL clock_dllpd_invalid     : std_logic := '0';
    SIGNAL start_dllpd_clk         : std_logic := '0';
    SIGNAL eclk_dllpd_out1         : std_logic := '0';
    SIGNAL eclk_dllpd_out          : std_logic := '0';
    SIGNAL sclk_dllpd_out1         : std_logic := '0';
    SIGNAL sclk_dllpd_out          : std_logic := '0';
    SIGNAL lock_dllpd_out          : std_logic := '0';

    SIGNAL t_fb_pll_clk            : time := 0 ps;
    SIGNAL t_in_pll_clk            : time := 0 ps;
    SIGNAL t_in_pll_clk1           : time := 0 ps;
    SIGNAL t_in_pll_clk2           : time := 0 ps;
    SIGNAL t_in_pll_clk3           : time := 0 ps;
    SIGNAL t_fb_pll_clk1           : time := 0 ps;
    SIGNAL t_fb_pll_clk2           : time := 0 ps;
    SIGNAL t_fb_pll_clk3           : time := 0 ps;
    SIGNAL t_fb_clk                : time := 0 ps;
    SIGNAL t_any_clock             : time := 0 ps;
    SIGNAL ha_any_clk              : time := 0 ps;
    SIGNAL t_inter_clk             : time := 0 ps;
    SIGNAL ha_inter_clk            : time := 0 ps;
    SIGNAL total_fb_delay          : time := 0 ps;
    SIGNAL virtual_delay1          : time := 0 ps;
    SIGNAL virtual_delay2          : time := 0 ps;
    SIGNAL real_delay              : time := 0 ps;
    SIGNAL real_delay1             : time := 0 ps;
    SIGNAL real_delay2             : time := 0 ps;
    SIGNAL clock_pll_valid         : std_logic := '0';
    SIGNAL fbclock_pll_valid         : std_logic := '0';
    SIGNAL valid_pll_clock         : std_logic := '0';
    SIGNAL clkfb_per_valid         : std_logic := '0';
    SIGNAL clock_pll_invalid       : std_logic := '0';
    SIGNAL fbclock_pll_invalid       : std_logic := '0';
    SIGNAL eclk_pll_out            : std_logic := '0';
    SIGNAL sclk_pll_out            : std_logic := '0';
    SIGNAL lock_pll_all            : std_logic := '0';
    SIGNAL vir_eclk                : std_logic := '0';
    SIGNAL vir_sclk                : std_logic := '0';
    SIGNAL ratio1                  : integer := 0;
    SIGNAL ratio2                  : integer := 0;
    SIGNAL new_eclk                : std_logic := '0';
    SIGNAL new_sclk                : std_logic := '0';
    SIGNAL funky_eclk              : std_logic := '0';
    SIGNAL funky_t_eclk            : time := 0 ns;
    SIGNAL funky_sclk              : std_logic := '0';
    SIGNAL funky_t1_sclk           : time := 5 ns;
    SIGNAL funky_t_sclk            : time := 0 ns;
    SIGNAL ext_divider             : Real := 1.0 ;
    SIGNAL ext_divider1            : Real := 1.0 ;
    SIGNAL ext_divider_1           : Real := 1.0 ;
    SIGNAL ext_divider2            : Real := 1.0 ;
    SIGNAL ext_divider3            : Real := 1.0 ;
    SIGNAL net_divide              : Real := 1.0 ;
-- Reset signals
    SIGNAL local_dll_reset         : std_logic := '0';
    SIGNAL local_pcm_reset         : std_logic := '0';
    SIGNAL global_reset            : std_logic := '1';
    SIGNAL pwrup_reset             : std_logic := '1';
 
BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   VitalWireDelay(fb_ipd, fb, tipd_fb);
   VitalWireDelay(we_ipd, we, tipd_we);
   VitalWireDelay(re_ipd, re, tipd_re);
   VitalWireDelay(addr(2), a2, tipd_a2);
   VitalWireDelay(addr(1), a1, tipd_a1);
   VitalWireDelay(addr(0), a0, tipd_a0);
   VitalWireDelay(data_in(7), di7, tipd_di7);
   VitalWireDelay(data_in(6), di6, tipd_di6);
   VitalWireDelay(data_in(5), di5, tipd_di5);
   VitalWireDelay(data_in(4), di4, tipd_di4);
   VitalWireDelay(data_in(3), di3, tipd_di3);
   VitalWireDelay(data_in(2), di2, tipd_di2);
   VitalWireDelay(data_in(1), di1, tipd_di1);
   VitalWireDelay(data_in(0), di0, tipd_di0);
   END BLOCK;

-- Assign all the generics to signals

   DUTY1 <= DUTY;
   DUTY2 <= DUTY;

   mode <= PCM;
   duty_reg <= DUTY1;
   duty_tap <= INTEGER ((32.0*DUTY1)/100.0);
--   duty_2x_tap1 <= INTEGER ((16.0*DUTY1)/100.0);
--   duty_2x_tap2 <= INTEGER ((16.0*DUTY2)/100.0);
   pdelay_reg <= pdelay_tostd_logic_vector(PDELAY);
   pdelay_reg1 <= PDELAY;
   done_reg <= DISABLED_DONE;
   gsr_reg  <= DISABLED_GSR;
   pwron_reg <= PWRON;
   fbdelay_reg <= FBDELAY;

-- Initialization of Configuration Registers.

   P1 : PROCESS (pdelay_reg, we, addr, data_in, pwron_reg, done_reg, gsr_reg)
   BEGIN
      IF (NOW = 0 ns) THEN
        initialize (mode=>PCM, duty_tap=>duty_tap, div0_reg1=>DIV0, 
                    duty_reg=>DUTY1, div1_reg1=>DIV1, 
                    div2_reg1=>DIV2, pdelay_reg=>pdelay_reg, configreg6=>configreg6,
                    configreg5=>configreg5, configreg4=>configreg4, configreg3=>configreg3,
                    configreg2=>configreg2, configreg1=>configreg1, configreg0=>configreg0);       

        configreg7(0) <= pwron_reg; 
        configreg7(6) <= done_reg; 
        configreg7(7) <= gsr_reg; 
        configreg0(3 downto 0) <= std_logic_vector(to_unsigned(DIV0, 4)); 
        configreg1(3 downto 0) <= std_logic_vector(to_unsigned(DIV1, 4)); 
        configreg2(3 downto 0) <= std_logic_vector(to_unsigned(DIV2, 4)); 
      END IF;
      
      IF (we = '1') THEN
        CASE addr IS
            WHEN "000" => configreg0 <= data_in;
            WHEN "001" => configreg1 <= data_in;
            WHEN "010" => configreg2 <= data_in;
            WHEN "011" => configreg3 <= data_in;
            WHEN "100" => configreg4 <= data_in;
            WHEN "101" => configreg5 <= data_in;
            WHEN "110" => configreg6(7 downto 4) <= data_in(7 downto 4);
            WHEN "111" => configreg7 <= data_in;
            WHEN others => NULL;
        END CASE;
      END IF;
   END PROCESS;

   GLOBALRESET : PROCESS (gsrnet, configreg7(7))
    BEGIN
      IF (configreg7(7) =  '0') THEN
         global_reset <= gsrnet;                  -- gsrnet is active low
      ELSE
         global_reset <= '1';
      END IF;
    END PROCESS;

   POWERUPRESET : PROCESS (purnet, configreg7(6))
    BEGIN
      IF (configreg7(6) =  '0') THEN
         pwrup_reset <= purnet;                    -- purnet is active low
      ELSE
         pwrup_reset <= '1';
      END IF;
    END PROCESS;

   local_dll_reset <= (local_pcm_reset OR configreg7(2));
   local_pcm_reset <= (configreg7(1) OR (NOT(pwrup_reset)) OR (NOT(global_reset)));
-- Readback Process

   P2 : PROCESS (re, addr, configreg0, configreg1, configreg2, configreg3, configreg4, configreg5,
                 configreg6, configreg7)
   BEGIN
      IF (configreg7(0) = '0') THEN
         data_out <= "ZZZZZZZZ";
      ELSE

        IF (re = '1') THEN
          CASE addr IS
              WHEN "000" => data_out <= configreg0;
              WHEN "001" => data_out <= configreg1;
              WHEN "010" => data_out <= configreg2;
              WHEN "011" => data_out <= configreg3;
              WHEN "100" => data_out <= configreg4;
              WHEN "101" => data_out <= configreg5;
              WHEN "110" => data_out <= configreg6;
              WHEN "111" => data_out <= configreg7;
              WHEN others => NULL;
          END CASE; 
        ELSIF (re = '0') THEN
          data_out <= "ZZZZZZZZ";
        END IF;
      END IF;
   END PROCESS;

-- Mode Selection

   P3 : PROCESS (mode, configreg5, configreg6)
   BEGIN
      IF (NOW = 0 ns) THEN
        new_mode <= mode;
      END IF;

      IF (configreg5(0) = '1' and configreg5(2) = '0') THEN
        new_mode <= PLL;
      ELSIF (configreg5(0) = '0' and configreg5(4) = '1' and configreg5(2) = '1') THEN
          new_mode <= DLL1X;
      ELSIF (configreg5(0) = '0' and configreg5(4) = '0' and configreg5(2) = '1') THEN
        IF (configreg6(7 downto 4) = "101-") THEN
          new_mode <= DLLPD;
        END IF;
      ELSIF (configreg6(7 downto 4) = "0000") THEN
        new_mode <= PCMBUF;
      END IF;
   END PROCESS;

   P4 : PROCESS (div0_reg1, div1_reg1, div2_reg1, configreg0, configreg1, configreg2)
   BEGIN
      IF (NOW = 0 ns) THEN
        div0_reg <= div0_reg1;
        div1_reg <= div1_reg1;
        div2_reg <= div2_reg1;
      END IF;
      
      div0_reg <= divider_to_ratio(configreg0(3 downto 0));
      div1_reg <= divider_to_ratio(configreg1(3 downto 0));
      div2_reg <= divider_to_ratio(configreg2(3 downto 0));
   END PROCESS;
        
   P5 : PROCESS (configreg4, duty_tap)
   BEGIN
      IF (NOW = 0 ns) THEN
        new_duty_tap <= duty_tap;
      END IF;

      IF (configreg4(7) = '0') THEN
        IF (configreg4(6) = '0') THEN
          new_duty_tap <= (make_integer(configreg4(2 downto 0)) + 1); 
        ELSIF (configreg4(6) = '1') THEN
          IF (configreg4(5 downto 3) = "111") THEN
            new_duty_tap <= 16;
          ELSE
            new_duty_tap <= (make_integer(configreg4(2 downto 0)) + 9); 
          END IF;
        END IF;
      ELSIF (configreg4(7) = '1') THEN
        IF (configreg4(6) = '0') THEN
          new_duty_tap <= (make_integer(configreg4(5 downto 3)) + 17); 
        ELSIF (configreg4(6) = '1') THEN
          new_duty_tap <= (make_integer(configreg4(5 downto 3)) + 25);
        END IF;
      END IF;
   END PROCESS;

   P6 : PROCESS (configreg4, pdelay_reg1)
   BEGIN
      IF (NOW = 0 ns) THEN
        new_pdelay_reg <= pdelay_reg1;
      END IF;

      IF (configreg4(7) = '0') THEN
        IF (configreg4(6) = '0') THEN
          new_pdelay_reg <= (make_integer(configreg4(2 downto 0)) + 1);
        ELSIF (configreg4(6) = '1') THEN
          IF (configreg4(5 downto 3) = "111") THEN
            new_pdelay_reg <= 16;
          ELSE
            new_pdelay_reg <= (make_integer(configreg4(2 downto 0)) + 9);
          END IF;
        END IF;
      ELSIF (configreg4(7) = '1') THEN
        IF (configreg4(6) = '0') THEN
          new_pdelay_reg <= (make_integer(configreg4(5 downto 3)) + 17);
        ELSIF (configreg4(6) = '1') THEN
          new_pdelay_reg <= (make_integer(configreg4(5 downto 3)) + 25);
        END IF;
      END IF;
   END PROCESS;
         
    P20 : PROCESS (clkin_ipd)
    VARIABLE index : Integer := 0;
    VARIABLE first_time : boolean := true;
    BEGIN
       IF (clkin_ipd'event) THEN
          IF (first_time) THEN
             IF (clkin_ipd = '1') THEN
                new_clock <= '1';
                first_time := false;
                index := 0;
             END IF;
          ELSE
             index := index + 1;
             IF (index = div0_reg) THEN
                new_clock <= NOT new_clock;
                index := 0;
             END IF;
          END IF;
       END IF;
    END PROCESS;

------------------------------------------------------------------------------------------------
-- Clock generation for PCMBUF mode
------------------------------------------------------------------------------------------------

   P8 : PROCESS (new_mode, clkin_ipd, local_pcm_reset)
   BEGIN
      IF (local_pcm_reset = '1') THEN
         lock_buf <= '0';
         eclk_buf <= '0';
         sclk_buf <= '0';
      ELSE
      IF (new_mode = PCMBUF) THEN
        eclk_buf <= VitalBUF(clkin_ipd);
        sclk_buf <= VitalBUF(clkin_ipd);
        IF (clkin_ipd'event AND clkin_ipd = '1') THEN
          lock_buf <= '1';
        END IF;
      END IF;
      END IF;
   END PROCESS;

------------------------------------------------------------------------------------------------
-- Clock generation for DLL1X mode
------------------------------------------------------------------------------------------------
   P9 : PROCESS (new_mode, new_clock, new_duty_tap, local_dll_reset)
   VARIABLE last_cycle, next_cycle, last_clock_edge : time := 0 ps;
   VARIABLE clock_delay : time := 0 ps;
   BEGIN
      IF (local_dll_reset = '1') THEN
         lock_dll1x <= '0';
         eclk_dll1x <= '0';
         sclk_dll1x <= '0';
      ELSE
      IF (new_mode = DLL1X) THEN
        IF (new_clock'event and new_clock = '1') THEN
           last_cycle := next_cycle;
           next_cycle := NOW - last_clock_edge;

           IF (next_cycle = last_cycle) THEN
              lock_dll1x <= '1';
           ELSE
              lock_dll1x <= '0';
           END IF;

           last_clock_edge := NOW;
           clock_delay := ((next_cycle * new_duty_tap)/32);

           eclk_dll1x <= '1';
           sclk_dll1x <= '1';

           eclk_dll1x <= transport '0' after clock_delay;
           sclk_dll1x <= transport '0' after clock_delay;
        END IF;
      END IF;
      END IF;
   END PROCESS;

------------------------------------------------------------------------------------------------
-- Clock generation for DLLPD mode
------------------------------------------------------------------------------------------------
   P11 : PROCESS (new_clock, local_pcm_reset)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   VARIABLE t_in_clk2 : time := 0 ps;
   BEGIN
      IF (local_pcm_reset = '1') THEN
         clock_dllpd_invalid <= '1';
      ELSE
      IF (new_clock'event and new_clock = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
              t_in_clk2 := next_clock_edge - last_clock_edge;
              IF (t_in_clk2 > 0 ps) THEN
                IF (t_in_clk2 = t_in_dllpd_clk) THEN
                   clock_dllpd_invalid <= '0';
                ELSE
                   clock_dllpd_invalid <= '1';
                END IF;
              END IF;
              t_in_dllpd_clk <= t_in_clk2;
           END IF;

           IF (t_in_dllpd_clk > 0 ps) THEN
             t_in_dllpd_clk1 <= t_in_dllpd_clk;
             IF (t_in_dllpd_clk = t_in_dllpd_clk1) THEN
                  clock_dllpd_valid <= '1';
             ELSE
                  clock_dllpd_valid <= '0';
             END IF;
           END IF;
       END IF;
       END IF;
   END PROCESS;

   clock_dllpd_delay <= ((t_in_dllpd_clk * new_pdelay_reg)/32);
   eclk_dllpd_period <= t_in_dllpd_clk * div2_reg;
   start_dllpd_clk <= transport clock_dllpd_valid after clock_dllpd_delay;
   eclk_dllpd_half_time <= eclk_dllpd_period/2;
   sclk_dllpd_half_time <= t_in_dllpd_clk/2;
   sclk_dllpd_out <= transport sclk_dllpd_out1 after clock_dllpd_delay;

   P12 : PROCESS (sclk_dllpd_out)
   VARIABLE index : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (sclk_dllpd_out'event) THEN
         IF (first_time) THEN
            IF (sclk_dllpd_out = '1') THEN
               eclk_dllpd_out <= '1';
               first_time := false;
               index := 0;
            END IF;
         ELSE 
            index := index + 1;
            IF (index = div2_reg) THEN
               eclk_dllpd_out <= NOT eclk_dllpd_out;
               index := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P13 : PROCESS
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (first_time) THEN
          WAIT until (clock_dllpd_valid'event and clock_dllpd_valid = '1'); 
          sclk_dllpd_out1 <= '1';
          first_time := false;
      ELSIF (clock_dllpd_valid = '1') THEN
        WAIT FOR sclk_dllpd_half_time;
        sclk_dllpd_out1 <= NOT sclk_dllpd_out1;
      END IF;
   END PROCESS;

   P14 : PROCESS (start_dllpd_clk, clock_dllpd_invalid, sclk_dllpd_out, eclk_dllpd_out )
   BEGIN
      IF (clock_dllpd_invalid = '1') THEN
        lock_dllpd_out <= '0';
      ELSE
        IF (start_dllpd_clk = '1') THEN
          IF (eclk_dllpd_out ='1' and sclk_dllpd_out = '1') THEN
             lock_dllpd_out <= '1';
          END IF;
        END IF;
      END IF;
   END PROCESS;

------------------------------------------------------------------------------------------------
-- Clock generation for PLL mode
------------------------------------------------------------------------------------------------
   ---------------------------------------------
   -- Create Funky clocks
   ---------------------------------------------
   funky_t_eclk <= (2 * funky_t1_sclk * div2_reg);
   funky_t_sclk <= (2 * funky_t1_sclk);

   P51 : PROCESS 
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (first_time) THEN
        Wait for 5 ns;
        funky_sclk <= NOT funky_sclk;
        first_time := false;
      ELSE
        funky_sclk <= NOT funky_sclk;
        Wait for funky_t1_sclk;
      END IF;
   END PROCESS;

   P52 : PROCESS
   VARIABLE funky_t1_eclk : time := 0 ns;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (first_time) THEN
        Wait for 5 ns;
        funky_eclk <= NOT funky_eclk;
        first_time := false;
      ELSE
        funky_t1_eclk := funky_t1_sclk * div2_reg;
        funky_eclk <= NOT funky_eclk;
        Wait for funky_t1_eclk;
      END IF;
   END PROCESS;

   P54 : PROCESS (local_pcm_reset, funky_sclk, funky_eclk)
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (local_pcm_reset = '1') THEN
         new_sclk <= '0';
         new_eclk <= '0';
      ELSE
         IF (first_time) THEN
           IF (funky_eclk'event and funky_eclk = '1')THEN
             new_sclk <= funky_sclk;
             new_eclk <= funky_eclk;
             first_time := false;
           END IF;
         ELSE
           IF funky_eclk'event THEN
             new_eclk <= funky_eclk;
           END IF;
           IF funky_sclk'event THEN
             new_sclk <= funky_sclk;
           END IF;
         END IF;
      END IF;
   END PROCESS;

   ----------------------------------
   -- measure input clock and feedback clock period
   ------------------------------------------------

   PLL1 : PROCESS (clkin_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clkin_ipd'event and clkin_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_pll_clk <= next_clock_edge - last_clock_edge;
                t_in_pll_clk1 <= t_in_pll_clk;
                t_in_pll_clk2 <= t_in_pll_clk1;
                t_in_pll_clk3 <= t_in_pll_clk2;
           END IF;
           IF (t_in_pll_clk > 0 ps) THEN
             IF (t_in_pll_clk = t_in_pll_clk3) THEN
                  clock_pll_valid <= '1';
             ELSE
                  clock_pll_valid <= '0';
             END IF;
           END IF;
           IF (t_in_pll_clk > 0 ps) THEN
             IF (t_in_pll_clk = t_in_pll_clk1) THEN
                  clock_pll_invalid <= '0';
             ELSE
                  clock_pll_invalid <= '1';
             END IF;
           END IF;
      END IF;
   END PROCESS;

   PROCESS (fb_ipd)
   VARIABLE last_clock_edge : time := 0 ps;
   VARIABLE next_clock_edge : time := 0 ps;
   BEGIN
      IF (fb_ipd'event and fb_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_fb_clk <= next_clock_edge - last_clock_edge;
           END IF;
      END IF;
      IF (last_clock_edge > 0 ps) THEN
           clkfb_per_valid <= '1';
      END IF;
   END PROCESS;

   PLL101 : PROCESS (fb_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (fb_ipd'event and fb_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_fb_pll_clk <= next_clock_edge - last_clock_edge;
                t_fb_pll_clk1 <= t_fb_pll_clk;
                t_fb_pll_clk2 <= t_fb_pll_clk1;
                t_fb_pll_clk3 <= t_fb_pll_clk2;
           END IF;

           IF (t_fb_pll_clk > 0 ps) THEN
             IF (t_fb_pll_clk = t_fb_pll_clk2) THEN
                  fbclock_pll_valid <= '1';
             ELSE
                  fbclock_pll_valid <= '0';
             END IF;
           END IF;
           IF (t_fb_pll_clk > 0 ps) THEN
             IF (t_fb_pll_clk = t_fb_pll_clk1) THEN
                  fbclock_pll_invalid <= '0';
             ELSE
                  fbclock_pll_invalid <= '1';
             END IF;
           END IF;
      END IF;
   END PROCESS;

-------------------------------------------------
-- Assume ExpressCLK feedback (eclkfb = 1)
-------------------------------------------------
   PROCESS (new_eclk)
   BEGIN
      IF (lock_pll_all = '0') THEN
          IF ((funky_t_eclk > 0 ps) and (t_fb_clk > 0 ps)) THEN
             ext_divider1 <= (real(time'pos(t_fb_clk)) / real(time'pos(funky_t_eclk)));
             ext_divider2 <= ext_divider1;
             ext_divider3 <= ext_divider2;
          END IF;
          IF (ext_divider1 = ext_divider3) THEN
             ext_divider_1 <= ext_divider3;
          END IF;
      END IF;
   END PROCESS;

   PROCESS (vir_eclk, ext_divider_1)
   VARIABLE first_time      : Boolean := true;
   BEGIN
      IF (first_time) THEN
         ext_divider <= ext_divider_1;
         IF (vir_eclk'event and vir_eclk = '1') THEN
                ext_divider <= ext_divider_1;
                first_time := false;
         END IF;
      END IF;
   END PROCESS;

   ------------------------------------------------
   -- measure the feedback delay value
   ------------------------------------------------
   GENERATE_FIRST_FD_EDGE : PROCESS ( new_eclk, new_sclk, fb_ipd)
   VARIABLE new_eclk_first_time : boolean := true;
   VARIABLE new_sclk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_eclk_edge : time := 0 ps;
   VARIABLE first_sclk_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   BEGIN
      if (new_eclk'event and new_eclk'last_value = '0' and new_eclk = '1') then
         if (new_eclk_first_time) then
            first_eclk_edge := NOW;
            new_eclk_first_time := false;
         end if;
      end if;
      if (new_sclk'event and new_sclk'last_value = '0' and new_sclk = '1') then
         if (new_sclk_first_time) then
            first_sclk_edge := NOW;
            new_sclk_first_time := false;
         end if;
      end if;
      if (fb_ipd'event and fb_ipd'last_value = '0' and fb_ipd = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;
         total_fb_delay <= first_fb_edge - first_eclk_edge ;
   END PROCESS;

   net_divide <= (real(div1_reg) * ext_divider);

   PLL2 : PROCESS (net_divide, t_in_pll_clk, div0_reg)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_any_clock <= ((t_in_pll_clk * div0_reg) / net_divide);
      END IF;
   END PROCESS;

   ha_any_clk  <= (t_any_clock / 2);

   PLL3 : PROCESS (t_any_clock, div2_reg)
   BEGIN
      IF (t_any_clock'event or div2_reg'event) THEN
         t_inter_clk  <= (t_any_clock / div2_reg);
      END IF;
   END PROCESS;

   ha_inter_clk  <= (t_inter_clk / 2);

   PLL7 : PROCESS (total_fb_delay, t_in_pll_clk, ratio1, virtual_delay1)
   BEGIN
      IF ((total_fb_delay > 0 ps) and (t_in_pll_clk > 0 ps)) THEN
          ratio1 <= total_fb_delay / t_in_pll_clk;
          virtual_delay1 <= total_fb_delay - (t_in_pll_clk * ratio1);
          real_delay1 <= t_in_pll_clk - virtual_delay1 ;
      END IF;
   END PROCESS;

   PLL8 : PROCESS (t_in_pll_clk, ratio2, virtual_delay2)
   BEGIN
      IF (fbdelay_reg > 0 ps and t_in_pll_clk > 0 ps) THEN
          ratio2 <= fbdelay / t_in_pll_clk;
          virtual_delay2 <= fbdelay_reg - (t_in_pll_clk * ratio2);
          real_delay2 <= t_in_pll_clk - virtual_delay2 ;
      END IF;
   END PROCESS;

   PLL9 : PROCESS (total_fb_delay, real_delay1, real_delay2)
   BEGIN
      IF (fbdelay = 0 ps) THEN
         IF (total_fb_delay = 0 ps) THEN
            real_delay <= 0 ps;
         ELSE
            real_delay <= real_delay1;
         END IF;
      ELSE
         real_delay <= real_delay2;
      END IF;
   END PROCESS;

   PLL5 : PROCESS (sclk_pll_out)
   VARIABLE index : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (sclk_pll_out'event) THEN
         IF (first_time) THEN
            IF (sclk_pll_out = '1') THEN
               eclk_pll_out <= '1';
               first_time := false;
               index := 0;
            END IF;
         ELSE 
            index := index + 1;
            IF (index = div2_reg) THEN
               eclk_pll_out <= NOT eclk_pll_out;
               index := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   PLL25 : PROCESS (clock_pll_valid, ha_inter_clk)
   BEGIN
      IF (ha_inter_clk > 0 ps) THEN
         valid_pll_clock <= clock_pll_valid;
      END IF;
   END PROCESS;

   PLL10 : PROCESS
   VARIABLE first_time : boolean := true;
   BEGIN
        IF (first_time) THEN
        WAIT until (valid_pll_clock'event and valid_pll_clock = '1') ;
           sclk_pll_out <= '1';
           first_time := false;
           WAIT FOR ha_inter_clk;
        ELSIF (clock_pll_valid = '1') THEN
           sclk_pll_out <= NOT sclk_pll_out;
           WAIT FOR ha_inter_clk;
        END IF;
   END PROCESS;

   PLL13 : PROCESS (vir_eclk, clock_pll_invalid, local_pcm_reset)
   VARIABLE counter : integer := 0;
   BEGIN
      IF (local_pcm_reset = '1') THEN
         lock_pll_all <= '0';
         counter := 0;
      ELSE
      if clock_pll_invalid = '1' then
         lock_pll_all <= '0';
         counter := 0;
      else
         if (vir_eclk'event and vir_eclk'last_value = '0' and vir_eclk = '1') THEN
            if clock_pll_valid = '1' then
               counter := counter + 1;
               if (counter = 2) THEN
                  lock_pll_all <= '1';
                  counter := 1;
               end if;
            end if;
         end if;
      end if;
      END IF;
   END PROCESS;

   PLL14 : PROCESS (eclk_pll_out, sclk_pll_out, local_pcm_reset)
   BEGIN
      IF (local_pcm_reset = '1') THEN
         vir_eclk <= '0';
         vir_sclk <= '0';
      ELSE
         vir_eclk <= transport eclk_pll_out after real_delay;
         vir_sclk <= transport sclk_pll_out after real_delay;
      END IF;
   END PROCESS;

------------------------------------------------------------------------------------------------
-- Output Clock Generation 
------------------------------------------------------------------------------------------------
   VitalBehavior : PROCESS (new_mode, eclk_buf, sclk_buf, lock_buf, eclk_dll1x, sclk_dll1x, lock_dll1x, 
                   eclk_dllpd_out, sclk_dllpd_out, lock_dllpd_out, local_pcm_reset,
                   vir_eclk, vir_sclk, lock_pll_all, data_out, clock_pll_valid, new_eclk, new_sclk)

   -- functionality results
   VARIABLE violation : x01 := '0';
   VARIABLE results : std_logic_vector(11 downto 1) := (others => '0');
   ALIAS eclk_zd : std_ulogic is results(1);
   ALIAS sclk_zd : std_ulogic is results(2);
   ALIAS lock_zd : std_ulogic is results(3);
   ALIAS do0_zd  : std_ulogic is results(4);
   ALIAS do1_zd  : std_ulogic is results(5);
   ALIAS do2_zd  : std_ulogic is results(6);
   ALIAS do3_zd  : std_ulogic is results(7);
   ALIAS do4_zd  : std_ulogic is results(8);
   ALIAS do5_zd  : std_ulogic is results(9);
   ALIAS do6_zd  : std_ulogic is results(10);
   ALIAS do7_zd  : std_ulogic is results(11);

   -- timing check results
   VARIABLE tviol_a0_we   : x01 := '0';
   VARIABLE tviol_a0_re   : x01 := '0';
   VARIABLE tviol_a1_we   : x01 := '0';
   VARIABLE tviol_a1_re   : x01 := '0';
   VARIABLE tviol_a2_we   : x01 := '0';
   VARIABLE tviol_a2_re   : x01 := '0';
   VARIABLE tviol_di0_we  : x01 := '0';
   VARIABLE tviol_di0_re  : x01 := '0';
   VARIABLE tviol_di1_we  : x01 := '0';
   VARIABLE tviol_di1_re  : x01 := '0';
   VARIABLE tviol_di2_we  : x01 := '0';
   VARIABLE tviol_di2_re  : x01 := '0';
   VARIABLE tviol_di3_we  : x01 := '0';
   VARIABLE tviol_di3_re  : x01 := '0';
   VARIABLE tviol_di4_we  : x01 := '0';
   VARIABLE tviol_di4_re  : x01 := '0';
   VARIABLE tviol_di5_we  : x01 := '0';
   VARIABLE tviol_di5_re  : x01 := '0';
   VARIABLE tviol_di6_we  : x01 := '0';
   VARIABLE tviol_di6_re  : x01 := '0';
   VARIABLE tviol_di7_we  : x01 := '0';
   VARIABLE tviol_di7_re  : x01 := '0';
   VARIABLE a0_we_TimingDatash  : VitalTimingDataType;
   VARIABLE a0_re_TimingDatash  : VitalTimingDataType;
   VARIABLE a1_we_TimingDatash  : VitalTimingDataType;
   VARIABLE a1_re_TimingDatash  : VitalTimingDataType;
   VARIABLE a2_we_TimingDatash  : VitalTimingDataType;
   VARIABLE a2_re_TimingDatash  : VitalTimingDataType;
   VARIABLE di0_we_TimingDatash : VitalTimingDataType;
   VARIABLE di0_re_TimingDatash : VitalTimingDataType;
   VARIABLE di1_we_TimingDatash : VitalTimingDataType;
   VARIABLE di1_re_TimingDatash : VitalTimingDataType;
   VARIABLE di2_we_TimingDatash : VitalTimingDataType;
   VARIABLE di2_re_TimingDatash : VitalTimingDataType;
   VARIABLE di3_we_TimingDatash : VitalTimingDataType;
   VARIABLE di3_re_TimingDatash : VitalTimingDataType;
   VARIABLE di4_we_TimingDatash : VitalTimingDataType;
   VARIABLE di4_re_TimingDatash : VitalTimingDataType;
   VARIABLE di5_we_TimingDatash : VitalTimingDataType;
   VARIABLE di5_re_TimingDatash : VitalTimingDataType;
   VARIABLE di6_we_TimingDatash : VitalTimingDataType;
   VARIABLE di6_re_TimingDatash : VitalTimingDataType;
   VARIABLE di7_we_TimingDatash : VitalTimingDataType;
   VARIABLE di7_re_TimingDatash : VitalTimingDataType;

   -- output glitch detection variables
   VARIABLE eclk_GlitchData : VitalGlitchDataType;
   VARIABLE sclk_GlitchData : VitalGlitchDataType;
   VARIABLE lock_GlitchData : VitalGlitchDataType;
   VARIABLE do0_GlitchData  : VitalGlitchDataType;
   VARIABLE do1_GlitchData  : VitalGlitchDataType;
   VARIABLE do2_GlitchData  : VitalGlitchDataType;
   VARIABLE do3_GlitchData  : VitalGlitchDataType;
   VARIABLE do4_GlitchData  : VitalGlitchDataType;
   VARIABLE do5_GlitchData  : VitalGlitchDataType;
   VARIABLE do6_GlitchData  : VitalGlitchDataType;
   VARIABLE do7_GlitchData  : VitalGlitchDataType;

   BEGIN

   -----------------------
   -- timing check section
   -----------------------

    IF (TimingChecksOn) THEN

           VitalSetupHoldCheck (
                TestSignal => addr(0),
                TestSignalName => "a0",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_a0_we_noedge_negedge,
                setuplow => tsetup_a0_we_noedge_negedge,
                HoldHigh => thold_a0_we_noedge_negedge,
                HoldLow => thold_a0_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => a0_we_timingdatash,
                Violation => tviol_a0_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => addr(0),
                TestSignalName => "a0",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_a0_re_noedge_negedge,
                setuplow => tsetup_a0_re_noedge_negedge,
                HoldHigh => thold_a0_re_noedge_negedge,
                HoldLow => thold_a0_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => a0_re_timingdatash,
                Violation => tviol_a0_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => addr(1),
                TestSignalName => "a1",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_a1_we_noedge_negedge,
                setuplow => tsetup_a1_we_noedge_negedge,
                HoldHigh => thold_a1_we_noedge_negedge,
                HoldLow => thold_a1_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => a1_we_timingdatash,
                Violation => tviol_a1_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => addr(1),
                TestSignalName => "a1",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_a1_re_noedge_negedge,
                setuplow => tsetup_a1_re_noedge_negedge,
                HoldHigh => thold_a1_re_noedge_negedge,
                HoldLow => thold_a1_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => a1_re_timingdatash,
                Violation => tviol_a1_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => addr(2),
                TestSignalName => "a2",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_a2_we_noedge_negedge,
                setuplow => tsetup_a2_we_noedge_negedge,
                HoldHigh => thold_a2_we_noedge_negedge,
                HoldLow => thold_a2_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => a2_we_timingdatash,
                Violation => tviol_a2_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => addr(2),
                TestSignalName => "a2",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_a2_re_noedge_negedge,
                setuplow => tsetup_a2_re_noedge_negedge,
                HoldHigh => thold_a2_re_noedge_negedge,
                HoldLow => thold_a2_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => a2_re_timingdatash,
                Violation => tviol_a2_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(0),
                TestSignalName => "di0",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di0_we_noedge_negedge,
                setuplow => tsetup_di0_we_noedge_negedge,
                HoldHigh => thold_di0_we_noedge_negedge,
                HoldLow => thold_di0_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di0_we_timingdatash,
                Violation => tviol_di0_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(0),
                TestSignalName => "di0",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di0_re_noedge_negedge,
                setuplow => tsetup_di0_re_noedge_negedge,
                HoldHigh => thold_di0_re_noedge_negedge,
                HoldLow => thold_di0_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di0_re_timingdatash,
                Violation => tviol_di0_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(1),
                TestSignalName => "di1",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di1_we_noedge_negedge,
                setuplow => tsetup_di1_we_noedge_negedge,
                HoldHigh => thold_di1_we_noedge_negedge,
                HoldLow => thold_di1_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di1_we_timingdatash,
                Violation => tviol_di1_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(1),
                TestSignalName => "di1",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di1_re_noedge_negedge,
                setuplow => tsetup_di1_re_noedge_negedge,
                HoldHigh => thold_di1_re_noedge_negedge,
                HoldLow => thold_di1_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di1_re_timingdatash,
                Violation => tviol_di1_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(2),
                TestSignalName => "di2",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di2_we_noedge_negedge,
                setuplow => tsetup_di2_we_noedge_negedge,
                HoldHigh => thold_di2_we_noedge_negedge,
                HoldLow => thold_di2_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di2_we_timingdatash,
                Violation => tviol_di2_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(2),
                TestSignalName => "di2",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di2_re_noedge_negedge,
                setuplow => tsetup_di2_re_noedge_negedge,
                HoldHigh => thold_di2_re_noedge_negedge,
                HoldLow => thold_di2_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di2_re_timingdatash,
                Violation => tviol_di2_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(3),
                TestSignalName => "di3",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di3_we_noedge_negedge,
                setuplow => tsetup_di3_we_noedge_negedge,
                HoldHigh => thold_di3_we_noedge_negedge,
                HoldLow => thold_di3_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di3_we_timingdatash,
                Violation => tviol_di3_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(3),
                TestSignalName => "di3",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di3_re_noedge_negedge,
                setuplow => tsetup_di3_re_noedge_negedge,
                HoldHigh => thold_di3_re_noedge_negedge,
                HoldLow => thold_di3_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di3_re_timingdatash,
                Violation => tviol_di3_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(4),
                TestSignalName => "di4",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di4_we_noedge_negedge,
                setuplow => tsetup_di4_we_noedge_negedge,
                HoldHigh => thold_di4_we_noedge_negedge,
                HoldLow => thold_di4_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di4_we_timingdatash,
                Violation => tviol_di4_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(4),
                TestSignalName => "di4",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di4_re_noedge_negedge,
                setuplow => tsetup_di4_re_noedge_negedge,
                HoldHigh => thold_di4_re_noedge_negedge,
                HoldLow => thold_di4_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di4_re_timingdatash,
                Violation => tviol_di4_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(5),
                TestSignalName => "di5",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di5_we_noedge_negedge,
                setuplow => tsetup_di5_we_noedge_negedge,
                HoldHigh => thold_di5_we_noedge_negedge,
                HoldLow => thold_di5_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di5_we_timingdatash,
                Violation => tviol_di5_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(5),
                TestSignalName => "di5",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di5_re_noedge_negedge,
                setuplow => tsetup_di5_re_noedge_negedge,
                HoldHigh => thold_di5_re_noedge_negedge,
                HoldLow => thold_di5_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di5_re_timingdatash,
                Violation => tviol_di5_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(6),
                TestSignalName => "di6",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di6_we_noedge_negedge,
                setuplow => tsetup_di6_we_noedge_negedge,
                HoldHigh => thold_di6_we_noedge_negedge,
                HoldLow => thold_di6_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di6_we_timingdatash,
                Violation => tviol_di6_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(6),
                TestSignalName => "di6",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di6_re_noedge_negedge,
                setuplow => tsetup_di6_re_noedge_negedge,
                HoldHigh => thold_di6_re_noedge_negedge,
                HoldLow => thold_di6_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di6_re_timingdatash,
                Violation => tviol_di6_re,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(7),
                TestSignalName => "di7",
                RefSignal => we_ipd,
                RefSignalName => "we",
                SetupHigh => tsetup_di7_we_noedge_negedge,
                setuplow => tsetup_di7_we_noedge_negedge,
                HoldHigh => thold_di7_we_noedge_negedge,
                HoldLow => thold_di7_we_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di7_we_timingdatash,
                Violation => tviol_di7_we,
                MsgSeverity => warning);
           VitalSetupHoldCheck (
                TestSignal => data_in(7),
                TestSignalName => "di7",
                RefSignal => re_ipd,
                RefSignalName => "re",
                SetupHigh => tsetup_di7_re_noedge_negedge,
                setuplow => tsetup_di7_re_noedge_negedge,
                HoldHigh => thold_di7_re_noedge_negedge,
                HoldLow => thold_di7_re_noedge_negedge,
                CheckEnabled => TRUE,
                RefTransition => '/',
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath,
                TimingData => di7_re_timingdatash,
                Violation => tviol_di7_re,
                MsgSeverity => warning);

    END IF;
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    results(11 downto 4) := data_out(7 downto 0);
 
    IF (new_mode = PCMBUF) THEN 
       eclk_zd := eclk_buf;
       sclk_zd := sclk_buf;
       lock_zd := lock_buf;
    ELSIF (new_mode = DLL1X) THEN
       eclk_zd := eclk_dll1x;
       sclk_zd := sclk_dll1x;
       lock_zd := lock_dll1x;
    ELSIF (new_mode = DLLPD) THEN
       IF (local_pcm_reset = '1') THEN
          lock_zd := '0';
          eclk_zd := '0';
          sclk_zd := '0';
       ELSE
          eclk_zd := eclk_dllpd_out;
          sclk_zd := sclk_dllpd_out;
          lock_zd := lock_dllpd_out;
       END IF;
    ELSIF (new_mode = PLL) THEN
       IF (clock_pll_valid = '0') THEN
          eclk_zd := new_eclk;
          sclk_zd := new_sclk;
       ELSIF (clock_pll_valid = '1') THEN
          eclk_zd := vir_eclk;
          sclk_zd := vir_sclk;
          lock_zd := lock_pll_all;
       END IF;
    END IF;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => eclk,
     OutSignalName => "eclk",
     OutTemp => eclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_eclk, TRUE)),
     GlitchData => eclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => sclk,
     OutSignalName => "sclk",
     OutTemp => sclk_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_sclk, TRUE)),
     GlitchData => sclk_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01 (
     OutSignal => lock,
     OutSignalName => "lock",
     OutTemp => lock_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_lock, TRUE)),
     GlitchData => lock_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do0, TRUE)),
     GlitchData => do0_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do1,
     OutSignalName => "do1",
     OutTemp => do1_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do1, TRUE)),
     GlitchData => do1_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do2,
     OutSignalName => "do2",
     OutTemp => do2_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do2, TRUE)),
     GlitchData => do2_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do3,
     OutSignalName => "do3",
     OutTemp => do3_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do3, TRUE)),
     GlitchData => do3_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do4,
     OutSignalName => "do4",
     OutTemp => do4_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do4, TRUE)),
     GlitchData => do4_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do5,
     OutSignalName => "do5",
     OutTemp => do5_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do5, TRUE)),
     GlitchData => do5_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do6,
     OutSignalName => "do6",
     OutTemp => do6_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do6, TRUE)),
     GlitchData => do6_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
    VitalPathDelay01Z (
     OutSignal => do7,
     OutSignalName => "do7",
     OutTemp => do7_zd,
     Paths => (0 => (re_ipd'last_event, tpd_re_do7, TRUE)),
     GlitchData => do7_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;


