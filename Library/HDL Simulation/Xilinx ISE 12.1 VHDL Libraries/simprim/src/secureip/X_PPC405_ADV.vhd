-- $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/vhdsclibs/data/simprims/virtex4/SMODEL/X_PPC405_ADV.vhd,v 1.1 2008/06/19 17:05:33 vandanad Exp $
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Timing Simulation Library Component
--  /   /                  Power PC Core
-- /___/   /\     Filename : X_PPC405_ADV.vhd
-- \   \  /  \    Timestamp : Fri Jun 18 10:57:22 PDT 2004
--  \___\/\___\
--
-- Revision:
--    03/23/04 - Initial version.

-------------------------------------------------------------------------------
-- Model for fpga_startup_virtex4 (for simulation only)
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity fpga_startup_virtex4 is

    port (
          bus_reset : out std_ulogic;
          ghigh_b : out std_ulogic;
          done : out std_ulogic;
          gsr : out std_ulogic;
          gwe : out std_ulogic;
          gts_b : out std_ulogic;

          shutdown : in std_ulogic;
          cclk : in std_ulogic;
          por : in std_ulogic
          );
end fpga_startup_virtex4;

architecture fpga_startup_virtex4_v of fpga_startup_virtex4 is
    signal count_changed : boolean := false;
begin
set_output:process(cclk, por)
  variable abus_reset : std_ulogic := '0';
  variable aghigh_b : std_ulogic := '0';
  variable agsr : std_ulogic := '0';
  variable adone : std_ulogic := '0'; 
  variable agwe : std_ulogic := '0';    
  variable agts_b : std_ulogic := '0';
  variable count : integer := 0;
  variable count_last_value : integer := 0;

begin
  if (((cclk'event) and (cclk = '1') and (cclk'last_value = '0')) or ((por'event) and (por = '1') and (por'last_value = '0')))then
    
          count_last_value := count;
    if (por = '1') then
      count := 0;
    elsif ((shutdown ='1') and (count > 0)) then
      count := count - 1;
    elsif ((shutdown ='0') and (count < 255)) then
      count := count + 1;
    end if;
   if(count_last_value /= count) then
     count_changed <= true;
   end if;  


    if (por = '1') then
      bus_reset <= '0';
      ghigh_b <=  '0';
      gsr <= '0';
      done <= '0'; 
      gwe <= '0';
      gts_b <= '0'; 
 
    else

      bus_reset <= abus_reset;
      ghigh_b <=  aghigh_b;
      gsr <= agsr;
      done <= adone; 
      gwe <= agwe;
      gts_b <= agts_b;

    end if;
  end if;
    if(count_last_value /= count) then
      abus_reset := '1';
      aghigh_b := '0';
      agsr := '0';
      adone := '0';
      agwe := '0';
      agts_b := '0';     
     if (count >= 02) then
       abus_reset := '0';
     end if;  
     if ((count = 23) or (count = 24)) then
       agsr := '1';
     end if;  
     if (count > 39) then
         aghigh_b := '1';
     end if;
     if (count > 49) then
        adone := '1';   
     end if;

     if ((count = 51) or (count = 52)) then
       agsr := '1';
     end if;        
     if (count > 54) then
        agwe := '1';   
     end if;
     if (count > 55) then
        agts_b := '1';   
     end if;
    end if;      
end process set_output;


end fpga_startup_virtex4_v;

----- CELL X_PPC405_ADV -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library IEEE;
use IEEE.VITAL_Timing.all;

library simprim;
use simprim.VCOMPONENTS.all; 

library secureip; 
use secureip.all; 

entity X_PPC405_ADV is
generic (
        TimingChecksOn : boolean := TRUE;
        InstancePath   : string  := "*";
        Xon            : boolean := TRUE;
        MsgOn          : boolean := FALSE;
        LOC            : string  := "UNPLACED";        

		IN_DELAY : time := 1 ps;
		OUT_DELAY : VitalDelayType01 := (0 ps, 0 ps);

--  Pin pulse width delays
--  Pin period delays

--  Input Pin path delays
        tipd_BRAMDSOCMCLK : VitalDelayType01 :=  (0 ps, 0 ps);
        tipd_BRAMDSOCMRDDBUS : VitalDelayArrayType01 (0 to 31) := (others => (100 ps, 100 ps));
        tipd_BRAMISOCMCLK : VitalDelayType01 :=  (0 ps, 0 ps);
        tipd_BRAMISOCMDCRRDDBUS : VitalDelayArrayType01 (0 to 31) := (others => (100 ps, 100 ps));
        tipd_BRAMISOCMRDDBUS : VitalDelayArrayType01 (0 to 63) := (others => (100 ps, 100 ps));
        tipd_CPMC405CLOCK : VitalDelayType01 :=  (0 ps, 0 ps);
        tipd_CPMC405CORECLKINACTIVE : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_CPMC405CPUCLKEN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_CPMC405JTAGCLKEN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_CPMC405SYNCBYPASS : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_CPMC405TIMERCLKEN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_CPMC405TIMERTICK : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_CPMDCRCLK : VitalDelayType01 :=  (0 ps, 0 ps);
        tipd_CPMFCMCLK : VitalDelayType01 :=  (0 ps, 0 ps);
        tipd_DBGC405DEBUGHALT : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_DBGC405EXTBUSHOLDACK : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_DBGC405UNCONDDEBUGEVENT : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_DSARCVALUE : VitalDelayArrayType01 (0 to 7) := (others => (100 ps, 100 ps));
        tipd_DSCNTLVALUE : VitalDelayArrayType01 (0 to 7) := (others => (100 ps, 100 ps));
        tipd_DSOCMRWCOMPLETE : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_EICC405CRITINPUTIRQ : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_EICC405EXTINPUTIRQ : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_EXTDCRACK : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_EXTDCRDBUSIN : VitalDelayArrayType01 (0 to 31) := (others => (100 ps, 100 ps));
        tipd_FCMAPUCR : VitalDelayArrayType01 (0 to 3) := (others => (100 ps, 100 ps));
        tipd_FCMAPUDCDCREN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDFORCEALIGN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDFORCEBESTEERING : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDFPUOP : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDGPRWRITE : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDLDSTBYTE : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDLDSTDW : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDLDSTHW : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDLDSTQW : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDLDSTWD : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDLOAD : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDPRIVOP : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDRAEN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDRBEN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDSTORE : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDTRAPBE : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDTRAPLE : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDUPDATE : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDXERCAEN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDCDXEROVEN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDECODEBUSY : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUDONE : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUEXCEPTION : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUEXEBLOCKINGMCO : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUEXECRFIELD : VitalDelayArrayType01 (0 to 2) := (others => (100 ps, 100 ps));
        tipd_FCMAPUEXENONBLOCKINGMCO : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUINSTRACK : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPULOADWAIT : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPURESULT : VitalDelayArrayType01 (0 to 31) := (others => (100 ps, 100 ps));
        tipd_FCMAPURESULTVALID : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUSLEEPNOTREADY : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUXERCA : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_FCMAPUXEROV : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_ISARCVALUE : VitalDelayArrayType01 (0 to 7) := (others => (100 ps, 100 ps));
        tipd_ISCNTLVALUE : VitalDelayArrayType01 (0 to 7) := (others => (100 ps, 100 ps));
        tipd_JTGC405BNDSCANTDO : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_JTGC405TCK : VitalDelayType01 :=  (0 ps, 0 ps);
        tipd_JTGC405TDI : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_JTGC405TMS : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_JTGC405TRSTNEG : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_MCBCPUCLKEN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_MCBJTAGEN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_MCBTIMEREN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_MCPPCRST : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_PLBC405DCUADDRACK : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_PLBC405DCUBUSY : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_PLBC405DCUERR : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_PLBC405DCURDDACK : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_PLBC405DCURDDBUS : VitalDelayArrayType01 (0 to 63) := (others => (100 ps, 100 ps));
        tipd_PLBC405DCURDWDADDR : VitalDelayArrayType01 (1 to 3) := (others => (100 ps, 100 ps));
        tipd_PLBC405DCUSSIZE1 : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_PLBC405DCUWRDACK : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_PLBC405ICUADDRACK : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_PLBC405ICUBUSY : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_PLBC405ICUERR : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_PLBC405ICURDDACK : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_PLBC405ICURDDBUS : VitalDelayArrayType01 (0 to 63) := (others => (100 ps, 100 ps));
        tipd_PLBC405ICURDWDADDR : VitalDelayArrayType01 (1 to 3) := (others => (100 ps, 100 ps));
        tipd_PLBC405ICUSSIZE1 : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_PLBCLK : VitalDelayType01 :=  (0 ps, 0 ps);
        tipd_RSTC405RESETCHIP : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_RSTC405RESETCORE : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_RSTC405RESETSYS : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TIEAPUCONTROL : VitalDelayArrayType01 (0 to 15) := (others => (100 ps, 100 ps));
        tipd_TIEAPUUDI1 : VitalDelayArrayType01 (0 to 23) := (others => (100 ps, 100 ps));
        tipd_TIEAPUUDI2 : VitalDelayArrayType01 (0 to 23) := (others => (100 ps, 100 ps));
        tipd_TIEAPUUDI3 : VitalDelayArrayType01 (0 to 23) := (others => (100 ps, 100 ps));
        tipd_TIEAPUUDI4 : VitalDelayArrayType01 (0 to 23) := (others => (100 ps, 100 ps));
        tipd_TIEAPUUDI5 : VitalDelayArrayType01 (0 to 23) := (others => (100 ps, 100 ps));
        tipd_TIEAPUUDI6 : VitalDelayArrayType01 (0 to 23) := (others => (100 ps, 100 ps));
        tipd_TIEAPUUDI7 : VitalDelayArrayType01 (0 to 23) := (others => (100 ps, 100 ps));
        tipd_TIEAPUUDI8 : VitalDelayArrayType01 (0 to 23) := (others => (100 ps, 100 ps));
        tipd_TIEC405DETERMINISTICMULT : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TIEC405DISOPERANDFWD : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TIEC405MMUEN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TIEDCRADDR : VitalDelayArrayType01 (0 to 5) := (others => (100 ps, 100 ps));
        tipd_TIEPVRBIT10 : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TIEPVRBIT11 : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TIEPVRBIT28 : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TIEPVRBIT29 : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TIEPVRBIT30 : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TIEPVRBIT31 : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TIEPVRBIT8 : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TIEPVRBIT9 : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TRCC405TRACEDISABLE : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_TRCC405TRIGGEREVENTIN : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_EMACDCRDBUS : VitalDelayArrayType01 (0 to 31) := (others => (100 ps, 100 ps));
        tipd_EMACDCRACK : VitalDelayType01 :=  (100 ps, 100 ps);
        tipd_GSR : VitalDelayType01 := (100 ps, 100 ps);
--  clk-to-output path delays
        tpd_CPMFCMCLK_APUFCMDECODED : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMFCMCLK_APUFCMDECUDI : VitalDelayArrayType01(0 to 2) := (others => (100 ps, 100 ps));
        tpd_CPMFCMCLK_APUFCMDECUDIVALID : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMFCMCLK_APUFCMENDIAN : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMFCMCLK_APUFCMFLUSH : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMFCMCLK_APUFCMINSTRUCTION : VitalDelayArrayType01(0 to 31) := (others => (100 ps, 100 ps));
        tpd_CPMFCMCLK_APUFCMINSTRVALID : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMFCMCLK_APUFCMLOADBYTEEN : VitalDelayArrayType01(0 to 3) := (others => (100 ps, 100 ps));
        tpd_CPMFCMCLK_APUFCMLOADDATA : VitalDelayArrayType01(0 to 31) := (others => (100 ps, 100 ps));
        tpd_CPMFCMCLK_APUFCMLOADDVALID : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMFCMCLK_APUFCMOPERANDVALID : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMFCMCLK_APUFCMRADATA : VitalDelayArrayType01(0 to 31) := (others => (100 ps, 100 ps));
        tpd_CPMFCMCLK_APUFCMRBDATA : VitalDelayArrayType01(0 to 31) := (others => (100 ps, 100 ps));
        tpd_CPMFCMCLK_APUFCMWRITEBACKOK : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMFCMCLK_APUFCMXERCA : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405CPMCORESLEEPREQ : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405CPMMSRCE : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405CPMMSREE : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405CPMTIMERIRQ : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405CPMTIMERRESETREQ : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405DBGLOADDATAONAPUDBUS : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405DBGMSRWE : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405DBGSTOPACK : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405DBGWBCOMPLETE : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405DBGWBFULL : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405DBGWBIAR : VitalDelayArrayType01(0 to 29) := (others => (100 ps, 100 ps));
        tpd_JTGC405TCK_C405JTGCAPTUREDR : VitalDelayType01 := (100 ps, 100 ps);
        tpd_JTGC405TCK_C405JTGEXTEST : VitalDelayType01 := (100 ps, 100 ps);
        tpd_JTGC405TCK_C405JTGPGMOUT : VitalDelayType01 := (100 ps, 100 ps);
        tpd_JTGC405TCK_C405JTGSHIFTDR : VitalDelayType01 := (100 ps, 100 ps);
        tpd_JTGC405TCK_C405JTGTDO : VitalDelayType01 := (100 ps, 100 ps);
        tpd_JTGC405TCK_C405JTGTDOEN : VitalDelayType01 := (100 ps, 100 ps);
        tpd_JTGC405TCK_C405JTGUPDATEDR : VitalDelayType01 := (100 ps, 100 ps);
        tpd_PLBCLK_C405PLBDCUABORT : VitalDelayType01 := (100 ps, 100 ps);
        tpd_PLBCLK_C405PLBDCUABUS : VitalDelayArrayType01(0 to 31) := (others => (100 ps, 100 ps));
        tpd_PLBCLK_C405PLBDCUBE : VitalDelayArrayType01(0 to 7) := (others => (100 ps, 100 ps));
        tpd_PLBCLK_C405PLBDCUCACHEABLE : VitalDelayType01 := (100 ps, 100 ps);
        tpd_PLBCLK_C405PLBDCUGUARDED : VitalDelayType01 := (100 ps, 100 ps);
        tpd_PLBCLK_C405PLBDCUPRIORITY : VitalDelayArrayType01(0 to 1) := (others => (100 ps, 100 ps));
        tpd_PLBCLK_C405PLBDCUREQUEST : VitalDelayType01 := (100 ps, 100 ps);
        tpd_PLBCLK_C405PLBDCURNW : VitalDelayType01 := (100 ps, 100 ps);
        tpd_PLBCLK_C405PLBDCUSIZE2 : VitalDelayType01 := (100 ps, 100 ps);
        tpd_PLBCLK_C405PLBDCUU0ATTR : VitalDelayType01 := (100 ps, 100 ps);
        tpd_PLBCLK_C405PLBDCUWRDBUS : VitalDelayArrayType01(0 to 63) := (others => (100 ps, 100 ps));
        tpd_PLBCLK_C405PLBDCUWRITETHRU : VitalDelayType01 := (100 ps, 100 ps);
        tpd_PLBCLK_C405PLBICUABORT : VitalDelayType01 := (100 ps, 100 ps);
        tpd_PLBCLK_C405PLBICUABUS : VitalDelayArrayType01(0 to 29) := (others => (100 ps, 100 ps));
        tpd_PLBCLK_C405PLBICUCACHEABLE : VitalDelayType01 := (100 ps, 100 ps);
        tpd_PLBCLK_C405PLBICUPRIORITY : VitalDelayArrayType01(0 to 1) := (others => (100 ps, 100 ps));
        tpd_PLBCLK_C405PLBICUREQUEST : VitalDelayType01 := (100 ps, 100 ps);
        tpd_PLBCLK_C405PLBICUSIZE : VitalDelayArrayType01(2 to 3) := (others => (100 ps, 100 ps));
        tpd_PLBCLK_C405PLBICUU0ATTR : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405RSTCHIPRESETREQ : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405RSTCORERESETREQ : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405RSTSYSRESETREQ : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405TRCCYCLE : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405TRCEVENEXECUTIONSTATUS : VitalDelayArrayType01(0 to 1) := (others => (100 ps, 100 ps));
        tpd_CPMC405CLOCK_C405TRCODDEXECUTIONSTATUS : VitalDelayArrayType01(0 to 1) := (others => (100 ps, 100 ps));
        tpd_CPMC405CLOCK_C405TRCTRACESTATUS : VitalDelayArrayType01(0 to 3) := (others => (100 ps, 100 ps));
        tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTOUT : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE : VitalDelayArrayType01(0 to 10) := (others => (100 ps, 100 ps));
        tpd_CPMC405CLOCK_C405XXXMACHINECHECK : VitalDelayType01 := (100 ps, 100 ps);
        tpd_BRAMDSOCMCLK_DSOCMBRAMABUS : VitalDelayArrayType01(8 to 29) := (others => (100 ps, 100 ps));
        tpd_BRAMDSOCMCLK_DSOCMBRAMBYTEWRITE : VitalDelayArrayType01(0 to 3) := (others => (100 ps, 100 ps));
        tpd_BRAMDSOCMCLK_DSOCMBRAMEN : VitalDelayType01 := (100 ps, 100 ps);
        tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS : VitalDelayArrayType01(0 to 31) := (others => (100 ps, 100 ps));
        tpd_BRAMDSOCMCLK_DSOCMBUSY : VitalDelayType01 := (100 ps, 100 ps);
        tpd_BRAMDSOCMCLK_DSOCMRDADDRVALID : VitalDelayType01 := (100 ps, 100 ps);
        tpd_BRAMDSOCMCLK_DSOCMWRADDRVALID : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMDCRCLK_EXTDCRABUS : VitalDelayArrayType01(0 to 9) := (others => (100 ps, 100 ps));
        tpd_CPMDCRCLK_EXTDCRDBUSOUT : VitalDelayArrayType01(0 to 31) := (others => (100 ps, 100 ps));
        tpd_CPMDCRCLK_EXTDCRREAD : VitalDelayType01 := (100 ps, 100 ps);
        tpd_CPMDCRCLK_EXTDCRWRITE : VitalDelayType01 := (100 ps, 100 ps);
        tpd_BRAMISOCMCLK_ISOCMBRAMEN : VitalDelayType01 := (100 ps, 100 ps);
        tpd_BRAMISOCMCLK_ISOCMBRAMEVENWRITEEN : VitalDelayType01 := (100 ps, 100 ps);
        tpd_BRAMISOCMCLK_ISOCMBRAMODDWRITEEN : VitalDelayType01 := (100 ps, 100 ps);
        tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS : VitalDelayArrayType01(8 to 28) := (others => (100 ps, 100 ps));
        tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS : VitalDelayArrayType01(8 to 28) := (others => (100 ps, 100 ps));
        tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS : VitalDelayArrayType01(0 to 31) := (others => (100 ps, 100 ps));
        tpd_BRAMISOCMCLK_ISOCMDCRBRAMEVENEN : VitalDelayType01 := (100 ps, 100 ps);
        tpd_BRAMISOCMCLK_ISOCMDCRBRAMODDEN : VitalDelayType01 := (100 ps, 100 ps);
        tpd_BRAMISOCMCLK_ISOCMDCRBRAMRDSELECT : VitalDelayType01 := (100 ps, 100 ps);

--  Setup/Hold delays
        tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        tsetup_CPMC405CORECLKINACTIVE_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_CPMC405CORECLKINACTIVE_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_CPMC405CORECLKINACTIVE_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_CPMC405CORECLKINACTIVE_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_CPMC405CPUCLKEN_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_CPMC405CPUCLKEN_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_CPMC405CPUCLKEN_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_CPMC405CPUCLKEN_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_CPMC405JTAGCLKEN_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_CPMC405JTAGCLKEN_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_CPMC405JTAGCLKEN_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_CPMC405JTAGCLKEN_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_CPMC405TIMERCLKEN_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_CPMC405TIMERCLKEN_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_CPMC405TIMERCLKEN_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_CPMC405TIMERCLKEN_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_CPMC405TIMERTICK_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_CPMC405TIMERTICK_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_CPMC405TIMERTICK_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_CPMC405TIMERTICK_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_DBGC405DEBUGHALT_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_DBGC405DEBUGHALT_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_DBGC405DEBUGHALT_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_DBGC405DEBUGHALT_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_DBGC405EXTBUSHOLDACK_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_DBGC405EXTBUSHOLDACK_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_DBGC405EXTBUSHOLDACK_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_DBGC405EXTBUSHOLDACK_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_DBGC405UNCONDDEBUGEVENT_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_DBGC405UNCONDDEBUGEVENT_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_DBGC405UNCONDDEBUGEVENT_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_DBGC405UNCONDDEBUGEVENT_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_DSOCMRWCOMPLETE_BRAMDSOCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_DSOCMRWCOMPLETE_BRAMDSOCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_DSOCMRWCOMPLETE_BRAMDSOCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_DSOCMRWCOMPLETE_BRAMDSOCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_EICC405CRITINPUTIRQ_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_EICC405CRITINPUTIRQ_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_EICC405CRITINPUTIRQ_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_EICC405CRITINPUTIRQ_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_EICC405EXTINPUTIRQ_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_EICC405EXTINPUTIRQ_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_EICC405EXTINPUTIRQ_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_EICC405EXTINPUTIRQ_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_EXTDCRACK_CPMDCRCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_EXTDCRACK_CPMDCRCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_EXTDCRACK_CPMDCRCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_EXTDCRACK_CPMDCRCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        tsetup_FCMAPUCR_CPMFCMCLK_posedge_posedge : VitalDelayArrayType(0 to 3) := (others => 0 ps);
        tsetup_FCMAPUCR_CPMFCMCLK_negedge_posedge : VitalDelayArrayType(0 to 3) := (others => 0 ps);
        thold_FCMAPUCR_CPMFCMCLK_posedge_posedge : VitalDelayArrayType(0 to 3) := (others => 0 ps);
        thold_FCMAPUCR_CPMFCMCLK_negedge_posedge : VitalDelayArrayType(0 to 3) := (others => 0 ps);
        tsetup_FCMAPUDCDCREN_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDCREN_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDCREN_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDCREN_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDFORCEALIGN_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDFORCEALIGN_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDFORCEALIGN_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDFORCEALIGN_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDFORCEBESTEERING_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDFORCEBESTEERING_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDFORCEBESTEERING_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDFORCEBESTEERING_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDFPUOP_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDFPUOP_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDFPUOP_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDFPUOP_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDGPRWRITE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDGPRWRITE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDGPRWRITE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDGPRWRITE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDLDSTBYTE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDLDSTBYTE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDLDSTBYTE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDLDSTBYTE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDLDSTDW_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDLDSTDW_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDLDSTDW_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDLDSTDW_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDLDSTHW_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDLDSTHW_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDLDSTHW_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDLDSTHW_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDLDSTQW_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDLDSTQW_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDLDSTQW_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDLDSTQW_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDLDSTWD_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDLDSTWD_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDLDSTWD_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDLDSTWD_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDLOAD_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDLOAD_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDLOAD_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDLOAD_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDPRIVOP_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDPRIVOP_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDPRIVOP_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDPRIVOP_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDRAEN_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDRAEN_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDRAEN_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDRAEN_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDRBEN_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDRBEN_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDRBEN_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDRBEN_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDSTORE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDSTORE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDSTORE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDSTORE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDTRAPBE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDTRAPBE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDTRAPBE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDTRAPBE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDTRAPLE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDTRAPLE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDTRAPLE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDTRAPLE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDUPDATE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDUPDATE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDUPDATE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDUPDATE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDXERCAEN_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDXERCAEN_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDXERCAEN_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDXERCAEN_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDXEROVEN_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDCDXEROVEN_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDXEROVEN_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDCDXEROVEN_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDECODEBUSY_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDECODEBUSY_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDECODEBUSY_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDECODEBUSY_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDONE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUDONE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDONE_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUDONE_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUEXCEPTION_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUEXCEPTION_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUEXCEPTION_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUEXCEPTION_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUEXEBLOCKINGMCO_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUEXEBLOCKINGMCO_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUEXEBLOCKINGMCO_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUEXEBLOCKINGMCO_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUEXECRFIELD_CPMFCMCLK_posedge_posedge : VitalDelayArrayType(0 to 2) := (others => 0 ps);
        tsetup_FCMAPUEXECRFIELD_CPMFCMCLK_negedge_posedge : VitalDelayArrayType(0 to 2) := (others => 0 ps);
        thold_FCMAPUEXECRFIELD_CPMFCMCLK_posedge_posedge : VitalDelayArrayType(0 to 2) := (others => 0 ps);
        thold_FCMAPUEXECRFIELD_CPMFCMCLK_negedge_posedge : VitalDelayArrayType(0 to 2) := (others => 0 ps);
        tsetup_FCMAPUEXENONBLOCKINGMCO_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUEXENONBLOCKINGMCO_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUEXENONBLOCKINGMCO_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUEXENONBLOCKINGMCO_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUINSTRACK_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUINSTRACK_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUINSTRACK_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUINSTRACK_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPULOADWAIT_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPULOADWAIT_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPULOADWAIT_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPULOADWAIT_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        tsetup_FCMAPURESULTVALID_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPURESULTVALID_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPURESULTVALID_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPURESULTVALID_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUSLEEPNOTREADY_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUSLEEPNOTREADY_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUSLEEPNOTREADY_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUSLEEPNOTREADY_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUXERCA_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUXERCA_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUXERCA_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUXERCA_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUXEROV_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_FCMAPUXEROV_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUXEROV_CPMFCMCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_FCMAPUXEROV_CPMFCMCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_JTGC405BNDSCANTDO_JTGC405TCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_JTGC405BNDSCANTDO_JTGC405TCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_JTGC405BNDSCANTDO_JTGC405TCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_JTGC405BNDSCANTDO_JTGC405TCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_JTGC405TDI_JTGC405TCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_JTGC405TDI_JTGC405TCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_JTGC405TDI_JTGC405TCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_JTGC405TDI_JTGC405TCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_JTGC405TMS_JTGC405TCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_JTGC405TMS_JTGC405TCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_JTGC405TMS_JTGC405TCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_JTGC405TMS_JTGC405TCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_JTGC405TRSTNEG_JTGC405TCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_JTGC405TRSTNEG_JTGC405TCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_JTGC405TRSTNEG_JTGC405TCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_JTGC405TRSTNEG_JTGC405TCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405DCUADDRACK_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405DCUADDRACK_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405DCUADDRACK_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405DCUADDRACK_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405DCUBUSY_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405DCUBUSY_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405DCUBUSY_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405DCUBUSY_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405DCUERR_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405DCUERR_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405DCUERR_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405DCUERR_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405DCURDDACK_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405DCURDDACK_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405DCURDDACK_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405DCURDDACK_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        tsetup_PLBC405DCURDWDADDR_PLBCLK_posedge_posedge : VitalDelayArrayType(1 to 3) := (others => 0 ps);
        tsetup_PLBC405DCURDWDADDR_PLBCLK_negedge_posedge : VitalDelayArrayType(1 to 3) := (others => 0 ps);
        thold_PLBC405DCURDWDADDR_PLBCLK_posedge_posedge : VitalDelayArrayType(1 to 3) := (others => 0 ps);
        thold_PLBC405DCURDWDADDR_PLBCLK_negedge_posedge : VitalDelayArrayType(1 to 3) := (others => 0 ps);
        tsetup_PLBC405DCUSSIZE1_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405DCUSSIZE1_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405DCUSSIZE1_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405DCUSSIZE1_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405DCUWRDACK_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405DCUWRDACK_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405DCUWRDACK_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405DCUWRDACK_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405ICUADDRACK_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405ICUADDRACK_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405ICUADDRACK_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405ICUADDRACK_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405ICUBUSY_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405ICUBUSY_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405ICUBUSY_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405ICUBUSY_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405ICUERR_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405ICUERR_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405ICUERR_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405ICUERR_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405ICURDDACK_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405ICURDDACK_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405ICURDDACK_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405ICURDDACK_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        tsetup_PLBC405ICURDWDADDR_PLBCLK_posedge_posedge : VitalDelayArrayType(1 to 3) := (others => 0 ps);
        tsetup_PLBC405ICURDWDADDR_PLBCLK_negedge_posedge : VitalDelayArrayType(1 to 3) := (others => 0 ps);
        thold_PLBC405ICURDWDADDR_PLBCLK_posedge_posedge : VitalDelayArrayType(1 to 3) := (others => 0 ps);
        thold_PLBC405ICURDWDADDR_PLBCLK_negedge_posedge : VitalDelayArrayType(1 to 3) := (others => 0 ps);
        tsetup_PLBC405ICUSSIZE1_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_PLBC405ICUSSIZE1_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405ICUSSIZE1_PLBCLK_posedge_posedge : VitalDelayType := 0 ps;
        thold_PLBC405ICUSSIZE1_PLBCLK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_RSTC405RESETCHIP_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_RSTC405RESETCHIP_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_RSTC405RESETCHIP_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_RSTC405RESETCHIP_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_RSTC405RESETCORE_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_RSTC405RESETCORE_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_RSTC405RESETCORE_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_RSTC405RESETCORE_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_RSTC405RESETSYS_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_RSTC405RESETSYS_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_RSTC405RESETSYS_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_RSTC405RESETSYS_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_TRCC405TRACEDISABLE_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_TRCC405TRACEDISABLE_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_TRCC405TRACEDISABLE_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_TRCC405TRACEDISABLE_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        tsetup_TRCC405TRIGGEREVENTIN_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_TRCC405TRIGGEREVENTIN_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;
        thold_TRCC405TRIGGEREVENTIN_CPMC405CLOCK_posedge_posedge : VitalDelayType := 0 ps;
        thold_TRCC405TRIGGEREVENTIN_CPMC405CLOCK_negedge_posedge : VitalDelayType := 0 ps;

        tperiod_CPMC405CLOCK_POSEDGE : VitalDelayType := 0 ps;
        tpw_CPMC405CLOCK_posedge : VitalDelayType := 0 ps;
        tpw_CPMC405CLOCK_negedge : VitalDelayType := 0 ps;        

--  Clock ticd

        ticd_BRAMDSOCMCLK : VitalDelayType := 0 ps;
        ticd_BRAMISOCMCLK : VitalDelayType := 0 ps;
        ticd_CPMC405CLOCK : VitalDelayType := 0 ps;
        ticd_CPMDCRCLK : VitalDelayType := 0 ps;
        ticd_CPMFCMCLK : VitalDelayType := 0 ps;
        ticd_JTGC405TCK : VitalDelayType := 0 ps;
        ticd_PLBCLK : VitalDelayType := 0 ps;

-- Clock-to-pin tisd 
        tisd_BRAMDSOCMRDDBUS : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        tisd_BRAMISOCMDCRRDDBUS : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        tisd_BRAMISOCMRDDBUS : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        tisd_CPMC405CORECLKINACTIVE : VitalDelayType := 0 ps;
        tisd_CPMC405CPUCLKEN : VitalDelayType := 0 ps;
        tisd_CPMC405JTAGCLKEN : VitalDelayType := 0 ps;
        tisd_CPMC405TIMERCLKEN : VitalDelayType := 0 ps;
        tisd_CPMC405TIMERTICK : VitalDelayType := 0 ps;
        tisd_DBGC405DEBUGHALT : VitalDelayType := 0 ps;
        tisd_DBGC405EXTBUSHOLDACK : VitalDelayType := 0 ps;
        tisd_DBGC405UNCONDDEBUGEVENT : VitalDelayType := 0 ps;
        tisd_DSOCMRWCOMPLETE : VitalDelayType := 0 ps;
        tisd_EICC405CRITINPUTIRQ : VitalDelayType := 0 ps;
        tisd_EICC405EXTINPUTIRQ : VitalDelayType := 0 ps;
        tisd_EXTDCRACK : VitalDelayType := 0 ps;
        tisd_EXTDCRDBUSIN : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        tisd_FCMAPUCR : VitalDelayArrayType(0 to 3) := (others => 0 ps);
        tisd_FCMAPUDCDCREN : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDFORCEALIGN : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDFORCEBESTEERING : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDFPUOP : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDGPRWRITE : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDLDSTBYTE : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDLDSTDW : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDLDSTHW : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDLDSTQW : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDLDSTWD : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDLOAD : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDPRIVOP : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDRAEN : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDRBEN : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDSTORE : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDTRAPBE : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDTRAPLE : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDUPDATE : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDXERCAEN : VitalDelayType := 0 ps;
        tisd_FCMAPUDCDXEROVEN : VitalDelayType := 0 ps;
        tisd_FCMAPUDECODEBUSY : VitalDelayType := 0 ps;
        tisd_FCMAPUDONE : VitalDelayType := 0 ps;
        tisd_FCMAPUEXCEPTION : VitalDelayType := 0 ps;
        tisd_FCMAPUEXEBLOCKINGMCO : VitalDelayType := 0 ps;
        tisd_FCMAPUEXECRFIELD : VitalDelayArrayType(0 to 2) := (others => 0 ps);
        tisd_FCMAPUEXENONBLOCKINGMCO : VitalDelayType := 0 ps;
        tisd_FCMAPUINSTRACK : VitalDelayType := 0 ps;
        tisd_FCMAPULOADWAIT : VitalDelayType := 0 ps;
        tisd_FCMAPURESULT : VitalDelayArrayType(0 to 31) := (others => 0 ps);
        tisd_FCMAPURESULTVALID : VitalDelayType := 0 ps;
        tisd_FCMAPUSLEEPNOTREADY : VitalDelayType := 0 ps;
        tisd_FCMAPUXERCA : VitalDelayType := 0 ps;
        tisd_FCMAPUXEROV : VitalDelayType := 0 ps;
        tisd_JTGC405BNDSCANTDO : VitalDelayType := 0 ps;
        tisd_JTGC405TDI : VitalDelayType := 0 ps;
        tisd_JTGC405TMS : VitalDelayType := 0 ps;
        tisd_JTGC405TRSTNEG : VitalDelayType := 0 ps;
        tisd_PLBC405DCUADDRACK : VitalDelayType := 0 ps;
        tisd_PLBC405DCUBUSY : VitalDelayType := 0 ps;
        tisd_PLBC405DCUERR : VitalDelayType := 0 ps;
        tisd_PLBC405DCURDDACK : VitalDelayType := 0 ps;
        tisd_PLBC405DCURDDBUS : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        tisd_PLBC405DCURDWDADDR : VitalDelayArrayType(1 to 3) := (others => 0 ps);
        tisd_PLBC405DCUSSIZE1 : VitalDelayType := 0 ps;
        tisd_PLBC405DCUWRDACK : VitalDelayType := 0 ps;
        tisd_PLBC405ICUADDRACK : VitalDelayType := 0 ps;
        tisd_PLBC405ICUBUSY : VitalDelayType := 0 ps;
        tisd_PLBC405ICUERR : VitalDelayType := 0 ps;
        tisd_PLBC405ICURDDACK : VitalDelayType := 0 ps;
        tisd_PLBC405ICURDDBUS : VitalDelayArrayType(0 to 63) := (others => 0 ps);
        tisd_PLBC405ICURDWDADDR : VitalDelayArrayType(1 to 3) := (others => 0 ps);
        tisd_PLBC405ICUSSIZE1 : VitalDelayType := 0 ps;
        tisd_RSTC405RESETCHIP : VitalDelayType := 0 ps;
        tisd_RSTC405RESETCORE : VitalDelayType := 0 ps;
        tisd_RSTC405RESETSYS : VitalDelayType := 0 ps;
        tisd_TRCC405TRACEDISABLE : VitalDelayType := 0 ps;
        tisd_TRCC405TRIGGEREVENTIN : VitalDelayType := 0 ps


  );

port (
		APUFCMDECODED : out std_ulogic;
		APUFCMDECUDI : out std_logic_vector(0 to 2);
		APUFCMDECUDIVALID : out std_ulogic;
		APUFCMENDIAN : out std_ulogic;
		APUFCMFLUSH : out std_ulogic;
		APUFCMINSTRUCTION : out std_logic_vector(0 to 31);
		APUFCMINSTRVALID : out std_ulogic;
		APUFCMLOADBYTEEN : out std_logic_vector(0 to 3);
		APUFCMLOADDATA : out std_logic_vector(0 to 31);
		APUFCMLOADDVALID : out std_ulogic;
		APUFCMOPERANDVALID : out std_ulogic;
		APUFCMRADATA : out std_logic_vector(0 to 31);
		APUFCMRBDATA : out std_logic_vector(0 to 31);
		APUFCMWRITEBACKOK : out std_ulogic;
		APUFCMXERCA : out std_ulogic;
		C405CPMCORESLEEPREQ : out std_ulogic;
		C405CPMMSRCE : out std_ulogic;
		C405CPMMSREE : out std_ulogic;
		C405CPMTIMERIRQ : out std_ulogic;
		C405CPMTIMERRESETREQ : out std_ulogic;
		C405DBGLOADDATAONAPUDBUS : out std_ulogic;
		C405DBGMSRWE : out std_ulogic;
		C405DBGSTOPACK : out std_ulogic;
		C405DBGWBCOMPLETE : out std_ulogic;
		C405DBGWBFULL : out std_ulogic;
		C405DBGWBIAR : out std_logic_vector(0 to 29);
		C405JTGCAPTUREDR : out std_ulogic;
		C405JTGEXTEST : out std_ulogic;
		C405JTGPGMOUT : out std_ulogic;
		C405JTGSHIFTDR : out std_ulogic;
		C405JTGTDO : out std_ulogic;
		C405JTGTDOEN : out std_ulogic;
		C405JTGUPDATEDR : out std_ulogic;
		C405PLBDCUABORT : out std_ulogic;
		C405PLBDCUABUS : out std_logic_vector(0 to 31);
		C405PLBDCUBE : out std_logic_vector(0 to 7);
		C405PLBDCUCACHEABLE : out std_ulogic;
		C405PLBDCUGUARDED : out std_ulogic;
		C405PLBDCUPRIORITY : out std_logic_vector(0 to 1);
		C405PLBDCUREQUEST : out std_ulogic;
		C405PLBDCURNW : out std_ulogic;
		C405PLBDCUSIZE2 : out std_ulogic;
		C405PLBDCUU0ATTR : out std_ulogic;
		C405PLBDCUWRDBUS : out std_logic_vector(0 to 63);
		C405PLBDCUWRITETHRU : out std_ulogic;
		C405PLBICUABORT : out std_ulogic;
		C405PLBICUABUS : out std_logic_vector(0 to 29);
		C405PLBICUCACHEABLE : out std_ulogic;
		C405PLBICUPRIORITY : out std_logic_vector(0 to 1);
		C405PLBICUREQUEST : out std_ulogic;
		C405PLBICUSIZE : out std_logic_vector(2 to 3);
		C405PLBICUU0ATTR : out std_ulogic;
		C405RSTCHIPRESETREQ : out std_ulogic;
		C405RSTCORERESETREQ : out std_ulogic;
		C405RSTSYSRESETREQ : out std_ulogic;
		C405TRCCYCLE : out std_ulogic;
		C405TRCEVENEXECUTIONSTATUS : out std_logic_vector(0 to 1);
		C405TRCODDEXECUTIONSTATUS : out std_logic_vector(0 to 1);
		C405TRCTRACESTATUS : out std_logic_vector(0 to 3);
		C405TRCTRIGGEREVENTOUT : out std_ulogic;
		C405TRCTRIGGEREVENTTYPE : out std_logic_vector(0 to 10);
		C405XXXMACHINECHECK : out std_ulogic;
		DCREMACABUS : out std_logic_vector(8 to 9);
		DCREMACCLK : out std_ulogic;
		DCREMACDBUS : out std_logic_vector(0 to 31);
		DCREMACENABLER : out std_ulogic;
		DCREMACREAD : out std_ulogic;
		DCREMACWRITE : out std_ulogic;
		DSOCMBRAMABUS : out std_logic_vector(8 to 29);
		DSOCMBRAMBYTEWRITE : out std_logic_vector(0 to 3);
		DSOCMBRAMEN : out std_ulogic;
		DSOCMBRAMWRDBUS : out std_logic_vector(0 to 31);
		DSOCMBUSY : out std_ulogic;
		DSOCMRDADDRVALID : out std_ulogic;
		DSOCMWRADDRVALID : out std_ulogic;
		EXTDCRABUS : out std_logic_vector(0 to 9);
		EXTDCRDBUSOUT : out std_logic_vector(0 to 31);
		EXTDCRREAD : out std_ulogic;
		EXTDCRWRITE : out std_ulogic;
		ISOCMBRAMEN : out std_ulogic;
		ISOCMBRAMEVENWRITEEN : out std_ulogic;
		ISOCMBRAMODDWRITEEN : out std_ulogic;
		ISOCMBRAMRDABUS : out std_logic_vector(8 to 28);
		ISOCMBRAMWRABUS : out std_logic_vector(8 to 28);
		ISOCMBRAMWRDBUS : out std_logic_vector(0 to 31);
		ISOCMDCRBRAMEVENEN : out std_ulogic;
		ISOCMDCRBRAMODDEN : out std_ulogic;
		ISOCMDCRBRAMRDSELECT : out std_ulogic;

		BRAMDSOCMCLK : in std_ulogic;
		BRAMDSOCMRDDBUS : in std_logic_vector(0 to 31);
		BRAMISOCMCLK : in std_ulogic;
		BRAMISOCMDCRRDDBUS : in std_logic_vector(0 to 31);
		BRAMISOCMRDDBUS : in std_logic_vector(0 to 63);
		CPMC405CLOCK : in std_ulogic;
		CPMC405CORECLKINACTIVE : in std_ulogic;
		CPMC405CPUCLKEN : in std_ulogic;
		CPMC405JTAGCLKEN : in std_ulogic;
		CPMC405SYNCBYPASS : in std_ulogic;
		CPMC405TIMERCLKEN : in std_ulogic;
		CPMC405TIMERTICK : in std_ulogic;
		CPMDCRCLK : in std_ulogic;
		CPMFCMCLK : in std_ulogic;
		DBGC405DEBUGHALT : in std_ulogic;
		DBGC405EXTBUSHOLDACK : in std_ulogic;
		DBGC405UNCONDDEBUGEVENT : in std_ulogic;
		DSARCVALUE : in std_logic_vector(0 to 7);
		DSCNTLVALUE : in std_logic_vector(0 to 7);
		DSOCMRWCOMPLETE : in std_ulogic;
		EICC405CRITINPUTIRQ : in std_ulogic;
		EICC405EXTINPUTIRQ : in std_ulogic;
		EMACDCRACK : in std_ulogic;
		EMACDCRDBUS : in std_logic_vector(0 to 31);
		EXTDCRACK : in std_ulogic;
		EXTDCRDBUSIN : in std_logic_vector(0 to 31);
		FCMAPUCR : in std_logic_vector(0 to 3);
		FCMAPUDCDCREN : in std_ulogic;
		FCMAPUDCDFORCEALIGN : in std_ulogic;
		FCMAPUDCDFORCEBESTEERING : in std_ulogic;
		FCMAPUDCDFPUOP : in std_ulogic;
		FCMAPUDCDGPRWRITE : in std_ulogic;
		FCMAPUDCDLDSTBYTE : in std_ulogic;
		FCMAPUDCDLDSTDW : in std_ulogic;
		FCMAPUDCDLDSTHW : in std_ulogic;
		FCMAPUDCDLDSTQW : in std_ulogic;
		FCMAPUDCDLDSTWD : in std_ulogic;
		FCMAPUDCDLOAD : in std_ulogic;
		FCMAPUDCDPRIVOP : in std_ulogic;
		FCMAPUDCDRAEN : in std_ulogic;
		FCMAPUDCDRBEN : in std_ulogic;
		FCMAPUDCDSTORE : in std_ulogic;
		FCMAPUDCDTRAPBE : in std_ulogic;
		FCMAPUDCDTRAPLE : in std_ulogic;
		FCMAPUDCDUPDATE : in std_ulogic;
		FCMAPUDCDXERCAEN : in std_ulogic;
		FCMAPUDCDXEROVEN : in std_ulogic;
		FCMAPUDECODEBUSY : in std_ulogic;
		FCMAPUDONE : in std_ulogic;
		FCMAPUEXCEPTION : in std_ulogic;
		FCMAPUEXEBLOCKINGMCO : in std_ulogic;
		FCMAPUEXECRFIELD : in std_logic_vector(0 to 2);
		FCMAPUEXENONBLOCKINGMCO : in std_ulogic;
		FCMAPUINSTRACK : in std_ulogic;
		FCMAPULOADWAIT : in std_ulogic;
		FCMAPURESULT : in std_logic_vector(0 to 31);
		FCMAPURESULTVALID : in std_ulogic;
		FCMAPUSLEEPNOTREADY : in std_ulogic;
		FCMAPUXERCA : in std_ulogic;
		FCMAPUXEROV : in std_ulogic;
		ISARCVALUE : in std_logic_vector(0 to 7);
		ISCNTLVALUE : in std_logic_vector(0 to 7);
		JTGC405BNDSCANTDO : in std_ulogic;
		JTGC405TCK : in std_ulogic;
		JTGC405TDI : in std_ulogic;
		JTGC405TMS : in std_ulogic;
		JTGC405TRSTNEG : in std_ulogic;
		MCBCPUCLKEN : in std_ulogic;
		MCBJTAGEN : in std_ulogic;
		MCBTIMEREN : in std_ulogic;
		MCPPCRST : in std_ulogic;
		PLBC405DCUADDRACK : in std_ulogic;
		PLBC405DCUBUSY : in std_ulogic;
		PLBC405DCUERR : in std_ulogic;
		PLBC405DCURDDACK : in std_ulogic;
		PLBC405DCURDDBUS : in std_logic_vector(0 to 63);
		PLBC405DCURDWDADDR : in std_logic_vector(1 to 3);
		PLBC405DCUSSIZE1 : in std_ulogic;
		PLBC405DCUWRDACK : in std_ulogic;
		PLBC405ICUADDRACK : in std_ulogic;
		PLBC405ICUBUSY : in std_ulogic;
		PLBC405ICUERR : in std_ulogic;
		PLBC405ICURDDACK : in std_ulogic;
		PLBC405ICURDDBUS : in std_logic_vector(0 to 63);
		PLBC405ICURDWDADDR : in std_logic_vector(1 to 3);
		PLBC405ICUSSIZE1 : in std_ulogic;
		PLBCLK : in std_ulogic;
		RSTC405RESETCHIP : in std_ulogic;
		RSTC405RESETCORE : in std_ulogic;
		RSTC405RESETSYS : in std_ulogic;
		TIEAPUCONTROL : in std_logic_vector(0 to 15);
		TIEAPUUDI1 : in std_logic_vector(0 to 23);
		TIEAPUUDI2 : in std_logic_vector(0 to 23);
		TIEAPUUDI3 : in std_logic_vector(0 to 23);
		TIEAPUUDI4 : in std_logic_vector(0 to 23);
		TIEAPUUDI5 : in std_logic_vector(0 to 23);
		TIEAPUUDI6 : in std_logic_vector(0 to 23);
		TIEAPUUDI7 : in std_logic_vector(0 to 23);
		TIEAPUUDI8 : in std_logic_vector(0 to 23);
		TIEC405DETERMINISTICMULT : in std_ulogic;
		TIEC405DISOPERANDFWD : in std_ulogic;
		TIEC405MMUEN : in std_ulogic;
		TIEDCRADDR : in std_logic_vector(0 to 5);
		TIEPVRBIT10 : in std_ulogic;
		TIEPVRBIT11 : in std_ulogic;
		TIEPVRBIT28 : in std_ulogic;
		TIEPVRBIT29 : in std_ulogic;
		TIEPVRBIT30 : in std_ulogic;
		TIEPVRBIT31 : in std_ulogic;
		TIEPVRBIT8 : in std_ulogic;
		TIEPVRBIT9 : in std_ulogic;
		TRCC405TRACEDISABLE : in std_ulogic;
		TRCC405TRIGGEREVENTIN : in std_ulogic
     );
end X_PPC405_ADV;

architecture X_PPC405_ADV_V of X_PPC405_ADV is



-- Attribute-to-Cell mapping signals

-- Input/Output Pin signals
        signal   APUFCMDECODED_out  :  std_ulogic;
        signal   APUFCMDECUDI_out  :  std_logic_vector(0 to 2);
        signal   APUFCMDECUDIVALID_out  :  std_ulogic;
        signal   APUFCMENDIAN_out  :  std_ulogic;
        signal   APUFCMFLUSH_out  :  std_ulogic;
        signal   APUFCMINSTRUCTION_out  :  std_logic_vector(0 to 31);
        signal   APUFCMINSTRVALID_out  :  std_ulogic;
        signal   APUFCMLOADBYTEEN_out  :  std_logic_vector(0 to 3);
        signal   APUFCMLOADDATA_out  :  std_logic_vector(0 to 31);
        signal   APUFCMLOADDVALID_out  :  std_ulogic;
        signal   APUFCMOPERANDVALID_out  :  std_ulogic;
        signal   APUFCMRADATA_out  :  std_logic_vector(0 to 31);
        signal   APUFCMRBDATA_out  :  std_logic_vector(0 to 31);
        signal   APUFCMWRITEBACKOK_out  :  std_ulogic;
        signal   APUFCMXERCA_out  :  std_ulogic;
        signal   C405CPMCORESLEEPREQ_out  :  std_ulogic;
        signal   C405CPMMSRCE_out  :  std_ulogic;
        signal   C405CPMMSREE_out  :  std_ulogic;
        signal   C405CPMTIMERIRQ_out  :  std_ulogic;
        signal   C405CPMTIMERRESETREQ_out  :  std_ulogic;
        signal   C405DBGLOADDATAONAPUDBUS_out  :  std_ulogic;
        signal   C405DBGMSRWE_out  :  std_ulogic;
        signal   C405DBGSTOPACK_out  :  std_ulogic;
        signal   C405DBGWBCOMPLETE_out  :  std_ulogic;
        signal   C405DBGWBFULL_out  :  std_ulogic;
        signal   C405DBGWBIAR_out  :  std_logic_vector(0 to 29);
        signal   C405JTGCAPTUREDR_out  :  std_ulogic;
        signal   C405JTGEXTEST_out  :  std_ulogic;
        signal   C405JTGPGMOUT_out  :  std_ulogic;
        signal   C405JTGSHIFTDR_out  :  std_ulogic;
        signal   C405JTGTDO_out  :  std_ulogic;
        signal   C405JTGTDOEN_out  :  std_ulogic;
        signal   C405JTGUPDATEDR_out  :  std_ulogic;
        signal   C405PLBDCUABORT_out  :  std_ulogic;
        signal   C405PLBDCUABUS_out  :  std_logic_vector(0 to 31);
        signal   C405PLBDCUBE_out  :  std_logic_vector(0 to 7);
        signal   C405PLBDCUCACHEABLE_out  :  std_ulogic;
        signal   C405PLBDCUGUARDED_out  :  std_ulogic;
        signal   C405PLBDCUPRIORITY_out  :  std_logic_vector(0 to 1);
        signal   C405PLBDCUREQUEST_out  :  std_ulogic;
        signal   C405PLBDCURNW_out  :  std_ulogic;
        signal   C405PLBDCUSIZE2_out  :  std_ulogic;
        signal   C405PLBDCUU0ATTR_out  :  std_ulogic;
        signal   C405PLBDCUWRDBUS_out  :  std_logic_vector(0 to 63);
        signal   C405PLBDCUWRITETHRU_out  :  std_ulogic;
        signal   C405PLBICUABORT_out  :  std_ulogic;
        signal   C405PLBICUABUS_out  :  std_logic_vector(0 to 29);
        signal   C405PLBICUCACHEABLE_out  :  std_ulogic;
        signal   C405PLBICUPRIORITY_out  :  std_logic_vector(0 to 1);
        signal   C405PLBICUREQUEST_out  :  std_ulogic;
        signal   C405PLBICUSIZE_out  :  std_logic_vector(2 to 3);
        signal   C405PLBICUU0ATTR_out  :  std_ulogic;
        signal   C405RSTCHIPRESETREQ_out  :  std_ulogic;
        signal   C405RSTCORERESETREQ_out  :  std_ulogic;
        signal   C405RSTSYSRESETREQ_out  :  std_ulogic;
        signal   C405TRCCYCLE_out  :  std_ulogic;
        signal   C405TRCEVENEXECUTIONSTATUS_out  :  std_logic_vector(0 to 1);
        signal   C405TRCODDEXECUTIONSTATUS_out  :  std_logic_vector(0 to 1);
        signal   C405TRCTRACESTATUS_out  :  std_logic_vector(0 to 3);
        signal   C405TRCTRIGGEREVENTOUT_out  :  std_ulogic;
        signal   C405TRCTRIGGEREVENTTYPE_out  :  std_logic_vector(0 to 10);
        signal   C405XXXMACHINECHECK_out  :  std_ulogic;
        signal   DCREMACENABLER_out  :  std_ulogic;
        signal   DSOCMBRAMABUS_out  :  std_logic_vector(8 to 29);
        signal   DSOCMBRAMBYTEWRITE_out  :  std_logic_vector(0 to 3);
        signal   DSOCMBRAMEN_out  :  std_ulogic;
        signal   DSOCMBRAMWRDBUS_out  :  std_logic_vector(0 to 31);
        signal   DSOCMBUSY_out  :  std_ulogic;
        signal   DSOCMRDADDRVALID_out  :  std_ulogic;
        signal   DSOCMWRADDRVALID_out  :  std_ulogic;
        signal   EXTDCRABUS_out  :  std_logic_vector(0 to 9);
        signal   EXTDCRDBUSOUT_out  :  std_logic_vector(0 to 31);
        signal   EXTDCRREAD_out  :  std_ulogic;
        signal   EXTDCRWRITE_out  :  std_ulogic;
        signal   ISOCMBRAMEN_out  :  std_ulogic;
        signal   ISOCMBRAMEVENWRITEEN_out  :  std_ulogic;
        signal   ISOCMBRAMODDWRITEEN_out  :  std_ulogic;
        signal   ISOCMBRAMRDABUS_out  :  std_logic_vector(8 to 28);
        signal   ISOCMBRAMWRABUS_out  :  std_logic_vector(8 to 28);
        signal   ISOCMBRAMWRDBUS_out  :  std_logic_vector(0 to 31);
        signal   ISOCMDCRBRAMEVENEN_out  :  std_ulogic;
        signal   ISOCMDCRBRAMODDEN_out  :  std_ulogic;
        signal   ISOCMDCRBRAMRDSELECT_out  :  std_ulogic;
        signal   DCREMACWRITE_out  :  std_ulogic;
        signal   DCREMACREAD_out  :  std_ulogic;
        signal   DCREMACDBUS_out  :  std_logic_vector(0 to 31);
        signal   DCREMACABUS_out  :  std_logic_vector(8 to 9);
        signal   DCREMACCLK_out  :  std_ulogic;

        signal   GSR_ipd  :  std_ulogic;
        signal   BRAMDSOCMCLK_ipd  :  std_ulogic;
        signal   BRAMDSOCMRDDBUS_ipd  :  std_logic_vector(0 to 31);
        signal   BRAMISOCMCLK_ipd  :  std_ulogic;
        signal   BRAMISOCMDCRRDDBUS_ipd  :  std_logic_vector(0 to 31);
        signal   BRAMISOCMRDDBUS_ipd  :  std_logic_vector(0 to 63);
        signal   CPMC405CLOCK_ipd  :  std_ulogic;
        signal   CPMC405CORECLKINACTIVE_ipd  :  std_ulogic;
        signal   CPMC405CPUCLKEN_ipd  :  std_ulogic;
        signal   CPMC405JTAGCLKEN_ipd  :  std_ulogic;
        signal   CPMC405SYNCBYPASS_ipd  :  std_ulogic;
        signal   CPMC405TIMERCLKEN_ipd  :  std_ulogic;
        signal   CPMC405TIMERTICK_ipd  :  std_ulogic;
        signal   CPMDCRCLK_ipd  :  std_ulogic;
        signal   CPMFCMCLK_ipd  :  std_ulogic;
        signal   DBGC405DEBUGHALT_ipd  :  std_ulogic;
        signal   DBGC405EXTBUSHOLDACK_ipd  :  std_ulogic;
        signal   DBGC405UNCONDDEBUGEVENT_ipd  :  std_ulogic;
        signal   DSARCVALUE_ipd  :  std_logic_vector(0 to 7);
        signal   DSCNTLVALUE_ipd  :  std_logic_vector(0 to 7);
        signal   DSOCMRWCOMPLETE_ipd  :  std_ulogic;
        signal   EICC405CRITINPUTIRQ_ipd  :  std_ulogic;
        signal   EICC405EXTINPUTIRQ_ipd  :  std_ulogic;
        signal   EXTDCRACK_ipd  :  std_ulogic;
        signal   EXTDCRDBUSIN_ipd  :  std_logic_vector(0 to 31);
        signal   FCMAPUCR_ipd  :  std_logic_vector(0 to 3);
        signal   FCMAPUDCDCREN_ipd  :  std_ulogic;
        signal   FCMAPUDCDFORCEALIGN_ipd  :  std_ulogic;
        signal   FCMAPUDCDFORCEBESTEERING_ipd  :  std_ulogic;
        signal   FCMAPUDCDFPUOP_ipd  :  std_ulogic;
        signal   FCMAPUDCDGPRWRITE_ipd  :  std_ulogic;
        signal   FCMAPUDCDLDSTBYTE_ipd  :  std_ulogic;
        signal   FCMAPUDCDLDSTDW_ipd  :  std_ulogic;
        signal   FCMAPUDCDLDSTHW_ipd  :  std_ulogic;
        signal   FCMAPUDCDLDSTQW_ipd  :  std_ulogic;
        signal   FCMAPUDCDLDSTWD_ipd  :  std_ulogic;
        signal   FCMAPUDCDLOAD_ipd  :  std_ulogic;
        signal   FCMAPUDCDPRIVOP_ipd  :  std_ulogic;
        signal   FCMAPUDCDRAEN_ipd  :  std_ulogic;
        signal   FCMAPUDCDRBEN_ipd  :  std_ulogic;
        signal   FCMAPUDCDSTORE_ipd  :  std_ulogic;
        signal   FCMAPUDCDTRAPBE_ipd  :  std_ulogic;
        signal   FCMAPUDCDTRAPLE_ipd  :  std_ulogic;
        signal   FCMAPUDCDUPDATE_ipd  :  std_ulogic;
        signal   FCMAPUDCDXERCAEN_ipd  :  std_ulogic;
        signal   FCMAPUDCDXEROVEN_ipd  :  std_ulogic;
        signal   FCMAPUDECODEBUSY_ipd  :  std_ulogic;
        signal   FCMAPUDONE_ipd  :  std_ulogic;
        signal   FCMAPUEXCEPTION_ipd  :  std_ulogic;
        signal   FCMAPUEXEBLOCKINGMCO_ipd  :  std_ulogic;
        signal   FCMAPUEXECRFIELD_ipd  :  std_logic_vector(0 to 2);
        signal   FCMAPUEXENONBLOCKINGMCO_ipd  :  std_ulogic;
        signal   FCMAPUINSTRACK_ipd  :  std_ulogic;
        signal   FCMAPULOADWAIT_ipd  :  std_ulogic;
        signal   FCMAPURESULT_ipd  :  std_logic_vector(0 to 31);
        signal   FCMAPURESULTVALID_ipd  :  std_ulogic;
        signal   FCMAPUSLEEPNOTREADY_ipd  :  std_ulogic;
        signal   FCMAPUXERCA_ipd  :  std_ulogic;
        signal   FCMAPUXEROV_ipd  :  std_ulogic;
        signal   ISARCVALUE_ipd  :  std_logic_vector(0 to 7);
        signal   ISCNTLVALUE_ipd  :  std_logic_vector(0 to 7);
        signal   JTGC405BNDSCANTDO_ipd  :  std_ulogic;
        signal   JTGC405TCK_ipd  :  std_ulogic;
        signal   JTGC405TDI_ipd  :  std_ulogic;
        signal   JTGC405TMS_ipd  :  std_ulogic;
        signal   JTGC405TRSTNEG_ipd  :  std_ulogic;
        signal   MCBCPUCLKEN_ipd  :  std_ulogic;
        signal   MCBJTAGEN_ipd  :  std_ulogic;
        signal   MCBTIMEREN_ipd  :  std_ulogic;
        signal   MCPPCRST_ipd  :  std_ulogic;
        signal   PLBC405DCUADDRACK_ipd  :  std_ulogic;
        signal   PLBC405DCUBUSY_ipd  :  std_ulogic;
        signal   PLBC405DCUERR_ipd  :  std_ulogic;
        signal   PLBC405DCURDDACK_ipd  :  std_ulogic;
        signal   PLBC405DCURDDBUS_ipd  :  std_logic_vector(0 to 63);
        signal   PLBC405DCURDWDADDR_ipd  :  std_logic_vector(1 to 3);
        signal   PLBC405DCUSSIZE1_ipd  :  std_ulogic;
        signal   PLBC405DCUWRDACK_ipd  :  std_ulogic;
        signal   PLBC405ICUADDRACK_ipd  :  std_ulogic;
        signal   PLBC405ICUBUSY_ipd  :  std_ulogic;
        signal   PLBC405ICUERR_ipd  :  std_ulogic;
        signal   PLBC405ICURDDACK_ipd  :  std_ulogic;
        signal   PLBC405ICURDDBUS_ipd  :  std_logic_vector(0 to 63);
        signal   PLBC405ICURDWDADDR_ipd  :  std_logic_vector(1 to 3);
        signal   PLBC405ICUSSIZE1_ipd  :  std_ulogic;
        signal   PLBCLK_ipd  :  std_ulogic;
        signal   RSTC405RESETCHIP_ipd  :  std_ulogic;
        signal   RSTC405RESETCORE_ipd  :  std_ulogic;
        signal   RSTC405RESETSYS_ipd  :  std_ulogic;
        signal   TIEAPUCONTROL_ipd  :  std_logic_vector(0 to 15);
        signal   TIEAPUUDI1_ipd  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI2_ipd  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI3_ipd  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI4_ipd  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI5_ipd  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI6_ipd  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI7_ipd  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI8_ipd  :  std_logic_vector(0 to 23);
        signal   TIEC405DETERMINISTICMULT_ipd  :  std_ulogic;
        signal   TIEC405DISOPERANDFWD_ipd  :  std_ulogic;
        signal   TIEC405MMUEN_ipd  :  std_ulogic;
        signal   TIEDCRADDR_ipd  :  std_logic_vector(0 to 5);
        signal   TIEPVRBIT10_ipd  :  std_ulogic;
        signal   TIEPVRBIT11_ipd  :  std_ulogic;
        signal   TIEPVRBIT28_ipd  :  std_ulogic;
        signal   TIEPVRBIT29_ipd  :  std_ulogic;
        signal   TIEPVRBIT30_ipd  :  std_ulogic;
        signal   TIEPVRBIT31_ipd  :  std_ulogic;
        signal   TIEPVRBIT8_ipd  :  std_ulogic;
        signal   TIEPVRBIT9_ipd  :  std_ulogic;
        signal   TRCC405TRACEDISABLE_ipd  :  std_ulogic;
        signal   TRCC405TRIGGEREVENTIN_ipd  :  std_ulogic;
        signal   EMACDCRDBUS_ipd  :  std_logic_vector(0 to 31);
        signal   EMACDCRACK_ipd  :  std_ulogic;
        
        signal   GSR_dly  :  std_ulogic;
        signal   BRAMDSOCMCLK_dly  :  std_ulogic;
        signal   BRAMDSOCMRDDBUS_dly  :  std_logic_vector(0 to 31);
        signal   BRAMISOCMCLK_dly  :  std_ulogic;
        signal   BRAMISOCMDCRRDDBUS_dly  :  std_logic_vector(0 to 31);
        signal   BRAMISOCMRDDBUS_dly  :  std_logic_vector(0 to 63);
        signal   CPMC405CLOCK_dly  :  std_ulogic;
        signal   CPMC405CORECLKINACTIVE_dly  :  std_ulogic;
        signal   CPMC405CPUCLKEN_dly  :  std_ulogic;
        signal   CPMC405JTAGCLKEN_dly  :  std_ulogic;
        signal   CPMC405SYNCBYPASS_dly  :  std_ulogic;
        signal   CPMC405TIMERCLKEN_dly  :  std_ulogic;
        signal   CPMC405TIMERTICK_dly  :  std_ulogic;
        signal   CPMDCRCLK_dly  :  std_ulogic;
        signal   CPMFCMCLK_dly  :  std_ulogic;
        signal   DBGC405DEBUGHALT_dly  :  std_ulogic;
        signal   DBGC405EXTBUSHOLDACK_dly  :  std_ulogic;
        signal   DBGC405UNCONDDEBUGEVENT_dly  :  std_ulogic;
        signal   DSARCVALUE_dly  :  std_logic_vector(0 to 7);
        signal   DSCNTLVALUE_dly  :  std_logic_vector(0 to 7);
        signal   DSOCMRWCOMPLETE_dly  :  std_ulogic;
        signal   EICC405CRITINPUTIRQ_dly  :  std_ulogic;
        signal   EICC405EXTINPUTIRQ_dly  :  std_ulogic;
        signal   EXTDCRACK_dly  :  std_ulogic;
        signal   EXTDCRDBUSIN_dly  :  std_logic_vector(0 to 31);
        signal   FCMAPUCR_dly  :  std_logic_vector(0 to 3);
        signal   FCMAPUDCDCREN_dly  :  std_ulogic;
        signal   FCMAPUDCDFORCEALIGN_dly  :  std_ulogic;
        signal   FCMAPUDCDFORCEBESTEERING_dly  :  std_ulogic;
        signal   FCMAPUDCDFPUOP_dly  :  std_ulogic;
        signal   FCMAPUDCDGPRWRITE_dly  :  std_ulogic;
        signal   FCMAPUDCDLDSTBYTE_dly  :  std_ulogic;
        signal   FCMAPUDCDLDSTDW_dly  :  std_ulogic;
        signal   FCMAPUDCDLDSTHW_dly  :  std_ulogic;
        signal   FCMAPUDCDLDSTQW_dly  :  std_ulogic;
        signal   FCMAPUDCDLDSTWD_dly  :  std_ulogic;
        signal   FCMAPUDCDLOAD_dly  :  std_ulogic;
        signal   FCMAPUDCDPRIVOP_dly  :  std_ulogic;
        signal   FCMAPUDCDRAEN_dly  :  std_ulogic;
        signal   FCMAPUDCDRBEN_dly  :  std_ulogic;
        signal   FCMAPUDCDSTORE_dly  :  std_ulogic;
        signal   FCMAPUDCDTRAPBE_dly  :  std_ulogic;
        signal   FCMAPUDCDTRAPLE_dly  :  std_ulogic;
        signal   FCMAPUDCDUPDATE_dly  :  std_ulogic;
        signal   FCMAPUDCDXERCAEN_dly  :  std_ulogic;
        signal   FCMAPUDCDXEROVEN_dly  :  std_ulogic;
        signal   FCMAPUDECODEBUSY_dly  :  std_ulogic;
        signal   FCMAPUDONE_dly  :  std_ulogic;
        signal   FCMAPUEXCEPTION_dly  :  std_ulogic;
        signal   FCMAPUEXEBLOCKINGMCO_dly  :  std_ulogic;
        signal   FCMAPUEXECRFIELD_dly  :  std_logic_vector(0 to 2);
        signal   FCMAPUEXENONBLOCKINGMCO_dly  :  std_ulogic;
        signal   FCMAPUINSTRACK_dly  :  std_ulogic;
        signal   FCMAPULOADWAIT_dly  :  std_ulogic;
        signal   FCMAPURESULT_dly  :  std_logic_vector(0 to 31);
        signal   FCMAPURESULTVALID_dly  :  std_ulogic;
        signal   FCMAPUSLEEPNOTREADY_dly  :  std_ulogic;
        signal   FCMAPUXERCA_dly  :  std_ulogic;
        signal   FCMAPUXEROV_dly  :  std_ulogic;
        signal   ISARCVALUE_dly  :  std_logic_vector(0 to 7);
        signal   ISCNTLVALUE_dly  :  std_logic_vector(0 to 7);
        signal   JTGC405BNDSCANTDO_dly  :  std_ulogic;
        signal   JTGC405TCK_dly  :  std_ulogic;
        signal   JTGC405TDI_dly  :  std_ulogic;
        signal   JTGC405TMS_dly  :  std_ulogic;
        signal   JTGC405TRSTNEG_dly  :  std_ulogic;
        signal   MCBCPUCLKEN_dly  :  std_ulogic;
        signal   MCBJTAGEN_dly  :  std_ulogic;
        signal   MCBTIMEREN_dly  :  std_ulogic;
        signal   MCPPCRST_dly  :  std_ulogic;
        signal   PLBC405DCUADDRACK_dly  :  std_ulogic;
        signal   PLBC405DCUBUSY_dly  :  std_ulogic;
        signal   PLBC405DCUERR_dly  :  std_ulogic;
        signal   PLBC405DCURDDACK_dly  :  std_ulogic;
        signal   PLBC405DCURDDBUS_dly  :  std_logic_vector(0 to 63);
        signal   PLBC405DCURDWDADDR_dly  :  std_logic_vector(1 to 3);
        signal   PLBC405DCUSSIZE1_dly  :  std_ulogic;
        signal   PLBC405DCUWRDACK_dly  :  std_ulogic;
        signal   PLBC405ICUADDRACK_dly  :  std_ulogic;
        signal   PLBC405ICUBUSY_dly  :  std_ulogic;
        signal   PLBC405ICUERR_dly  :  std_ulogic;
        signal   PLBC405ICURDDACK_dly  :  std_ulogic;
        signal   PLBC405ICURDDBUS_dly  :  std_logic_vector(0 to 63);
        signal   PLBC405ICURDWDADDR_dly  :  std_logic_vector(1 to 3);
        signal   PLBC405ICUSSIZE1_dly  :  std_ulogic;
        signal   PLBCLK_dly  :  std_ulogic;
        signal   RSTC405RESETCHIP_dly  :  std_ulogic;
        signal   RSTC405RESETCORE_dly  :  std_ulogic;
        signal   RSTC405RESETSYS_dly  :  std_ulogic;
        signal   TIEAPUCONTROL_dly  :  std_logic_vector(0 to 15);
        signal   TIEAPUUDI1_dly  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI2_dly  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI3_dly  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI4_dly  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI5_dly  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI6_dly  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI7_dly  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI8_dly  :  std_logic_vector(0 to 23);
        signal   TIEC405DETERMINISTICMULT_dly  :  std_ulogic;
        signal   TIEC405DISOPERANDFWD_dly  :  std_ulogic;
        signal   TIEC405MMUEN_dly  :  std_ulogic;
        signal   TIEDCRADDR_dly  :  std_logic_vector(0 to 5);
        signal   TIEPVRBIT10_dly  :  std_ulogic;
        signal   TIEPVRBIT11_dly  :  std_ulogic;
        signal   TIEPVRBIT28_dly  :  std_ulogic;
        signal   TIEPVRBIT29_dly  :  std_ulogic;
        signal   TIEPVRBIT30_dly  :  std_ulogic;
        signal   TIEPVRBIT31_dly  :  std_ulogic;
        signal   TIEPVRBIT8_dly  :  std_ulogic;
        signal   TIEPVRBIT9_dly  :  std_ulogic;
        signal   TRCC405TRACEDISABLE_dly  :  std_ulogic;
        signal   TRCC405TRIGGEREVENTIN_dly  :  std_ulogic;
        signal   EMACDCRDBUS_dly  :  std_logic_vector(0 to 31);
        signal   EMACDCRACK_dly  :  std_ulogic;

        signal   GSR_dly_1  :  std_ulogic;
        signal   BRAMDSOCMCLK_dly_1  :  std_ulogic;
        signal   BRAMDSOCMRDDBUS_dly_1  :  std_logic_vector(0 to 31);
        signal   BRAMISOCMCLK_dly_1  :  std_ulogic;
        signal   BRAMISOCMDCRRDDBUS_dly_1  :  std_logic_vector(0 to 31);
        signal   BRAMISOCMRDDBUS_dly_1  :  std_logic_vector(0 to 63);
        signal   CPMC405CLOCK_dly_1  :  std_ulogic;
        signal   CPMC405CORECLKINACTIVE_dly_1  :  std_ulogic;
        signal   CPMC405CPUCLKEN_dly_1  :  std_ulogic;
        signal   CPMC405JTAGCLKEN_dly_1  :  std_ulogic;
        signal   CPMC405SYNCBYPASS_dly_1  :  std_ulogic;
        signal   CPMC405TIMERCLKEN_dly_1  :  std_ulogic;
        signal   CPMC405TIMERTICK_dly_1  :  std_ulogic;
        signal   CPMDCRCLK_dly_1  :  std_ulogic;
        signal   CPMFCMCLK_dly_1  :  std_ulogic;
        signal   DBGC405DEBUGHALT_dly_1  :  std_ulogic;
        signal   DBGC405EXTBUSHOLDACK_dly_1  :  std_ulogic;
        signal   DBGC405UNCONDDEBUGEVENT_dly_1  :  std_ulogic;
        signal   DSARCVALUE_dly_1  :  std_logic_vector(0 to 7);
        signal   DSCNTLVALUE_dly_1  :  std_logic_vector(0 to 7);
        signal   DSOCMRWCOMPLETE_dly_1  :  std_ulogic;
        signal   EICC405CRITINPUTIRQ_dly_1  :  std_ulogic;
        signal   EICC405EXTINPUTIRQ_dly_1  :  std_ulogic;
        signal   EXTDCRACK_dly_1  :  std_ulogic;
        signal   EXTDCRDBUSIN_dly_1  :  std_logic_vector(0 to 31);
        signal   FCMAPUCR_dly_1  :  std_logic_vector(0 to 3);
        signal   FCMAPUDCDCREN_dly_1  :  std_ulogic;
        signal   FCMAPUDCDFORCEALIGN_dly_1  :  std_ulogic;
        signal   FCMAPUDCDFORCEBESTEERING_dly_1  :  std_ulogic;
        signal   FCMAPUDCDFPUOP_dly_1  :  std_ulogic;
        signal   FCMAPUDCDGPRWRITE_dly_1  :  std_ulogic;
        signal   FCMAPUDCDLDSTBYTE_dly_1  :  std_ulogic;
        signal   FCMAPUDCDLDSTDW_dly_1  :  std_ulogic;
        signal   FCMAPUDCDLDSTHW_dly_1  :  std_ulogic;
        signal   FCMAPUDCDLDSTQW_dly_1  :  std_ulogic;
        signal   FCMAPUDCDLDSTWD_dly_1  :  std_ulogic;
        signal   FCMAPUDCDLOAD_dly_1  :  std_ulogic;
        signal   FCMAPUDCDPRIVOP_dly_1  :  std_ulogic;
        signal   FCMAPUDCDRAEN_dly_1  :  std_ulogic;
        signal   FCMAPUDCDRBEN_dly_1  :  std_ulogic;
        signal   FCMAPUDCDSTORE_dly_1  :  std_ulogic;
        signal   FCMAPUDCDTRAPBE_dly_1  :  std_ulogic;
        signal   FCMAPUDCDTRAPLE_dly_1  :  std_ulogic;
        signal   FCMAPUDCDUPDATE_dly_1  :  std_ulogic;
        signal   FCMAPUDCDXERCAEN_dly_1  :  std_ulogic;
        signal   FCMAPUDCDXEROVEN_dly_1  :  std_ulogic;
        signal   FCMAPUDECODEBUSY_dly_1  :  std_ulogic;
        signal   FCMAPUDONE_dly_1  :  std_ulogic;
        signal   FCMAPUEXCEPTION_dly_1  :  std_ulogic;
        signal   FCMAPUEXEBLOCKINGMCO_dly_1  :  std_ulogic;
        signal   FCMAPUEXECRFIELD_dly_1  :  std_logic_vector(0 to 2);
        signal   FCMAPUEXENONBLOCKINGMCO_dly_1  :  std_ulogic;
        signal   FCMAPUINSTRACK_dly_1  :  std_ulogic;
        signal   FCMAPULOADWAIT_dly_1  :  std_ulogic;
        signal   FCMAPURESULT_dly_1  :  std_logic_vector(0 to 31);
        signal   FCMAPURESULTVALID_dly_1  :  std_ulogic;
        signal   FCMAPUSLEEPNOTREADY_dly_1  :  std_ulogic;
        signal   FCMAPUXERCA_dly_1  :  std_ulogic;
        signal   FCMAPUXEROV_dly_1  :  std_ulogic;
        signal   ISARCVALUE_dly_1  :  std_logic_vector(0 to 7);
        signal   ISCNTLVALUE_dly_1  :  std_logic_vector(0 to 7);
        signal   JTGC405BNDSCANTDO_dly_1  :  std_ulogic;
        signal   JTGC405TCK_dly_1  :  std_ulogic;
        signal   JTGC405TDI_dly_1  :  std_ulogic;
        signal   JTGC405TMS_dly_1  :  std_ulogic;
        signal   JTGC405TRSTNEG_dly_1  :  std_ulogic;
        signal   MCBCPUCLKEN_dly_1  :  std_ulogic;
        signal   MCBJTAGEN_dly_1  :  std_ulogic;
        signal   MCBTIMEREN_dly_1  :  std_ulogic;
        signal   MCPPCRST_dly_1  :  std_ulogic;
        signal   PLBC405DCUADDRACK_dly_1  :  std_ulogic;
        signal   PLBC405DCUBUSY_dly_1  :  std_ulogic;
        signal   PLBC405DCUERR_dly_1  :  std_ulogic;
        signal   PLBC405DCURDDACK_dly_1  :  std_ulogic;
        signal   PLBC405DCURDDBUS_dly_1  :  std_logic_vector(0 to 63);
        signal   PLBC405DCURDWDADDR_dly_1  :  std_logic_vector(1 to 3);
        signal   PLBC405DCUSSIZE1_dly_1  :  std_ulogic;
        signal   PLBC405DCUWRDACK_dly_1  :  std_ulogic;
        signal   PLBC405ICUADDRACK_dly_1  :  std_ulogic;
        signal   PLBC405ICUBUSY_dly_1  :  std_ulogic;
        signal   PLBC405ICUERR_dly_1  :  std_ulogic;
        signal   PLBC405ICURDDACK_dly_1  :  std_ulogic;
        signal   PLBC405ICURDDBUS_dly_1  :  std_logic_vector(0 to 63);
        signal   PLBC405ICURDWDADDR_dly_1  :  std_logic_vector(1 to 3);
        signal   PLBC405ICUSSIZE1_dly_1  :  std_ulogic;
        signal   PLBCLK_dly_1  :  std_ulogic;
        signal   RSTC405RESETCHIP_dly_1  :  std_ulogic;
        signal   RSTC405RESETCORE_dly_1  :  std_ulogic;
        signal   RSTC405RESETSYS_dly_1  :  std_ulogic;
        signal   TIEAPUCONTROL_dly_1  :  std_logic_vector(0 to 15);
        signal   TIEAPUUDI1_dly_1  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI2_dly_1  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI3_dly_1  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI4_dly_1  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI5_dly_1  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI6_dly_1  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI7_dly_1  :  std_logic_vector(0 to 23);
        signal   TIEAPUUDI8_dly_1  :  std_logic_vector(0 to 23);
        signal   TIEC405DETERMINISTICMULT_dly_1  :  std_ulogic;
        signal   TIEC405DISOPERANDFWD_dly_1  :  std_ulogic;
        signal   TIEC405MMUEN_dly_1  :  std_ulogic;
        signal   TIEDCRADDR_dly_1  :  std_logic_vector(0 to 5);
        signal   TIEPVRBIT10_dly_1  :  std_ulogic;
        signal   TIEPVRBIT11_dly_1  :  std_ulogic;
        signal   TIEPVRBIT28_dly_1  :  std_ulogic;
        signal   TIEPVRBIT29_dly_1  :  std_ulogic;
        signal   TIEPVRBIT30_dly_1  :  std_ulogic;
        signal   TIEPVRBIT31_dly_1  :  std_ulogic;
        signal   TIEPVRBIT8_dly_1  :  std_ulogic;
        signal   TIEPVRBIT9_dly_1  :  std_ulogic;
        signal   TRCC405TRACEDISABLE_dly_1  :  std_ulogic;
        signal   TRCC405TRIGGEREVENTIN_dly_1  :  std_ulogic;
        signal   EMACDCRDBUS_dly_1  :  std_logic_vector(0 to 31);
        signal   EMACDCRACK_dly_1  :  std_ulogic;        

        signal open_sig : std_ulogic;
        signal VCC_sig : std_ulogic := '1';
        signal GND_sig : std_ulogic := '0';        

        signal FPGA_CCLK : std_ulogic := '0';
        signal FPGA_POR : std_ulogic := '1';        
        signal FPGA_BUS_RESET : std_ulogic := '0';
        signal FPGA_GWE : std_ulogic := '0';
        signal FPGA_GHIGHB : std_ulogic := '0';
        signal FPGA_GSR  : std_ulogic := '0';
        signal GSR_OR : std_ulogic := '0';
--        signal GSR  : std_ulogic := '0';
        signal FPGA_SHUTDOWN  : std_ulogic := '0';

        signal FPGA_CCLK_delay : std_ulogic := '0';
        signal FPGA_BUS_RESET_delay : std_ulogic := '0';
        signal GSR_delay  : std_ulogic := '0';
        signal FPGA_GWE_delay : std_ulogic := '0';
        signal FPGA_GHIGHB_delay : std_ulogic := '0';
        signal FPGA_CCLK_reg : std_ulogic := '0';        
--        signal PPCUSER_binary : std_logic_vector(0 to 3) :=PPCUSER;        
--        signal PPCUSER_reverse_binary : std_logic_vector(0 to 3) :=PPCUSER_binary;                


   component PPC405_ADV_SWIFT
     port ( CFG_MCLK : in std_logic;
            BUS_RESET : in std_logic;
            GSR : in std_logic;
            GWE : in std_logic;
            GHIGHB : in std_logic;
            CPMC405CPUCLKEN : in std_logic;
            CPMC405JTAGCLKEN : in std_logic;
            CPMC405TIMERCLKEN : in std_logic;
            C405JTGPGMOUT : out std_logic;
            MCBCPUCLKEN : in std_logic;
            MCBJTAGEN : in std_logic;
            MCBTIMEREN : in std_logic;
            MCPPCRST : in std_logic;
            C405TRCODDEXECUTIONSTATUS : out std_logic_vector(0 to 1);
            C405TRCEVENEXECUTIONSTATUS : out std_logic_vector(0 to 1); 
            CPMC405CLOCK : in std_logic;
            CPMC405CORECLKINACTIVE : in std_logic;
            PLBCLK : in std_logic;
            CPMFCMCLK : in std_logic;
            CPMDCRCLK : in std_logic;
            CPMC405SYNCBYPASS : in std_logic;
            CPMC405TIMERTICK : in std_logic;
            C405CPMMSREE : out std_logic;
            C405CPMMSRCE : out std_logic;
            C405CPMTIMERIRQ : out std_logic;
            C405CPMTIMERRESETREQ : out std_logic;
            C405CPMCORESLEEPREQ : out std_logic;
            TIEC405DISOPERANDFWD : in std_logic;
            TIEC405DETERMINISTICMULT : in std_logic;
            TIEC405MMUEN : in std_logic;
            TIEPVRBIT8 : in std_logic;
            TIEPVRBIT9 : in std_logic;
            TIEPVRBIT10 : in std_logic;
            TIEPVRBIT11 : in std_logic;
            TIEPVRBIT28 : in std_logic;
            TIEPVRBIT29 : in std_logic;
            TIEPVRBIT30 : in std_logic;
            TIEPVRBIT31 : in std_logic;
            C405XXXMACHINECHECK : out std_logic;
            DCREMACENABLER : out std_logic;
            DCREMACCLK : out std_logic;
            DCREMACWRITE : out std_logic;
            DCREMACREAD : out std_logic;
            DCREMACDBUS : out std_logic_vector(0 to 31);
            DCREMACABUS : out std_logic_vector(8 to 9);
            EMACDCRDBUS : in std_logic_vector(0 to 31);
            EMACDCRACK : in std_logic;
            C405RSTCHIPRESETREQ : out std_logic;
            C405RSTCORERESETREQ : out std_logic;
            C405RSTSYSRESETREQ : out std_logic;
            RSTC405RESETCHIP : in std_logic;
            RSTC405RESETCORE : in std_logic;
            RSTC405RESETSYS : in std_logic;
            C405PLBICUREQUEST : out std_logic;
            C405PLBICUPRIORITY : out std_logic_vector(0 to 1);
            C405PLBICUCACHEABLE : out std_logic;
            C405PLBICUABUS : out std_logic_vector(0 to 29);
            C405PLBICUSIZE : out std_logic_vector(2 to 3);
            C405PLBICUABORT : out std_logic;
            C405PLBICUU0ATTR : out std_logic;
            PLBC405ICUADDRACK : in std_logic;
            PLBC405ICUBUSY : in std_logic;
            PLBC405ICUERR : in std_logic;
            PLBC405ICURDDACK : in std_logic;
            PLBC405ICURDDBUS :in std_logic_vector(0 to 63);
            PLBC405ICUSSIZE1 : in std_logic;
            PLBC405ICURDWDADDR : in std_logic_vector(1 to 3);
            C405PLBDCUREQUEST : out std_logic;
            C405PLBDCURNW : out std_logic;
            C405PLBDCUABUS : out std_logic_vector(0 to 31);
            C405PLBDCUBE : out std_logic_vector(0 to 7);
            C405PLBDCUCACHEABLE : out std_logic;
            C405PLBDCUGUARDED : out std_logic;
            C405PLBDCUPRIORITY : out std_logic_vector(0 to 1);
            C405PLBDCUSIZE2 : out std_logic;
            C405PLBDCUABORT : out std_logic;
            C405PLBDCUWRDBUS : out std_logic_vector(0 to 63);
            C405PLBDCUU0ATTR : out std_logic;
            C405PLBDCUWRITETHRU : out std_logic;
            PLBC405DCUADDRACK : in std_logic;
            PLBC405DCUBUSY : in std_logic;
            PLBC405DCUERR : in std_logic;
            PLBC405DCURDDACK : in std_logic;
            PLBC405DCURDDBUS : in std_logic_vector(0 to 63);
            PLBC405DCURDWDADDR : in std_logic_vector(1 to 3);
            PLBC405DCUSSIZE1 : in std_logic;
            PLBC405DCUWRDACK : in std_logic;
            ISOCMBRAMRDABUS : out std_logic_vector(8 to 28);
            ISOCMBRAMWRABUS : out std_logic_vector(8 to 28);
            ISOCMBRAMEN : out std_logic;
            ISOCMBRAMODDWRITEEN : out std_logic;
            ISOCMBRAMEVENWRITEEN : out std_logic;
            ISOCMBRAMWRDBUS : out std_logic_vector(0 to 31);
            ISOCMDCRBRAMEVENEN : out std_logic;
            ISOCMDCRBRAMODDEN : out std_logic;
            ISOCMDCRBRAMRDSELECT : out std_logic;
            BRAMISOCMDCRRDDBUS : in std_logic_vector(0 to 31);
            BRAMISOCMRDDBUS : in std_logic_vector(0 to 63);
            ISARCVALUE : in std_logic_vector(0 to 7);
            ISCNTLVALUE : in std_logic_vector(0 to 7); 
            BRAMISOCMCLK : in std_logic;
            DSOCMBRAMABUS : out std_logic_vector(8 to 29);
            DSOCMBRAMBYTEWRITE : out std_logic_vector(0 to 3);
            DSOCMBRAMEN : out std_logic;
            DSOCMBRAMWRDBUS : out std_logic_vector(0 to 31);
            BRAMDSOCMRDDBUS : in std_logic_vector(0 to 31);
            DSOCMRWCOMPLETE : in std_logic;
            DSOCMBUSY : out std_logic;
            DSOCMWRADDRVALID : out std_logic;
            DSOCMRDADDRVALID : out std_logic;
            TIEDCRADDR : in std_logic_vector(0 to 5);
            DSARCVALUE : in std_logic_vector(0 to 7);
            DSCNTLVALUE : in std_logic_vector(0 to 7);
            BRAMDSOCMCLK : in std_logic;
            EXTDCRREAD : out std_logic;
            EXTDCRWRITE : out std_logic;
            EXTDCRABUS : out std_logic_vector(0 to 9);
            EXTDCRDBUSOUT : out std_logic_vector(0 to 31);
            EXTDCRACK : in std_logic;
            EXTDCRDBUSIN : in std_logic_vector(0 to 31);
            EICC405EXTINPUTIRQ : in std_logic;
            EICC405CRITINPUTIRQ : in std_logic;
            JTGC405BNDSCANTDO : in std_logic;
            JTGC405TCK : in std_logic;
            JTGC405TDI : in std_logic;
            JTGC405TMS : in std_logic;
            JTGC405TRSTNEG : in std_logic;
            C405JTGTDO : out std_logic;
            C405JTGTDOEN : out std_logic;
            C405JTGEXTEST : out std_logic;
            C405JTGCAPTUREDR : out std_logic;
            C405JTGSHIFTDR : out std_logic;
            C405JTGUPDATEDR : out std_logic;
            DBGC405DEBUGHALT : in std_logic;
            DBGC405UNCONDDEBUGEVENT : in std_logic;
            DBGC405EXTBUSHOLDACK : in std_logic;
            C405DBGMSRWE : out std_logic;
            C405DBGSTOPACK : out std_logic;
            C405DBGWBCOMPLETE : out std_logic;
            C405DBGWBFULL : out std_logic;
            C405DBGWBIAR : out std_logic_vector(0 to 29);
            C405TRCTRIGGEREVENTOUT : out std_logic;
            C405TRCTRIGGEREVENTTYPE : out std_logic_vector(0 to 10);
            C405TRCCYCLE : out std_logic;
            C405TRCTRACESTATUS : out std_logic_vector(0 to 3);
            TRCC405TRACEDISABLE : in std_logic;
            TRCC405TRIGGEREVENTIN : in std_logic;
            C405DBGLOADDATAONAPUDBUS : out std_logic;
            APUFCMINSTRUCTION : out std_logic_vector(0 to 31);
            APUFCMRADATA : out std_logic_vector(0 to 31);
            APUFCMRBDATA : out std_logic_vector(0 to 31);
            APUFCMINSTRVALID : out std_logic;
            APUFCMLOADDATA : out std_logic_vector(0 to 31);
            APUFCMOPERANDVALID : out std_logic;
            APUFCMLOADDVALID : out std_logic;
            APUFCMFLUSH : out std_logic;
            APUFCMWRITEBACKOK : out std_logic;
            APUFCMLOADBYTEEN : out std_logic_vector(0 to 3);
            APUFCMENDIAN : out std_logic;
            APUFCMXERCA : out std_logic;
            APUFCMDECODED : out std_logic;
            APUFCMDECUDI : out std_logic_vector(0 to 2);
            APUFCMDECUDIVALID : out std_logic;
            FCMAPUDONE : in std_logic;
            FCMAPURESULT : in std_logic_vector(0 to 31);
            FCMAPURESULTVALID : in std_logic;
            FCMAPUINSTRACK : in std_logic;
            FCMAPUEXCEPTION : in std_logic;
            FCMAPUXERCA : in std_logic;
            FCMAPUXEROV : in std_logic;
            FCMAPUCR : in std_logic_vector(0 to 3);
            FCMAPUDCDFPUOP : in std_logic;
            FCMAPUDCDGPRWRITE : in std_logic;
            FCMAPUDCDRAEN : in std_logic;
            FCMAPUDCDRBEN : in std_logic;
            FCMAPUDCDLOAD : in std_logic;
            FCMAPUDCDSTORE : in std_logic;
            FCMAPUDCDXERCAEN : in std_logic;
            FCMAPUDCDXEROVEN : in std_logic;
            FCMAPUDCDPRIVOP : in std_logic;
            FCMAPUDCDCREN : in std_logic;
            FCMAPUEXECRFIELD : in std_logic_vector(0 to 2);
            FCMAPUDCDUPDATE : in std_logic;
            FCMAPUDCDFORCEALIGN : in std_logic;
            FCMAPUDCDFORCEBESTEERING : in std_logic;
            FCMAPUDCDLDSTBYTE : in std_logic;
            FCMAPUDCDLDSTHW : in std_logic;
            FCMAPUDCDLDSTWD : in std_logic;
            FCMAPUDCDLDSTDW : in std_logic;
            FCMAPUDCDLDSTQW : in std_logic;
            FCMAPUDCDTRAPBE : in std_logic;
            FCMAPUDCDTRAPLE : in std_logic;
            FCMAPUEXEBLOCKINGMCO : in std_logic;
            FCMAPUEXENONBLOCKINGMCO : in std_logic;
            FCMAPUSLEEPNOTREADY : in std_logic;
            FCMAPULOADWAIT : in std_logic;
            FCMAPUDECODEBUSY : in std_logic;
            TIEAPUCONTROL : in std_logic_vector(0 to 15);
            TIEAPUUDI1 : in std_logic_vector(0 to 23);
            TIEAPUUDI2 : in std_logic_vector(0 to 23);
            TIEAPUUDI3 : in std_logic_vector(0 to 23);
            TIEAPUUDI4 : in std_logic_vector(0 to 23);
            TIEAPUUDI5 : in std_logic_vector(0 to 23);
            TIEAPUUDI6 : in std_logic_vector(0 to 23);
            TIEAPUUDI7 : in std_logic_vector(0 to 23);
            TIEAPUUDI8 : in std_logic_vector(0 to 23)
 );  
   end component;
----- component fpga_startup_virtex4            -----
component fpga_startup_virtex4
  port (
    bus_reset : out std_ulogic;
    done      : out std_ulogic;
    ghigh_b   : out std_ulogic;
    gsr       : out std_ulogic;
    gts_b     : out std_ulogic;
    gwe       : out std_ulogic;

    cclk      : in  std_ulogic;
    por       : in  std_ulogic;
    shutdown  : in  std_ulogic
    );
end component;        
begin
   WireDelay : block
       begin
              VitalWireDelay (BRAMDSOCMCLK_ipd,BRAMDSOCMCLK,tipd_BRAMDSOCMCLK);
           BRAMDSOCMRDDBUS_DELAY : for i in 0 to 31 generate
              VitalWireDelay (BRAMDSOCMRDDBUS_ipd(i),BRAMDSOCMRDDBUS(i),tipd_BRAMDSOCMRDDBUS(i));
           end generate BRAMDSOCMRDDBUS_DELAY;
              VitalWireDelay (BRAMISOCMCLK_ipd,BRAMISOCMCLK,tipd_BRAMISOCMCLK);
           BRAMISOCMDCRRDDBUS_DELAY : for i in 0 to 31 generate
              VitalWireDelay (BRAMISOCMDCRRDDBUS_ipd(i),BRAMISOCMDCRRDDBUS(i),tipd_BRAMISOCMDCRRDDBUS(i));
           end generate BRAMISOCMDCRRDDBUS_DELAY;
           BRAMISOCMRDDBUS_DELAY : for i in 0 to 63 generate
              VitalWireDelay (BRAMISOCMRDDBUS_ipd(i),BRAMISOCMRDDBUS(i),tipd_BRAMISOCMRDDBUS(i));
           end generate BRAMISOCMRDDBUS_DELAY;
              VitalWireDelay (CPMC405CLOCK_ipd,CPMC405CLOCK,tipd_CPMC405CLOCK);
              VitalWireDelay (CPMC405CORECLKINACTIVE_ipd,CPMC405CORECLKINACTIVE,tipd_CPMC405CORECLKINACTIVE);
              VitalWireDelay (CPMC405CPUCLKEN_ipd,CPMC405CPUCLKEN,tipd_CPMC405CPUCLKEN);
              VitalWireDelay (CPMC405JTAGCLKEN_ipd,CPMC405JTAGCLKEN,tipd_CPMC405JTAGCLKEN);
              VitalWireDelay (CPMC405SYNCBYPASS_ipd,CPMC405SYNCBYPASS,tipd_CPMC405SYNCBYPASS);
              VitalWireDelay (CPMC405TIMERCLKEN_ipd,CPMC405TIMERCLKEN,tipd_CPMC405TIMERCLKEN);
              VitalWireDelay (CPMC405TIMERTICK_ipd,CPMC405TIMERTICK,tipd_CPMC405TIMERTICK);
              VitalWireDelay (CPMDCRCLK_ipd,CPMDCRCLK,tipd_CPMDCRCLK);
              VitalWireDelay (CPMFCMCLK_ipd,CPMFCMCLK,tipd_CPMFCMCLK);
              VitalWireDelay (DBGC405DEBUGHALT_ipd,DBGC405DEBUGHALT,tipd_DBGC405DEBUGHALT);
              VitalWireDelay (DBGC405EXTBUSHOLDACK_ipd,DBGC405EXTBUSHOLDACK,tipd_DBGC405EXTBUSHOLDACK);
              VitalWireDelay (DBGC405UNCONDDEBUGEVENT_ipd,DBGC405UNCONDDEBUGEVENT,tipd_DBGC405UNCONDDEBUGEVENT);
           DSARCVALUE_DELAY : for i in 0 to 7 generate
              VitalWireDelay (DSARCVALUE_ipd(i),DSARCVALUE(i),tipd_DSARCVALUE(i));
           end generate DSARCVALUE_DELAY;
           DSCNTLVALUE_DELAY : for i in 0 to 7 generate
              VitalWireDelay (DSCNTLVALUE_ipd(i),DSCNTLVALUE(i),tipd_DSCNTLVALUE(i));
           end generate DSCNTLVALUE_DELAY;
              VitalWireDelay (DSOCMRWCOMPLETE_ipd,DSOCMRWCOMPLETE,tipd_DSOCMRWCOMPLETE);
              VitalWireDelay (EICC405CRITINPUTIRQ_ipd,EICC405CRITINPUTIRQ,tipd_EICC405CRITINPUTIRQ);
              VitalWireDelay (EICC405EXTINPUTIRQ_ipd,EICC405EXTINPUTIRQ,tipd_EICC405EXTINPUTIRQ);
              VitalWireDelay (EXTDCRACK_ipd,EXTDCRACK,tipd_EXTDCRACK);
           EXTDCRDBUSIN_DELAY : for i in 0 to 31 generate
              VitalWireDelay (EXTDCRDBUSIN_ipd(i),EXTDCRDBUSIN(i),tipd_EXTDCRDBUSIN(i));
           end generate EXTDCRDBUSIN_DELAY;
           FCMAPUCR_DELAY : for i in 0 to 3 generate
              VitalWireDelay (FCMAPUCR_ipd(i),FCMAPUCR(i),tipd_FCMAPUCR(i));
           end generate FCMAPUCR_DELAY;
              VitalWireDelay (FCMAPUDCDCREN_ipd,FCMAPUDCDCREN,tipd_FCMAPUDCDCREN);
              VitalWireDelay (FCMAPUDCDFORCEALIGN_ipd,FCMAPUDCDFORCEALIGN,tipd_FCMAPUDCDFORCEALIGN);
              VitalWireDelay (FCMAPUDCDFORCEBESTEERING_ipd,FCMAPUDCDFORCEBESTEERING,tipd_FCMAPUDCDFORCEBESTEERING);
              VitalWireDelay (FCMAPUDCDFPUOP_ipd,FCMAPUDCDFPUOP,tipd_FCMAPUDCDFPUOP);
              VitalWireDelay (FCMAPUDCDGPRWRITE_ipd,FCMAPUDCDGPRWRITE,tipd_FCMAPUDCDGPRWRITE);
              VitalWireDelay (FCMAPUDCDLDSTBYTE_ipd,FCMAPUDCDLDSTBYTE,tipd_FCMAPUDCDLDSTBYTE);
              VitalWireDelay (FCMAPUDCDLDSTDW_ipd,FCMAPUDCDLDSTDW,tipd_FCMAPUDCDLDSTDW);
              VitalWireDelay (FCMAPUDCDLDSTHW_ipd,FCMAPUDCDLDSTHW,tipd_FCMAPUDCDLDSTHW);
              VitalWireDelay (FCMAPUDCDLDSTQW_ipd,FCMAPUDCDLDSTQW,tipd_FCMAPUDCDLDSTQW);
              VitalWireDelay (FCMAPUDCDLDSTWD_ipd,FCMAPUDCDLDSTWD,tipd_FCMAPUDCDLDSTWD);
              VitalWireDelay (FCMAPUDCDLOAD_ipd,FCMAPUDCDLOAD,tipd_FCMAPUDCDLOAD);
              VitalWireDelay (FCMAPUDCDPRIVOP_ipd,FCMAPUDCDPRIVOP,tipd_FCMAPUDCDPRIVOP);
              VitalWireDelay (FCMAPUDCDRAEN_ipd,FCMAPUDCDRAEN,tipd_FCMAPUDCDRAEN);
              VitalWireDelay (FCMAPUDCDRBEN_ipd,FCMAPUDCDRBEN,tipd_FCMAPUDCDRBEN);
              VitalWireDelay (FCMAPUDCDSTORE_ipd,FCMAPUDCDSTORE,tipd_FCMAPUDCDSTORE);
              VitalWireDelay (FCMAPUDCDTRAPBE_ipd,FCMAPUDCDTRAPBE,tipd_FCMAPUDCDTRAPBE);
              VitalWireDelay (FCMAPUDCDTRAPLE_ipd,FCMAPUDCDTRAPLE,tipd_FCMAPUDCDTRAPLE);
              VitalWireDelay (FCMAPUDCDUPDATE_ipd,FCMAPUDCDUPDATE,tipd_FCMAPUDCDUPDATE);
              VitalWireDelay (FCMAPUDCDXERCAEN_ipd,FCMAPUDCDXERCAEN,tipd_FCMAPUDCDXERCAEN);
              VitalWireDelay (FCMAPUDCDXEROVEN_ipd,FCMAPUDCDXEROVEN,tipd_FCMAPUDCDXEROVEN);
              VitalWireDelay (FCMAPUDECODEBUSY_ipd,FCMAPUDECODEBUSY,tipd_FCMAPUDECODEBUSY);
              VitalWireDelay (FCMAPUDONE_ipd,FCMAPUDONE,tipd_FCMAPUDONE);
              VitalWireDelay (FCMAPUEXCEPTION_ipd,FCMAPUEXCEPTION,tipd_FCMAPUEXCEPTION);
              VitalWireDelay (FCMAPUEXEBLOCKINGMCO_ipd,FCMAPUEXEBLOCKINGMCO,tipd_FCMAPUEXEBLOCKINGMCO);
           FCMAPUEXECRFIELD_DELAY : for i in 0 to 2 generate
              VitalWireDelay (FCMAPUEXECRFIELD_ipd(i),FCMAPUEXECRFIELD(i),tipd_FCMAPUEXECRFIELD(i));
           end generate FCMAPUEXECRFIELD_DELAY;
              VitalWireDelay (FCMAPUEXENONBLOCKINGMCO_ipd,FCMAPUEXENONBLOCKINGMCO,tipd_FCMAPUEXENONBLOCKINGMCO);
              VitalWireDelay (FCMAPUINSTRACK_ipd,FCMAPUINSTRACK,tipd_FCMAPUINSTRACK);
              VitalWireDelay (FCMAPULOADWAIT_ipd,FCMAPULOADWAIT,tipd_FCMAPULOADWAIT);
           FCMAPURESULT_DELAY : for i in 0 to 31 generate
              VitalWireDelay (FCMAPURESULT_ipd(i),FCMAPURESULT(i),tipd_FCMAPURESULT(i));
           end generate FCMAPURESULT_DELAY;
              VitalWireDelay (FCMAPURESULTVALID_ipd,FCMAPURESULTVALID,tipd_FCMAPURESULTVALID);
              VitalWireDelay (FCMAPUSLEEPNOTREADY_ipd,FCMAPUSLEEPNOTREADY,tipd_FCMAPUSLEEPNOTREADY);
              VitalWireDelay (FCMAPUXERCA_ipd,FCMAPUXERCA,tipd_FCMAPUXERCA);
              VitalWireDelay (FCMAPUXEROV_ipd,FCMAPUXEROV,tipd_FCMAPUXEROV);
           ISARCVALUE_DELAY : for i in 0 to 7 generate
              VitalWireDelay (ISARCVALUE_ipd(i),ISARCVALUE(i),tipd_ISARCVALUE(i));
           end generate ISARCVALUE_DELAY;
           ISCNTLVALUE_DELAY : for i in 0 to 7 generate
              VitalWireDelay (ISCNTLVALUE_ipd(i),ISCNTLVALUE(i),tipd_ISCNTLVALUE(i));
           end generate ISCNTLVALUE_DELAY;
              VitalWireDelay (JTGC405BNDSCANTDO_ipd,JTGC405BNDSCANTDO,tipd_JTGC405BNDSCANTDO);
              VitalWireDelay (JTGC405TCK_ipd,JTGC405TCK,tipd_JTGC405TCK);
              VitalWireDelay (JTGC405TDI_ipd,JTGC405TDI,tipd_JTGC405TDI);
              VitalWireDelay (JTGC405TMS_ipd,JTGC405TMS,tipd_JTGC405TMS);
              VitalWireDelay (JTGC405TRSTNEG_ipd,JTGC405TRSTNEG,tipd_JTGC405TRSTNEG);
              VitalWireDelay (MCBCPUCLKEN_ipd,MCBCPUCLKEN,tipd_MCBCPUCLKEN);
              VitalWireDelay (MCBJTAGEN_ipd,MCBJTAGEN,tipd_MCBJTAGEN);
              VitalWireDelay (MCBTIMEREN_ipd,MCBTIMEREN,tipd_MCBTIMEREN);
              VitalWireDelay (MCPPCRST_ipd,MCPPCRST,tipd_MCPPCRST);
              VitalWireDelay (PLBC405DCUADDRACK_ipd,PLBC405DCUADDRACK,tipd_PLBC405DCUADDRACK);
              VitalWireDelay (PLBC405DCUBUSY_ipd,PLBC405DCUBUSY,tipd_PLBC405DCUBUSY);
              VitalWireDelay (PLBC405DCUERR_ipd,PLBC405DCUERR,tipd_PLBC405DCUERR);
              VitalWireDelay (PLBC405DCURDDACK_ipd,PLBC405DCURDDACK,tipd_PLBC405DCURDDACK);
           PLBC405DCURDDBUS_DELAY : for i in 0 to 63 generate
              VitalWireDelay (PLBC405DCURDDBUS_ipd(i),PLBC405DCURDDBUS(i),tipd_PLBC405DCURDDBUS(i));
           end generate PLBC405DCURDDBUS_DELAY;
           PLBC405DCURDWDADDR_DELAY : for i in 1 to 3 generate
              VitalWireDelay (PLBC405DCURDWDADDR_ipd(i),PLBC405DCURDWDADDR(i),tipd_PLBC405DCURDWDADDR(i));
           end generate PLBC405DCURDWDADDR_DELAY;
              VitalWireDelay (PLBC405DCUSSIZE1_ipd,PLBC405DCUSSIZE1,tipd_PLBC405DCUSSIZE1);
              VitalWireDelay (PLBC405DCUWRDACK_ipd,PLBC405DCUWRDACK,tipd_PLBC405DCUWRDACK);
              VitalWireDelay (PLBC405ICUADDRACK_ipd,PLBC405ICUADDRACK,tipd_PLBC405ICUADDRACK);
              VitalWireDelay (PLBC405ICUBUSY_ipd,PLBC405ICUBUSY,tipd_PLBC405ICUBUSY);
              VitalWireDelay (PLBC405ICUERR_ipd,PLBC405ICUERR,tipd_PLBC405ICUERR);
              VitalWireDelay (PLBC405ICURDDACK_ipd,PLBC405ICURDDACK,tipd_PLBC405ICURDDACK);
           PLBC405ICURDDBUS_DELAY : for i in 0 to 63 generate
              VitalWireDelay (PLBC405ICURDDBUS_ipd(i),PLBC405ICURDDBUS(i),tipd_PLBC405ICURDDBUS(i));
           end generate PLBC405ICURDDBUS_DELAY;
           PLBC405ICURDWDADDR_DELAY : for i in 1 to 3 generate
              VitalWireDelay (PLBC405ICURDWDADDR_ipd(i),PLBC405ICURDWDADDR(i),tipd_PLBC405ICURDWDADDR(i));
           end generate PLBC405ICURDWDADDR_DELAY;
              VitalWireDelay (PLBC405ICUSSIZE1_ipd,PLBC405ICUSSIZE1,tipd_PLBC405ICUSSIZE1);
              VitalWireDelay (PLBCLK_ipd,PLBCLK,tipd_PLBCLK);
              VitalWireDelay (RSTC405RESETCHIP_ipd,RSTC405RESETCHIP,tipd_RSTC405RESETCHIP);
              VitalWireDelay (RSTC405RESETCORE_ipd,RSTC405RESETCORE,tipd_RSTC405RESETCORE);
              VitalWireDelay (RSTC405RESETSYS_ipd,RSTC405RESETSYS,tipd_RSTC405RESETSYS);
           TIEAPUCONTROL_DELAY : for i in 0 to 15 generate
              VitalWireDelay (TIEAPUCONTROL_ipd(i),TIEAPUCONTROL(i),tipd_TIEAPUCONTROL(i));
           end generate TIEAPUCONTROL_DELAY;
           TIEAPUUDI1_DELAY : for i in 0 to 23 generate
              VitalWireDelay (TIEAPUUDI1_ipd(i),TIEAPUUDI1(i),tipd_TIEAPUUDI1(i));
           end generate TIEAPUUDI1_DELAY;
           TIEAPUUDI2_DELAY : for i in 0 to 23 generate
              VitalWireDelay (TIEAPUUDI2_ipd(i),TIEAPUUDI2(i),tipd_TIEAPUUDI2(i));
           end generate TIEAPUUDI2_DELAY;
           TIEAPUUDI3_DELAY : for i in 0 to 23 generate
              VitalWireDelay (TIEAPUUDI3_ipd(i),TIEAPUUDI3(i),tipd_TIEAPUUDI3(i));
           end generate TIEAPUUDI3_DELAY;
           TIEAPUUDI4_DELAY : for i in 0 to 23 generate
              VitalWireDelay (TIEAPUUDI4_ipd(i),TIEAPUUDI4(i),tipd_TIEAPUUDI4(i));
           end generate TIEAPUUDI4_DELAY;
           TIEAPUUDI5_DELAY : for i in 0 to 23 generate
              VitalWireDelay (TIEAPUUDI5_ipd(i),TIEAPUUDI5(i),tipd_TIEAPUUDI5(i));
           end generate TIEAPUUDI5_DELAY;
           TIEAPUUDI6_DELAY : for i in 0 to 23 generate
              VitalWireDelay (TIEAPUUDI6_ipd(i),TIEAPUUDI6(i),tipd_TIEAPUUDI6(i));
           end generate TIEAPUUDI6_DELAY;
           TIEAPUUDI7_DELAY : for i in 0 to 23 generate
              VitalWireDelay (TIEAPUUDI7_ipd(i),TIEAPUUDI7(i),tipd_TIEAPUUDI7(i));
           end generate TIEAPUUDI7_DELAY;
           TIEAPUUDI8_DELAY : for i in 0 to 23 generate
              VitalWireDelay (TIEAPUUDI8_ipd(i),TIEAPUUDI8(i),tipd_TIEAPUUDI8(i));
           end generate TIEAPUUDI8_DELAY;
              VitalWireDelay (TIEC405DETERMINISTICMULT_ipd,TIEC405DETERMINISTICMULT,tipd_TIEC405DETERMINISTICMULT);
              VitalWireDelay (TIEC405DISOPERANDFWD_ipd,TIEC405DISOPERANDFWD,tipd_TIEC405DISOPERANDFWD);
              VitalWireDelay (TIEC405MMUEN_ipd,TIEC405MMUEN,tipd_TIEC405MMUEN);
           TIEDCRADDR_DELAY : for i in 0 to 5 generate
              VitalWireDelay (TIEDCRADDR_ipd(i),TIEDCRADDR(i),tipd_TIEDCRADDR(i));
           end generate TIEDCRADDR_DELAY;
              VitalWireDelay (TIEPVRBIT10_ipd,TIEPVRBIT10,tipd_TIEPVRBIT10);
              VitalWireDelay (TIEPVRBIT11_ipd,TIEPVRBIT11,tipd_TIEPVRBIT11);
              VitalWireDelay (TIEPVRBIT28_ipd,TIEPVRBIT28,tipd_TIEPVRBIT28);
              VitalWireDelay (TIEPVRBIT29_ipd,TIEPVRBIT29,tipd_TIEPVRBIT29);
              VitalWireDelay (TIEPVRBIT30_ipd,TIEPVRBIT30,tipd_TIEPVRBIT30);
              VitalWireDelay (TIEPVRBIT31_ipd,TIEPVRBIT31,tipd_TIEPVRBIT31);
              VitalWireDelay (TIEPVRBIT8_ipd,TIEPVRBIT8,tipd_TIEPVRBIT8);
              VitalWireDelay (TIEPVRBIT9_ipd,TIEPVRBIT9,tipd_TIEPVRBIT9);
              VitalWireDelay (TRCC405TRACEDISABLE_ipd,TRCC405TRACEDISABLE,tipd_TRCC405TRACEDISABLE);
              VitalWireDelay (TRCC405TRIGGEREVENTIN_ipd,TRCC405TRIGGEREVENTIN,tipd_TRCC405TRIGGEREVENTIN);
           EMACDCRDBUS_DELAY : for i in 0 to 31 generate
              VitalWireDelay (EMACDCRDBUS_ipd(i),EMACDCRDBUS(i),tipd_EMACDCRDBUS(i));
           end generate EMACDCRDBUS_DELAY;
              VitalWireDelay (EMACDCRACK_ipd,EMACDCRACK,tipd_EMACDCRACK);
              VitalWireDelay (GSR_ipd,GSR,tipd_GSR);
       end block;

   SignalDelay : block
       begin
           BRAMDSOCMRDDBUS_DELAY : for i in 0 to 31 generate
              VitalSignalDelay (BRAMDSOCMRDDBUS_dly(i),BRAMDSOCMRDDBUS_ipd(i),tisd_BRAMDSOCMRDDBUS(i));
           end generate BRAMDSOCMRDDBUS_DELAY;
           BRAMISOCMDCRRDDBUS_DELAY : for i in 0 to 31 generate
              VitalSignalDelay (BRAMISOCMDCRRDDBUS_dly(i),BRAMISOCMDCRRDDBUS_ipd(i),tisd_BRAMISOCMDCRRDDBUS(i));
           end generate BRAMISOCMDCRRDDBUS_DELAY;
           BRAMISOCMRDDBUS_DELAY : for i in 0 to 63 generate
              VitalSignalDelay (BRAMISOCMRDDBUS_dly(i),BRAMISOCMRDDBUS_ipd(i),tisd_BRAMISOCMRDDBUS(i));
           end generate BRAMISOCMRDDBUS_DELAY;
              VitalSignalDelay (CPMC405CORECLKINACTIVE_dly,CPMC405CORECLKINACTIVE_ipd,tisd_CPMC405CORECLKINACTIVE);
              VitalSignalDelay (CPMC405CPUCLKEN_dly,CPMC405CPUCLKEN_ipd,tisd_CPMC405CPUCLKEN);
              VitalSignalDelay (CPMC405JTAGCLKEN_dly,CPMC405JTAGCLKEN_ipd,tisd_CPMC405JTAGCLKEN);
              VitalSignalDelay (CPMC405TIMERCLKEN_dly,CPMC405TIMERCLKEN_ipd,tisd_CPMC405TIMERCLKEN);
              VitalSignalDelay (CPMC405TIMERTICK_dly,CPMC405TIMERTICK_ipd,tisd_CPMC405TIMERTICK);
              VitalSignalDelay (DBGC405DEBUGHALT_dly,DBGC405DEBUGHALT_ipd,tisd_DBGC405DEBUGHALT);
              VitalSignalDelay (DBGC405EXTBUSHOLDACK_dly,DBGC405EXTBUSHOLDACK_ipd,tisd_DBGC405EXTBUSHOLDACK);
              VitalSignalDelay (DBGC405UNCONDDEBUGEVENT_dly,DBGC405UNCONDDEBUGEVENT_ipd,tisd_DBGC405UNCONDDEBUGEVENT);
              VitalSignalDelay (DSOCMRWCOMPLETE_dly,DSOCMRWCOMPLETE_ipd,tisd_DSOCMRWCOMPLETE);
              VitalSignalDelay (EICC405CRITINPUTIRQ_dly,EICC405CRITINPUTIRQ_ipd,tisd_EICC405CRITINPUTIRQ);
              VitalSignalDelay (EICC405EXTINPUTIRQ_dly,EICC405EXTINPUTIRQ_ipd,tisd_EICC405EXTINPUTIRQ);
              VitalSignalDelay (EXTDCRACK_dly,EXTDCRACK_ipd,tisd_EXTDCRACK);
           EXTDCRDBUSIN_DELAY : for i in 0 to 31 generate
              VitalSignalDelay (EXTDCRDBUSIN_dly(i),EXTDCRDBUSIN_ipd(i),tisd_EXTDCRDBUSIN(i));
           end generate EXTDCRDBUSIN_DELAY;
           FCMAPUCR_DELAY : for i in 0 to 3 generate
              VitalSignalDelay (FCMAPUCR_dly(i),FCMAPUCR_ipd(i),tisd_FCMAPUCR(i));
           end generate FCMAPUCR_DELAY;
              VitalSignalDelay (FCMAPUDCDCREN_dly,FCMAPUDCDCREN_ipd,tisd_FCMAPUDCDCREN);
              VitalSignalDelay (FCMAPUDCDFORCEALIGN_dly,FCMAPUDCDFORCEALIGN_ipd,tisd_FCMAPUDCDFORCEALIGN);
              VitalSignalDelay (FCMAPUDCDFORCEBESTEERING_dly,FCMAPUDCDFORCEBESTEERING_ipd,tisd_FCMAPUDCDFORCEBESTEERING);
              VitalSignalDelay (FCMAPUDCDFPUOP_dly,FCMAPUDCDFPUOP_ipd,tisd_FCMAPUDCDFPUOP);
              VitalSignalDelay (FCMAPUDCDGPRWRITE_dly,FCMAPUDCDGPRWRITE_ipd,tisd_FCMAPUDCDGPRWRITE);
              VitalSignalDelay (FCMAPUDCDLDSTBYTE_dly,FCMAPUDCDLDSTBYTE_ipd,tisd_FCMAPUDCDLDSTBYTE);
              VitalSignalDelay (FCMAPUDCDLDSTDW_dly,FCMAPUDCDLDSTDW_ipd,tisd_FCMAPUDCDLDSTDW);
              VitalSignalDelay (FCMAPUDCDLDSTHW_dly,FCMAPUDCDLDSTHW_ipd,tisd_FCMAPUDCDLDSTHW);
              VitalSignalDelay (FCMAPUDCDLDSTQW_dly,FCMAPUDCDLDSTQW_ipd,tisd_FCMAPUDCDLDSTQW);
              VitalSignalDelay (FCMAPUDCDLDSTWD_dly,FCMAPUDCDLDSTWD_ipd,tisd_FCMAPUDCDLDSTWD);
              VitalSignalDelay (FCMAPUDCDLOAD_dly,FCMAPUDCDLOAD_ipd,tisd_FCMAPUDCDLOAD);
              VitalSignalDelay (FCMAPUDCDPRIVOP_dly,FCMAPUDCDPRIVOP_ipd,tisd_FCMAPUDCDPRIVOP);
              VitalSignalDelay (FCMAPUDCDRAEN_dly,FCMAPUDCDRAEN_ipd,tisd_FCMAPUDCDRAEN);
              VitalSignalDelay (FCMAPUDCDRBEN_dly,FCMAPUDCDRBEN_ipd,tisd_FCMAPUDCDRBEN);
              VitalSignalDelay (FCMAPUDCDSTORE_dly,FCMAPUDCDSTORE_ipd,tisd_FCMAPUDCDSTORE);
              VitalSignalDelay (FCMAPUDCDTRAPBE_dly,FCMAPUDCDTRAPBE_ipd,tisd_FCMAPUDCDTRAPBE);
              VitalSignalDelay (FCMAPUDCDTRAPLE_dly,FCMAPUDCDTRAPLE_ipd,tisd_FCMAPUDCDTRAPLE);
              VitalSignalDelay (FCMAPUDCDUPDATE_dly,FCMAPUDCDUPDATE_ipd,tisd_FCMAPUDCDUPDATE);
              VitalSignalDelay (FCMAPUDCDXERCAEN_dly,FCMAPUDCDXERCAEN_ipd,tisd_FCMAPUDCDXERCAEN);
              VitalSignalDelay (FCMAPUDCDXEROVEN_dly,FCMAPUDCDXEROVEN_ipd,tisd_FCMAPUDCDXEROVEN);
              VitalSignalDelay (FCMAPUDECODEBUSY_dly,FCMAPUDECODEBUSY_ipd,tisd_FCMAPUDECODEBUSY);
              VitalSignalDelay (FCMAPUDONE_dly,FCMAPUDONE_ipd,tisd_FCMAPUDONE);
              VitalSignalDelay (FCMAPUEXCEPTION_dly,FCMAPUEXCEPTION_ipd,tisd_FCMAPUEXCEPTION);
              VitalSignalDelay (FCMAPUEXEBLOCKINGMCO_dly,FCMAPUEXEBLOCKINGMCO_ipd,tisd_FCMAPUEXEBLOCKINGMCO);
           FCMAPUEXECRFIELD_DELAY : for i in 0 to 2 generate
              VitalSignalDelay (FCMAPUEXECRFIELD_dly(i),FCMAPUEXECRFIELD_ipd(i),tisd_FCMAPUEXECRFIELD(i));
           end generate FCMAPUEXECRFIELD_DELAY;
              VitalSignalDelay (FCMAPUEXENONBLOCKINGMCO_dly,FCMAPUEXENONBLOCKINGMCO_ipd,tisd_FCMAPUEXENONBLOCKINGMCO);
              VitalSignalDelay (FCMAPUINSTRACK_dly,FCMAPUINSTRACK_ipd,tisd_FCMAPUINSTRACK);
              VitalSignalDelay (FCMAPULOADWAIT_dly,FCMAPULOADWAIT_ipd,tisd_FCMAPULOADWAIT);
           FCMAPURESULT_DELAY : for i in 0 to 31 generate
              VitalSignalDelay (FCMAPURESULT_dly(i),FCMAPURESULT_ipd(i),tisd_FCMAPURESULT(i));
           end generate FCMAPURESULT_DELAY;
              VitalSignalDelay (FCMAPURESULTVALID_dly,FCMAPURESULTVALID_ipd,tisd_FCMAPURESULTVALID);
              VitalSignalDelay (FCMAPUSLEEPNOTREADY_dly,FCMAPUSLEEPNOTREADY_ipd,tisd_FCMAPUSLEEPNOTREADY);
              VitalSignalDelay (FCMAPUXERCA_dly,FCMAPUXERCA_ipd,tisd_FCMAPUXERCA);
              VitalSignalDelay (FCMAPUXEROV_dly,FCMAPUXEROV_ipd,tisd_FCMAPUXEROV);
              VitalSignalDelay (JTGC405BNDSCANTDO_dly,JTGC405BNDSCANTDO_ipd,tisd_JTGC405BNDSCANTDO);
              VitalSignalDelay (JTGC405TDI_dly,JTGC405TDI_ipd,tisd_JTGC405TDI);
              VitalSignalDelay (JTGC405TMS_dly,JTGC405TMS_ipd,tisd_JTGC405TMS);
              VitalSignalDelay (JTGC405TRSTNEG_dly,JTGC405TRSTNEG_ipd,tisd_JTGC405TRSTNEG);
              VitalSignalDelay (PLBC405DCUADDRACK_dly,PLBC405DCUADDRACK_ipd,tisd_PLBC405DCUADDRACK);
              VitalSignalDelay (PLBC405DCUBUSY_dly,PLBC405DCUBUSY_ipd,tisd_PLBC405DCUBUSY);
              VitalSignalDelay (PLBC405DCUERR_dly,PLBC405DCUERR_ipd,tisd_PLBC405DCUERR);
              VitalSignalDelay (PLBC405DCURDDACK_dly,PLBC405DCURDDACK_ipd,tisd_PLBC405DCURDDACK);
           PLBC405DCURDDBUS_DELAY : for i in 0 to 63 generate
              VitalSignalDelay (PLBC405DCURDDBUS_dly(i),PLBC405DCURDDBUS_ipd(i),tisd_PLBC405DCURDDBUS(i));
           end generate PLBC405DCURDDBUS_DELAY;
           PLBC405DCURDWDADDR_DELAY : for i in 1 to 3 generate
              VitalSignalDelay (PLBC405DCURDWDADDR_dly(i),PLBC405DCURDWDADDR_ipd(i),tisd_PLBC405DCURDWDADDR(i));
           end generate PLBC405DCURDWDADDR_DELAY;           
           PLBC405ICURDWDADDR_DELAY : for i in 1 to 3 generate
              VitalSignalDelay (PLBC405ICURDWDADDR_dly(i),PLBC405ICURDWDADDR_ipd(i),tisd_PLBC405ICURDWDADDR(i));
           end generate PLBC405ICURDWDADDR_DELAY;
           
              VitalSignalDelay (PLBC405DCUSSIZE1_dly,PLBC405DCUSSIZE1_ipd,tisd_PLBC405DCUSSIZE1);
              VitalSignalDelay (PLBC405DCUWRDACK_dly,PLBC405DCUWRDACK_ipd,tisd_PLBC405DCUWRDACK);
              VitalSignalDelay (PLBC405ICUADDRACK_dly,PLBC405ICUADDRACK_ipd,tisd_PLBC405ICUADDRACK);
              VitalSignalDelay (PLBC405ICUBUSY_dly,PLBC405ICUBUSY_ipd,tisd_PLBC405ICUBUSY);
              VitalSignalDelay (PLBC405ICUERR_dly,PLBC405ICUERR_ipd,tisd_PLBC405ICUERR);
              VitalSignalDelay (PLBC405ICURDDACK_dly,PLBC405ICURDDACK_ipd,tisd_PLBC405ICURDDACK);
           PLBC405ICURDDBUS_DELAY : for i in 0 to 63 generate
              VitalSignalDelay (PLBC405ICURDDBUS_dly(i),PLBC405ICURDDBUS_ipd(i),tisd_PLBC405ICURDDBUS(i));
           end generate PLBC405ICURDDBUS_DELAY;
              VitalSignalDelay (PLBC405ICUSSIZE1_dly,PLBC405ICUSSIZE1_ipd,tisd_PLBC405ICUSSIZE1);
              VitalSignalDelay (RSTC405RESETCHIP_dly,RSTC405RESETCHIP_ipd,tisd_RSTC405RESETCHIP);
              VitalSignalDelay (RSTC405RESETCORE_dly,RSTC405RESETCORE_ipd,tisd_RSTC405RESETCORE);
              VitalSignalDelay (RSTC405RESETSYS_dly,RSTC405RESETSYS_ipd,tisd_RSTC405RESETSYS);
              VitalSignalDelay (TRCC405TRACEDISABLE_dly,TRCC405TRACEDISABLE_ipd,tisd_TRCC405TRACEDISABLE);
              VitalSignalDelay (TRCC405TRIGGEREVENTIN_dly,TRCC405TRIGGEREVENTIN_ipd,tisd_TRCC405TRIGGEREVENTIN);

              VitalSignalDelay (BRAMDSOCMCLK_dly,BRAMDSOCMCLK_ipd,ticd_BRAMDSOCMCLK);
              VitalSignalDelay (BRAMISOCMCLK_dly,BRAMISOCMCLK_ipd,ticd_BRAMISOCMCLK);
              VitalSignalDelay (CPMC405CLOCK_dly,CPMC405CLOCK_ipd,ticd_CPMC405CLOCK);
              VitalSignalDelay (CPMDCRCLK_dly,CPMDCRCLK_ipd,ticd_CPMDCRCLK);
              VitalSignalDelay (CPMFCMCLK_dly,CPMFCMCLK_ipd,ticd_CPMFCMCLK);
              VitalSignalDelay (JTGC405TCK_dly,JTGC405TCK_ipd,ticd_JTGC405TCK);
              VitalSignalDelay (PLBCLK_dly,PLBCLK_ipd,ticd_PLBCLK);
           
       end block;

   CPMC405SYNCBYPASS_dly <= CPMC405SYNCBYPASS_ipd;
   DSARCVALUE_dly <= DSARCVALUE_ipd;
   DSCNTLVALUE_dly <= DSCNTLVALUE_ipd;
   ISARCVALUE_dly <= ISARCVALUE_ipd;
   ISCNTLVALUE_dly <= ISCNTLVALUE_ipd;
   MCBCPUCLKEN_dly <= MCBCPUCLKEN_ipd;
   MCBJTAGEN_dly <= MCBJTAGEN_ipd;
   MCBTIMEREN_dly <= MCBTIMEREN_ipd;
   MCPPCRST_dly <= MCPPCRST_ipd;
   TIEAPUCONTROL_dly <= TIEAPUCONTROL_ipd;
   TIEAPUUDI1_dly <= TIEAPUUDI1_ipd;
   TIEAPUUDI2_dly <= TIEAPUUDI2_ipd;
   TIEAPUUDI3_dly <= TIEAPUUDI3_ipd;
   TIEAPUUDI4_dly <= TIEAPUUDI4_ipd;
   TIEAPUUDI5_dly <= TIEAPUUDI5_ipd;
   TIEAPUUDI6_dly <= TIEAPUUDI6_ipd;
   TIEAPUUDI7_dly <= TIEAPUUDI7_ipd;
   TIEAPUUDI8_dly <= TIEAPUUDI8_ipd;
   TIEC405DETERMINISTICMULT_dly <= TIEC405DETERMINISTICMULT_ipd;
   TIEC405DISOPERANDFWD_dly <= TIEC405DISOPERANDFWD_ipd;
   TIEC405MMUEN_dly <= TIEC405MMUEN_ipd;
   TIEDCRADDR_dly <= TIEDCRADDR_ipd;
   TIEPVRBIT10_dly <= TIEPVRBIT10_ipd;
   TIEPVRBIT11_dly <= TIEPVRBIT11_ipd;
   TIEPVRBIT28_dly <= TIEPVRBIT28_ipd;
   TIEPVRBIT29_dly <= TIEPVRBIT29_ipd;
   TIEPVRBIT30_dly <= TIEPVRBIT30_ipd;
   TIEPVRBIT31_dly <= TIEPVRBIT31_ipd;
   TIEPVRBIT8_dly <= TIEPVRBIT8_ipd;
   TIEPVRBIT9_dly <= TIEPVRBIT9_ipd;
   EMACDCRDBUS_dly <= EMACDCRDBUS_ipd;
   EMACDCRACK_dly <= EMACDCRACK_ipd;
   PLBC405DCURDWDADDR_dly <= PLBC405DCURDWDADDR_ipd;
   PLBC405ICURDWDADDR_dly <= PLBC405ICURDWDADDR_ipd;

GSR_dly_1 <= GSR_dly after in_delay;
BRAMDSOCMCLK_dly_1 <= BRAMDSOCMCLK_dly;
BRAMDSOCMRDDBUS_dly_1 <= BRAMDSOCMRDDBUS_dly after in_delay;
BRAMISOCMCLK_dly_1 <= BRAMISOCMCLK_dly;
BRAMISOCMDCRRDDBUS_dly_1 <= BRAMISOCMDCRRDDBUS_dly after in_delay;
BRAMISOCMRDDBUS_dly_1 <= BRAMISOCMRDDBUS_dly after in_delay;
CPMC405CLOCK_dly_1 <= CPMC405CLOCK_dly;
CPMC405CORECLKINACTIVE_dly_1 <= CPMC405CORECLKINACTIVE_dly after in_delay;
CPMC405CPUCLKEN_dly_1 <= CPMC405CPUCLKEN_dly after in_delay;
CPMC405JTAGCLKEN_dly_1 <= CPMC405JTAGCLKEN_dly after in_delay;
CPMC405SYNCBYPASS_dly_1 <= CPMC405SYNCBYPASS_dly after in_delay;
CPMC405TIMERCLKEN_dly_1 <= CPMC405TIMERCLKEN_dly after in_delay;
CPMC405TIMERTICK_dly_1 <= CPMC405TIMERTICK_dly after in_delay;
CPMDCRCLK_dly_1 <= CPMDCRCLK_dly;
CPMFCMCLK_dly_1 <= CPMFCMCLK_dly;
DBGC405DEBUGHALT_dly_1 <= DBGC405DEBUGHALT_dly after in_delay;
DBGC405EXTBUSHOLDACK_dly_1 <= DBGC405EXTBUSHOLDACK_dly after in_delay;
DBGC405UNCONDDEBUGEVENT_dly_1 <= DBGC405UNCONDDEBUGEVENT_dly after in_delay;
DSARCVALUE_dly_1 <= DSARCVALUE_dly after in_delay;
DSCNTLVALUE_dly_1 <= DSCNTLVALUE_dly after in_delay;
DSOCMRWCOMPLETE_dly_1 <= DSOCMRWCOMPLETE_dly after in_delay;
EICC405CRITINPUTIRQ_dly_1 <= EICC405CRITINPUTIRQ_dly after in_delay;
EICC405EXTINPUTIRQ_dly_1 <= EICC405EXTINPUTIRQ_dly after in_delay;
EXTDCRACK_dly_1 <= EXTDCRACK_dly after in_delay;
EXTDCRDBUSIN_dly_1 <= EXTDCRDBUSIN_dly after in_delay;
FCMAPUCR_dly_1 <= FCMAPUCR_dly after in_delay;
FCMAPUDCDCREN_dly_1 <= FCMAPUDCDCREN_dly after in_delay;
FCMAPUDCDFORCEALIGN_dly_1 <= FCMAPUDCDFORCEALIGN_dly after in_delay;
FCMAPUDCDFORCEBESTEERING_dly_1 <= FCMAPUDCDFORCEBESTEERING_dly after in_delay;
FCMAPUDCDFPUOP_dly_1 <= FCMAPUDCDFPUOP_dly after in_delay;
FCMAPUDCDGPRWRITE_dly_1 <= FCMAPUDCDGPRWRITE_dly after in_delay;
FCMAPUDCDLDSTBYTE_dly_1 <= FCMAPUDCDLDSTBYTE_dly after in_delay;
FCMAPUDCDLDSTDW_dly_1 <= FCMAPUDCDLDSTDW_dly after in_delay;
FCMAPUDCDLDSTHW_dly_1 <= FCMAPUDCDLDSTHW_dly after in_delay;
FCMAPUDCDLDSTQW_dly_1 <= FCMAPUDCDLDSTQW_dly after in_delay;
FCMAPUDCDLDSTWD_dly_1 <= FCMAPUDCDLDSTWD_dly after in_delay;
FCMAPUDCDLOAD_dly_1 <= FCMAPUDCDLOAD_dly after in_delay;
FCMAPUDCDPRIVOP_dly_1 <= FCMAPUDCDPRIVOP_dly after in_delay;
FCMAPUDCDRAEN_dly_1 <= FCMAPUDCDRAEN_dly after in_delay;
FCMAPUDCDRBEN_dly_1 <= FCMAPUDCDRBEN_dly after in_delay;
FCMAPUDCDSTORE_dly_1 <= FCMAPUDCDSTORE_dly after in_delay;
FCMAPUDCDTRAPBE_dly_1 <= FCMAPUDCDTRAPBE_dly after in_delay;
FCMAPUDCDTRAPLE_dly_1 <= FCMAPUDCDTRAPLE_dly after in_delay;
FCMAPUDCDUPDATE_dly_1 <= FCMAPUDCDUPDATE_dly after in_delay;
FCMAPUDCDXERCAEN_dly_1 <= FCMAPUDCDXERCAEN_dly after in_delay;
FCMAPUDCDXEROVEN_dly_1 <= FCMAPUDCDXEROVEN_dly after in_delay;
FCMAPUDECODEBUSY_dly_1 <= FCMAPUDECODEBUSY_dly after in_delay;
FCMAPUDONE_dly_1 <= FCMAPUDONE_dly after in_delay;
FCMAPUEXCEPTION_dly_1 <= FCMAPUEXCEPTION_dly after in_delay;
FCMAPUEXEBLOCKINGMCO_dly_1 <= FCMAPUEXEBLOCKINGMCO_dly after in_delay;
FCMAPUEXECRFIELD_dly_1 <= FCMAPUEXECRFIELD_dly after in_delay;
FCMAPUEXENONBLOCKINGMCO_dly_1 <= FCMAPUEXENONBLOCKINGMCO_dly after in_delay;
FCMAPUINSTRACK_dly_1 <= FCMAPUINSTRACK_dly after in_delay;
FCMAPULOADWAIT_dly_1 <= FCMAPULOADWAIT_dly after in_delay;
FCMAPURESULT_dly_1 <= FCMAPURESULT_dly after in_delay;
FCMAPURESULTVALID_dly_1 <= FCMAPURESULTVALID_dly after in_delay;
FCMAPUSLEEPNOTREADY_dly_1 <= FCMAPUSLEEPNOTREADY_dly after in_delay;
FCMAPUXERCA_dly_1 <= FCMAPUXERCA_dly after in_delay;
FCMAPUXEROV_dly_1 <= FCMAPUXEROV_dly after in_delay;
ISARCVALUE_dly_1 <= ISARCVALUE_dly after in_delay;
ISCNTLVALUE_dly_1 <= ISCNTLVALUE_dly after in_delay;
JTGC405BNDSCANTDO_dly_1 <= JTGC405BNDSCANTDO_dly after in_delay;
JTGC405TCK_dly_1 <= JTGC405TCK_dly;
JTGC405TDI_dly_1 <= JTGC405TDI_dly after in_delay;
JTGC405TMS_dly_1 <= JTGC405TMS_dly after in_delay;
JTGC405TRSTNEG_dly_1 <= JTGC405TRSTNEG_dly after in_delay;
MCBCPUCLKEN_dly_1 <= MCBCPUCLKEN_dly after in_delay;
MCBJTAGEN_dly_1 <= MCBJTAGEN_dly after in_delay;
MCBTIMEREN_dly_1 <= MCBTIMEREN_dly after in_delay;
MCPPCRST_dly_1 <= MCPPCRST_dly after in_delay;
PLBC405DCUADDRACK_dly_1 <= PLBC405DCUADDRACK_dly after in_delay;
PLBC405DCUBUSY_dly_1 <= PLBC405DCUBUSY_dly after in_delay;
PLBC405DCUERR_dly_1 <= PLBC405DCUERR_dly after in_delay;
PLBC405DCURDDACK_dly_1 <= PLBC405DCURDDACK_dly after in_delay;
PLBC405DCURDDBUS_dly_1 <= PLBC405DCURDDBUS_dly after in_delay;
PLBC405DCURDWDADDR_dly_1 <= PLBC405DCURDWDADDR_dly after in_delay;
PLBC405DCUSSIZE1_dly_1 <= PLBC405DCUSSIZE1_dly after in_delay;
PLBC405DCUWRDACK_dly_1 <= PLBC405DCUWRDACK_dly after in_delay;
PLBC405ICUADDRACK_dly_1 <= PLBC405ICUADDRACK_dly after in_delay;
PLBC405ICUBUSY_dly_1 <= PLBC405ICUBUSY_dly after in_delay;
PLBC405ICUERR_dly_1 <= PLBC405ICUERR_dly after in_delay;
PLBC405ICURDDACK_dly_1 <= PLBC405ICURDDACK_dly after in_delay;
PLBC405ICURDDBUS_dly_1 <= PLBC405ICURDDBUS_dly after in_delay;
PLBC405ICURDWDADDR_dly_1 <= PLBC405ICURDWDADDR_dly after in_delay;
PLBC405ICUSSIZE1_dly_1 <= PLBC405ICUSSIZE1_dly after in_delay;
PLBCLK_dly_1 <= PLBCLK_dly after in_delay;
RSTC405RESETCHIP_dly_1 <= RSTC405RESETCHIP_dly after in_delay;
RSTC405RESETCORE_dly_1 <= RSTC405RESETCORE_dly after in_delay;
RSTC405RESETSYS_dly_1 <= RSTC405RESETSYS_dly after in_delay;
TIEAPUCONTROL_dly_1 <= TIEAPUCONTROL_dly after in_delay;
TIEAPUUDI1_dly_1 <= TIEAPUUDI1_dly after in_delay;
TIEAPUUDI2_dly_1 <= TIEAPUUDI2_dly after in_delay;
TIEAPUUDI3_dly_1 <= TIEAPUUDI3_dly after in_delay;
TIEAPUUDI4_dly_1 <= TIEAPUUDI4_dly after in_delay;
TIEAPUUDI5_dly_1 <= TIEAPUUDI5_dly after in_delay;
TIEAPUUDI6_dly_1 <= TIEAPUUDI6_dly after in_delay;
TIEAPUUDI7_dly_1 <= TIEAPUUDI7_dly after in_delay;
TIEAPUUDI8_dly_1 <= TIEAPUUDI8_dly after in_delay;
TIEC405DETERMINISTICMULT_dly_1 <= TIEC405DETERMINISTICMULT_dly after in_delay;
TIEC405DISOPERANDFWD_dly_1 <= TIEC405DISOPERANDFWD_dly after in_delay;
TIEC405MMUEN_dly_1 <= TIEC405MMUEN_dly after in_delay;
TIEDCRADDR_dly_1 <= TIEDCRADDR_dly after in_delay;
TIEPVRBIT10_dly_1 <= TIEPVRBIT10_dly after in_delay;
TIEPVRBIT11_dly_1 <= TIEPVRBIT11_dly after in_delay;
TIEPVRBIT28_dly_1 <= TIEPVRBIT28_dly after in_delay;
TIEPVRBIT29_dly_1 <= TIEPVRBIT29_dly after in_delay;
TIEPVRBIT30_dly_1 <= TIEPVRBIT30_dly after in_delay;
TIEPVRBIT31_dly_1 <= TIEPVRBIT31_dly after in_delay;
TIEPVRBIT8_dly_1 <= TIEPVRBIT8_dly after in_delay;
TIEPVRBIT9_dly_1 <= TIEPVRBIT9_dly after in_delay;
TRCC405TRACEDISABLE_dly_1 <= TRCC405TRACEDISABLE_dly after in_delay;
TRCC405TRIGGEREVENTIN_dly_1 <= TRCC405TRIGGEREVENTIN_dly after in_delay;
EMACDCRDBUS_dly_1 <= EMACDCRDBUS_dly after in_delay;
EMACDCRACK_dly_1 <= EMACDCRACK_dly after in_delay;

   ppc405_adv_swift_bw_1 : PPC405_ADV_SWIFT
      port map (
            CFG_MCLK => FPGA_CCLK,
            BUS_RESET => FPGA_BUS_RESET_delay,
            GSR => GSR_delay,
            GWE => FPGA_GWE_delay,
            GHIGHB => FPGA_GHIGHB_delay,
            
            CPMC405CPUCLKEN => CPMC405CPUCLKEN_dly_1,
            CPMC405JTAGCLKEN => CPMC405JTAGCLKEN_dly_1,
            CPMC405TIMERCLKEN => CPMC405TIMERCLKEN_dly_1,
            C405JTGPGMOUT => C405JTGPGMOUT_out,
            MCBCPUCLKEN => MCBCPUCLKEN_dly_1,
            MCBJTAGEN => MCBJTAGEN_dly_1,
            MCBTIMEREN => MCBTIMEREN_dly_1,
            MCPPCRST => MCPPCRST_dly_1,
            C405TRCODDEXECUTIONSTATUS => C405TRCODDEXECUTIONSTATUS_out,
            C405TRCEVENEXECUTIONSTATUS => C405TRCEVENEXECUTIONSTATUS_out,
            CPMC405CLOCK => CPMC405CLOCK_dly_1,
            CPMC405CORECLKINACTIVE => CPMC405CORECLKINACTIVE_dly_1,
            PLBCLK => PLBCLK_dly_1,
            CPMFCMCLK => CPMFCMCLK_dly_1,
            CPMDCRCLK => CPMDCRCLK_dly_1,
            CPMC405SYNCBYPASS => CPMC405SYNCBYPASS_dly_1,
            CPMC405TIMERTICK => CPMC405TIMERTICK_dly_1,
            C405CPMMSREE => C405CPMMSREE_out,
            C405CPMMSRCE => C405CPMMSRCE_out,
            C405CPMTIMERIRQ => C405CPMTIMERIRQ_out,
            C405CPMTIMERRESETREQ => C405CPMTIMERRESETREQ_out,
            C405CPMCORESLEEPREQ => C405CPMCORESLEEPREQ_out,
            TIEC405DISOPERANDFWD => TIEC405DISOPERANDFWD_dly_1,
            TIEC405DETERMINISTICMULT => TIEC405DETERMINISTICMULT_dly_1,
            TIEC405MMUEN => TIEC405MMUEN_dly_1,
            TIEPVRBIT8 => TIEPVRBIT8_dly_1,
            TIEPVRBIT9 => TIEPVRBIT9_dly_1,
            TIEPVRBIT10 => TIEPVRBIT10_dly_1,
            TIEPVRBIT11 => TIEPVRBIT11_dly_1,
            TIEPVRBIT28 => TIEPVRBIT28_dly_1,
            TIEPVRBIT29 => TIEPVRBIT29_dly_1,
            TIEPVRBIT30 => TIEPVRBIT30_dly_1,
            TIEPVRBIT31 => TIEPVRBIT31_dly_1,
            C405XXXMACHINECHECK => C405XXXMACHINECHECK_out,
            DCREMACENABLER => DCREMACENABLER_out,
            DCREMACCLK => DCREMACCLK_out,
            DCREMACWRITE => DCREMACWRITE_out,
            DCREMACREAD => DCREMACREAD_out,
            DCREMACDBUS => DCREMACDBUS_out,
            DCREMACABUS => DCREMACABUS_out,
            EMACDCRDBUS => EMACDCRDBUS_dly_1,
            EMACDCRACK => EMACDCRACK_dly_1,
            C405RSTCHIPRESETREQ => C405RSTCHIPRESETREQ_out,
            C405RSTCORERESETREQ => C405RSTCORERESETREQ_out,
            C405RSTSYSRESETREQ => C405RSTSYSRESETREQ_out,
            RSTC405RESETCHIP => RSTC405RESETCHIP_dly_1,
            RSTC405RESETCORE => RSTC405RESETCORE_dly_1,
            RSTC405RESETSYS => RSTC405RESETSYS_dly_1,
            C405PLBICUREQUEST => C405PLBICUREQUEST_out,
            C405PLBICUPRIORITY => C405PLBICUPRIORITY_out,
            C405PLBICUCACHEABLE => C405PLBICUCACHEABLE_out,
            C405PLBICUABUS => C405PLBICUABUS_out,
            C405PLBICUSIZE => C405PLBICUSIZE_out,
            C405PLBICUABORT => C405PLBICUABORT_out,
            C405PLBICUU0ATTR => C405PLBICUU0ATTR_out,
            PLBC405ICUADDRACK => PLBC405ICUADDRACK_dly_1,
            PLBC405ICUBUSY => PLBC405ICUBUSY_dly_1,
            PLBC405ICUERR => PLBC405ICUERR_dly_1,
            PLBC405ICURDDACK => PLBC405ICURDDACK_dly_1,
            PLBC405ICURDDBUS => PLBC405ICURDDBUS_dly_1,
            PLBC405ICUSSIZE1 => PLBC405ICUSSIZE1_dly_1,
            PLBC405ICURDWDADDR => PLBC405ICURDWDADDR_dly_1,
            C405PLBDCUREQUEST => C405PLBDCUREQUEST_out,
            C405PLBDCURNW => C405PLBDCURNW_out,
            C405PLBDCUABUS => C405PLBDCUABUS_out,
            C405PLBDCUBE => C405PLBDCUBE_out,
            C405PLBDCUCACHEABLE => C405PLBDCUCACHEABLE_out,
            C405PLBDCUGUARDED => C405PLBDCUGUARDED_out,
            C405PLBDCUPRIORITY => C405PLBDCUPRIORITY_out,
            C405PLBDCUSIZE2 => C405PLBDCUSIZE2_out,
            C405PLBDCUABORT => C405PLBDCUABORT_out,
            C405PLBDCUWRDBUS => C405PLBDCUWRDBUS_out,
            C405PLBDCUU0ATTR => C405PLBDCUU0ATTR_out,
            C405PLBDCUWRITETHRU => C405PLBDCUWRITETHRU_out,
            PLBC405DCUADDRACK => PLBC405DCUADDRACK_dly_1,
            PLBC405DCUBUSY => PLBC405DCUBUSY_dly_1,
            PLBC405DCUERR => PLBC405DCUERR_dly_1,
            PLBC405DCURDDACK => PLBC405DCURDDACK_dly_1,
            PLBC405DCURDDBUS => PLBC405DCURDDBUS_dly_1,
            PLBC405DCURDWDADDR => PLBC405DCURDWDADDR_dly_1,
            PLBC405DCUSSIZE1 => PLBC405DCUSSIZE1_dly_1,
            PLBC405DCUWRDACK => PLBC405DCUWRDACK_dly_1,
            ISOCMBRAMRDABUS => ISOCMBRAMRDABUS_out,
            ISOCMBRAMWRABUS => ISOCMBRAMWRABUS_out,
            ISOCMBRAMEN => ISOCMBRAMEN_out,
            ISOCMBRAMODDWRITEEN => ISOCMBRAMODDWRITEEN_out,
            ISOCMBRAMEVENWRITEEN => ISOCMBRAMEVENWRITEEN_out,
            ISOCMBRAMWRDBUS => ISOCMBRAMWRDBUS_out,
            ISOCMDCRBRAMEVENEN => ISOCMDCRBRAMEVENEN_out,
            ISOCMDCRBRAMODDEN => ISOCMDCRBRAMODDEN_out,
            ISOCMDCRBRAMRDSELECT => ISOCMDCRBRAMRDSELECT_out,
            BRAMISOCMDCRRDDBUS => BRAMISOCMDCRRDDBUS_dly_1,
            BRAMISOCMRDDBUS => BRAMISOCMRDDBUS_dly_1,
            ISARCVALUE => ISARCVALUE_dly_1,
            ISCNTLVALUE => ISCNTLVALUE_dly_1,
            BRAMISOCMCLK => BRAMISOCMCLK_dly_1,
            DSOCMBRAMABUS => DSOCMBRAMABUS_out,
            DSOCMBRAMBYTEWRITE => DSOCMBRAMBYTEWRITE_out,
            DSOCMBRAMEN => DSOCMBRAMEN_out,
            DSOCMBRAMWRDBUS => DSOCMBRAMWRDBUS_out,
            BRAMDSOCMRDDBUS => BRAMDSOCMRDDBUS_dly_1,
            DSOCMRWCOMPLETE => DSOCMRWCOMPLETE_dly_1,
            DSOCMBUSY => DSOCMBUSY_out,
            DSOCMWRADDRVALID => DSOCMWRADDRVALID_out,
            DSOCMRDADDRVALID => DSOCMRDADDRVALID_out,
            TIEDCRADDR => TIEDCRADDR_dly_1,
            DSARCVALUE => DSARCVALUE_dly_1,
            DSCNTLVALUE => DSCNTLVALUE_dly_1,
            BRAMDSOCMCLK => BRAMDSOCMCLK_dly_1,
            EXTDCRREAD => EXTDCRREAD_out,
            EXTDCRWRITE => EXTDCRWRITE_out,
            EXTDCRABUS => EXTDCRABUS_out,
            EXTDCRDBUSOUT => EXTDCRDBUSOUT_out,
            EXTDCRACK => EXTDCRACK_dly_1,
            EXTDCRDBUSIN => EXTDCRDBUSIN_dly_1,
            EICC405EXTINPUTIRQ => EICC405EXTINPUTIRQ_dly_1,
            EICC405CRITINPUTIRQ => EICC405CRITINPUTIRQ_dly_1,
            JTGC405BNDSCANTDO => JTGC405BNDSCANTDO_dly_1,
            JTGC405TCK => JTGC405TCK_dly_1,
            JTGC405TDI => JTGC405TDI_dly_1,
            JTGC405TMS => JTGC405TMS,
            JTGC405TRSTNEG => JTGC405TRSTNEG_dly_1,
            C405JTGTDO => C405JTGTDO_out,
            C405JTGTDOEN => C405JTGTDOEN_out,
            C405JTGEXTEST => C405JTGEXTEST_out,
            C405JTGCAPTUREDR => C405JTGCAPTUREDR_out,
            C405JTGSHIFTDR => C405JTGSHIFTDR_out,
            C405JTGUPDATEDR => C405JTGUPDATEDR_out,
            DBGC405DEBUGHALT => DBGC405DEBUGHALT_dly_1,
            DBGC405UNCONDDEBUGEVENT => DBGC405UNCONDDEBUGEVENT_dly_1,
            DBGC405EXTBUSHOLDACK => DBGC405EXTBUSHOLDACK_dly_1,
            C405DBGMSRWE => C405DBGMSRWE_out,
            C405DBGSTOPACK => C405DBGSTOPACK_out,
            C405DBGWBCOMPLETE => C405DBGWBCOMPLETE_out,
            C405DBGWBFULL => C405DBGWBFULL_out,
            C405DBGWBIAR => C405DBGWBIAR_out,
            C405TRCTRIGGEREVENTOUT => C405TRCTRIGGEREVENTOUT_out,
            C405TRCTRIGGEREVENTTYPE => C405TRCTRIGGEREVENTTYPE_out,
            C405TRCCYCLE => C405TRCCYCLE_out,
            C405TRCTRACESTATUS => C405TRCTRACESTATUS_out,
            TRCC405TRACEDISABLE => TRCC405TRACEDISABLE_dly_1,
            TRCC405TRIGGEREVENTIN => TRCC405TRIGGEREVENTIN_dly_1,
            C405DBGLOADDATAONAPUDBUS => C405DBGLOADDATAONAPUDBUS_out,
            APUFCMINSTRUCTION => APUFCMINSTRUCTION_out,
            APUFCMRADATA => APUFCMRADATA_out,
            APUFCMRBDATA => APUFCMRBDATA_out,
            APUFCMINSTRVALID => APUFCMINSTRVALID_out,
            APUFCMLOADDATA => APUFCMLOADDATA_out,
            APUFCMOPERANDVALID => APUFCMOPERANDVALID_out,
            APUFCMLOADDVALID => APUFCMLOADDVALID_out,
            APUFCMFLUSH => APUFCMFLUSH_out,
            APUFCMWRITEBACKOK => APUFCMWRITEBACKOK_out,
            APUFCMLOADBYTEEN => APUFCMLOADBYTEEN_out,
            APUFCMENDIAN => APUFCMENDIAN_out,
            APUFCMXERCA => APUFCMXERCA_out,
            APUFCMDECODED => APUFCMDECODED_out,
            APUFCMDECUDI => APUFCMDECUDI_out,
            APUFCMDECUDIVALID => APUFCMDECUDIVALID_out,
            FCMAPUDONE => FCMAPUDONE_dly_1,
            FCMAPURESULT => FCMAPURESULT_dly_1,
            FCMAPURESULTVALID => FCMAPURESULTVALID_dly_1,
            FCMAPUINSTRACK => FCMAPUINSTRACK_dly_1,
            FCMAPUEXCEPTION => FCMAPUEXCEPTION_dly_1,
            FCMAPUXERCA => FCMAPUXERCA_dly_1,
            FCMAPUXEROV => FCMAPUXEROV_dly_1,
            FCMAPUCR => FCMAPUCR_dly_1,
            FCMAPUDCDFPUOP => FCMAPUDCDFPUOP_dly_1,
            FCMAPUDCDGPRWRITE => FCMAPUDCDGPRWRITE_dly_1,
            FCMAPUDCDRAEN => FCMAPUDCDRAEN_dly_1,
            FCMAPUDCDRBEN => FCMAPUDCDRBEN_dly_1,
            FCMAPUDCDLOAD => FCMAPUDCDLOAD_dly_1,
            FCMAPUDCDSTORE => FCMAPUDCDSTORE_dly_1,
            FCMAPUDCDXERCAEN => FCMAPUDCDXERCAEN_dly_1,
            FCMAPUDCDXEROVEN => FCMAPUDCDXEROVEN_dly_1,
            FCMAPUDCDPRIVOP => FCMAPUDCDPRIVOP_dly_1,
            FCMAPUDCDCREN => FCMAPUDCDCREN_dly_1,
            FCMAPUEXECRFIELD => FCMAPUEXECRFIELD_dly_1,
            FCMAPUDCDUPDATE => FCMAPUDCDUPDATE_dly_1,
            FCMAPUDCDFORCEALIGN => FCMAPUDCDFORCEALIGN_dly_1,
            FCMAPUDCDFORCEBESTEERING => FCMAPUDCDFORCEBESTEERING_dly_1,
            FCMAPUDCDLDSTBYTE => FCMAPUDCDLDSTBYTE_dly_1,
            FCMAPUDCDLDSTHW => FCMAPUDCDLDSTHW_dly_1,
            FCMAPUDCDLDSTWD => FCMAPUDCDLDSTWD_dly_1,
            FCMAPUDCDLDSTDW => FCMAPUDCDLDSTDW_dly_1,
            FCMAPUDCDLDSTQW => FCMAPUDCDLDSTQW_dly_1,
            FCMAPUDCDTRAPBE => FCMAPUDCDTRAPBE_dly_1,
            FCMAPUDCDTRAPLE => FCMAPUDCDTRAPLE_dly_1,
            FCMAPUEXEBLOCKINGMCO => FCMAPUEXEBLOCKINGMCO_dly_1,
            FCMAPUEXENONBLOCKINGMCO => FCMAPUEXENONBLOCKINGMCO_dly_1,
            FCMAPUSLEEPNOTREADY => FCMAPUSLEEPNOTREADY_dly_1,
            FCMAPULOADWAIT => FCMAPULOADWAIT_dly_1,
            FCMAPUDECODEBUSY => FCMAPUDECODEBUSY_dly_1,
            TIEAPUCONTROL => TIEAPUCONTROL_dly_1,
            TIEAPUUDI1 => TIEAPUUDI1_dly_1,
            TIEAPUUDI2 => TIEAPUUDI2_dly_1,
            TIEAPUUDI3 => TIEAPUUDI3_dly_1,
            TIEAPUUDI4 => TIEAPUUDI4_dly_1,
            TIEAPUUDI5 => TIEAPUUDI5_dly_1,
            TIEAPUUDI6 => TIEAPUUDI6_dly_1,
            TIEAPUUDI7 => TIEAPUUDI7_dly_1,
            TIEAPUUDI8 => TIEAPUUDI8_dly_1

      );

start_blk : fpga_startup_virtex4
  port map (
    bus_reset => FPGA_BUS_RESET,
    ghigh_b => FPGA_GHIGHB,
    gsr => FPGA_GSR,
    gwe => FPGA_GWE,
    shutdown => FPGA_SHUTDOWN,
    
    cclk => FPGA_CCLK,
    por => FPGA_POR);

  GSR_OR <= FPGA_GSR or GSR;
  FPGA_POR <= '0' after 1000 ps;
  FPGA_CCLK <= NOT(FPGA_CCLK) after 5000 ps;                                       

        FPGA_BUS_RESET_delay <= FPGA_BUS_RESET after 10 ps ;
        GSR_delay <= GSR_OR after 10 ps;
        FPGA_GWE_delay <= FPGA_GWE after 10 ps;
        FPGA_GHIGHB_delay <= FPGA_GHIGHB after 10 ps;

       
   TIMING : process

--  Pin timing violations (clock input pins)

--  Pin Timing Violations (all input pins)
     variable Tviol_BRAMDSOCMRDDBUS0_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS0_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS1_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS1_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS2_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS2_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS3_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS3_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS4_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS4_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS5_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS5_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS6_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS6_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS7_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS7_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS8_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS8_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS9_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS9_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS10_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS10_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS11_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS11_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS12_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS12_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS13_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS13_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS14_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS14_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS15_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS15_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS16_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS16_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS17_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS17_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS18_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS18_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS19_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS19_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS20_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS20_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS21_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS21_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS22_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS22_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS23_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS23_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS24_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS24_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS25_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS25_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS26_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS26_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS27_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS27_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS28_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS28_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS29_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS29_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS30_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS30_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMDSOCMRDDBUS31_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMDSOCMRDDBUS31_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS0_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS0_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS1_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS1_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS2_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS2_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS3_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS3_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS4_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS4_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS5_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS5_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS6_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS6_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS7_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS7_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS8_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS8_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS9_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS9_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS10_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS10_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS11_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS11_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS12_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS12_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS13_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS13_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS14_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS14_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS15_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS15_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS16_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS16_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS17_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS17_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS18_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS18_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS19_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS19_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS20_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS20_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS21_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS21_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS22_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS22_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS23_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS23_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS24_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS24_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS25_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS25_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS26_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS26_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS27_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS27_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS28_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS28_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS29_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS29_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS30_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS30_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMDCRRDDBUS31_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMDCRRDDBUS31_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS0_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS0_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS1_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS1_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS2_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS2_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS3_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS3_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS4_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS4_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS5_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS5_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS6_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS6_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS7_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS7_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS8_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS8_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS9_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS9_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS10_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS10_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS11_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS11_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS12_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS12_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS13_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS13_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS14_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS14_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS15_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS15_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS16_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS16_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS17_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS17_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS18_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS18_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS19_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS19_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS20_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS20_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS21_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS21_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS22_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS22_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS23_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS23_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS24_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS24_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS25_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS25_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS26_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS26_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS27_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS27_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS28_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS28_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS29_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS29_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS30_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS30_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS31_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS31_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS32_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS32_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS33_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS33_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS34_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS34_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS35_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS35_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS36_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS36_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS37_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS37_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS38_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS38_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS39_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS39_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS40_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS40_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS41_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS41_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS42_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS42_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS43_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS43_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS44_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS44_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS45_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS45_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS46_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS46_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS47_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS47_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS48_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS48_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS49_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS49_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS50_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS50_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS51_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS51_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS52_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS52_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS53_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS53_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS54_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS54_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS55_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS55_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS56_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS56_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS57_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS57_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS58_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS58_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS59_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS59_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS60_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS60_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS61_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS61_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS62_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS62_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_BRAMISOCMRDDBUS63_BRAMISOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_BRAMISOCMRDDBUS63_BRAMISOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CPMC405CORECLKINACTIVE_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CPMC405CORECLKINACTIVE_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CPMC405CPUCLKEN_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CPMC405CPUCLKEN_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CPMC405JTAGCLKEN_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CPMC405JTAGCLKEN_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CPMC405TIMERCLKEN_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CPMC405TIMERCLKEN_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CPMC405TIMERTICK_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CPMC405TIMERTICK_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DBGC405DEBUGHALT_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DBGC405DEBUGHALT_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DBGC405EXTBUSHOLDACK_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DBGC405EXTBUSHOLDACK_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DBGC405UNCONDDEBUGEVENT_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DBGC405UNCONDDEBUGEVENT_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DSOCMRWCOMPLETE_BRAMDSOCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DSOCMRWCOMPLETE_BRAMDSOCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EICC405CRITINPUTIRQ_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EICC405CRITINPUTIRQ_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EICC405EXTINPUTIRQ_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EICC405EXTINPUTIRQ_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRACK_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRACK_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN0_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN0_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN1_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN1_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN2_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN2_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN3_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN3_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN4_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN4_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN5_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN5_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN6_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN6_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN7_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN7_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN8_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN8_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN9_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN9_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN10_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN10_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN11_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN11_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN12_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN12_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN13_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN13_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN14_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN14_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN15_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN15_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN16_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN16_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN17_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN17_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN18_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN18_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN19_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN19_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN20_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN20_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN21_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN21_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN22_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN22_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN23_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN23_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN24_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN24_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN25_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN25_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN26_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN26_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN27_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN27_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN28_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN28_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN29_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN29_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN30_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN30_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_EXTDCRDBUSIN31_CPMDCRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_EXTDCRDBUSIN31_CPMDCRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUCR0_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUCR0_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUCR1_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUCR1_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUCR2_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUCR2_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUCR3_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUCR3_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDCREN_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDCREN_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDFORCEALIGN_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDFORCEALIGN_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDFORCEBESTEERING_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDFORCEBESTEERING_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDFPUOP_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDFPUOP_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDGPRWRITE_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDGPRWRITE_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDLDSTBYTE_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDLDSTBYTE_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDLDSTDW_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDLDSTDW_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDLDSTHW_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDLDSTHW_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDLDSTQW_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDLDSTQW_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDLDSTWD_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDLDSTWD_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDLOAD_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDLOAD_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDPRIVOP_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDPRIVOP_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDRAEN_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDRAEN_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDRBEN_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDRBEN_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDSTORE_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDSTORE_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDTRAPBE_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDTRAPBE_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDTRAPLE_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDTRAPLE_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDUPDATE_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDUPDATE_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDXERCAEN_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDXERCAEN_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDCDXEROVEN_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDCDXEROVEN_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDECODEBUSY_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDECODEBUSY_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUDONE_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUDONE_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUEXCEPTION_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUEXCEPTION_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUEXEBLOCKINGMCO_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUEXEBLOCKINGMCO_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUEXECRFIELD0_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUEXECRFIELD0_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUEXECRFIELD1_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUEXECRFIELD1_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUEXECRFIELD2_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUEXECRFIELD2_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUEXENONBLOCKINGMCO_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUEXENONBLOCKINGMCO_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUINSTRACK_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUINSTRACK_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPULOADWAIT_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPULOADWAIT_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT0_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT0_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT1_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT1_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT2_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT2_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT3_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT3_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT4_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT4_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT5_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT5_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT6_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT6_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT7_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT7_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT8_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT8_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT9_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT9_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT10_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT10_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT11_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT11_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT12_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT12_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT13_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT13_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT14_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT14_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT15_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT15_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT16_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT16_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT17_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT17_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT18_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT18_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT19_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT19_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT20_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT20_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT21_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT21_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT22_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT22_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT23_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT23_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT24_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT24_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT25_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT25_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT26_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT26_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT27_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT27_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT28_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT28_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT29_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT29_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT30_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT30_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULT31_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULT31_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPURESULTVALID_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPURESULTVALID_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUSLEEPNOTREADY_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUSLEEPNOTREADY_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUXERCA_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUXERCA_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_FCMAPUXEROV_CPMFCMCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_FCMAPUXEROV_CPMFCMCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_JTGC405BNDSCANTDO_JTGC405TCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_JTGC405BNDSCANTDO_JTGC405TCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_JTGC405TDI_JTGC405TCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_JTGC405TDI_JTGC405TCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_JTGC405TMS_JTGC405TCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_JTGC405TMS_JTGC405TCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_JTGC405TRSTNEG_JTGC405TCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_JTGC405TRSTNEG_JTGC405TCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCUADDRACK_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCUADDRACK_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCUBUSY_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCUBUSY_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCUERR_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCUERR_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDACK_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDACK_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS0_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS0_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS1_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS1_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS2_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS2_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS3_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS3_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS4_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS4_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS5_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS5_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS6_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS6_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS7_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS7_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS8_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS8_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS9_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS9_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS10_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS10_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS11_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS11_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS12_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS12_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS13_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS13_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS14_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS14_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS15_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS15_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS16_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS16_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS17_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS17_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS18_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS18_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS19_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS19_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS20_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS20_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS21_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS21_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS22_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS22_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS23_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS23_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS24_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS24_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS25_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS25_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS26_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS26_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS27_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS27_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS28_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS28_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS29_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS29_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS30_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS30_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS31_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS31_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS32_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS32_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS33_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS33_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS34_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS34_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS35_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS35_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS36_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS36_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS37_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS37_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS38_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS38_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS39_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS39_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS40_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS40_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS41_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS41_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS42_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS42_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS43_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS43_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS44_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS44_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS45_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS45_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS46_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS46_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS47_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS47_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS48_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS48_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS49_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS49_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS50_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS50_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS51_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS51_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS52_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS52_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS53_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS53_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS54_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS54_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS55_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS55_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS56_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS56_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS57_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS57_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS58_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS58_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS59_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS59_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS60_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS60_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS61_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS61_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS62_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS62_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDDBUS63_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDDBUS63_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDWDADDR1_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDWDADDR1_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDWDADDR2_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDWDADDR2_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCURDWDADDR3_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCURDWDADDR3_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCUSSIZE1_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCUSSIZE1_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405DCUWRDACK_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405DCUWRDACK_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICUADDRACK_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICUADDRACK_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICUBUSY_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICUBUSY_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICUERR_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICUERR_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDACK_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDACK_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS0_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS0_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS1_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS1_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS2_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS2_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS3_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS3_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS4_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS4_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS5_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS5_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS6_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS6_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS7_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS7_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS8_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS8_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS9_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS9_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS10_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS10_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS11_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS11_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS12_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS12_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS13_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS13_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS14_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS14_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS15_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS15_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS16_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS16_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS17_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS17_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS18_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS18_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS19_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS19_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS20_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS20_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS21_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS21_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS22_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS22_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS23_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS23_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS24_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS24_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS25_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS25_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS26_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS26_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS27_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS27_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS28_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS28_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS29_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS29_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS30_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS30_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS31_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS31_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS32_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS32_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS33_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS33_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS34_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS34_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS35_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS35_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS36_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS36_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS37_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS37_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS38_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS38_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS39_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS39_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS40_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS40_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS41_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS41_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS42_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS42_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS43_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS43_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS44_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS44_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS45_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS45_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS46_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS46_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS47_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS47_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS48_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS48_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS49_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS49_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS50_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS50_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS51_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS51_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS52_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS52_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS53_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS53_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS54_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS54_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS55_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS55_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS56_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS56_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS57_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS57_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS58_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS58_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS59_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS59_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS60_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS60_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS61_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS61_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS62_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS62_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDDBUS63_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDDBUS63_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDWDADDR1_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDWDADDR1_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDWDADDR2_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDWDADDR2_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICURDWDADDR3_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICURDWDADDR3_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PLBC405ICUSSIZE1_PLBCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PLBC405ICUSSIZE1_PLBCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RSTC405RESETCHIP_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RSTC405RESETCHIP_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RSTC405RESETCORE_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RSTC405RESETCORE_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RSTC405RESETSYS_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RSTC405RESETSYS_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TRCC405TRACEDISABLE_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TRCC405TRACEDISABLE_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TRCC405TRIGGEREVENTIN_CPMC405CLOCK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TRCC405TRIGGEREVENTIN_CPMC405CLOCK_posedge : VitalTimingDataType := VitalTimingDataInit;

     variable Pviol_CPMC405CLOCK: STD_ULOGIC := '0';
     variable PInfo_CPMC405CLOCK: VitalPeriodDataType := VitalPeriodDataInit;          

--  Output Pin glitch declaration
     variable  APUFCMDECODED_GlitchData : VitalGlitchDataType;
     variable  APUFCMDECUDI0_GlitchData : VitalGlitchDataType;
     variable  APUFCMDECUDI1_GlitchData : VitalGlitchDataType;
     variable  APUFCMDECUDI2_GlitchData : VitalGlitchDataType;
     variable  APUFCMDECUDIVALID_GlitchData : VitalGlitchDataType;
     variable  APUFCMENDIAN_GlitchData : VitalGlitchDataType;
     variable  APUFCMFLUSH_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION0_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION1_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION2_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION3_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION4_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION5_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION6_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION7_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION8_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION9_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION10_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION11_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION12_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION13_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION14_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION15_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION16_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION17_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION18_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION19_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION20_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION21_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION22_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION23_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION24_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION25_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION26_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION27_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION28_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION29_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION30_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRUCTION31_GlitchData : VitalGlitchDataType;
     variable  APUFCMINSTRVALID_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADBYTEEN0_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADBYTEEN1_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADBYTEEN2_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADBYTEEN3_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA0_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA1_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA2_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA3_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA4_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA5_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA6_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA7_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA8_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA9_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA10_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA11_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA12_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA13_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA14_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA15_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA16_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA17_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA18_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA19_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA20_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA21_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA22_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA23_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA24_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA25_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA26_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA27_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA28_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA29_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA30_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDATA31_GlitchData : VitalGlitchDataType;
     variable  APUFCMLOADDVALID_GlitchData : VitalGlitchDataType;
     variable  APUFCMOPERANDVALID_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA0_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA1_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA2_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA3_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA4_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA5_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA6_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA7_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA8_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA9_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA10_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA11_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA12_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA13_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA14_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA15_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA16_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA17_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA18_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA19_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA20_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA21_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA22_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA23_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA24_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA25_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA26_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA27_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA28_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA29_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA30_GlitchData : VitalGlitchDataType;
     variable  APUFCMRADATA31_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA0_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA1_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA2_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA3_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA4_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA5_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA6_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA7_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA8_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA9_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA10_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA11_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA12_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA13_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA14_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA15_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA16_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA17_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA18_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA19_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA20_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA21_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA22_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA23_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA24_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA25_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA26_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA27_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA28_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA29_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA30_GlitchData : VitalGlitchDataType;
     variable  APUFCMRBDATA31_GlitchData : VitalGlitchDataType;
     variable  APUFCMWRITEBACKOK_GlitchData : VitalGlitchDataType;
     variable  APUFCMXERCA_GlitchData : VitalGlitchDataType;
     variable  C405CPMCORESLEEPREQ_GlitchData : VitalGlitchDataType;
     variable  C405CPMMSRCE_GlitchData : VitalGlitchDataType;
     variable  C405CPMMSREE_GlitchData : VitalGlitchDataType;
     variable  C405CPMTIMERIRQ_GlitchData : VitalGlitchDataType;
     variable  C405CPMTIMERRESETREQ_GlitchData : VitalGlitchDataType;
     variable  C405DBGLOADDATAONAPUDBUS_GlitchData : VitalGlitchDataType;
     variable  C405DBGMSRWE_GlitchData : VitalGlitchDataType;
     variable  C405DBGSTOPACK_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBCOMPLETE_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBFULL_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR0_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR1_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR2_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR3_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR4_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR5_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR6_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR7_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR8_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR9_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR10_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR11_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR12_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR13_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR14_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR15_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR16_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR17_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR18_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR19_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR20_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR21_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR22_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR23_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR24_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR25_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR26_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR27_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR28_GlitchData : VitalGlitchDataType;
     variable  C405DBGWBIAR29_GlitchData : VitalGlitchDataType;
     variable  C405JTGCAPTUREDR_GlitchData : VitalGlitchDataType;
     variable  C405JTGEXTEST_GlitchData : VitalGlitchDataType;
     variable  C405JTGPGMOUT_GlitchData : VitalGlitchDataType;
     variable  C405JTGSHIFTDR_GlitchData : VitalGlitchDataType;
     variable  C405JTGTDO_GlitchData : VitalGlitchDataType;
     variable  C405JTGTDOEN_GlitchData : VitalGlitchDataType;
     variable  C405JTGUPDATEDR_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABORT_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS0_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS1_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS2_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS3_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS4_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS5_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS6_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS7_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS8_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS9_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS10_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS11_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS12_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS13_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS14_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS15_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS16_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS17_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS18_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS19_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS20_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS21_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS22_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS23_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS24_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS25_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS26_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS27_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS28_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS29_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS30_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUABUS31_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUBE0_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUBE1_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUBE2_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUBE3_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUBE4_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUBE5_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUBE6_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUBE7_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUCACHEABLE_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUGUARDED_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUPRIORITY0_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUPRIORITY1_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUREQUEST_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCURNW_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUSIZE2_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUU0ATTR_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS0_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS1_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS2_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS3_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS4_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS5_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS6_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS7_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS8_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS9_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS10_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS11_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS12_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS13_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS14_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS15_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS16_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS17_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS18_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS19_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS20_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS21_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS22_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS23_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS24_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS25_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS26_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS27_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS28_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS29_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS30_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS31_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS32_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS33_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS34_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS35_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS36_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS37_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS38_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS39_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS40_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS41_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS42_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS43_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS44_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS45_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS46_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS47_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS48_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS49_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS50_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS51_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS52_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS53_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS54_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS55_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS56_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS57_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS58_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS59_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS60_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS61_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS62_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRDBUS63_GlitchData : VitalGlitchDataType;
     variable  C405PLBDCUWRITETHRU_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABORT_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS0_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS1_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS2_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS3_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS4_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS5_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS6_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS7_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS8_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS9_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS10_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS11_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS12_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS13_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS14_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS15_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS16_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS17_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS18_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS19_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS20_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS21_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS22_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS23_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS24_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS25_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS26_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS27_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS28_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUABUS29_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUCACHEABLE_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUPRIORITY0_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUPRIORITY1_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUREQUEST_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUSIZE2_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUSIZE3_GlitchData : VitalGlitchDataType;
     variable  C405PLBICUU0ATTR_GlitchData : VitalGlitchDataType;
     variable  C405RSTCHIPRESETREQ_GlitchData : VitalGlitchDataType;
     variable  C405RSTCORERESETREQ_GlitchData : VitalGlitchDataType;
     variable  C405RSTSYSRESETREQ_GlitchData : VitalGlitchDataType;
     variable  C405TRCCYCLE_GlitchData : VitalGlitchDataType;
     variable  C405TRCEVENEXECUTIONSTATUS0_GlitchData : VitalGlitchDataType;
     variable  C405TRCEVENEXECUTIONSTATUS1_GlitchData : VitalGlitchDataType;
     variable  C405TRCODDEXECUTIONSTATUS0_GlitchData : VitalGlitchDataType;
     variable  C405TRCODDEXECUTIONSTATUS1_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRACESTATUS0_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRACESTATUS1_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRACESTATUS2_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRACESTATUS3_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRIGGEREVENTOUT_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRIGGEREVENTTYPE0_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRIGGEREVENTTYPE1_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRIGGEREVENTTYPE2_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRIGGEREVENTTYPE3_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRIGGEREVENTTYPE4_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRIGGEREVENTTYPE5_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRIGGEREVENTTYPE6_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRIGGEREVENTTYPE7_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRIGGEREVENTTYPE8_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRIGGEREVENTTYPE9_GlitchData : VitalGlitchDataType;
     variable  C405TRCTRIGGEREVENTTYPE10_GlitchData : VitalGlitchDataType;
     variable  C405XXXMACHINECHECK_GlitchData : VitalGlitchDataType;
     variable  DCREMACENABLER_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS8_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS9_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS10_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS11_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS12_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS13_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS14_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS15_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS16_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS17_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS18_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS19_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS20_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS21_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS22_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS23_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS24_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS25_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS26_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS27_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS28_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMABUS29_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMBYTEWRITE0_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMBYTEWRITE1_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMBYTEWRITE2_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMBYTEWRITE3_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMEN_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS0_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS1_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS2_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS3_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS4_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS5_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS6_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS7_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS8_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS9_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS10_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS11_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS12_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS13_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS14_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS15_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS16_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS17_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS18_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS19_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS20_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS21_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS22_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS23_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS24_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS25_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS26_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS27_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS28_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS29_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS30_GlitchData : VitalGlitchDataType;
     variable  DSOCMBRAMWRDBUS31_GlitchData : VitalGlitchDataType;
     variable  DSOCMBUSY_GlitchData : VitalGlitchDataType;
     variable  DSOCMRDADDRVALID_GlitchData : VitalGlitchDataType;
     variable  DSOCMWRADDRVALID_GlitchData : VitalGlitchDataType;
     variable  EXTDCRABUS0_GlitchData : VitalGlitchDataType;
     variable  EXTDCRABUS1_GlitchData : VitalGlitchDataType;
     variable  EXTDCRABUS2_GlitchData : VitalGlitchDataType;
     variable  EXTDCRABUS3_GlitchData : VitalGlitchDataType;
     variable  EXTDCRABUS4_GlitchData : VitalGlitchDataType;
     variable  EXTDCRABUS5_GlitchData : VitalGlitchDataType;
     variable  EXTDCRABUS6_GlitchData : VitalGlitchDataType;
     variable  EXTDCRABUS7_GlitchData : VitalGlitchDataType;
     variable  EXTDCRABUS8_GlitchData : VitalGlitchDataType;
     variable  EXTDCRABUS9_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT0_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT1_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT2_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT3_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT4_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT5_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT6_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT7_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT8_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT9_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT10_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT11_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT12_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT13_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT14_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT15_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT16_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT17_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT18_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT19_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT20_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT21_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT22_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT23_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT24_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT25_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT26_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT27_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT28_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT29_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT30_GlitchData : VitalGlitchDataType;
     variable  EXTDCRDBUSOUT31_GlitchData : VitalGlitchDataType;
     variable  EXTDCRREAD_GlitchData : VitalGlitchDataType;
     variable  EXTDCRWRITE_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMEN_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMEVENWRITEEN_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMODDWRITEEN_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS8_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS9_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS10_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS11_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS12_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS13_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS14_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS15_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS16_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS17_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS18_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS19_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS20_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS21_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS22_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS23_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS24_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS25_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS26_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS27_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMRDABUS28_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS8_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS9_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS10_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS11_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS12_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS13_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS14_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS15_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS16_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS17_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS18_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS19_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS20_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS21_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS22_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS23_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS24_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS25_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS26_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS27_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRABUS28_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS0_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS1_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS2_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS3_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS4_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS5_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS6_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS7_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS8_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS9_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS10_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS11_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS12_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS13_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS14_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS15_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS16_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS17_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS18_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS19_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS20_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS21_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS22_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS23_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS24_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS25_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS26_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS27_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS28_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS29_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS30_GlitchData : VitalGlitchDataType;
     variable  ISOCMBRAMWRDBUS31_GlitchData : VitalGlitchDataType;
     variable  ISOCMDCRBRAMEVENEN_GlitchData : VitalGlitchDataType;
     variable  ISOCMDCRBRAMODDEN_GlitchData : VitalGlitchDataType;
     variable  ISOCMDCRBRAMRDSELECT_GlitchData : VitalGlitchDataType;
     variable  DCREMACWRITE_GlitchData : VitalGlitchDataType;
     variable  DCREMACREAD_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS0_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS1_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS2_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS3_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS4_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS5_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS6_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS7_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS8_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS9_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS10_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS11_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS12_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS13_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS14_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS15_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS16_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS17_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS18_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS19_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS20_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS21_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS22_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS23_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS24_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS25_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS26_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS27_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS28_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS29_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS30_GlitchData : VitalGlitchDataType;
     variable  DCREMACDBUS31_GlitchData : VitalGlitchDataType;
     variable  DCREMACABUS8_GlitchData : VitalGlitchDataType;
     variable  DCREMACABUS9_GlitchData : VitalGlitchDataType;
     variable  DCREMACCLK_GlitchData : VitalGlitchDataType;

begin
--  Setup/Hold Check Violations (all input pins)

     if (TimingChecksOn) then
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS0_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS0_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(0),
         TestSignalName => "BRAMDSOCMRDDBUS(0)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(0),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(0),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(0),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(0),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS1_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS1_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(1),
         TestSignalName => "BRAMDSOCMRDDBUS(1)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(1),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(1),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(1),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(1),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS2_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS2_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(2),
         TestSignalName => "BRAMDSOCMRDDBUS(2)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(2),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(2),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(2),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(2),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS3_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS3_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(3),
         TestSignalName => "BRAMDSOCMRDDBUS(3)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(3),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(3),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(3),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(3),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS4_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS4_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(4),
         TestSignalName => "BRAMDSOCMRDDBUS(4)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(4),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(4),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(4),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(4),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS5_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS5_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(5),
         TestSignalName => "BRAMDSOCMRDDBUS(5)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(5),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(5),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(5),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(5),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS6_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS6_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(6),
         TestSignalName => "BRAMDSOCMRDDBUS(6)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(6),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(6),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(6),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(6),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS7_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS7_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(7),
         TestSignalName => "BRAMDSOCMRDDBUS(7)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(7),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(7),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(7),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(7),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS8_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS8_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(8),
         TestSignalName => "BRAMDSOCMRDDBUS(8)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(8),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(8),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(8),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(8),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS9_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS9_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(9),
         TestSignalName => "BRAMDSOCMRDDBUS(9)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(9),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(9),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(9),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(9),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS10_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS10_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(10),
         TestSignalName => "BRAMDSOCMRDDBUS(10)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(10),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(10),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(10),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(10),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS11_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS11_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(11),
         TestSignalName => "BRAMDSOCMRDDBUS(11)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(11),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(11),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(11),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(11),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS12_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS12_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(12),
         TestSignalName => "BRAMDSOCMRDDBUS(12)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(12),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(12),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(12),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(12),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS13_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS13_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(13),
         TestSignalName => "BRAMDSOCMRDDBUS(13)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(13),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(13),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(13),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(13),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS14_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS14_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(14),
         TestSignalName => "BRAMDSOCMRDDBUS(14)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(14),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(14),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(14),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(14),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS15_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS15_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(15),
         TestSignalName => "BRAMDSOCMRDDBUS(15)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(15),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(15),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(15),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(15),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS16_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS16_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(16),
         TestSignalName => "BRAMDSOCMRDDBUS(16)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(16),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(16),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(16),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(16),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(16),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS17_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS17_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(17),
         TestSignalName => "BRAMDSOCMRDDBUS(17)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(17),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(17),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(17),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(17),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(17),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS18_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS18_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(18),
         TestSignalName => "BRAMDSOCMRDDBUS(18)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(18),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(18),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(18),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(18),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(18),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS19_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS19_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(19),
         TestSignalName => "BRAMDSOCMRDDBUS(19)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(19),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(19),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(19),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(19),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(19),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS20_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS20_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(20),
         TestSignalName => "BRAMDSOCMRDDBUS(20)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(20),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(20),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(20),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(20),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(20),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS21_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS21_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(21),
         TestSignalName => "BRAMDSOCMRDDBUS(21)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(21),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(21),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(21),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(21),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(21),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS22_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS22_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(22),
         TestSignalName => "BRAMDSOCMRDDBUS(22)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(22),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(22),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(22),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(22),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(22),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS23_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS23_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(23),
         TestSignalName => "BRAMDSOCMRDDBUS(23)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(23),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(23),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(23),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(23),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(23),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS24_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS24_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(24),
         TestSignalName => "BRAMDSOCMRDDBUS(24)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(24),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(24),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(24),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(24),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(24),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS25_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS25_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(25),
         TestSignalName => "BRAMDSOCMRDDBUS(25)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(25),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(25),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(25),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(25),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(25),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS26_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS26_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(26),
         TestSignalName => "BRAMDSOCMRDDBUS(26)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(26),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(26),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(26),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(26),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(26),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS27_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS27_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(27),
         TestSignalName => "BRAMDSOCMRDDBUS(27)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(27),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(27),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(27),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(27),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(27),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS28_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS28_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(28),
         TestSignalName => "BRAMDSOCMRDDBUS(28)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(28),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(28),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(28),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(28),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(28),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS29_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS29_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(29),
         TestSignalName => "BRAMDSOCMRDDBUS(29)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(29),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(29),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(29),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(29),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(29),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS30_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS30_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(30),
         TestSignalName => "BRAMDSOCMRDDBUS(30)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(30),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(30),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(30),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(30),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(30),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMDSOCMRDDBUS31_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_BRAMDSOCMRDDBUS31_BRAMDSOCMCLK_posedge,
         TestSignal     => BRAMDSOCMRDDBUS_dly_1(31),
         TestSignalName => "BRAMDSOCMRDDBUS(31)",
         TestDelay      => tisd_BRAMDSOCMRDDBUS(31),
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => ticd_BRAMDSOCMCLK,
         SetupHigh      => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(31),
         SetupLow       => tsetup_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(31),
         HoldLow        => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_posedge_posedge(31),
         HoldHigh       => thold_BRAMDSOCMRDDBUS_BRAMDSOCMCLK_negedge_posedge(31),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS0_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS0_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(0),
         TestSignalName => "BRAMISOCMDCRRDDBUS(0)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(0),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(0),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(0),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(0),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS1_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS1_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(1),
         TestSignalName => "BRAMISOCMDCRRDDBUS(1)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(1),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(1),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(1),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(1),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS2_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS2_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(2),
         TestSignalName => "BRAMISOCMDCRRDDBUS(2)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(2),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(2),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(2),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(2),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS3_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS3_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(3),
         TestSignalName => "BRAMISOCMDCRRDDBUS(3)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(3),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(3),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(3),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(3),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS4_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS4_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(4),
         TestSignalName => "BRAMISOCMDCRRDDBUS(4)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(4),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(4),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(4),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(4),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS5_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS5_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(5),
         TestSignalName => "BRAMISOCMDCRRDDBUS(5)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(5),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(5),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(5),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(5),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS6_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS6_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(6),
         TestSignalName => "BRAMISOCMDCRRDDBUS(6)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(6),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(6),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(6),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(6),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS7_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS7_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(7),
         TestSignalName => "BRAMISOCMDCRRDDBUS(7)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(7),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(7),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(7),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(7),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS8_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS8_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(8),
         TestSignalName => "BRAMISOCMDCRRDDBUS(8)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(8),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(8),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(8),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(8),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS9_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS9_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(9),
         TestSignalName => "BRAMISOCMDCRRDDBUS(9)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(9),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(9),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(9),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(9),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS10_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS10_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(10),
         TestSignalName => "BRAMISOCMDCRRDDBUS(10)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(10),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(10),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(10),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(10),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS11_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS11_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(11),
         TestSignalName => "BRAMISOCMDCRRDDBUS(11)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(11),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(11),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(11),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(11),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS12_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS12_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(12),
         TestSignalName => "BRAMISOCMDCRRDDBUS(12)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(12),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(12),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(12),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(12),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS13_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS13_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(13),
         TestSignalName => "BRAMISOCMDCRRDDBUS(13)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(13),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(13),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(13),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(13),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS14_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS14_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(14),
         TestSignalName => "BRAMISOCMDCRRDDBUS(14)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(14),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(14),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(14),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(14),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS15_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS15_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(15),
         TestSignalName => "BRAMISOCMDCRRDDBUS(15)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(15),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(15),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(15),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(15),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS16_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS16_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(16),
         TestSignalName => "BRAMISOCMDCRRDDBUS(16)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(16),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(16),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(16),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(16),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(16),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS17_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS17_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(17),
         TestSignalName => "BRAMISOCMDCRRDDBUS(17)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(17),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(17),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(17),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(17),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(17),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS18_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS18_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(18),
         TestSignalName => "BRAMISOCMDCRRDDBUS(18)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(18),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(18),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(18),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(18),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(18),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS19_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS19_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(19),
         TestSignalName => "BRAMISOCMDCRRDDBUS(19)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(19),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(19),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(19),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(19),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(19),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS20_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS20_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(20),
         TestSignalName => "BRAMISOCMDCRRDDBUS(20)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(20),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(20),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(20),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(20),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(20),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS21_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS21_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(21),
         TestSignalName => "BRAMISOCMDCRRDDBUS(21)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(21),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(21),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(21),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(21),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(21),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS22_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS22_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(22),
         TestSignalName => "BRAMISOCMDCRRDDBUS(22)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(22),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(22),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(22),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(22),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(22),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS23_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS23_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(23),
         TestSignalName => "BRAMISOCMDCRRDDBUS(23)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(23),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(23),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(23),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(23),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(23),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS24_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS24_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(24),
         TestSignalName => "BRAMISOCMDCRRDDBUS(24)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(24),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(24),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(24),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(24),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(24),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS25_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS25_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(25),
         TestSignalName => "BRAMISOCMDCRRDDBUS(25)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(25),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(25),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(25),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(25),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(25),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS26_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS26_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(26),
         TestSignalName => "BRAMISOCMDCRRDDBUS(26)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(26),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(26),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(26),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(26),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(26),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS27_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS27_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(27),
         TestSignalName => "BRAMISOCMDCRRDDBUS(27)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(27),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(27),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(27),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(27),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(27),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS28_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS28_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(28),
         TestSignalName => "BRAMISOCMDCRRDDBUS(28)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(28),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(28),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(28),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(28),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(28),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS29_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS29_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(29),
         TestSignalName => "BRAMISOCMDCRRDDBUS(29)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(29),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(29),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(29),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(29),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(29),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS30_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS30_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(30),
         TestSignalName => "BRAMISOCMDCRRDDBUS(30)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(30),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(30),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(30),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(30),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(30),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMDCRRDDBUS31_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMDCRRDDBUS31_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMDCRRDDBUS_dly_1(31),
         TestSignalName => "BRAMISOCMDCRRDDBUS(31)",
         TestDelay      => tisd_BRAMISOCMDCRRDDBUS(31),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(31),
         SetupLow       => tsetup_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(31),
         HoldLow        => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_posedge_posedge(31),
         HoldHigh       => thold_BRAMISOCMDCRRDDBUS_BRAMISOCMCLK_negedge_posedge(31),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS0_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS0_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(0),
         TestSignalName => "BRAMISOCMRDDBUS(0)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(0),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(0),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(0),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(0),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS1_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS1_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(1),
         TestSignalName => "BRAMISOCMRDDBUS(1)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(1),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(1),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(1),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(1),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS2_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS2_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(2),
         TestSignalName => "BRAMISOCMRDDBUS(2)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(2),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(2),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(2),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(2),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS3_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS3_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(3),
         TestSignalName => "BRAMISOCMRDDBUS(3)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(3),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(3),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(3),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(3),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS4_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS4_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(4),
         TestSignalName => "BRAMISOCMRDDBUS(4)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(4),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(4),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(4),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(4),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS5_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS5_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(5),
         TestSignalName => "BRAMISOCMRDDBUS(5)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(5),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(5),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(5),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(5),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS6_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS6_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(6),
         TestSignalName => "BRAMISOCMRDDBUS(6)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(6),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(6),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(6),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(6),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS7_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS7_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(7),
         TestSignalName => "BRAMISOCMRDDBUS(7)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(7),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(7),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(7),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(7),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS8_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS8_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(8),
         TestSignalName => "BRAMISOCMRDDBUS(8)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(8),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(8),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(8),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(8),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS9_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS9_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(9),
         TestSignalName => "BRAMISOCMRDDBUS(9)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(9),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(9),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(9),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(9),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS10_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS10_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(10),
         TestSignalName => "BRAMISOCMRDDBUS(10)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(10),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(10),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(10),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(10),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS11_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS11_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(11),
         TestSignalName => "BRAMISOCMRDDBUS(11)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(11),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(11),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(11),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(11),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS12_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS12_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(12),
         TestSignalName => "BRAMISOCMRDDBUS(12)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(12),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(12),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(12),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(12),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS13_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS13_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(13),
         TestSignalName => "BRAMISOCMRDDBUS(13)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(13),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(13),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(13),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(13),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS14_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS14_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(14),
         TestSignalName => "BRAMISOCMRDDBUS(14)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(14),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(14),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(14),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(14),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS15_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS15_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(15),
         TestSignalName => "BRAMISOCMRDDBUS(15)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(15),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(15),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(15),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(15),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS16_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS16_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(16),
         TestSignalName => "BRAMISOCMRDDBUS(16)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(16),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(16),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(16),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(16),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(16),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS17_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS17_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(17),
         TestSignalName => "BRAMISOCMRDDBUS(17)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(17),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(17),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(17),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(17),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(17),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS18_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS18_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(18),
         TestSignalName => "BRAMISOCMRDDBUS(18)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(18),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(18),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(18),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(18),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(18),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS19_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS19_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(19),
         TestSignalName => "BRAMISOCMRDDBUS(19)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(19),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(19),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(19),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(19),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(19),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS20_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS20_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(20),
         TestSignalName => "BRAMISOCMRDDBUS(20)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(20),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(20),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(20),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(20),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(20),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS21_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS21_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(21),
         TestSignalName => "BRAMISOCMRDDBUS(21)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(21),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(21),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(21),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(21),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(21),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS22_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS22_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(22),
         TestSignalName => "BRAMISOCMRDDBUS(22)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(22),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(22),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(22),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(22),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(22),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS23_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS23_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(23),
         TestSignalName => "BRAMISOCMRDDBUS(23)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(23),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(23),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(23),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(23),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(23),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS24_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS24_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(24),
         TestSignalName => "BRAMISOCMRDDBUS(24)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(24),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(24),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(24),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(24),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(24),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS25_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS25_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(25),
         TestSignalName => "BRAMISOCMRDDBUS(25)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(25),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(25),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(25),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(25),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(25),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS26_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS26_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(26),
         TestSignalName => "BRAMISOCMRDDBUS(26)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(26),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(26),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(26),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(26),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(26),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS27_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS27_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(27),
         TestSignalName => "BRAMISOCMRDDBUS(27)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(27),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(27),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(27),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(27),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(27),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS28_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS28_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(28),
         TestSignalName => "BRAMISOCMRDDBUS(28)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(28),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(28),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(28),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(28),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(28),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS29_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS29_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(29),
         TestSignalName => "BRAMISOCMRDDBUS(29)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(29),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(29),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(29),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(29),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(29),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS30_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS30_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(30),
         TestSignalName => "BRAMISOCMRDDBUS(30)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(30),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(30),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(30),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(30),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(30),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS31_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS31_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(31),
         TestSignalName => "BRAMISOCMRDDBUS(31)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(31),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(31),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(31),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(31),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(31),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS32_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS32_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(32),
         TestSignalName => "BRAMISOCMRDDBUS(32)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(32),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(32),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(32),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(32),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(32),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS33_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS33_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(33),
         TestSignalName => "BRAMISOCMRDDBUS(33)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(33),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(33),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(33),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(33),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(33),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS34_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS34_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(34),
         TestSignalName => "BRAMISOCMRDDBUS(34)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(34),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(34),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(34),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(34),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(34),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS35_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS35_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(35),
         TestSignalName => "BRAMISOCMRDDBUS(35)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(35),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(35),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(35),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(35),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(35),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS36_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS36_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(36),
         TestSignalName => "BRAMISOCMRDDBUS(36)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(36),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(36),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(36),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(36),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(36),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS37_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS37_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(37),
         TestSignalName => "BRAMISOCMRDDBUS(37)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(37),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(37),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(37),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(37),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(37),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS38_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS38_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(38),
         TestSignalName => "BRAMISOCMRDDBUS(38)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(38),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(38),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(38),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(38),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(38),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS39_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS39_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(39),
         TestSignalName => "BRAMISOCMRDDBUS(39)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(39),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(39),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(39),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(39),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(39),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS40_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS40_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(40),
         TestSignalName => "BRAMISOCMRDDBUS(40)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(40),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(40),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(40),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(40),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(40),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS41_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS41_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(41),
         TestSignalName => "BRAMISOCMRDDBUS(41)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(41),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(41),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(41),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(41),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(41),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS42_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS42_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(42),
         TestSignalName => "BRAMISOCMRDDBUS(42)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(42),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(42),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(42),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(42),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(42),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS43_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS43_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(43),
         TestSignalName => "BRAMISOCMRDDBUS(43)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(43),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(43),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(43),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(43),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(43),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS44_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS44_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(44),
         TestSignalName => "BRAMISOCMRDDBUS(44)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(44),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(44),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(44),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(44),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(44),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS45_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS45_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(45),
         TestSignalName => "BRAMISOCMRDDBUS(45)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(45),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(45),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(45),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(45),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(45),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS46_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS46_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(46),
         TestSignalName => "BRAMISOCMRDDBUS(46)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(46),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(46),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(46),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(46),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(46),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS47_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS47_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(47),
         TestSignalName => "BRAMISOCMRDDBUS(47)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(47),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(47),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(47),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(47),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(47),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS48_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS48_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(48),
         TestSignalName => "BRAMISOCMRDDBUS(48)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(48),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(48),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(48),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(48),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(48),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS49_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS49_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(49),
         TestSignalName => "BRAMISOCMRDDBUS(49)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(49),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(49),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(49),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(49),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(49),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS50_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS50_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(50),
         TestSignalName => "BRAMISOCMRDDBUS(50)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(50),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(50),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(50),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(50),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(50),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS51_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS51_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(51),
         TestSignalName => "BRAMISOCMRDDBUS(51)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(51),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(51),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(51),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(51),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(51),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS52_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS52_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(52),
         TestSignalName => "BRAMISOCMRDDBUS(52)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(52),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(52),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(52),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(52),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(52),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS53_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS53_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(53),
         TestSignalName => "BRAMISOCMRDDBUS(53)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(53),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(53),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(53),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(53),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(53),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS54_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS54_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(54),
         TestSignalName => "BRAMISOCMRDDBUS(54)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(54),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(54),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(54),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(54),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(54),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS55_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS55_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(55),
         TestSignalName => "BRAMISOCMRDDBUS(55)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(55),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(55),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(55),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(55),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(55),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS56_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS56_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(56),
         TestSignalName => "BRAMISOCMRDDBUS(56)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(56),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(56),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(56),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(56),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(56),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS57_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS57_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(57),
         TestSignalName => "BRAMISOCMRDDBUS(57)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(57),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(57),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(57),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(57),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(57),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS58_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS58_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(58),
         TestSignalName => "BRAMISOCMRDDBUS(58)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(58),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(58),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(58),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(58),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(58),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS59_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS59_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(59),
         TestSignalName => "BRAMISOCMRDDBUS(59)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(59),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(59),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(59),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(59),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(59),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS60_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS60_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(60),
         TestSignalName => "BRAMISOCMRDDBUS(60)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(60),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(60),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(60),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(60),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(60),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS61_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS61_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(61),
         TestSignalName => "BRAMISOCMRDDBUS(61)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(61),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(61),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(61),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(61),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(61),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS62_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS62_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(62),
         TestSignalName => "BRAMISOCMRDDBUS(62)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(62),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(62),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(62),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(62),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(62),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_BRAMISOCMRDDBUS63_BRAMISOCMCLK_posedge,
         TimingData     => Tmkr_BRAMISOCMRDDBUS63_BRAMISOCMCLK_posedge,
         TestSignal     => BRAMISOCMRDDBUS_dly_1(63),
         TestSignalName => "BRAMISOCMRDDBUS(63)",
         TestDelay      => tisd_BRAMISOCMRDDBUS(63),
         RefSignal      => BRAMISOCMCLK_dly_1,
         RefSignalName  => "BRAMISOCMCLK",
         RefDelay       => ticd_BRAMISOCMCLK,
         SetupHigh      => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(63),
         SetupLow       => tsetup_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(63),
         HoldLow        => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_posedge_posedge(63),
         HoldHigh       => thold_BRAMISOCMRDDBUS_BRAMISOCMCLK_negedge_posedge(63),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CPMC405CORECLKINACTIVE_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_CPMC405CORECLKINACTIVE_CPMC405CLOCK_posedge,
         TestSignal     => CPMC405CORECLKINACTIVE,
         TestSignalName => "CPMC405CORECLKINACTIVE",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CPMC405CORECLKINACTIVE_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_CPMC405CORECLKINACTIVE_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_CPMC405CORECLKINACTIVE_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_CPMC405CORECLKINACTIVE_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CPMC405CPUCLKEN_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_CPMC405CPUCLKEN_CPMC405CLOCK_posedge,
         TestSignal     => CPMC405CPUCLKEN,
         TestSignalName => "CPMC405CPUCLKEN",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CPMC405CPUCLKEN_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_CPMC405CPUCLKEN_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_CPMC405CPUCLKEN_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_CPMC405CPUCLKEN_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CPMC405JTAGCLKEN_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_CPMC405JTAGCLKEN_CPMC405CLOCK_posedge,
         TestSignal     => CPMC405JTAGCLKEN,
         TestSignalName => "CPMC405JTAGCLKEN",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CPMC405JTAGCLKEN_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_CPMC405JTAGCLKEN_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_CPMC405JTAGCLKEN_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_CPMC405JTAGCLKEN_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CPMC405TIMERCLKEN_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_CPMC405TIMERCLKEN_CPMC405CLOCK_posedge,
         TestSignal     => CPMC405TIMERCLKEN,
         TestSignalName => "CPMC405TIMERCLKEN",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CPMC405TIMERCLKEN_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_CPMC405TIMERCLKEN_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_CPMC405TIMERCLKEN_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_CPMC405TIMERCLKEN_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CPMC405TIMERTICK_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_CPMC405TIMERTICK_CPMC405CLOCK_posedge,
         TestSignal     => CPMC405TIMERTICK,
         TestSignalName => "CPMC405TIMERTICK",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CPMC405TIMERTICK_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_CPMC405TIMERTICK_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_CPMC405TIMERTICK_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_CPMC405TIMERTICK_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DBGC405DEBUGHALT_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_DBGC405DEBUGHALT_CPMC405CLOCK_posedge,
         TestSignal     => DBGC405DEBUGHALT,
         TestSignalName => "DBGC405DEBUGHALT",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DBGC405DEBUGHALT_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_DBGC405DEBUGHALT_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_DBGC405DEBUGHALT_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_DBGC405DEBUGHALT_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DBGC405EXTBUSHOLDACK_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_DBGC405EXTBUSHOLDACK_CPMC405CLOCK_posedge,
         TestSignal     => DBGC405EXTBUSHOLDACK,
         TestSignalName => "DBGC405EXTBUSHOLDACK",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DBGC405EXTBUSHOLDACK_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_DBGC405EXTBUSHOLDACK_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_DBGC405EXTBUSHOLDACK_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_DBGC405EXTBUSHOLDACK_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DBGC405UNCONDDEBUGEVENT_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_DBGC405UNCONDDEBUGEVENT_CPMC405CLOCK_posedge,
         TestSignal     => DBGC405UNCONDDEBUGEVENT,
         TestSignalName => "DBGC405UNCONDDEBUGEVENT",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DBGC405UNCONDDEBUGEVENT_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_DBGC405UNCONDDEBUGEVENT_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_DBGC405UNCONDDEBUGEVENT_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_DBGC405UNCONDDEBUGEVENT_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DSOCMRWCOMPLETE_BRAMDSOCMCLK_posedge,
         TimingData     => Tmkr_DSOCMRWCOMPLETE_BRAMDSOCMCLK_posedge,
         TestSignal     => DSOCMRWCOMPLETE,
         TestSignalName => "DSOCMRWCOMPLETE",
         TestDelay      => 0 ns,
         RefSignal      => BRAMDSOCMCLK_dly_1,
         RefSignalName  => "BRAMDSOCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DSOCMRWCOMPLETE_BRAMDSOCMCLK_posedge_posedge,
         SetupLow       => tsetup_DSOCMRWCOMPLETE_BRAMDSOCMCLK_negedge_posedge,
         HoldLow        => thold_DSOCMRWCOMPLETE_BRAMDSOCMCLK_posedge_posedge,
         HoldHigh       => thold_DSOCMRWCOMPLETE_BRAMDSOCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EICC405CRITINPUTIRQ_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_EICC405CRITINPUTIRQ_CPMC405CLOCK_posedge,
         TestSignal     => EICC405CRITINPUTIRQ,
         TestSignalName => "EICC405CRITINPUTIRQ",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_EICC405CRITINPUTIRQ_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_EICC405CRITINPUTIRQ_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_EICC405CRITINPUTIRQ_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_EICC405CRITINPUTIRQ_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EICC405EXTINPUTIRQ_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_EICC405EXTINPUTIRQ_CPMC405CLOCK_posedge,
         TestSignal     => EICC405EXTINPUTIRQ,
         TestSignalName => "EICC405EXTINPUTIRQ",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_EICC405EXTINPUTIRQ_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_EICC405EXTINPUTIRQ_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_EICC405EXTINPUTIRQ_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_EICC405EXTINPUTIRQ_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRACK_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRACK_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRACK,
         TestSignalName => "EXTDCRACK",
         TestDelay      => 0 ns,
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_EXTDCRACK_CPMDCRCLK_posedge_posedge,
         SetupLow       => tsetup_EXTDCRACK_CPMDCRCLK_negedge_posedge,
         HoldLow        => thold_EXTDCRACK_CPMDCRCLK_posedge_posedge,
         HoldHigh       => thold_EXTDCRACK_CPMDCRCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN0_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN0_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(0),
         TestSignalName => "EXTDCRDBUSIN(0)",
         TestDelay      => tisd_EXTDCRDBUSIN(0),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(0),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(0),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(0),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN1_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN1_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(1),
         TestSignalName => "EXTDCRDBUSIN(1)",
         TestDelay      => tisd_EXTDCRDBUSIN(1),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(1),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(1),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(1),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN2_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN2_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(2),
         TestSignalName => "EXTDCRDBUSIN(2)",
         TestDelay      => tisd_EXTDCRDBUSIN(2),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(2),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(2),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(2),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN3_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN3_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(3),
         TestSignalName => "EXTDCRDBUSIN(3)",
         TestDelay      => tisd_EXTDCRDBUSIN(3),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(3),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(3),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(3),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN4_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN4_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(4),
         TestSignalName => "EXTDCRDBUSIN(4)",
         TestDelay      => tisd_EXTDCRDBUSIN(4),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(4),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(4),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(4),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN5_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN5_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(5),
         TestSignalName => "EXTDCRDBUSIN(5)",
         TestDelay      => tisd_EXTDCRDBUSIN(5),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(5),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(5),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(5),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN6_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN6_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(6),
         TestSignalName => "EXTDCRDBUSIN(6)",
         TestDelay      => tisd_EXTDCRDBUSIN(6),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(6),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(6),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(6),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN7_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN7_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(7),
         TestSignalName => "EXTDCRDBUSIN(7)",
         TestDelay      => tisd_EXTDCRDBUSIN(7),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(7),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(7),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(7),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN8_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN8_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(8),
         TestSignalName => "EXTDCRDBUSIN(8)",
         TestDelay      => tisd_EXTDCRDBUSIN(8),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(8),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(8),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(8),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN9_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN9_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(9),
         TestSignalName => "EXTDCRDBUSIN(9)",
         TestDelay      => tisd_EXTDCRDBUSIN(9),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(9),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(9),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(9),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN10_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN10_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(10),
         TestSignalName => "EXTDCRDBUSIN(10)",
         TestDelay      => tisd_EXTDCRDBUSIN(10),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(10),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(10),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(10),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN11_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN11_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(11),
         TestSignalName => "EXTDCRDBUSIN(11)",
         TestDelay      => tisd_EXTDCRDBUSIN(11),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(11),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(11),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(11),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN12_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN12_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(12),
         TestSignalName => "EXTDCRDBUSIN(12)",
         TestDelay      => tisd_EXTDCRDBUSIN(12),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(12),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(12),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(12),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN13_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN13_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(13),
         TestSignalName => "EXTDCRDBUSIN(13)",
         TestDelay      => tisd_EXTDCRDBUSIN(13),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(13),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(13),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(13),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN14_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN14_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(14),
         TestSignalName => "EXTDCRDBUSIN(14)",
         TestDelay      => tisd_EXTDCRDBUSIN(14),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(14),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(14),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(14),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN15_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN15_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(15),
         TestSignalName => "EXTDCRDBUSIN(15)",
         TestDelay      => tisd_EXTDCRDBUSIN(15),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(15),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(15),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(15),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN16_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN16_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(16),
         TestSignalName => "EXTDCRDBUSIN(16)",
         TestDelay      => tisd_EXTDCRDBUSIN(16),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(16),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(16),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(16),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(16),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN17_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN17_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(17),
         TestSignalName => "EXTDCRDBUSIN(17)",
         TestDelay      => tisd_EXTDCRDBUSIN(17),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(17),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(17),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(17),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(17),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN18_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN18_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(18),
         TestSignalName => "EXTDCRDBUSIN(18)",
         TestDelay      => tisd_EXTDCRDBUSIN(18),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(18),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(18),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(18),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(18),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN19_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN19_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(19),
         TestSignalName => "EXTDCRDBUSIN(19)",
         TestDelay      => tisd_EXTDCRDBUSIN(19),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(19),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(19),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(19),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(19),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN20_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN20_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(20),
         TestSignalName => "EXTDCRDBUSIN(20)",
         TestDelay      => tisd_EXTDCRDBUSIN(20),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(20),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(20),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(20),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(20),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN21_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN21_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(21),
         TestSignalName => "EXTDCRDBUSIN(21)",
         TestDelay      => tisd_EXTDCRDBUSIN(21),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(21),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(21),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(21),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(21),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN22_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN22_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(22),
         TestSignalName => "EXTDCRDBUSIN(22)",
         TestDelay      => tisd_EXTDCRDBUSIN(22),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(22),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(22),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(22),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(22),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN23_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN23_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(23),
         TestSignalName => "EXTDCRDBUSIN(23)",
         TestDelay      => tisd_EXTDCRDBUSIN(23),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(23),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(23),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(23),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(23),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN24_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN24_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(24),
         TestSignalName => "EXTDCRDBUSIN(24)",
         TestDelay      => tisd_EXTDCRDBUSIN(24),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(24),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(24),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(24),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(24),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN25_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN25_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(25),
         TestSignalName => "EXTDCRDBUSIN(25)",
         TestDelay      => tisd_EXTDCRDBUSIN(25),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(25),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(25),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(25),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(25),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN26_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN26_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(26),
         TestSignalName => "EXTDCRDBUSIN(26)",
         TestDelay      => tisd_EXTDCRDBUSIN(26),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(26),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(26),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(26),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(26),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN27_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN27_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(27),
         TestSignalName => "EXTDCRDBUSIN(27)",
         TestDelay      => tisd_EXTDCRDBUSIN(27),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(27),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(27),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(27),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(27),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN28_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN28_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(28),
         TestSignalName => "EXTDCRDBUSIN(28)",
         TestDelay      => tisd_EXTDCRDBUSIN(28),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(28),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(28),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(28),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(28),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN29_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN29_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(29),
         TestSignalName => "EXTDCRDBUSIN(29)",
         TestDelay      => tisd_EXTDCRDBUSIN(29),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(29),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(29),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(29),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(29),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN30_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN30_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(30),
         TestSignalName => "EXTDCRDBUSIN(30)",
         TestDelay      => tisd_EXTDCRDBUSIN(30),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(30),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(30),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(30),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(30),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_EXTDCRDBUSIN31_CPMDCRCLK_posedge,
         TimingData     => Tmkr_EXTDCRDBUSIN31_CPMDCRCLK_posedge,
         TestSignal     => EXTDCRDBUSIN_dly_1(31),
         TestSignalName => "EXTDCRDBUSIN(31)",
         TestDelay      => tisd_EXTDCRDBUSIN(31),
         RefSignal      => CPMDCRCLK_dly_1,
         RefSignalName  => "CPMDCRCLK",
         RefDelay       => ticd_CPMDCRCLK,
         SetupHigh      => tsetup_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(31),
         SetupLow       => tsetup_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(31),
         HoldLow        => thold_EXTDCRDBUSIN_CPMDCRCLK_posedge_posedge(31),
         HoldHigh       => thold_EXTDCRDBUSIN_CPMDCRCLK_negedge_posedge(31),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUCR0_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUCR0_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUCR_dly_1(0),
         TestSignalName => "FCMAPUCR(0)",
         TestDelay      => tisd_FCMAPUCR(0),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPUCR_CPMFCMCLK_posedge_posedge(0),
         SetupLow       => tsetup_FCMAPUCR_CPMFCMCLK_negedge_posedge(0),
         HoldLow        => thold_FCMAPUCR_CPMFCMCLK_posedge_posedge(0),
         HoldHigh       => thold_FCMAPUCR_CPMFCMCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUCR1_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUCR1_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUCR_dly_1(1),
         TestSignalName => "FCMAPUCR(1)",
         TestDelay      => tisd_FCMAPUCR(1),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPUCR_CPMFCMCLK_posedge_posedge(1),
         SetupLow       => tsetup_FCMAPUCR_CPMFCMCLK_negedge_posedge(1),
         HoldLow        => thold_FCMAPUCR_CPMFCMCLK_posedge_posedge(1),
         HoldHigh       => thold_FCMAPUCR_CPMFCMCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUCR2_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUCR2_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUCR_dly_1(2),
         TestSignalName => "FCMAPUCR(2)",
         TestDelay      => tisd_FCMAPUCR(2),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPUCR_CPMFCMCLK_posedge_posedge(2),
         SetupLow       => tsetup_FCMAPUCR_CPMFCMCLK_negedge_posedge(2),
         HoldLow        => thold_FCMAPUCR_CPMFCMCLK_posedge_posedge(2),
         HoldHigh       => thold_FCMAPUCR_CPMFCMCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUCR3_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUCR3_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUCR_dly_1(3),
         TestSignalName => "FCMAPUCR(3)",
         TestDelay      => tisd_FCMAPUCR(3),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPUCR_CPMFCMCLK_posedge_posedge(3),
         SetupLow       => tsetup_FCMAPUCR_CPMFCMCLK_negedge_posedge(3),
         HoldLow        => thold_FCMAPUCR_CPMFCMCLK_posedge_posedge(3),
         HoldHigh       => thold_FCMAPUCR_CPMFCMCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDCREN_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDCREN_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDCREN,
         TestSignalName => "FCMAPUDCDCREN",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDCREN_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDCREN_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDCREN_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDCREN_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDFORCEALIGN_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDFORCEALIGN_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDFORCEALIGN,
         TestSignalName => "FCMAPUDCDFORCEALIGN",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDFORCEALIGN_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDFORCEALIGN_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDFORCEALIGN_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDFORCEALIGN_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDFORCEBESTEERING_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDFORCEBESTEERING_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDFORCEBESTEERING,
         TestSignalName => "FCMAPUDCDFORCEBESTEERING",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDFORCEBESTEERING_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDFORCEBESTEERING_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDFORCEBESTEERING_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDFORCEBESTEERING_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDFPUOP_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDFPUOP_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDFPUOP,
         TestSignalName => "FCMAPUDCDFPUOP",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDFPUOP_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDFPUOP_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDFPUOP_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDFPUOP_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDGPRWRITE_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDGPRWRITE_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDGPRWRITE,
         TestSignalName => "FCMAPUDCDGPRWRITE",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDGPRWRITE_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDGPRWRITE_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDGPRWRITE_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDGPRWRITE_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDLDSTBYTE_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDLDSTBYTE_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDLDSTBYTE,
         TestSignalName => "FCMAPUDCDLDSTBYTE",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDLDSTBYTE_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDLDSTBYTE_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDLDSTBYTE_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDLDSTBYTE_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDLDSTDW_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDLDSTDW_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDLDSTDW,
         TestSignalName => "FCMAPUDCDLDSTDW",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDLDSTDW_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDLDSTDW_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDLDSTDW_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDLDSTDW_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDLDSTHW_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDLDSTHW_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDLDSTHW,
         TestSignalName => "FCMAPUDCDLDSTHW",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDLDSTHW_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDLDSTHW_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDLDSTHW_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDLDSTHW_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDLDSTQW_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDLDSTQW_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDLDSTQW,
         TestSignalName => "FCMAPUDCDLDSTQW",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDLDSTQW_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDLDSTQW_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDLDSTQW_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDLDSTQW_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDLDSTWD_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDLDSTWD_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDLDSTWD,
         TestSignalName => "FCMAPUDCDLDSTWD",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDLDSTWD_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDLDSTWD_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDLDSTWD_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDLDSTWD_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDLOAD_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDLOAD_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDLOAD,
         TestSignalName => "FCMAPUDCDLOAD",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDLOAD_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDLOAD_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDLOAD_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDLOAD_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDPRIVOP_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDPRIVOP_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDPRIVOP,
         TestSignalName => "FCMAPUDCDPRIVOP",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDPRIVOP_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDPRIVOP_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDPRIVOP_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDPRIVOP_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDRAEN_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDRAEN_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDRAEN,
         TestSignalName => "FCMAPUDCDRAEN",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDRAEN_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDRAEN_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDRAEN_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDRAEN_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDRBEN_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDRBEN_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDRBEN,
         TestSignalName => "FCMAPUDCDRBEN",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDRBEN_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDRBEN_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDRBEN_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDRBEN_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDSTORE_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDSTORE_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDSTORE,
         TestSignalName => "FCMAPUDCDSTORE",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDSTORE_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDSTORE_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDSTORE_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDSTORE_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDTRAPBE_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDTRAPBE_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDTRAPBE,
         TestSignalName => "FCMAPUDCDTRAPBE",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDTRAPBE_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDTRAPBE_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDTRAPBE_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDTRAPBE_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDTRAPLE_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDTRAPLE_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDTRAPLE,
         TestSignalName => "FCMAPUDCDTRAPLE",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDTRAPLE_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDTRAPLE_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDTRAPLE_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDTRAPLE_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDUPDATE_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDUPDATE_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDUPDATE,
         TestSignalName => "FCMAPUDCDUPDATE",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDUPDATE_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDUPDATE_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDUPDATE_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDUPDATE_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDXERCAEN_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDXERCAEN_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDXERCAEN,
         TestSignalName => "FCMAPUDCDXERCAEN",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDXERCAEN_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDXERCAEN_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDXERCAEN_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDXERCAEN_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDCDXEROVEN_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDCDXEROVEN_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDCDXEROVEN,
         TestSignalName => "FCMAPUDCDXEROVEN",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDCDXEROVEN_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDCDXEROVEN_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDCDXEROVEN_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDCDXEROVEN_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDECODEBUSY_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDECODEBUSY_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDECODEBUSY,
         TestSignalName => "FCMAPUDECODEBUSY",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDECODEBUSY_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDECODEBUSY_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDECODEBUSY_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDECODEBUSY_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUDONE_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUDONE_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUDONE,
         TestSignalName => "FCMAPUDONE",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUDONE_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUDONE_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUDONE_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUDONE_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUEXCEPTION_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUEXCEPTION_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUEXCEPTION,
         TestSignalName => "FCMAPUEXCEPTION",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUEXCEPTION_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUEXCEPTION_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUEXCEPTION_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUEXCEPTION_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUEXEBLOCKINGMCO_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUEXEBLOCKINGMCO_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUEXEBLOCKINGMCO,
         TestSignalName => "FCMAPUEXEBLOCKINGMCO",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUEXEBLOCKINGMCO_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUEXEBLOCKINGMCO_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUEXEBLOCKINGMCO_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUEXEBLOCKINGMCO_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUEXECRFIELD0_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUEXECRFIELD0_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUEXECRFIELD_dly_1(0),
         TestSignalName => "FCMAPUEXECRFIELD(0)",
         TestDelay      => tisd_FCMAPUEXECRFIELD(0),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPUEXECRFIELD_CPMFCMCLK_posedge_posedge(0),
         SetupLow       => tsetup_FCMAPUEXECRFIELD_CPMFCMCLK_negedge_posedge(0),
         HoldLow        => thold_FCMAPUEXECRFIELD_CPMFCMCLK_posedge_posedge(0),
         HoldHigh       => thold_FCMAPUEXECRFIELD_CPMFCMCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUEXECRFIELD1_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUEXECRFIELD1_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUEXECRFIELD_dly_1(1),
         TestSignalName => "FCMAPUEXECRFIELD(1)",
         TestDelay      => tisd_FCMAPUEXECRFIELD(1),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPUEXECRFIELD_CPMFCMCLK_posedge_posedge(1),
         SetupLow       => tsetup_FCMAPUEXECRFIELD_CPMFCMCLK_negedge_posedge(1),
         HoldLow        => thold_FCMAPUEXECRFIELD_CPMFCMCLK_posedge_posedge(1),
         HoldHigh       => thold_FCMAPUEXECRFIELD_CPMFCMCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUEXECRFIELD2_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUEXECRFIELD2_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUEXECRFIELD_dly_1(2),
         TestSignalName => "FCMAPUEXECRFIELD(2)",
         TestDelay      => tisd_FCMAPUEXECRFIELD(2),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPUEXECRFIELD_CPMFCMCLK_posedge_posedge(2),
         SetupLow       => tsetup_FCMAPUEXECRFIELD_CPMFCMCLK_negedge_posedge(2),
         HoldLow        => thold_FCMAPUEXECRFIELD_CPMFCMCLK_posedge_posedge(2),
         HoldHigh       => thold_FCMAPUEXECRFIELD_CPMFCMCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUEXENONBLOCKINGMCO_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUEXENONBLOCKINGMCO_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUEXENONBLOCKINGMCO,
         TestSignalName => "FCMAPUEXENONBLOCKINGMCO",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUEXENONBLOCKINGMCO_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUEXENONBLOCKINGMCO_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUEXENONBLOCKINGMCO_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUEXENONBLOCKINGMCO_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUINSTRACK_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUINSTRACK_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUINSTRACK,
         TestSignalName => "FCMAPUINSTRACK",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUINSTRACK_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUINSTRACK_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUINSTRACK_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUINSTRACK_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPULOADWAIT_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPULOADWAIT_CPMFCMCLK_posedge,
         TestSignal     => FCMAPULOADWAIT,
         TestSignalName => "FCMAPULOADWAIT",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPULOADWAIT_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPULOADWAIT_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPULOADWAIT_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPULOADWAIT_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT0_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT0_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(0),
         TestSignalName => "FCMAPURESULT(0)",
         TestDelay      => tisd_FCMAPURESULT(0),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(0),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(0),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(0),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT1_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT1_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(1),
         TestSignalName => "FCMAPURESULT(1)",
         TestDelay      => tisd_FCMAPURESULT(1),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(1),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(1),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(1),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT2_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT2_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(2),
         TestSignalName => "FCMAPURESULT(2)",
         TestDelay      => tisd_FCMAPURESULT(2),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(2),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(2),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(2),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT3_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT3_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(3),
         TestSignalName => "FCMAPURESULT(3)",
         TestDelay      => tisd_FCMAPURESULT(3),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(3),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(3),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(3),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT4_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT4_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(4),
         TestSignalName => "FCMAPURESULT(4)",
         TestDelay      => tisd_FCMAPURESULT(4),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(4),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(4),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(4),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT5_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT5_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(5),
         TestSignalName => "FCMAPURESULT(5)",
         TestDelay      => tisd_FCMAPURESULT(5),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(5),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(5),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(5),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT6_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT6_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(6),
         TestSignalName => "FCMAPURESULT(6)",
         TestDelay      => tisd_FCMAPURESULT(6),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(6),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(6),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(6),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT7_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT7_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(7),
         TestSignalName => "FCMAPURESULT(7)",
         TestDelay      => tisd_FCMAPURESULT(7),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(7),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(7),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(7),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT8_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT8_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(8),
         TestSignalName => "FCMAPURESULT(8)",
         TestDelay      => tisd_FCMAPURESULT(8),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(8),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(8),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(8),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT9_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT9_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(9),
         TestSignalName => "FCMAPURESULT(9)",
         TestDelay      => tisd_FCMAPURESULT(9),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(9),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(9),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(9),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT10_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT10_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(10),
         TestSignalName => "FCMAPURESULT(10)",
         TestDelay      => tisd_FCMAPURESULT(10),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(10),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(10),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(10),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT11_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT11_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(11),
         TestSignalName => "FCMAPURESULT(11)",
         TestDelay      => tisd_FCMAPURESULT(11),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(11),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(11),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(11),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT12_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT12_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(12),
         TestSignalName => "FCMAPURESULT(12)",
         TestDelay      => tisd_FCMAPURESULT(12),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(12),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(12),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(12),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT13_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT13_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(13),
         TestSignalName => "FCMAPURESULT(13)",
         TestDelay      => tisd_FCMAPURESULT(13),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(13),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(13),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(13),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT14_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT14_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(14),
         TestSignalName => "FCMAPURESULT(14)",
         TestDelay      => tisd_FCMAPURESULT(14),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(14),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(14),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(14),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT15_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT15_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(15),
         TestSignalName => "FCMAPURESULT(15)",
         TestDelay      => tisd_FCMAPURESULT(15),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(15),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(15),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(15),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT16_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT16_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(16),
         TestSignalName => "FCMAPURESULT(16)",
         TestDelay      => tisd_FCMAPURESULT(16),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(16),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(16),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(16),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(16),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT17_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT17_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(17),
         TestSignalName => "FCMAPURESULT(17)",
         TestDelay      => tisd_FCMAPURESULT(17),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(17),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(17),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(17),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(17),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT18_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT18_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(18),
         TestSignalName => "FCMAPURESULT(18)",
         TestDelay      => tisd_FCMAPURESULT(18),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(18),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(18),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(18),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(18),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT19_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT19_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(19),
         TestSignalName => "FCMAPURESULT(19)",
         TestDelay      => tisd_FCMAPURESULT(19),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(19),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(19),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(19),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(19),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT20_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT20_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(20),
         TestSignalName => "FCMAPURESULT(20)",
         TestDelay      => tisd_FCMAPURESULT(20),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(20),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(20),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(20),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(20),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT21_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT21_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(21),
         TestSignalName => "FCMAPURESULT(21)",
         TestDelay      => tisd_FCMAPURESULT(21),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(21),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(21),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(21),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(21),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT22_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT22_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(22),
         TestSignalName => "FCMAPURESULT(22)",
         TestDelay      => tisd_FCMAPURESULT(22),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(22),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(22),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(22),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(22),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT23_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT23_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(23),
         TestSignalName => "FCMAPURESULT(23)",
         TestDelay      => tisd_FCMAPURESULT(23),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(23),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(23),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(23),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(23),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT24_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT24_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(24),
         TestSignalName => "FCMAPURESULT(24)",
         TestDelay      => tisd_FCMAPURESULT(24),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(24),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(24),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(24),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(24),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT25_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT25_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(25),
         TestSignalName => "FCMAPURESULT(25)",
         TestDelay      => tisd_FCMAPURESULT(25),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(25),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(25),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(25),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(25),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT26_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT26_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(26),
         TestSignalName => "FCMAPURESULT(26)",
         TestDelay      => tisd_FCMAPURESULT(26),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(26),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(26),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(26),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(26),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT27_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT27_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(27),
         TestSignalName => "FCMAPURESULT(27)",
         TestDelay      => tisd_FCMAPURESULT(27),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(27),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(27),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(27),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(27),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT28_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT28_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(28),
         TestSignalName => "FCMAPURESULT(28)",
         TestDelay      => tisd_FCMAPURESULT(28),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(28),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(28),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(28),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(28),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT29_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT29_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(29),
         TestSignalName => "FCMAPURESULT(29)",
         TestDelay      => tisd_FCMAPURESULT(29),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(29),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(29),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(29),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(29),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT30_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT30_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(30),
         TestSignalName => "FCMAPURESULT(30)",
         TestDelay      => tisd_FCMAPURESULT(30),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(30),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(30),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(30),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(30),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULT31_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULT31_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULT_dly_1(31),
         TestSignalName => "FCMAPURESULT(31)",
         TestDelay      => tisd_FCMAPURESULT(31),
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => ticd_CPMFCMCLK,
         SetupHigh      => tsetup_FCMAPURESULT_CPMFCMCLK_posedge_posedge(31),
         SetupLow       => tsetup_FCMAPURESULT_CPMFCMCLK_negedge_posedge(31),
         HoldLow        => thold_FCMAPURESULT_CPMFCMCLK_posedge_posedge(31),
         HoldHigh       => thold_FCMAPURESULT_CPMFCMCLK_negedge_posedge(31),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPURESULTVALID_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPURESULTVALID_CPMFCMCLK_posedge,
         TestSignal     => FCMAPURESULTVALID,
         TestSignalName => "FCMAPURESULTVALID",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPURESULTVALID_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPURESULTVALID_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPURESULTVALID_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPURESULTVALID_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUSLEEPNOTREADY_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUSLEEPNOTREADY_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUSLEEPNOTREADY,
         TestSignalName => "FCMAPUSLEEPNOTREADY",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUSLEEPNOTREADY_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUSLEEPNOTREADY_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUSLEEPNOTREADY_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUSLEEPNOTREADY_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUXERCA_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUXERCA_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUXERCA,
         TestSignalName => "FCMAPUXERCA",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUXERCA_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUXERCA_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUXERCA_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUXERCA_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_FCMAPUXEROV_CPMFCMCLK_posedge,
         TimingData     => Tmkr_FCMAPUXEROV_CPMFCMCLK_posedge,
         TestSignal     => FCMAPUXEROV,
         TestSignalName => "FCMAPUXEROV",
         TestDelay      => 0 ns,
         RefSignal      => CPMFCMCLK_dly_1,
         RefSignalName  => "CPMFCMCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_FCMAPUXEROV_CPMFCMCLK_posedge_posedge,
         SetupLow       => tsetup_FCMAPUXEROV_CPMFCMCLK_negedge_posedge,
         HoldLow        => thold_FCMAPUXEROV_CPMFCMCLK_posedge_posedge,
         HoldHigh       => thold_FCMAPUXEROV_CPMFCMCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_JTGC405BNDSCANTDO_JTGC405TCK_posedge,
         TimingData     => Tmkr_JTGC405BNDSCANTDO_JTGC405TCK_posedge,
         TestSignal     => JTGC405BNDSCANTDO,
         TestSignalName => "JTGC405BNDSCANTDO",
         TestDelay      => 0 ns,
         RefSignal      => JTGC405TCK_dly_1,
         RefSignalName  => "JTGC405TCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_JTGC405BNDSCANTDO_JTGC405TCK_posedge_posedge,
         SetupLow       => tsetup_JTGC405BNDSCANTDO_JTGC405TCK_negedge_posedge,
         HoldLow        => thold_JTGC405BNDSCANTDO_JTGC405TCK_posedge_posedge,
         HoldHigh       => thold_JTGC405BNDSCANTDO_JTGC405TCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_JTGC405TDI_JTGC405TCK_posedge,
         TimingData     => Tmkr_JTGC405TDI_JTGC405TCK_posedge,
         TestSignal     => JTGC405TDI,
         TestSignalName => "JTGC405TDI",
         TestDelay      => 0 ns,
         RefSignal      => JTGC405TCK_dly_1,
         RefSignalName  => "JTGC405TCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_JTGC405TDI_JTGC405TCK_posedge_posedge,
         SetupLow       => tsetup_JTGC405TDI_JTGC405TCK_negedge_posedge,
         HoldLow        => thold_JTGC405TDI_JTGC405TCK_posedge_posedge,
         HoldHigh       => thold_JTGC405TDI_JTGC405TCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_JTGC405TMS_JTGC405TCK_posedge,
         TimingData     => Tmkr_JTGC405TMS_JTGC405TCK_posedge,
         TestSignal     => JTGC405TMS,
         TestSignalName => "JTGC405TMS",
         TestDelay      => 0 ns,
         RefSignal      => JTGC405TCK_dly_1,
         RefSignalName  => "JTGC405TCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_JTGC405TMS_JTGC405TCK_posedge_posedge,
         SetupLow       => tsetup_JTGC405TMS_JTGC405TCK_negedge_posedge,
         HoldLow        => thold_JTGC405TMS_JTGC405TCK_posedge_posedge,
         HoldHigh       => thold_JTGC405TMS_JTGC405TCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_JTGC405TRSTNEG_JTGC405TCK_posedge,
         TimingData     => Tmkr_JTGC405TRSTNEG_JTGC405TCK_posedge,
         TestSignal     => JTGC405TRSTNEG,
         TestSignalName => "JTGC405TRSTNEG",
         TestDelay      => 0 ns,
         RefSignal      => JTGC405TCK_dly_1,
         RefSignalName  => "JTGC405TCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_JTGC405TRSTNEG_JTGC405TCK_posedge_posedge,
         SetupLow       => tsetup_JTGC405TRSTNEG_JTGC405TCK_negedge_posedge,
         HoldLow        => thold_JTGC405TRSTNEG_JTGC405TCK_posedge_posedge,
         HoldHigh       => thold_JTGC405TRSTNEG_JTGC405TCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCUADDRACK_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCUADDRACK_PLBCLK_posedge,
         TestSignal     => PLBC405DCUADDRACK,
         TestSignalName => "PLBC405DCUADDRACK",
         TestDelay      => 0 ns,
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PLBC405DCUADDRACK_PLBCLK_posedge_posedge,
         SetupLow       => tsetup_PLBC405DCUADDRACK_PLBCLK_negedge_posedge,
         HoldLow        => thold_PLBC405DCUADDRACK_PLBCLK_posedge_posedge,
         HoldHigh       => thold_PLBC405DCUADDRACK_PLBCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCUBUSY_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCUBUSY_PLBCLK_posedge,
         TestSignal     => PLBC405DCUBUSY,
         TestSignalName => "PLBC405DCUBUSY",
         TestDelay      => 0 ns,
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PLBC405DCUBUSY_PLBCLK_posedge_posedge,
         SetupLow       => tsetup_PLBC405DCUBUSY_PLBCLK_negedge_posedge,
         HoldLow        => thold_PLBC405DCUBUSY_PLBCLK_posedge_posedge,
         HoldHigh       => thold_PLBC405DCUBUSY_PLBCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCUERR_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCUERR_PLBCLK_posedge,
         TestSignal     => PLBC405DCUERR,
         TestSignalName => "PLBC405DCUERR",
         TestDelay      => 0 ns,
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PLBC405DCUERR_PLBCLK_posedge_posedge,
         SetupLow       => tsetup_PLBC405DCUERR_PLBCLK_negedge_posedge,
         HoldLow        => thold_PLBC405DCUERR_PLBCLK_posedge_posedge,
         HoldHigh       => thold_PLBC405DCUERR_PLBCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDACK_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDACK_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDACK,
         TestSignalName => "PLBC405DCURDDACK",
         TestDelay      => 0 ns,
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PLBC405DCURDDACK_PLBCLK_posedge_posedge,
         SetupLow       => tsetup_PLBC405DCURDDACK_PLBCLK_negedge_posedge,
         HoldLow        => thold_PLBC405DCURDDACK_PLBCLK_posedge_posedge,
         HoldHigh       => thold_PLBC405DCURDDACK_PLBCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS0_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS0_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(0),
         TestSignalName => "PLBC405DCURDDBUS(0)",
         TestDelay      => tisd_PLBC405DCURDDBUS(0),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(0),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(0),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(0),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS1_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS1_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(1),
         TestSignalName => "PLBC405DCURDDBUS(1)",
         TestDelay      => tisd_PLBC405DCURDDBUS(1),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(1),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(1),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(1),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS2_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS2_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(2),
         TestSignalName => "PLBC405DCURDDBUS(2)",
         TestDelay      => tisd_PLBC405DCURDDBUS(2),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(2),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(2),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(2),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS3_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS3_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(3),
         TestSignalName => "PLBC405DCURDDBUS(3)",
         TestDelay      => tisd_PLBC405DCURDDBUS(3),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(3),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(3),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(3),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS4_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS4_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(4),
         TestSignalName => "PLBC405DCURDDBUS(4)",
         TestDelay      => tisd_PLBC405DCURDDBUS(4),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(4),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(4),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(4),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS5_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS5_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(5),
         TestSignalName => "PLBC405DCURDDBUS(5)",
         TestDelay      => tisd_PLBC405DCURDDBUS(5),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(5),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(5),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(5),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS6_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS6_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(6),
         TestSignalName => "PLBC405DCURDDBUS(6)",
         TestDelay      => tisd_PLBC405DCURDDBUS(6),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(6),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(6),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(6),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS7_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS7_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(7),
         TestSignalName => "PLBC405DCURDDBUS(7)",
         TestDelay      => tisd_PLBC405DCURDDBUS(7),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(7),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(7),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(7),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS8_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS8_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(8),
         TestSignalName => "PLBC405DCURDDBUS(8)",
         TestDelay      => tisd_PLBC405DCURDDBUS(8),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(8),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(8),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(8),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS9_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS9_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(9),
         TestSignalName => "PLBC405DCURDDBUS(9)",
         TestDelay      => tisd_PLBC405DCURDDBUS(9),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(9),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(9),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(9),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS10_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS10_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(10),
         TestSignalName => "PLBC405DCURDDBUS(10)",
         TestDelay      => tisd_PLBC405DCURDDBUS(10),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(10),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(10),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(10),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS11_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS11_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(11),
         TestSignalName => "PLBC405DCURDDBUS(11)",
         TestDelay      => tisd_PLBC405DCURDDBUS(11),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(11),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(11),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(11),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS12_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS12_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(12),
         TestSignalName => "PLBC405DCURDDBUS(12)",
         TestDelay      => tisd_PLBC405DCURDDBUS(12),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(12),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(12),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(12),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS13_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS13_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(13),
         TestSignalName => "PLBC405DCURDDBUS(13)",
         TestDelay      => tisd_PLBC405DCURDDBUS(13),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(13),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(13),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(13),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS14_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS14_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(14),
         TestSignalName => "PLBC405DCURDDBUS(14)",
         TestDelay      => tisd_PLBC405DCURDDBUS(14),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(14),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(14),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(14),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS15_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS15_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(15),
         TestSignalName => "PLBC405DCURDDBUS(15)",
         TestDelay      => tisd_PLBC405DCURDDBUS(15),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(15),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(15),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(15),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS16_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS16_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(16),
         TestSignalName => "PLBC405DCURDDBUS(16)",
         TestDelay      => tisd_PLBC405DCURDDBUS(16),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(16),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(16),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(16),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(16),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS17_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS17_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(17),
         TestSignalName => "PLBC405DCURDDBUS(17)",
         TestDelay      => tisd_PLBC405DCURDDBUS(17),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(17),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(17),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(17),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(17),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS18_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS18_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(18),
         TestSignalName => "PLBC405DCURDDBUS(18)",
         TestDelay      => tisd_PLBC405DCURDDBUS(18),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(18),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(18),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(18),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(18),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS19_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS19_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(19),
         TestSignalName => "PLBC405DCURDDBUS(19)",
         TestDelay      => tisd_PLBC405DCURDDBUS(19),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(19),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(19),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(19),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(19),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS20_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS20_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(20),
         TestSignalName => "PLBC405DCURDDBUS(20)",
         TestDelay      => tisd_PLBC405DCURDDBUS(20),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(20),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(20),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(20),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(20),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS21_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS21_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(21),
         TestSignalName => "PLBC405DCURDDBUS(21)",
         TestDelay      => tisd_PLBC405DCURDDBUS(21),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(21),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(21),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(21),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(21),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS22_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS22_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(22),
         TestSignalName => "PLBC405DCURDDBUS(22)",
         TestDelay      => tisd_PLBC405DCURDDBUS(22),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(22),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(22),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(22),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(22),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS23_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS23_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(23),
         TestSignalName => "PLBC405DCURDDBUS(23)",
         TestDelay      => tisd_PLBC405DCURDDBUS(23),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(23),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(23),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(23),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(23),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS24_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS24_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(24),
         TestSignalName => "PLBC405DCURDDBUS(24)",
         TestDelay      => tisd_PLBC405DCURDDBUS(24),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(24),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(24),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(24),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(24),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS25_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS25_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(25),
         TestSignalName => "PLBC405DCURDDBUS(25)",
         TestDelay      => tisd_PLBC405DCURDDBUS(25),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(25),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(25),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(25),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(25),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS26_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS26_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(26),
         TestSignalName => "PLBC405DCURDDBUS(26)",
         TestDelay      => tisd_PLBC405DCURDDBUS(26),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(26),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(26),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(26),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(26),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS27_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS27_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(27),
         TestSignalName => "PLBC405DCURDDBUS(27)",
         TestDelay      => tisd_PLBC405DCURDDBUS(27),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(27),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(27),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(27),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(27),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS28_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS28_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(28),
         TestSignalName => "PLBC405DCURDDBUS(28)",
         TestDelay      => tisd_PLBC405DCURDDBUS(28),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(28),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(28),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(28),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(28),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS29_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS29_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(29),
         TestSignalName => "PLBC405DCURDDBUS(29)",
         TestDelay      => tisd_PLBC405DCURDDBUS(29),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(29),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(29),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(29),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(29),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS30_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS30_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(30),
         TestSignalName => "PLBC405DCURDDBUS(30)",
         TestDelay      => tisd_PLBC405DCURDDBUS(30),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(30),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(30),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(30),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(30),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS31_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS31_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(31),
         TestSignalName => "PLBC405DCURDDBUS(31)",
         TestDelay      => tisd_PLBC405DCURDDBUS(31),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(31),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(31),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(31),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(31),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS32_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS32_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(32),
         TestSignalName => "PLBC405DCURDDBUS(32)",
         TestDelay      => tisd_PLBC405DCURDDBUS(32),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(32),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(32),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(32),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(32),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS33_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS33_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(33),
         TestSignalName => "PLBC405DCURDDBUS(33)",
         TestDelay      => tisd_PLBC405DCURDDBUS(33),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(33),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(33),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(33),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(33),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS34_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS34_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(34),
         TestSignalName => "PLBC405DCURDDBUS(34)",
         TestDelay      => tisd_PLBC405DCURDDBUS(34),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(34),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(34),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(34),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(34),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS35_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS35_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(35),
         TestSignalName => "PLBC405DCURDDBUS(35)",
         TestDelay      => tisd_PLBC405DCURDDBUS(35),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(35),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(35),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(35),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(35),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS36_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS36_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(36),
         TestSignalName => "PLBC405DCURDDBUS(36)",
         TestDelay      => tisd_PLBC405DCURDDBUS(36),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(36),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(36),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(36),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(36),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS37_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS37_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(37),
         TestSignalName => "PLBC405DCURDDBUS(37)",
         TestDelay      => tisd_PLBC405DCURDDBUS(37),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(37),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(37),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(37),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(37),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS38_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS38_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(38),
         TestSignalName => "PLBC405DCURDDBUS(38)",
         TestDelay      => tisd_PLBC405DCURDDBUS(38),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(38),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(38),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(38),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(38),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS39_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS39_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(39),
         TestSignalName => "PLBC405DCURDDBUS(39)",
         TestDelay      => tisd_PLBC405DCURDDBUS(39),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(39),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(39),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(39),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(39),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS40_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS40_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(40),
         TestSignalName => "PLBC405DCURDDBUS(40)",
         TestDelay      => tisd_PLBC405DCURDDBUS(40),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(40),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(40),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(40),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(40),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS41_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS41_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(41),
         TestSignalName => "PLBC405DCURDDBUS(41)",
         TestDelay      => tisd_PLBC405DCURDDBUS(41),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(41),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(41),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(41),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(41),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS42_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS42_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(42),
         TestSignalName => "PLBC405DCURDDBUS(42)",
         TestDelay      => tisd_PLBC405DCURDDBUS(42),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(42),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(42),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(42),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(42),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS43_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS43_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(43),
         TestSignalName => "PLBC405DCURDDBUS(43)",
         TestDelay      => tisd_PLBC405DCURDDBUS(43),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(43),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(43),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(43),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(43),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS44_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS44_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(44),
         TestSignalName => "PLBC405DCURDDBUS(44)",
         TestDelay      => tisd_PLBC405DCURDDBUS(44),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(44),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(44),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(44),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(44),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS45_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS45_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(45),
         TestSignalName => "PLBC405DCURDDBUS(45)",
         TestDelay      => tisd_PLBC405DCURDDBUS(45),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(45),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(45),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(45),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(45),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS46_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS46_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(46),
         TestSignalName => "PLBC405DCURDDBUS(46)",
         TestDelay      => tisd_PLBC405DCURDDBUS(46),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(46),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(46),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(46),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(46),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS47_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS47_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(47),
         TestSignalName => "PLBC405DCURDDBUS(47)",
         TestDelay      => tisd_PLBC405DCURDDBUS(47),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(47),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(47),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(47),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(47),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS48_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS48_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(48),
         TestSignalName => "PLBC405DCURDDBUS(48)",
         TestDelay      => tisd_PLBC405DCURDDBUS(48),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(48),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(48),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(48),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(48),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS49_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS49_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(49),
         TestSignalName => "PLBC405DCURDDBUS(49)",
         TestDelay      => tisd_PLBC405DCURDDBUS(49),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(49),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(49),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(49),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(49),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS50_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS50_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(50),
         TestSignalName => "PLBC405DCURDDBUS(50)",
         TestDelay      => tisd_PLBC405DCURDDBUS(50),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(50),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(50),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(50),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(50),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS51_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS51_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(51),
         TestSignalName => "PLBC405DCURDDBUS(51)",
         TestDelay      => tisd_PLBC405DCURDDBUS(51),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(51),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(51),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(51),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(51),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS52_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS52_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(52),
         TestSignalName => "PLBC405DCURDDBUS(52)",
         TestDelay      => tisd_PLBC405DCURDDBUS(52),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(52),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(52),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(52),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(52),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS53_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS53_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(53),
         TestSignalName => "PLBC405DCURDDBUS(53)",
         TestDelay      => tisd_PLBC405DCURDDBUS(53),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(53),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(53),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(53),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(53),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS54_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS54_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(54),
         TestSignalName => "PLBC405DCURDDBUS(54)",
         TestDelay      => tisd_PLBC405DCURDDBUS(54),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(54),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(54),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(54),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(54),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS55_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS55_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(55),
         TestSignalName => "PLBC405DCURDDBUS(55)",
         TestDelay      => tisd_PLBC405DCURDDBUS(55),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(55),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(55),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(55),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(55),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS56_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS56_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(56),
         TestSignalName => "PLBC405DCURDDBUS(56)",
         TestDelay      => tisd_PLBC405DCURDDBUS(56),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(56),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(56),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(56),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(56),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS57_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS57_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(57),
         TestSignalName => "PLBC405DCURDDBUS(57)",
         TestDelay      => tisd_PLBC405DCURDDBUS(57),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(57),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(57),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(57),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(57),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS58_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS58_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(58),
         TestSignalName => "PLBC405DCURDDBUS(58)",
         TestDelay      => tisd_PLBC405DCURDDBUS(58),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(58),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(58),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(58),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(58),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS59_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS59_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(59),
         TestSignalName => "PLBC405DCURDDBUS(59)",
         TestDelay      => tisd_PLBC405DCURDDBUS(59),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(59),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(59),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(59),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(59),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS60_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS60_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(60),
         TestSignalName => "PLBC405DCURDDBUS(60)",
         TestDelay      => tisd_PLBC405DCURDDBUS(60),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(60),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(60),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(60),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(60),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS61_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS61_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(61),
         TestSignalName => "PLBC405DCURDDBUS(61)",
         TestDelay      => tisd_PLBC405DCURDDBUS(61),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(61),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(61),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(61),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(61),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS62_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS62_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(62),
         TestSignalName => "PLBC405DCURDDBUS(62)",
         TestDelay      => tisd_PLBC405DCURDDBUS(62),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(62),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(62),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(62),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(62),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDDBUS63_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDDBUS63_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDDBUS_dly_1(63),
         TestSignalName => "PLBC405DCURDDBUS(63)",
         TestDelay      => tisd_PLBC405DCURDDBUS(63),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(63),
         SetupLow       => tsetup_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(63),
         HoldLow        => thold_PLBC405DCURDDBUS_PLBCLK_posedge_posedge(63),
         HoldHigh       => thold_PLBC405DCURDDBUS_PLBCLK_negedge_posedge(63),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDWDADDR1_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDWDADDR1_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDWDADDR_dly_1(1),
         TestSignalName => "PLBC405DCURDWDADDR(1)",
         TestDelay      => tisd_PLBC405DCURDWDADDR(1),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDWDADDR_PLBCLK_posedge_posedge(1),
         SetupLow       => tsetup_PLBC405DCURDWDADDR_PLBCLK_negedge_posedge(1),
         HoldLow        => thold_PLBC405DCURDWDADDR_PLBCLK_posedge_posedge(1),
         HoldHigh       => thold_PLBC405DCURDWDADDR_PLBCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDWDADDR2_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDWDADDR2_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDWDADDR_dly_1(2),
         TestSignalName => "PLBC405DCURDWDADDR(2)",
         TestDelay      => tisd_PLBC405DCURDWDADDR(2),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDWDADDR_PLBCLK_posedge_posedge(2),
         SetupLow       => tsetup_PLBC405DCURDWDADDR_PLBCLK_negedge_posedge(2),
         HoldLow        => thold_PLBC405DCURDWDADDR_PLBCLK_posedge_posedge(2),
         HoldHigh       => thold_PLBC405DCURDWDADDR_PLBCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCURDWDADDR3_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCURDWDADDR3_PLBCLK_posedge,
         TestSignal     => PLBC405DCURDWDADDR_dly_1(3),
         TestSignalName => "PLBC405DCURDWDADDR(3)",
         TestDelay      => tisd_PLBC405DCURDWDADDR(3),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405DCURDWDADDR_PLBCLK_posedge_posedge(3),
         SetupLow       => tsetup_PLBC405DCURDWDADDR_PLBCLK_negedge_posedge(3),
         HoldLow        => thold_PLBC405DCURDWDADDR_PLBCLK_posedge_posedge(3),
         HoldHigh       => thold_PLBC405DCURDWDADDR_PLBCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCUSSIZE1_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCUSSIZE1_PLBCLK_posedge,
         TestSignal     => PLBC405DCUSSIZE1,
         TestSignalName => "PLBC405DCUSSIZE1",
         TestDelay      => 0 ns,
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PLBC405DCUSSIZE1_PLBCLK_posedge_posedge,
         SetupLow       => tsetup_PLBC405DCUSSIZE1_PLBCLK_negedge_posedge,
         HoldLow        => thold_PLBC405DCUSSIZE1_PLBCLK_posedge_posedge,
         HoldHigh       => thold_PLBC405DCUSSIZE1_PLBCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405DCUWRDACK_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405DCUWRDACK_PLBCLK_posedge,
         TestSignal     => PLBC405DCUWRDACK,
         TestSignalName => "PLBC405DCUWRDACK",
         TestDelay      => 0 ns,
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PLBC405DCUWRDACK_PLBCLK_posedge_posedge,
         SetupLow       => tsetup_PLBC405DCUWRDACK_PLBCLK_negedge_posedge,
         HoldLow        => thold_PLBC405DCUWRDACK_PLBCLK_posedge_posedge,
         HoldHigh       => thold_PLBC405DCUWRDACK_PLBCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICUADDRACK_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICUADDRACK_PLBCLK_posedge,
         TestSignal     => PLBC405ICUADDRACK,
         TestSignalName => "PLBC405ICUADDRACK",
         TestDelay      => 0 ns,
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PLBC405ICUADDRACK_PLBCLK_posedge_posedge,
         SetupLow       => tsetup_PLBC405ICUADDRACK_PLBCLK_negedge_posedge,
         HoldLow        => thold_PLBC405ICUADDRACK_PLBCLK_posedge_posedge,
         HoldHigh       => thold_PLBC405ICUADDRACK_PLBCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICUBUSY_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICUBUSY_PLBCLK_posedge,
         TestSignal     => PLBC405ICUBUSY,
         TestSignalName => "PLBC405ICUBUSY",
         TestDelay      => 0 ns,
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PLBC405ICUBUSY_PLBCLK_posedge_posedge,
         SetupLow       => tsetup_PLBC405ICUBUSY_PLBCLK_negedge_posedge,
         HoldLow        => thold_PLBC405ICUBUSY_PLBCLK_posedge_posedge,
         HoldHigh       => thold_PLBC405ICUBUSY_PLBCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICUERR_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICUERR_PLBCLK_posedge,
         TestSignal     => PLBC405ICUERR,
         TestSignalName => "PLBC405ICUERR",
         TestDelay      => 0 ns,
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PLBC405ICUERR_PLBCLK_posedge_posedge,
         SetupLow       => tsetup_PLBC405ICUERR_PLBCLK_negedge_posedge,
         HoldLow        => thold_PLBC405ICUERR_PLBCLK_posedge_posedge,
         HoldHigh       => thold_PLBC405ICUERR_PLBCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDACK_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDACK_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDACK,
         TestSignalName => "PLBC405ICURDDACK",
         TestDelay      => 0 ns,
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PLBC405ICURDDACK_PLBCLK_posedge_posedge,
         SetupLow       => tsetup_PLBC405ICURDDACK_PLBCLK_negedge_posedge,
         HoldLow        => thold_PLBC405ICURDDACK_PLBCLK_posedge_posedge,
         HoldHigh       => thold_PLBC405ICURDDACK_PLBCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS0_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS0_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(0),
         TestSignalName => "PLBC405ICURDDBUS(0)",
         TestDelay      => tisd_PLBC405ICURDDBUS(0),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(0),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(0),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(0),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS1_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS1_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(1),
         TestSignalName => "PLBC405ICURDDBUS(1)",
         TestDelay      => tisd_PLBC405ICURDDBUS(1),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(1),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(1),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(1),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS2_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS2_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(2),
         TestSignalName => "PLBC405ICURDDBUS(2)",
         TestDelay      => tisd_PLBC405ICURDDBUS(2),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(2),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(2),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(2),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS3_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS3_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(3),
         TestSignalName => "PLBC405ICURDDBUS(3)",
         TestDelay      => tisd_PLBC405ICURDDBUS(3),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(3),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(3),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(3),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS4_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS4_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(4),
         TestSignalName => "PLBC405ICURDDBUS(4)",
         TestDelay      => tisd_PLBC405ICURDDBUS(4),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(4),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(4),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(4),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS5_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS5_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(5),
         TestSignalName => "PLBC405ICURDDBUS(5)",
         TestDelay      => tisd_PLBC405ICURDDBUS(5),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(5),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(5),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(5),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS6_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS6_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(6),
         TestSignalName => "PLBC405ICURDDBUS(6)",
         TestDelay      => tisd_PLBC405ICURDDBUS(6),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(6),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(6),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(6),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS7_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS7_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(7),
         TestSignalName => "PLBC405ICURDDBUS(7)",
         TestDelay      => tisd_PLBC405ICURDDBUS(7),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(7),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(7),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(7),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS8_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS8_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(8),
         TestSignalName => "PLBC405ICURDDBUS(8)",
         TestDelay      => tisd_PLBC405ICURDDBUS(8),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(8),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(8),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(8),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS9_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS9_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(9),
         TestSignalName => "PLBC405ICURDDBUS(9)",
         TestDelay      => tisd_PLBC405ICURDDBUS(9),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(9),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(9),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(9),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS10_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS10_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(10),
         TestSignalName => "PLBC405ICURDDBUS(10)",
         TestDelay      => tisd_PLBC405ICURDDBUS(10),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(10),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(10),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(10),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS11_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS11_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(11),
         TestSignalName => "PLBC405ICURDDBUS(11)",
         TestDelay      => tisd_PLBC405ICURDDBUS(11),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(11),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(11),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(11),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS12_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS12_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(12),
         TestSignalName => "PLBC405ICURDDBUS(12)",
         TestDelay      => tisd_PLBC405ICURDDBUS(12),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(12),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(12),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(12),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS13_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS13_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(13),
         TestSignalName => "PLBC405ICURDDBUS(13)",
         TestDelay      => tisd_PLBC405ICURDDBUS(13),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(13),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(13),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(13),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS14_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS14_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(14),
         TestSignalName => "PLBC405ICURDDBUS(14)",
         TestDelay      => tisd_PLBC405ICURDDBUS(14),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(14),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(14),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(14),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS15_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS15_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(15),
         TestSignalName => "PLBC405ICURDDBUS(15)",
         TestDelay      => tisd_PLBC405ICURDDBUS(15),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(15),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(15),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(15),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS16_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS16_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(16),
         TestSignalName => "PLBC405ICURDDBUS(16)",
         TestDelay      => tisd_PLBC405ICURDDBUS(16),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(16),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(16),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(16),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(16),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS17_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS17_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(17),
         TestSignalName => "PLBC405ICURDDBUS(17)",
         TestDelay      => tisd_PLBC405ICURDDBUS(17),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(17),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(17),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(17),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(17),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS18_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS18_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(18),
         TestSignalName => "PLBC405ICURDDBUS(18)",
         TestDelay      => tisd_PLBC405ICURDDBUS(18),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(18),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(18),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(18),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(18),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS19_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS19_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(19),
         TestSignalName => "PLBC405ICURDDBUS(19)",
         TestDelay      => tisd_PLBC405ICURDDBUS(19),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(19),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(19),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(19),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(19),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS20_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS20_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(20),
         TestSignalName => "PLBC405ICURDDBUS(20)",
         TestDelay      => tisd_PLBC405ICURDDBUS(20),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(20),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(20),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(20),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(20),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS21_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS21_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(21),
         TestSignalName => "PLBC405ICURDDBUS(21)",
         TestDelay      => tisd_PLBC405ICURDDBUS(21),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(21),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(21),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(21),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(21),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS22_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS22_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(22),
         TestSignalName => "PLBC405ICURDDBUS(22)",
         TestDelay      => tisd_PLBC405ICURDDBUS(22),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(22),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(22),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(22),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(22),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS23_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS23_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(23),
         TestSignalName => "PLBC405ICURDDBUS(23)",
         TestDelay      => tisd_PLBC405ICURDDBUS(23),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(23),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(23),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(23),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(23),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS24_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS24_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(24),
         TestSignalName => "PLBC405ICURDDBUS(24)",
         TestDelay      => tisd_PLBC405ICURDDBUS(24),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(24),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(24),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(24),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(24),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS25_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS25_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(25),
         TestSignalName => "PLBC405ICURDDBUS(25)",
         TestDelay      => tisd_PLBC405ICURDDBUS(25),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(25),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(25),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(25),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(25),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS26_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS26_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(26),
         TestSignalName => "PLBC405ICURDDBUS(26)",
         TestDelay      => tisd_PLBC405ICURDDBUS(26),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(26),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(26),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(26),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(26),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS27_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS27_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(27),
         TestSignalName => "PLBC405ICURDDBUS(27)",
         TestDelay      => tisd_PLBC405ICURDDBUS(27),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(27),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(27),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(27),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(27),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS28_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS28_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(28),
         TestSignalName => "PLBC405ICURDDBUS(28)",
         TestDelay      => tisd_PLBC405ICURDDBUS(28),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(28),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(28),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(28),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(28),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS29_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS29_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(29),
         TestSignalName => "PLBC405ICURDDBUS(29)",
         TestDelay      => tisd_PLBC405ICURDDBUS(29),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(29),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(29),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(29),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(29),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS30_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS30_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(30),
         TestSignalName => "PLBC405ICURDDBUS(30)",
         TestDelay      => tisd_PLBC405ICURDDBUS(30),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(30),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(30),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(30),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(30),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS31_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS31_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(31),
         TestSignalName => "PLBC405ICURDDBUS(31)",
         TestDelay      => tisd_PLBC405ICURDDBUS(31),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(31),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(31),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(31),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(31),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS32_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS32_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(32),
         TestSignalName => "PLBC405ICURDDBUS(32)",
         TestDelay      => tisd_PLBC405ICURDDBUS(32),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(32),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(32),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(32),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(32),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS33_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS33_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(33),
         TestSignalName => "PLBC405ICURDDBUS(33)",
         TestDelay      => tisd_PLBC405ICURDDBUS(33),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(33),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(33),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(33),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(33),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS34_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS34_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(34),
         TestSignalName => "PLBC405ICURDDBUS(34)",
         TestDelay      => tisd_PLBC405ICURDDBUS(34),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(34),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(34),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(34),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(34),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS35_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS35_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(35),
         TestSignalName => "PLBC405ICURDDBUS(35)",
         TestDelay      => tisd_PLBC405ICURDDBUS(35),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(35),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(35),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(35),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(35),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS36_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS36_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(36),
         TestSignalName => "PLBC405ICURDDBUS(36)",
         TestDelay      => tisd_PLBC405ICURDDBUS(36),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(36),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(36),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(36),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(36),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS37_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS37_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(37),
         TestSignalName => "PLBC405ICURDDBUS(37)",
         TestDelay      => tisd_PLBC405ICURDDBUS(37),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(37),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(37),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(37),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(37),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS38_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS38_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(38),
         TestSignalName => "PLBC405ICURDDBUS(38)",
         TestDelay      => tisd_PLBC405ICURDDBUS(38),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(38),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(38),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(38),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(38),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS39_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS39_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(39),
         TestSignalName => "PLBC405ICURDDBUS(39)",
         TestDelay      => tisd_PLBC405ICURDDBUS(39),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(39),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(39),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(39),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(39),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS40_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS40_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(40),
         TestSignalName => "PLBC405ICURDDBUS(40)",
         TestDelay      => tisd_PLBC405ICURDDBUS(40),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(40),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(40),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(40),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(40),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS41_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS41_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(41),
         TestSignalName => "PLBC405ICURDDBUS(41)",
         TestDelay      => tisd_PLBC405ICURDDBUS(41),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(41),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(41),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(41),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(41),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS42_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS42_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(42),
         TestSignalName => "PLBC405ICURDDBUS(42)",
         TestDelay      => tisd_PLBC405ICURDDBUS(42),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(42),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(42),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(42),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(42),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS43_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS43_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(43),
         TestSignalName => "PLBC405ICURDDBUS(43)",
         TestDelay      => tisd_PLBC405ICURDDBUS(43),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(43),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(43),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(43),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(43),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS44_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS44_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(44),
         TestSignalName => "PLBC405ICURDDBUS(44)",
         TestDelay      => tisd_PLBC405ICURDDBUS(44),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(44),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(44),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(44),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(44),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS45_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS45_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(45),
         TestSignalName => "PLBC405ICURDDBUS(45)",
         TestDelay      => tisd_PLBC405ICURDDBUS(45),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(45),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(45),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(45),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(45),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS46_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS46_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(46),
         TestSignalName => "PLBC405ICURDDBUS(46)",
         TestDelay      => tisd_PLBC405ICURDDBUS(46),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(46),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(46),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(46),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(46),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS47_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS47_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(47),
         TestSignalName => "PLBC405ICURDDBUS(47)",
         TestDelay      => tisd_PLBC405ICURDDBUS(47),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(47),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(47),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(47),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(47),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS48_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS48_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(48),
         TestSignalName => "PLBC405ICURDDBUS(48)",
         TestDelay      => tisd_PLBC405ICURDDBUS(48),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(48),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(48),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(48),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(48),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS49_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS49_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(49),
         TestSignalName => "PLBC405ICURDDBUS(49)",
         TestDelay      => tisd_PLBC405ICURDDBUS(49),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(49),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(49),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(49),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(49),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS50_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS50_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(50),
         TestSignalName => "PLBC405ICURDDBUS(50)",
         TestDelay      => tisd_PLBC405ICURDDBUS(50),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(50),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(50),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(50),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(50),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS51_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS51_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(51),
         TestSignalName => "PLBC405ICURDDBUS(51)",
         TestDelay      => tisd_PLBC405ICURDDBUS(51),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(51),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(51),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(51),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(51),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS52_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS52_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(52),
         TestSignalName => "PLBC405ICURDDBUS(52)",
         TestDelay      => tisd_PLBC405ICURDDBUS(52),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(52),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(52),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(52),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(52),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS53_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS53_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(53),
         TestSignalName => "PLBC405ICURDDBUS(53)",
         TestDelay      => tisd_PLBC405ICURDDBUS(53),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(53),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(53),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(53),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(53),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS54_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS54_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(54),
         TestSignalName => "PLBC405ICURDDBUS(54)",
         TestDelay      => tisd_PLBC405ICURDDBUS(54),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(54),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(54),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(54),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(54),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS55_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS55_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(55),
         TestSignalName => "PLBC405ICURDDBUS(55)",
         TestDelay      => tisd_PLBC405ICURDDBUS(55),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(55),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(55),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(55),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(55),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS56_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS56_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(56),
         TestSignalName => "PLBC405ICURDDBUS(56)",
         TestDelay      => tisd_PLBC405ICURDDBUS(56),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(56),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(56),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(56),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(56),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS57_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS57_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(57),
         TestSignalName => "PLBC405ICURDDBUS(57)",
         TestDelay      => tisd_PLBC405ICURDDBUS(57),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(57),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(57),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(57),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(57),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS58_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS58_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(58),
         TestSignalName => "PLBC405ICURDDBUS(58)",
         TestDelay      => tisd_PLBC405ICURDDBUS(58),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(58),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(58),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(58),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(58),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS59_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS59_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(59),
         TestSignalName => "PLBC405ICURDDBUS(59)",
         TestDelay      => tisd_PLBC405ICURDDBUS(59),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(59),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(59),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(59),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(59),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS60_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS60_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(60),
         TestSignalName => "PLBC405ICURDDBUS(60)",
         TestDelay      => tisd_PLBC405ICURDDBUS(60),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(60),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(60),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(60),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(60),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS61_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS61_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(61),
         TestSignalName => "PLBC405ICURDDBUS(61)",
         TestDelay      => tisd_PLBC405ICURDDBUS(61),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(61),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(61),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(61),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(61),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS62_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS62_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(62),
         TestSignalName => "PLBC405ICURDDBUS(62)",
         TestDelay      => tisd_PLBC405ICURDDBUS(62),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(62),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(62),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(62),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(62),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDDBUS63_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDDBUS63_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDDBUS_dly_1(63),
         TestSignalName => "PLBC405ICURDDBUS(63)",
         TestDelay      => tisd_PLBC405ICURDDBUS(63),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(63),
         SetupLow       => tsetup_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(63),
         HoldLow        => thold_PLBC405ICURDDBUS_PLBCLK_posedge_posedge(63),
         HoldHigh       => thold_PLBC405ICURDDBUS_PLBCLK_negedge_posedge(63),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDWDADDR1_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDWDADDR1_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDWDADDR_dly_1(1),
         TestSignalName => "PLBC405ICURDWDADDR(1)",
         TestDelay      => tisd_PLBC405ICURDWDADDR(1),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDWDADDR_PLBCLK_posedge_posedge(1),
         SetupLow       => tsetup_PLBC405ICURDWDADDR_PLBCLK_negedge_posedge(1),
         HoldLow        => thold_PLBC405ICURDWDADDR_PLBCLK_posedge_posedge(1),
         HoldHigh       => thold_PLBC405ICURDWDADDR_PLBCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDWDADDR2_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDWDADDR2_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDWDADDR_dly_1(2),
         TestSignalName => "PLBC405ICURDWDADDR(2)",
         TestDelay      => tisd_PLBC405ICURDWDADDR(2),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDWDADDR_PLBCLK_posedge_posedge(2),
         SetupLow       => tsetup_PLBC405ICURDWDADDR_PLBCLK_negedge_posedge(2),
         HoldLow        => thold_PLBC405ICURDWDADDR_PLBCLK_posedge_posedge(2),
         HoldHigh       => thold_PLBC405ICURDWDADDR_PLBCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICURDWDADDR3_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICURDWDADDR3_PLBCLK_posedge,
         TestSignal     => PLBC405ICURDWDADDR_dly_1(3),
         TestSignalName => "PLBC405ICURDWDADDR(3)",
         TestDelay      => tisd_PLBC405ICURDWDADDR(3),
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => ticd_PLBCLK,
         SetupHigh      => tsetup_PLBC405ICURDWDADDR_PLBCLK_posedge_posedge(3),
         SetupLow       => tsetup_PLBC405ICURDWDADDR_PLBCLK_negedge_posedge(3),
         HoldLow        => thold_PLBC405ICURDWDADDR_PLBCLK_posedge_posedge(3),
         HoldHigh       => thold_PLBC405ICURDWDADDR_PLBCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PLBC405ICUSSIZE1_PLBCLK_posedge,
         TimingData     => Tmkr_PLBC405ICUSSIZE1_PLBCLK_posedge,
         TestSignal     => PLBC405ICUSSIZE1,
         TestSignalName => "PLBC405ICUSSIZE1",
         TestDelay      => 0 ns,
         RefSignal      => PLBCLK_dly_1,
         RefSignalName  => "PLBCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PLBC405ICUSSIZE1_PLBCLK_posedge_posedge,
         SetupLow       => tsetup_PLBC405ICUSSIZE1_PLBCLK_negedge_posedge,
         HoldLow        => thold_PLBC405ICUSSIZE1_PLBCLK_posedge_posedge,
         HoldHigh       => thold_PLBC405ICUSSIZE1_PLBCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RSTC405RESETCHIP_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_RSTC405RESETCHIP_CPMC405CLOCK_posedge,
         TestSignal     => RSTC405RESETCHIP,
         TestSignalName => "RSTC405RESETCHIP",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RSTC405RESETCHIP_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_RSTC405RESETCHIP_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_RSTC405RESETCHIP_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_RSTC405RESETCHIP_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RSTC405RESETCORE_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_RSTC405RESETCORE_CPMC405CLOCK_posedge,
         TestSignal     => RSTC405RESETCORE,
         TestSignalName => "RSTC405RESETCORE",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RSTC405RESETCORE_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_RSTC405RESETCORE_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_RSTC405RESETCORE_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_RSTC405RESETCORE_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RSTC405RESETSYS_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_RSTC405RESETSYS_CPMC405CLOCK_posedge,
         TestSignal     => RSTC405RESETSYS,
         TestSignalName => "RSTC405RESETSYS",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RSTC405RESETSYS_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_RSTC405RESETSYS_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_RSTC405RESETSYS_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_RSTC405RESETSYS_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TRCC405TRACEDISABLE_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_TRCC405TRACEDISABLE_CPMC405CLOCK_posedge,
         TestSignal     => TRCC405TRACEDISABLE,
         TestSignalName => "TRCC405TRACEDISABLE",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_TRCC405TRACEDISABLE_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_TRCC405TRACEDISABLE_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_TRCC405TRACEDISABLE_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_TRCC405TRACEDISABLE_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TRCC405TRIGGEREVENTIN_CPMC405CLOCK_posedge,
         TimingData     => Tmkr_TRCC405TRIGGEREVENTIN_CPMC405CLOCK_posedge,
         TestSignal     => TRCC405TRIGGEREVENTIN,
         TestSignalName => "TRCC405TRIGGEREVENTIN",
         TestDelay      => 0 ns,
         RefSignal      => CPMC405CLOCK_dly_1,
         RefSignalName  => "CPMC405CLOCK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_TRCC405TRIGGEREVENTIN_CPMC405CLOCK_posedge_posedge,
         SetupLow       => tsetup_TRCC405TRIGGEREVENTIN_CPMC405CLOCK_negedge_posedge,
         HoldLow        => thold_TRCC405TRIGGEREVENTIN_CPMC405CLOCK_posedge_posedge,
         HoldHigh       => thold_TRCC405TRIGGEREVENTIN_CPMC405CLOCK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_PPC405_ADV",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalPeriodPulseCheck
       (
         Violation               => Pviol_CPMC405CLOCK,
         PeriodData              => PInfo_CPMC405CLOCK,
         TestSignal              => CPMC405CLOCK_dly_1,
         TestSignalName          => "CPMC405CLOCK",
         TestDelay               => 0 ns,
         Period                  => tperiod_CPMC405CLOCK_POSEDGE,
         PulseWidthHigh          => tpw_CPMC405CLOCK_posedge,
         PulseWidthLow           => tpw_CPMC405CLOCK_negedge,
         CheckEnabled            =>  TRUE,
         HeaderMsg               => InstancePath &"/X_PPC405_ADV",
         Xon                     => Xon,
         MsgOn                   => MsgOn,
         MsgSeverity             => WARNING
       );     
     end if;
-- End of (TimingChecksOn)

--  Output-to-Clock path delay
     VitalPathDelay01
       (
         OutSignal     => APUFCMDECODED,
         GlitchData    => APUFCMDECODED_GlitchData,
         OutSignalName => "APUFCMDECODED",
         OutTemp       => APUFCMDECODED_OUT,
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMDECODED,TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMDECODED, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMDECUDIVALID,
         GlitchData    => APUFCMDECUDIVALID_GlitchData,
         OutSignalName => "APUFCMDECUDIVALID",
         OutTemp       => APUFCMDECUDIVALID_OUT,
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMDECUDIVALID,TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMDECUDIVALID, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMENDIAN,
         GlitchData    => APUFCMENDIAN_GlitchData,
         OutSignalName => "APUFCMENDIAN",
         OutTemp       => APUFCMENDIAN_OUT,
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMENDIAN,TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMENDIAN, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMFLUSH,
         GlitchData    => APUFCMFLUSH_GlitchData,
         OutSignalName => "APUFCMFLUSH",
         OutTemp       => APUFCMFLUSH_OUT,
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMFLUSH,TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMFLUSH, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRVALID,
         GlitchData    => APUFCMINSTRVALID_GlitchData,
         OutSignalName => "APUFCMINSTRVALID",
         OutTemp       => APUFCMINSTRVALID_OUT,
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRVALID,TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRVALID, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDVALID,
         GlitchData    => APUFCMLOADDVALID_GlitchData,
         OutSignalName => "APUFCMLOADDVALID",
         OutTemp       => APUFCMLOADDVALID_OUT,
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDVALID,TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDVALID, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMOPERANDVALID,
         GlitchData    => APUFCMOPERANDVALID_GlitchData,
         OutSignalName => "APUFCMOPERANDVALID",
         OutTemp       => APUFCMOPERANDVALID_OUT,
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMOPERANDVALID,TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMOPERANDVALID, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMWRITEBACKOK,
         GlitchData    => APUFCMWRITEBACKOK_GlitchData,
         OutSignalName => "APUFCMWRITEBACKOK",
         OutTemp       => APUFCMWRITEBACKOK_OUT,
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMWRITEBACKOK,TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMWRITEBACKOK, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMXERCA,
         GlitchData    => APUFCMXERCA_GlitchData,
         OutSignalName => "APUFCMXERCA",
         OutTemp       => APUFCMXERCA_OUT,
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMXERCA,TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMXERCA, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405CPMCORESLEEPREQ,
         GlitchData    => C405CPMCORESLEEPREQ_GlitchData,
         OutSignalName => "C405CPMCORESLEEPREQ",
         OutTemp       => C405CPMCORESLEEPREQ_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405CPMCORESLEEPREQ,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405CPMCORESLEEPREQ, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405CPMMSRCE,
         GlitchData    => C405CPMMSRCE_GlitchData,
         OutSignalName => "C405CPMMSRCE",
         OutTemp       => C405CPMMSRCE_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405CPMMSRCE,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405CPMMSRCE, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405CPMMSREE,
         GlitchData    => C405CPMMSREE_GlitchData,
         OutSignalName => "C405CPMMSREE",
         OutTemp       => C405CPMMSREE_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405CPMMSREE,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405CPMMSREE, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405CPMTIMERIRQ,
         GlitchData    => C405CPMTIMERIRQ_GlitchData,
         OutSignalName => "C405CPMTIMERIRQ",
         OutTemp       => C405CPMTIMERIRQ_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405CPMTIMERIRQ,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405CPMTIMERIRQ, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405CPMTIMERRESETREQ,
         GlitchData    => C405CPMTIMERRESETREQ_GlitchData,
         OutSignalName => "C405CPMTIMERRESETREQ",
         OutTemp       => C405CPMTIMERRESETREQ_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405CPMTIMERRESETREQ,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405CPMTIMERRESETREQ, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGLOADDATAONAPUDBUS,
         GlitchData    => C405DBGLOADDATAONAPUDBUS_GlitchData,
         OutSignalName => "C405DBGLOADDATAONAPUDBUS",
         OutTemp       => C405DBGLOADDATAONAPUDBUS_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGLOADDATAONAPUDBUS,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGLOADDATAONAPUDBUS, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGMSRWE,
         GlitchData    => C405DBGMSRWE_GlitchData,
         OutSignalName => "C405DBGMSRWE",
         OutTemp       => C405DBGMSRWE_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGMSRWE,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGMSRWE, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGSTOPACK,
         GlitchData    => C405DBGSTOPACK_GlitchData,
         OutSignalName => "C405DBGSTOPACK",
         OutTemp       => C405DBGSTOPACK_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGSTOPACK,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGSTOPACK, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBCOMPLETE,
         GlitchData    => C405DBGWBCOMPLETE_GlitchData,
         OutSignalName => "C405DBGWBCOMPLETE",
         OutTemp       => C405DBGWBCOMPLETE_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBCOMPLETE,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBCOMPLETE, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBFULL,
         GlitchData    => C405DBGWBFULL_GlitchData,
         OutSignalName => "C405DBGWBFULL",
         OutTemp       => C405DBGWBFULL_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBFULL,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBFULL, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405JTGCAPTUREDR,
         GlitchData    => C405JTGCAPTUREDR_GlitchData,
         OutSignalName => "C405JTGCAPTUREDR",
         OutTemp       => C405JTGCAPTUREDR_OUT,
         Paths         => (0 => (JTGC405TCK_dly_1'last_event, tpd_JTGC405TCK_C405JTGCAPTUREDR,TRUE)),
	 DefaultDelay =>  tpd_JTGC405TCK_C405JTGCAPTUREDR, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405JTGEXTEST,
         GlitchData    => C405JTGEXTEST_GlitchData,
         OutSignalName => "C405JTGEXTEST",
         OutTemp       => C405JTGEXTEST_OUT,
         Paths         => (0 => (JTGC405TCK_dly_1'last_event, tpd_JTGC405TCK_C405JTGEXTEST,TRUE)),
	 DefaultDelay =>  tpd_JTGC405TCK_C405JTGEXTEST, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405JTGPGMOUT,
         GlitchData    => C405JTGPGMOUT_GlitchData,
         OutSignalName => "C405JTGPGMOUT",
         OutTemp       => C405JTGPGMOUT_OUT,
         Paths         => (0 => (JTGC405TCK_dly_1'last_event, tpd_JTGC405TCK_C405JTGPGMOUT,TRUE)),
	 DefaultDelay =>  tpd_JTGC405TCK_C405JTGPGMOUT, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405JTGSHIFTDR,
         GlitchData    => C405JTGSHIFTDR_GlitchData,
         OutSignalName => "C405JTGSHIFTDR",
         OutTemp       => C405JTGSHIFTDR_OUT,
         Paths         => (0 => (JTGC405TCK_dly_1'last_event, tpd_JTGC405TCK_C405JTGSHIFTDR,TRUE)),
	 DefaultDelay =>  tpd_JTGC405TCK_C405JTGSHIFTDR, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405JTGTDO,
         GlitchData    => C405JTGTDO_GlitchData,
         OutSignalName => "C405JTGTDO",
         OutTemp       => C405JTGTDO_OUT,
         Paths         => (0 => (JTGC405TCK_dly_1'last_event, tpd_JTGC405TCK_C405JTGTDO,TRUE)),
	 DefaultDelay =>  tpd_JTGC405TCK_C405JTGTDO, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405JTGTDOEN,
         GlitchData    => C405JTGTDOEN_GlitchData,
         OutSignalName => "C405JTGTDOEN",
         OutTemp       => C405JTGTDOEN_OUT,
         Paths         => (0 => (JTGC405TCK_dly_1'last_event, tpd_JTGC405TCK_C405JTGTDOEN,TRUE)),
	 DefaultDelay =>  tpd_JTGC405TCK_C405JTGTDOEN, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405JTGUPDATEDR,
         GlitchData    => C405JTGUPDATEDR_GlitchData,
         OutSignalName => "C405JTGUPDATEDR",
         OutTemp       => C405JTGUPDATEDR_OUT,
         Paths         => (0 => (JTGC405TCK_dly_1'last_event, tpd_JTGC405TCK_C405JTGUPDATEDR,TRUE)),
	 DefaultDelay =>  tpd_JTGC405TCK_C405JTGUPDATEDR, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABORT,
         GlitchData    => C405PLBDCUABORT_GlitchData,
         OutSignalName => "C405PLBDCUABORT",
         OutTemp       => C405PLBDCUABORT_OUT,
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABORT,TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABORT, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUCACHEABLE,
         GlitchData    => C405PLBDCUCACHEABLE_GlitchData,
         OutSignalName => "C405PLBDCUCACHEABLE",
         OutTemp       => C405PLBDCUCACHEABLE_OUT,
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUCACHEABLE,TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUCACHEABLE, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUGUARDED,
         GlitchData    => C405PLBDCUGUARDED_GlitchData,
         OutSignalName => "C405PLBDCUGUARDED",
         OutTemp       => C405PLBDCUGUARDED_OUT,
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUGUARDED,TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUGUARDED, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUREQUEST,
         GlitchData    => C405PLBDCUREQUEST_GlitchData,
         OutSignalName => "C405PLBDCUREQUEST",
         OutTemp       => C405PLBDCUREQUEST_OUT,
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUREQUEST,TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUREQUEST, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCURNW,
         GlitchData    => C405PLBDCURNW_GlitchData,
         OutSignalName => "C405PLBDCURNW",
         OutTemp       => C405PLBDCURNW_OUT,
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCURNW,TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCURNW, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUSIZE2,
         GlitchData    => C405PLBDCUSIZE2_GlitchData,
         OutSignalName => "C405PLBDCUSIZE2",
         OutTemp       => C405PLBDCUSIZE2_OUT,
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUSIZE2,TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUSIZE2, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUU0ATTR,
         GlitchData    => C405PLBDCUU0ATTR_GlitchData,
         OutSignalName => "C405PLBDCUU0ATTR",
         OutTemp       => C405PLBDCUU0ATTR_OUT,
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUU0ATTR,TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUU0ATTR, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRITETHRU,
         GlitchData    => C405PLBDCUWRITETHRU_GlitchData,
         OutSignalName => "C405PLBDCUWRITETHRU",
         OutTemp       => C405PLBDCUWRITETHRU_OUT,
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRITETHRU,TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRITETHRU, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABORT,
         GlitchData    => C405PLBICUABORT_GlitchData,
         OutSignalName => "C405PLBICUABORT",
         OutTemp       => C405PLBICUABORT_OUT,
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABORT,TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABORT, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUCACHEABLE,
         GlitchData    => C405PLBICUCACHEABLE_GlitchData,
         OutSignalName => "C405PLBICUCACHEABLE",
         OutTemp       => C405PLBICUCACHEABLE_OUT,
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUCACHEABLE,TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUCACHEABLE, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUREQUEST,
         GlitchData    => C405PLBICUREQUEST_GlitchData,
         OutSignalName => "C405PLBICUREQUEST",
         OutTemp       => C405PLBICUREQUEST_OUT,
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUREQUEST,TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUREQUEST, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUU0ATTR,
         GlitchData    => C405PLBICUU0ATTR_GlitchData,
         OutSignalName => "C405PLBICUU0ATTR",
         OutTemp       => C405PLBICUU0ATTR_OUT,
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUU0ATTR,TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUU0ATTR, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405RSTCHIPRESETREQ,
         GlitchData    => C405RSTCHIPRESETREQ_GlitchData,
         OutSignalName => "C405RSTCHIPRESETREQ",
         OutTemp       => C405RSTCHIPRESETREQ_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405RSTCHIPRESETREQ,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405RSTCHIPRESETREQ, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405RSTCORERESETREQ,
         GlitchData    => C405RSTCORERESETREQ_GlitchData,
         OutSignalName => "C405RSTCORERESETREQ",
         OutTemp       => C405RSTCORERESETREQ_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405RSTCORERESETREQ,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405RSTCORERESETREQ, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405RSTSYSRESETREQ,
         GlitchData    => C405RSTSYSRESETREQ_GlitchData,
         OutSignalName => "C405RSTSYSRESETREQ",
         OutTemp       => C405RSTSYSRESETREQ_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405RSTSYSRESETREQ,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405RSTSYSRESETREQ, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCCYCLE,
         GlitchData    => C405TRCCYCLE_GlitchData,
         OutSignalName => "C405TRCCYCLE",
         OutTemp       => C405TRCCYCLE_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCCYCLE,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCCYCLE, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRIGGEREVENTOUT,
         GlitchData    => C405TRCTRIGGEREVENTOUT_GlitchData,
         OutSignalName => "C405TRCTRIGGEREVENTOUT",
         OutTemp       => C405TRCTRIGGEREVENTOUT_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTOUT,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTOUT, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405XXXMACHINECHECK,
         GlitchData    => C405XXXMACHINECHECK_GlitchData,
         OutSignalName => "C405XXXMACHINECHECK",
         OutTemp       => C405XXXMACHINECHECK_OUT,
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405XXXMACHINECHECK,TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405XXXMACHINECHECK, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMEN,
         GlitchData    => DSOCMBRAMEN_GlitchData,
         OutSignalName => "DSOCMBRAMEN",
         OutTemp       => DSOCMBRAMEN_OUT,
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMEN,TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMEN, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBUSY,
         GlitchData    => DSOCMBUSY_GlitchData,
         OutSignalName => "DSOCMBUSY",
         OutTemp       => DSOCMBUSY_OUT,
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBUSY,TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBUSY, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMRDADDRVALID,
         GlitchData    => DSOCMRDADDRVALID_GlitchData,
         OutSignalName => "DSOCMRDADDRVALID",
         OutTemp       => DSOCMRDADDRVALID_OUT,
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMRDADDRVALID,TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMRDADDRVALID, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMWRADDRVALID,
         GlitchData    => DSOCMWRADDRVALID_GlitchData,
         OutSignalName => "DSOCMWRADDRVALID",
         OutTemp       => DSOCMWRADDRVALID_OUT,
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMWRADDRVALID,TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMWRADDRVALID, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRREAD,
         GlitchData    => EXTDCRREAD_GlitchData,
         OutSignalName => "EXTDCRREAD",
         OutTemp       => EXTDCRREAD_OUT,
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRREAD,TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRREAD, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRWRITE,
         GlitchData    => EXTDCRWRITE_GlitchData,
         OutSignalName => "EXTDCRWRITE",
         OutTemp       => EXTDCRWRITE_OUT,
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRWRITE,TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRWRITE, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMEN,
         GlitchData    => ISOCMBRAMEN_GlitchData,
         OutSignalName => "ISOCMBRAMEN",
         OutTemp       => ISOCMBRAMEN_OUT,
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMEN,TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMEN, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMEVENWRITEEN,
         GlitchData    => ISOCMBRAMEVENWRITEEN_GlitchData,
         OutSignalName => "ISOCMBRAMEVENWRITEEN",
         OutTemp       => ISOCMBRAMEVENWRITEEN_OUT,
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMEVENWRITEEN,TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMEVENWRITEEN, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMODDWRITEEN,
         GlitchData    => ISOCMBRAMODDWRITEEN_GlitchData,
         OutSignalName => "ISOCMBRAMODDWRITEEN",
         OutTemp       => ISOCMBRAMODDWRITEEN_OUT,
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMODDWRITEEN,TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMODDWRITEEN, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMDCRBRAMEVENEN,
         GlitchData    => ISOCMDCRBRAMEVENEN_GlitchData,
         OutSignalName => "ISOCMDCRBRAMEVENEN",
         OutTemp       => ISOCMDCRBRAMEVENEN_OUT,
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMDCRBRAMEVENEN,TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMDCRBRAMEVENEN, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMDCRBRAMODDEN,
         GlitchData    => ISOCMDCRBRAMODDEN_GlitchData,
         OutSignalName => "ISOCMDCRBRAMODDEN",
         OutTemp       => ISOCMDCRBRAMODDEN_OUT,
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMDCRBRAMODDEN,TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMDCRBRAMODDEN, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMDCRBRAMRDSELECT,
         GlitchData    => ISOCMDCRBRAMRDSELECT_GlitchData,
         OutSignalName => "ISOCMDCRBRAMRDSELECT",
         OutTemp       => ISOCMDCRBRAMRDSELECT_OUT,
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMDCRBRAMRDSELECT,TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMDCRBRAMRDSELECT, 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
---- bused path delays
     VitalPathDelay01
       (
         OutSignal     => APUFCMDECUDI(0),
         GlitchData    => APUFCMDECUDI0_GlitchData,
         OutSignalName => "APUFCMDECUDI(0)",
         OutTemp       => APUFCMDECUDI_OUT(0),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMDECUDI(0),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMDECUDI(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMDECUDI(1),
         GlitchData    => APUFCMDECUDI1_GlitchData,
         OutSignalName => "APUFCMDECUDI(1)",
         OutTemp       => APUFCMDECUDI_OUT(1),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMDECUDI(1),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMDECUDI(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMDECUDI(2),
         GlitchData    => APUFCMDECUDI2_GlitchData,
         OutSignalName => "APUFCMDECUDI(2)",
         OutTemp       => APUFCMDECUDI_OUT(2),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMDECUDI(2),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMDECUDI(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(0),
         GlitchData    => APUFCMINSTRUCTION0_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(0)",
         OutTemp       => APUFCMINSTRUCTION_OUT(0),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(0),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(1),
         GlitchData    => APUFCMINSTRUCTION1_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(1)",
         OutTemp       => APUFCMINSTRUCTION_OUT(1),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(1),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(2),
         GlitchData    => APUFCMINSTRUCTION2_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(2)",
         OutTemp       => APUFCMINSTRUCTION_OUT(2),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(2),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(3),
         GlitchData    => APUFCMINSTRUCTION3_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(3)",
         OutTemp       => APUFCMINSTRUCTION_OUT(3),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(3),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(4),
         GlitchData    => APUFCMINSTRUCTION4_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(4)",
         OutTemp       => APUFCMINSTRUCTION_OUT(4),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(4),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(5),
         GlitchData    => APUFCMINSTRUCTION5_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(5)",
         OutTemp       => APUFCMINSTRUCTION_OUT(5),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(5),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(6),
         GlitchData    => APUFCMINSTRUCTION6_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(6)",
         OutTemp       => APUFCMINSTRUCTION_OUT(6),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(6),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(7),
         GlitchData    => APUFCMINSTRUCTION7_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(7)",
         OutTemp       => APUFCMINSTRUCTION_OUT(7),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(7),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(8),
         GlitchData    => APUFCMINSTRUCTION8_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(8)",
         OutTemp       => APUFCMINSTRUCTION_OUT(8),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(8),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(9),
         GlitchData    => APUFCMINSTRUCTION9_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(9)",
         OutTemp       => APUFCMINSTRUCTION_OUT(9),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(9),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(10),
         GlitchData    => APUFCMINSTRUCTION10_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(10)",
         OutTemp       => APUFCMINSTRUCTION_OUT(10),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(10),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(11),
         GlitchData    => APUFCMINSTRUCTION11_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(11)",
         OutTemp       => APUFCMINSTRUCTION_OUT(11),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(11),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(12),
         GlitchData    => APUFCMINSTRUCTION12_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(12)",
         OutTemp       => APUFCMINSTRUCTION_OUT(12),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(12),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(13),
         GlitchData    => APUFCMINSTRUCTION13_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(13)",
         OutTemp       => APUFCMINSTRUCTION_OUT(13),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(13),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(14),
         GlitchData    => APUFCMINSTRUCTION14_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(14)",
         OutTemp       => APUFCMINSTRUCTION_OUT(14),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(14),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(15),
         GlitchData    => APUFCMINSTRUCTION15_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(15)",
         OutTemp       => APUFCMINSTRUCTION_OUT(15),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(15),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(16),
         GlitchData    => APUFCMINSTRUCTION16_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(16)",
         OutTemp       => APUFCMINSTRUCTION_OUT(16),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(16),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(17),
         GlitchData    => APUFCMINSTRUCTION17_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(17)",
         OutTemp       => APUFCMINSTRUCTION_OUT(17),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(17),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(18),
         GlitchData    => APUFCMINSTRUCTION18_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(18)",
         OutTemp       => APUFCMINSTRUCTION_OUT(18),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(18),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(19),
         GlitchData    => APUFCMINSTRUCTION19_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(19)",
         OutTemp       => APUFCMINSTRUCTION_OUT(19),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(19),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(20),
         GlitchData    => APUFCMINSTRUCTION20_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(20)",
         OutTemp       => APUFCMINSTRUCTION_OUT(20),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(20),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(21),
         GlitchData    => APUFCMINSTRUCTION21_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(21)",
         OutTemp       => APUFCMINSTRUCTION_OUT(21),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(21),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(22),
         GlitchData    => APUFCMINSTRUCTION22_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(22)",
         OutTemp       => APUFCMINSTRUCTION_OUT(22),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(22),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(23),
         GlitchData    => APUFCMINSTRUCTION23_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(23)",
         OutTemp       => APUFCMINSTRUCTION_OUT(23),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(23),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(24),
         GlitchData    => APUFCMINSTRUCTION24_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(24)",
         OutTemp       => APUFCMINSTRUCTION_OUT(24),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(24),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(25),
         GlitchData    => APUFCMINSTRUCTION25_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(25)",
         OutTemp       => APUFCMINSTRUCTION_OUT(25),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(25),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(26),
         GlitchData    => APUFCMINSTRUCTION26_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(26)",
         OutTemp       => APUFCMINSTRUCTION_OUT(26),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(26),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(27),
         GlitchData    => APUFCMINSTRUCTION27_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(27)",
         OutTemp       => APUFCMINSTRUCTION_OUT(27),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(27),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(28),
         GlitchData    => APUFCMINSTRUCTION28_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(28)",
         OutTemp       => APUFCMINSTRUCTION_OUT(28),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(28),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(29),
         GlitchData    => APUFCMINSTRUCTION29_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(29)",
         OutTemp       => APUFCMINSTRUCTION_OUT(29),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(29),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(29), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(30),
         GlitchData    => APUFCMINSTRUCTION30_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(30)",
         OutTemp       => APUFCMINSTRUCTION_OUT(30),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(30),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(30), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMINSTRUCTION(31),
         GlitchData    => APUFCMINSTRUCTION31_GlitchData,
         OutSignalName => "APUFCMINSTRUCTION(31)",
         OutTemp       => APUFCMINSTRUCTION_OUT(31),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMINSTRUCTION(31),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMINSTRUCTION(31), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADBYTEEN(0),
         GlitchData    => APUFCMLOADBYTEEN0_GlitchData,
         OutSignalName => "APUFCMLOADBYTEEN(0)",
         OutTemp       => APUFCMLOADBYTEEN_OUT(0),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADBYTEEN(0),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADBYTEEN(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADBYTEEN(1),
         GlitchData    => APUFCMLOADBYTEEN1_GlitchData,
         OutSignalName => "APUFCMLOADBYTEEN(1)",
         OutTemp       => APUFCMLOADBYTEEN_OUT(1),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADBYTEEN(1),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADBYTEEN(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADBYTEEN(2),
         GlitchData    => APUFCMLOADBYTEEN2_GlitchData,
         OutSignalName => "APUFCMLOADBYTEEN(2)",
         OutTemp       => APUFCMLOADBYTEEN_OUT(2),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADBYTEEN(2),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADBYTEEN(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADBYTEEN(3),
         GlitchData    => APUFCMLOADBYTEEN3_GlitchData,
         OutSignalName => "APUFCMLOADBYTEEN(3)",
         OutTemp       => APUFCMLOADBYTEEN_OUT(3),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADBYTEEN(3),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADBYTEEN(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(0),
         GlitchData    => APUFCMLOADDATA0_GlitchData,
         OutSignalName => "APUFCMLOADDATA(0)",
         OutTemp       => APUFCMLOADDATA_OUT(0),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(0),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(1),
         GlitchData    => APUFCMLOADDATA1_GlitchData,
         OutSignalName => "APUFCMLOADDATA(1)",
         OutTemp       => APUFCMLOADDATA_OUT(1),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(1),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(2),
         GlitchData    => APUFCMLOADDATA2_GlitchData,
         OutSignalName => "APUFCMLOADDATA(2)",
         OutTemp       => APUFCMLOADDATA_OUT(2),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(2),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(3),
         GlitchData    => APUFCMLOADDATA3_GlitchData,
         OutSignalName => "APUFCMLOADDATA(3)",
         OutTemp       => APUFCMLOADDATA_OUT(3),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(3),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(4),
         GlitchData    => APUFCMLOADDATA4_GlitchData,
         OutSignalName => "APUFCMLOADDATA(4)",
         OutTemp       => APUFCMLOADDATA_OUT(4),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(4),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(5),
         GlitchData    => APUFCMLOADDATA5_GlitchData,
         OutSignalName => "APUFCMLOADDATA(5)",
         OutTemp       => APUFCMLOADDATA_OUT(5),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(5),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(6),
         GlitchData    => APUFCMLOADDATA6_GlitchData,
         OutSignalName => "APUFCMLOADDATA(6)",
         OutTemp       => APUFCMLOADDATA_OUT(6),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(6),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(7),
         GlitchData    => APUFCMLOADDATA7_GlitchData,
         OutSignalName => "APUFCMLOADDATA(7)",
         OutTemp       => APUFCMLOADDATA_OUT(7),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(7),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(8),
         GlitchData    => APUFCMLOADDATA8_GlitchData,
         OutSignalName => "APUFCMLOADDATA(8)",
         OutTemp       => APUFCMLOADDATA_OUT(8),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(8),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(9),
         GlitchData    => APUFCMLOADDATA9_GlitchData,
         OutSignalName => "APUFCMLOADDATA(9)",
         OutTemp       => APUFCMLOADDATA_OUT(9),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(9),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(10),
         GlitchData    => APUFCMLOADDATA10_GlitchData,
         OutSignalName => "APUFCMLOADDATA(10)",
         OutTemp       => APUFCMLOADDATA_OUT(10),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(10),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(11),
         GlitchData    => APUFCMLOADDATA11_GlitchData,
         OutSignalName => "APUFCMLOADDATA(11)",
         OutTemp       => APUFCMLOADDATA_OUT(11),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(11),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(12),
         GlitchData    => APUFCMLOADDATA12_GlitchData,
         OutSignalName => "APUFCMLOADDATA(12)",
         OutTemp       => APUFCMLOADDATA_OUT(12),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(12),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(13),
         GlitchData    => APUFCMLOADDATA13_GlitchData,
         OutSignalName => "APUFCMLOADDATA(13)",
         OutTemp       => APUFCMLOADDATA_OUT(13),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(13),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(14),
         GlitchData    => APUFCMLOADDATA14_GlitchData,
         OutSignalName => "APUFCMLOADDATA(14)",
         OutTemp       => APUFCMLOADDATA_OUT(14),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(14),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(15),
         GlitchData    => APUFCMLOADDATA15_GlitchData,
         OutSignalName => "APUFCMLOADDATA(15)",
         OutTemp       => APUFCMLOADDATA_OUT(15),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(15),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(16),
         GlitchData    => APUFCMLOADDATA16_GlitchData,
         OutSignalName => "APUFCMLOADDATA(16)",
         OutTemp       => APUFCMLOADDATA_OUT(16),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(16),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(17),
         GlitchData    => APUFCMLOADDATA17_GlitchData,
         OutSignalName => "APUFCMLOADDATA(17)",
         OutTemp       => APUFCMLOADDATA_OUT(17),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(17),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(18),
         GlitchData    => APUFCMLOADDATA18_GlitchData,
         OutSignalName => "APUFCMLOADDATA(18)",
         OutTemp       => APUFCMLOADDATA_OUT(18),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(18),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(19),
         GlitchData    => APUFCMLOADDATA19_GlitchData,
         OutSignalName => "APUFCMLOADDATA(19)",
         OutTemp       => APUFCMLOADDATA_OUT(19),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(19),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(20),
         GlitchData    => APUFCMLOADDATA20_GlitchData,
         OutSignalName => "APUFCMLOADDATA(20)",
         OutTemp       => APUFCMLOADDATA_OUT(20),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(20),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(21),
         GlitchData    => APUFCMLOADDATA21_GlitchData,
         OutSignalName => "APUFCMLOADDATA(21)",
         OutTemp       => APUFCMLOADDATA_OUT(21),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(21),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(22),
         GlitchData    => APUFCMLOADDATA22_GlitchData,
         OutSignalName => "APUFCMLOADDATA(22)",
         OutTemp       => APUFCMLOADDATA_OUT(22),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(22),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(23),
         GlitchData    => APUFCMLOADDATA23_GlitchData,
         OutSignalName => "APUFCMLOADDATA(23)",
         OutTemp       => APUFCMLOADDATA_OUT(23),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(23),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(24),
         GlitchData    => APUFCMLOADDATA24_GlitchData,
         OutSignalName => "APUFCMLOADDATA(24)",
         OutTemp       => APUFCMLOADDATA_OUT(24),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(24),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(25),
         GlitchData    => APUFCMLOADDATA25_GlitchData,
         OutSignalName => "APUFCMLOADDATA(25)",
         OutTemp       => APUFCMLOADDATA_OUT(25),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(25),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(26),
         GlitchData    => APUFCMLOADDATA26_GlitchData,
         OutSignalName => "APUFCMLOADDATA(26)",
         OutTemp       => APUFCMLOADDATA_OUT(26),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(26),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(27),
         GlitchData    => APUFCMLOADDATA27_GlitchData,
         OutSignalName => "APUFCMLOADDATA(27)",
         OutTemp       => APUFCMLOADDATA_OUT(27),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(27),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(28),
         GlitchData    => APUFCMLOADDATA28_GlitchData,
         OutSignalName => "APUFCMLOADDATA(28)",
         OutTemp       => APUFCMLOADDATA_OUT(28),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(28),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(29),
         GlitchData    => APUFCMLOADDATA29_GlitchData,
         OutSignalName => "APUFCMLOADDATA(29)",
         OutTemp       => APUFCMLOADDATA_OUT(29),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(29),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(29), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(30),
         GlitchData    => APUFCMLOADDATA30_GlitchData,
         OutSignalName => "APUFCMLOADDATA(30)",
         OutTemp       => APUFCMLOADDATA_OUT(30),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(30),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(30), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMLOADDATA(31),
         GlitchData    => APUFCMLOADDATA31_GlitchData,
         OutSignalName => "APUFCMLOADDATA(31)",
         OutTemp       => APUFCMLOADDATA_OUT(31),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMLOADDATA(31),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMLOADDATA(31), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(0),
         GlitchData    => APUFCMRADATA0_GlitchData,
         OutSignalName => "APUFCMRADATA(0)",
         OutTemp       => APUFCMRADATA_OUT(0),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(0),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(1),
         GlitchData    => APUFCMRADATA1_GlitchData,
         OutSignalName => "APUFCMRADATA(1)",
         OutTemp       => APUFCMRADATA_OUT(1),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(1),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(2),
         GlitchData    => APUFCMRADATA2_GlitchData,
         OutSignalName => "APUFCMRADATA(2)",
         OutTemp       => APUFCMRADATA_OUT(2),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(2),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(3),
         GlitchData    => APUFCMRADATA3_GlitchData,
         OutSignalName => "APUFCMRADATA(3)",
         OutTemp       => APUFCMRADATA_OUT(3),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(3),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(4),
         GlitchData    => APUFCMRADATA4_GlitchData,
         OutSignalName => "APUFCMRADATA(4)",
         OutTemp       => APUFCMRADATA_OUT(4),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(4),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(5),
         GlitchData    => APUFCMRADATA5_GlitchData,
         OutSignalName => "APUFCMRADATA(5)",
         OutTemp       => APUFCMRADATA_OUT(5),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(5),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(6),
         GlitchData    => APUFCMRADATA6_GlitchData,
         OutSignalName => "APUFCMRADATA(6)",
         OutTemp       => APUFCMRADATA_OUT(6),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(6),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(7),
         GlitchData    => APUFCMRADATA7_GlitchData,
         OutSignalName => "APUFCMRADATA(7)",
         OutTemp       => APUFCMRADATA_OUT(7),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(7),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(8),
         GlitchData    => APUFCMRADATA8_GlitchData,
         OutSignalName => "APUFCMRADATA(8)",
         OutTemp       => APUFCMRADATA_OUT(8),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(8),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(9),
         GlitchData    => APUFCMRADATA9_GlitchData,
         OutSignalName => "APUFCMRADATA(9)",
         OutTemp       => APUFCMRADATA_OUT(9),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(9),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(10),
         GlitchData    => APUFCMRADATA10_GlitchData,
         OutSignalName => "APUFCMRADATA(10)",
         OutTemp       => APUFCMRADATA_OUT(10),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(10),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(11),
         GlitchData    => APUFCMRADATA11_GlitchData,
         OutSignalName => "APUFCMRADATA(11)",
         OutTemp       => APUFCMRADATA_OUT(11),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(11),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(12),
         GlitchData    => APUFCMRADATA12_GlitchData,
         OutSignalName => "APUFCMRADATA(12)",
         OutTemp       => APUFCMRADATA_OUT(12),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(12),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(13),
         GlitchData    => APUFCMRADATA13_GlitchData,
         OutSignalName => "APUFCMRADATA(13)",
         OutTemp       => APUFCMRADATA_OUT(13),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(13),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(14),
         GlitchData    => APUFCMRADATA14_GlitchData,
         OutSignalName => "APUFCMRADATA(14)",
         OutTemp       => APUFCMRADATA_OUT(14),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(14),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(15),
         GlitchData    => APUFCMRADATA15_GlitchData,
         OutSignalName => "APUFCMRADATA(15)",
         OutTemp       => APUFCMRADATA_OUT(15),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(15),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(16),
         GlitchData    => APUFCMRADATA16_GlitchData,
         OutSignalName => "APUFCMRADATA(16)",
         OutTemp       => APUFCMRADATA_OUT(16),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(16),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(17),
         GlitchData    => APUFCMRADATA17_GlitchData,
         OutSignalName => "APUFCMRADATA(17)",
         OutTemp       => APUFCMRADATA_OUT(17),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(17),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(18),
         GlitchData    => APUFCMRADATA18_GlitchData,
         OutSignalName => "APUFCMRADATA(18)",
         OutTemp       => APUFCMRADATA_OUT(18),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(18),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(19),
         GlitchData    => APUFCMRADATA19_GlitchData,
         OutSignalName => "APUFCMRADATA(19)",
         OutTemp       => APUFCMRADATA_OUT(19),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(19),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(20),
         GlitchData    => APUFCMRADATA20_GlitchData,
         OutSignalName => "APUFCMRADATA(20)",
         OutTemp       => APUFCMRADATA_OUT(20),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(20),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(21),
         GlitchData    => APUFCMRADATA21_GlitchData,
         OutSignalName => "APUFCMRADATA(21)",
         OutTemp       => APUFCMRADATA_OUT(21),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(21),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(22),
         GlitchData    => APUFCMRADATA22_GlitchData,
         OutSignalName => "APUFCMRADATA(22)",
         OutTemp       => APUFCMRADATA_OUT(22),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(22),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(23),
         GlitchData    => APUFCMRADATA23_GlitchData,
         OutSignalName => "APUFCMRADATA(23)",
         OutTemp       => APUFCMRADATA_OUT(23),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(23),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(24),
         GlitchData    => APUFCMRADATA24_GlitchData,
         OutSignalName => "APUFCMRADATA(24)",
         OutTemp       => APUFCMRADATA_OUT(24),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(24),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(25),
         GlitchData    => APUFCMRADATA25_GlitchData,
         OutSignalName => "APUFCMRADATA(25)",
         OutTemp       => APUFCMRADATA_OUT(25),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(25),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(26),
         GlitchData    => APUFCMRADATA26_GlitchData,
         OutSignalName => "APUFCMRADATA(26)",
         OutTemp       => APUFCMRADATA_OUT(26),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(26),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(27),
         GlitchData    => APUFCMRADATA27_GlitchData,
         OutSignalName => "APUFCMRADATA(27)",
         OutTemp       => APUFCMRADATA_OUT(27),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(27),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(28),
         GlitchData    => APUFCMRADATA28_GlitchData,
         OutSignalName => "APUFCMRADATA(28)",
         OutTemp       => APUFCMRADATA_OUT(28),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(28),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(29),
         GlitchData    => APUFCMRADATA29_GlitchData,
         OutSignalName => "APUFCMRADATA(29)",
         OutTemp       => APUFCMRADATA_OUT(29),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(29),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(29), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(30),
         GlitchData    => APUFCMRADATA30_GlitchData,
         OutSignalName => "APUFCMRADATA(30)",
         OutTemp       => APUFCMRADATA_OUT(30),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(30),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(30), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRADATA(31),
         GlitchData    => APUFCMRADATA31_GlitchData,
         OutSignalName => "APUFCMRADATA(31)",
         OutTemp       => APUFCMRADATA_OUT(31),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRADATA(31),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRADATA(31), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(0),
         GlitchData    => APUFCMRBDATA0_GlitchData,
         OutSignalName => "APUFCMRBDATA(0)",
         OutTemp       => APUFCMRBDATA_OUT(0),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(0),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(1),
         GlitchData    => APUFCMRBDATA1_GlitchData,
         OutSignalName => "APUFCMRBDATA(1)",
         OutTemp       => APUFCMRBDATA_OUT(1),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(1),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(2),
         GlitchData    => APUFCMRBDATA2_GlitchData,
         OutSignalName => "APUFCMRBDATA(2)",
         OutTemp       => APUFCMRBDATA_OUT(2),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(2),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(3),
         GlitchData    => APUFCMRBDATA3_GlitchData,
         OutSignalName => "APUFCMRBDATA(3)",
         OutTemp       => APUFCMRBDATA_OUT(3),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(3),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(4),
         GlitchData    => APUFCMRBDATA4_GlitchData,
         OutSignalName => "APUFCMRBDATA(4)",
         OutTemp       => APUFCMRBDATA_OUT(4),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(4),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(5),
         GlitchData    => APUFCMRBDATA5_GlitchData,
         OutSignalName => "APUFCMRBDATA(5)",
         OutTemp       => APUFCMRBDATA_OUT(5),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(5),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(6),
         GlitchData    => APUFCMRBDATA6_GlitchData,
         OutSignalName => "APUFCMRBDATA(6)",
         OutTemp       => APUFCMRBDATA_OUT(6),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(6),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(7),
         GlitchData    => APUFCMRBDATA7_GlitchData,
         OutSignalName => "APUFCMRBDATA(7)",
         OutTemp       => APUFCMRBDATA_OUT(7),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(7),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(8),
         GlitchData    => APUFCMRBDATA8_GlitchData,
         OutSignalName => "APUFCMRBDATA(8)",
         OutTemp       => APUFCMRBDATA_OUT(8),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(8),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(9),
         GlitchData    => APUFCMRBDATA9_GlitchData,
         OutSignalName => "APUFCMRBDATA(9)",
         OutTemp       => APUFCMRBDATA_OUT(9),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(9),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(10),
         GlitchData    => APUFCMRBDATA10_GlitchData,
         OutSignalName => "APUFCMRBDATA(10)",
         OutTemp       => APUFCMRBDATA_OUT(10),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(10),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(11),
         GlitchData    => APUFCMRBDATA11_GlitchData,
         OutSignalName => "APUFCMRBDATA(11)",
         OutTemp       => APUFCMRBDATA_OUT(11),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(11),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(12),
         GlitchData    => APUFCMRBDATA12_GlitchData,
         OutSignalName => "APUFCMRBDATA(12)",
         OutTemp       => APUFCMRBDATA_OUT(12),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(12),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(13),
         GlitchData    => APUFCMRBDATA13_GlitchData,
         OutSignalName => "APUFCMRBDATA(13)",
         OutTemp       => APUFCMRBDATA_OUT(13),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(13),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(14),
         GlitchData    => APUFCMRBDATA14_GlitchData,
         OutSignalName => "APUFCMRBDATA(14)",
         OutTemp       => APUFCMRBDATA_OUT(14),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(14),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(15),
         GlitchData    => APUFCMRBDATA15_GlitchData,
         OutSignalName => "APUFCMRBDATA(15)",
         OutTemp       => APUFCMRBDATA_OUT(15),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(15),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(16),
         GlitchData    => APUFCMRBDATA16_GlitchData,
         OutSignalName => "APUFCMRBDATA(16)",
         OutTemp       => APUFCMRBDATA_OUT(16),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(16),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(17),
         GlitchData    => APUFCMRBDATA17_GlitchData,
         OutSignalName => "APUFCMRBDATA(17)",
         OutTemp       => APUFCMRBDATA_OUT(17),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(17),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(18),
         GlitchData    => APUFCMRBDATA18_GlitchData,
         OutSignalName => "APUFCMRBDATA(18)",
         OutTemp       => APUFCMRBDATA_OUT(18),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(18),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(19),
         GlitchData    => APUFCMRBDATA19_GlitchData,
         OutSignalName => "APUFCMRBDATA(19)",
         OutTemp       => APUFCMRBDATA_OUT(19),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(19),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(20),
         GlitchData    => APUFCMRBDATA20_GlitchData,
         OutSignalName => "APUFCMRBDATA(20)",
         OutTemp       => APUFCMRBDATA_OUT(20),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(20),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(21),
         GlitchData    => APUFCMRBDATA21_GlitchData,
         OutSignalName => "APUFCMRBDATA(21)",
         OutTemp       => APUFCMRBDATA_OUT(21),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(21),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(22),
         GlitchData    => APUFCMRBDATA22_GlitchData,
         OutSignalName => "APUFCMRBDATA(22)",
         OutTemp       => APUFCMRBDATA_OUT(22),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(22),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(23),
         GlitchData    => APUFCMRBDATA23_GlitchData,
         OutSignalName => "APUFCMRBDATA(23)",
         OutTemp       => APUFCMRBDATA_OUT(23),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(23),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(24),
         GlitchData    => APUFCMRBDATA24_GlitchData,
         OutSignalName => "APUFCMRBDATA(24)",
         OutTemp       => APUFCMRBDATA_OUT(24),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(24),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(25),
         GlitchData    => APUFCMRBDATA25_GlitchData,
         OutSignalName => "APUFCMRBDATA(25)",
         OutTemp       => APUFCMRBDATA_OUT(25),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(25),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(26),
         GlitchData    => APUFCMRBDATA26_GlitchData,
         OutSignalName => "APUFCMRBDATA(26)",
         OutTemp       => APUFCMRBDATA_OUT(26),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(26),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(27),
         GlitchData    => APUFCMRBDATA27_GlitchData,
         OutSignalName => "APUFCMRBDATA(27)",
         OutTemp       => APUFCMRBDATA_OUT(27),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(27),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(28),
         GlitchData    => APUFCMRBDATA28_GlitchData,
         OutSignalName => "APUFCMRBDATA(28)",
         OutTemp       => APUFCMRBDATA_OUT(28),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(28),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(29),
         GlitchData    => APUFCMRBDATA29_GlitchData,
         OutSignalName => "APUFCMRBDATA(29)",
         OutTemp       => APUFCMRBDATA_OUT(29),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(29),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(29), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(30),
         GlitchData    => APUFCMRBDATA30_GlitchData,
         OutSignalName => "APUFCMRBDATA(30)",
         OutTemp       => APUFCMRBDATA_OUT(30),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(30),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(30), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => APUFCMRBDATA(31),
         GlitchData    => APUFCMRBDATA31_GlitchData,
         OutSignalName => "APUFCMRBDATA(31)",
         OutTemp       => APUFCMRBDATA_OUT(31),
         Paths         => (0 => (CPMFCMCLK_dly_1'last_event, tpd_CPMFCMCLK_APUFCMRBDATA(31),TRUE)),
	 DefaultDelay =>  tpd_CPMFCMCLK_APUFCMRBDATA(31), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(0),
         GlitchData    => C405DBGWBIAR0_GlitchData,
         OutSignalName => "C405DBGWBIAR(0)",
         OutTemp       => C405DBGWBIAR_OUT(0),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(0),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(1),
         GlitchData    => C405DBGWBIAR1_GlitchData,
         OutSignalName => "C405DBGWBIAR(1)",
         OutTemp       => C405DBGWBIAR_OUT(1),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(1),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(2),
         GlitchData    => C405DBGWBIAR2_GlitchData,
         OutSignalName => "C405DBGWBIAR(2)",
         OutTemp       => C405DBGWBIAR_OUT(2),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(2),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(3),
         GlitchData    => C405DBGWBIAR3_GlitchData,
         OutSignalName => "C405DBGWBIAR(3)",
         OutTemp       => C405DBGWBIAR_OUT(3),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(3),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(4),
         GlitchData    => C405DBGWBIAR4_GlitchData,
         OutSignalName => "C405DBGWBIAR(4)",
         OutTemp       => C405DBGWBIAR_OUT(4),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(4),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(5),
         GlitchData    => C405DBGWBIAR5_GlitchData,
         OutSignalName => "C405DBGWBIAR(5)",
         OutTemp       => C405DBGWBIAR_OUT(5),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(5),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(6),
         GlitchData    => C405DBGWBIAR6_GlitchData,
         OutSignalName => "C405DBGWBIAR(6)",
         OutTemp       => C405DBGWBIAR_OUT(6),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(6),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(7),
         GlitchData    => C405DBGWBIAR7_GlitchData,
         OutSignalName => "C405DBGWBIAR(7)",
         OutTemp       => C405DBGWBIAR_OUT(7),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(7),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(8),
         GlitchData    => C405DBGWBIAR8_GlitchData,
         OutSignalName => "C405DBGWBIAR(8)",
         OutTemp       => C405DBGWBIAR_OUT(8),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(8),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(9),
         GlitchData    => C405DBGWBIAR9_GlitchData,
         OutSignalName => "C405DBGWBIAR(9)",
         OutTemp       => C405DBGWBIAR_OUT(9),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(9),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(10),
         GlitchData    => C405DBGWBIAR10_GlitchData,
         OutSignalName => "C405DBGWBIAR(10)",
         OutTemp       => C405DBGWBIAR_OUT(10),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(10),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(11),
         GlitchData    => C405DBGWBIAR11_GlitchData,
         OutSignalName => "C405DBGWBIAR(11)",
         OutTemp       => C405DBGWBIAR_OUT(11),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(11),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(12),
         GlitchData    => C405DBGWBIAR12_GlitchData,
         OutSignalName => "C405DBGWBIAR(12)",
         OutTemp       => C405DBGWBIAR_OUT(12),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(12),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(13),
         GlitchData    => C405DBGWBIAR13_GlitchData,
         OutSignalName => "C405DBGWBIAR(13)",
         OutTemp       => C405DBGWBIAR_OUT(13),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(13),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(14),
         GlitchData    => C405DBGWBIAR14_GlitchData,
         OutSignalName => "C405DBGWBIAR(14)",
         OutTemp       => C405DBGWBIAR_OUT(14),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(14),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(15),
         GlitchData    => C405DBGWBIAR15_GlitchData,
         OutSignalName => "C405DBGWBIAR(15)",
         OutTemp       => C405DBGWBIAR_OUT(15),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(15),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(16),
         GlitchData    => C405DBGWBIAR16_GlitchData,
         OutSignalName => "C405DBGWBIAR(16)",
         OutTemp       => C405DBGWBIAR_OUT(16),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(16),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(17),
         GlitchData    => C405DBGWBIAR17_GlitchData,
         OutSignalName => "C405DBGWBIAR(17)",
         OutTemp       => C405DBGWBIAR_OUT(17),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(17),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(18),
         GlitchData    => C405DBGWBIAR18_GlitchData,
         OutSignalName => "C405DBGWBIAR(18)",
         OutTemp       => C405DBGWBIAR_OUT(18),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(18),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(19),
         GlitchData    => C405DBGWBIAR19_GlitchData,
         OutSignalName => "C405DBGWBIAR(19)",
         OutTemp       => C405DBGWBIAR_OUT(19),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(19),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(20),
         GlitchData    => C405DBGWBIAR20_GlitchData,
         OutSignalName => "C405DBGWBIAR(20)",
         OutTemp       => C405DBGWBIAR_OUT(20),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(20),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(21),
         GlitchData    => C405DBGWBIAR21_GlitchData,
         OutSignalName => "C405DBGWBIAR(21)",
         OutTemp       => C405DBGWBIAR_OUT(21),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(21),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(22),
         GlitchData    => C405DBGWBIAR22_GlitchData,
         OutSignalName => "C405DBGWBIAR(22)",
         OutTemp       => C405DBGWBIAR_OUT(22),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(22),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(23),
         GlitchData    => C405DBGWBIAR23_GlitchData,
         OutSignalName => "C405DBGWBIAR(23)",
         OutTemp       => C405DBGWBIAR_OUT(23),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(23),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(24),
         GlitchData    => C405DBGWBIAR24_GlitchData,
         OutSignalName => "C405DBGWBIAR(24)",
         OutTemp       => C405DBGWBIAR_OUT(24),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(24),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(25),
         GlitchData    => C405DBGWBIAR25_GlitchData,
         OutSignalName => "C405DBGWBIAR(25)",
         OutTemp       => C405DBGWBIAR_OUT(25),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(25),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(26),
         GlitchData    => C405DBGWBIAR26_GlitchData,
         OutSignalName => "C405DBGWBIAR(26)",
         OutTemp       => C405DBGWBIAR_OUT(26),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(26),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(27),
         GlitchData    => C405DBGWBIAR27_GlitchData,
         OutSignalName => "C405DBGWBIAR(27)",
         OutTemp       => C405DBGWBIAR_OUT(27),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(27),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(28),
         GlitchData    => C405DBGWBIAR28_GlitchData,
         OutSignalName => "C405DBGWBIAR(28)",
         OutTemp       => C405DBGWBIAR_OUT(28),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(28),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405DBGWBIAR(29),
         GlitchData    => C405DBGWBIAR29_GlitchData,
         OutSignalName => "C405DBGWBIAR(29)",
         OutTemp       => C405DBGWBIAR_OUT(29),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405DBGWBIAR(29),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405DBGWBIAR(29), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(0),
         GlitchData    => C405PLBDCUABUS0_GlitchData,
         OutSignalName => "C405PLBDCUABUS(0)",
         OutTemp       => C405PLBDCUABUS_OUT(0),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(0),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(1),
         GlitchData    => C405PLBDCUABUS1_GlitchData,
         OutSignalName => "C405PLBDCUABUS(1)",
         OutTemp       => C405PLBDCUABUS_OUT(1),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(1),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(2),
         GlitchData    => C405PLBDCUABUS2_GlitchData,
         OutSignalName => "C405PLBDCUABUS(2)",
         OutTemp       => C405PLBDCUABUS_OUT(2),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(2),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(3),
         GlitchData    => C405PLBDCUABUS3_GlitchData,
         OutSignalName => "C405PLBDCUABUS(3)",
         OutTemp       => C405PLBDCUABUS_OUT(3),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(3),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(4),
         GlitchData    => C405PLBDCUABUS4_GlitchData,
         OutSignalName => "C405PLBDCUABUS(4)",
         OutTemp       => C405PLBDCUABUS_OUT(4),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(4),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(5),
         GlitchData    => C405PLBDCUABUS5_GlitchData,
         OutSignalName => "C405PLBDCUABUS(5)",
         OutTemp       => C405PLBDCUABUS_OUT(5),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(5),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(6),
         GlitchData    => C405PLBDCUABUS6_GlitchData,
         OutSignalName => "C405PLBDCUABUS(6)",
         OutTemp       => C405PLBDCUABUS_OUT(6),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(6),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(7),
         GlitchData    => C405PLBDCUABUS7_GlitchData,
         OutSignalName => "C405PLBDCUABUS(7)",
         OutTemp       => C405PLBDCUABUS_OUT(7),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(7),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(8),
         GlitchData    => C405PLBDCUABUS8_GlitchData,
         OutSignalName => "C405PLBDCUABUS(8)",
         OutTemp       => C405PLBDCUABUS_OUT(8),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(8),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(9),
         GlitchData    => C405PLBDCUABUS9_GlitchData,
         OutSignalName => "C405PLBDCUABUS(9)",
         OutTemp       => C405PLBDCUABUS_OUT(9),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(9),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(10),
         GlitchData    => C405PLBDCUABUS10_GlitchData,
         OutSignalName => "C405PLBDCUABUS(10)",
         OutTemp       => C405PLBDCUABUS_OUT(10),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(10),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(11),
         GlitchData    => C405PLBDCUABUS11_GlitchData,
         OutSignalName => "C405PLBDCUABUS(11)",
         OutTemp       => C405PLBDCUABUS_OUT(11),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(11),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(12),
         GlitchData    => C405PLBDCUABUS12_GlitchData,
         OutSignalName => "C405PLBDCUABUS(12)",
         OutTemp       => C405PLBDCUABUS_OUT(12),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(12),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(13),
         GlitchData    => C405PLBDCUABUS13_GlitchData,
         OutSignalName => "C405PLBDCUABUS(13)",
         OutTemp       => C405PLBDCUABUS_OUT(13),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(13),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(14),
         GlitchData    => C405PLBDCUABUS14_GlitchData,
         OutSignalName => "C405PLBDCUABUS(14)",
         OutTemp       => C405PLBDCUABUS_OUT(14),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(14),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(15),
         GlitchData    => C405PLBDCUABUS15_GlitchData,
         OutSignalName => "C405PLBDCUABUS(15)",
         OutTemp       => C405PLBDCUABUS_OUT(15),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(15),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(16),
         GlitchData    => C405PLBDCUABUS16_GlitchData,
         OutSignalName => "C405PLBDCUABUS(16)",
         OutTemp       => C405PLBDCUABUS_OUT(16),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(16),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(17),
         GlitchData    => C405PLBDCUABUS17_GlitchData,
         OutSignalName => "C405PLBDCUABUS(17)",
         OutTemp       => C405PLBDCUABUS_OUT(17),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(17),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(18),
         GlitchData    => C405PLBDCUABUS18_GlitchData,
         OutSignalName => "C405PLBDCUABUS(18)",
         OutTemp       => C405PLBDCUABUS_OUT(18),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(18),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(19),
         GlitchData    => C405PLBDCUABUS19_GlitchData,
         OutSignalName => "C405PLBDCUABUS(19)",
         OutTemp       => C405PLBDCUABUS_OUT(19),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(19),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(20),
         GlitchData    => C405PLBDCUABUS20_GlitchData,
         OutSignalName => "C405PLBDCUABUS(20)",
         OutTemp       => C405PLBDCUABUS_OUT(20),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(20),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(21),
         GlitchData    => C405PLBDCUABUS21_GlitchData,
         OutSignalName => "C405PLBDCUABUS(21)",
         OutTemp       => C405PLBDCUABUS_OUT(21),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(21),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(22),
         GlitchData    => C405PLBDCUABUS22_GlitchData,
         OutSignalName => "C405PLBDCUABUS(22)",
         OutTemp       => C405PLBDCUABUS_OUT(22),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(22),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(23),
         GlitchData    => C405PLBDCUABUS23_GlitchData,
         OutSignalName => "C405PLBDCUABUS(23)",
         OutTemp       => C405PLBDCUABUS_OUT(23),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(23),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(24),
         GlitchData    => C405PLBDCUABUS24_GlitchData,
         OutSignalName => "C405PLBDCUABUS(24)",
         OutTemp       => C405PLBDCUABUS_OUT(24),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(24),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(25),
         GlitchData    => C405PLBDCUABUS25_GlitchData,
         OutSignalName => "C405PLBDCUABUS(25)",
         OutTemp       => C405PLBDCUABUS_OUT(25),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(25),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(26),
         GlitchData    => C405PLBDCUABUS26_GlitchData,
         OutSignalName => "C405PLBDCUABUS(26)",
         OutTemp       => C405PLBDCUABUS_OUT(26),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(26),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(27),
         GlitchData    => C405PLBDCUABUS27_GlitchData,
         OutSignalName => "C405PLBDCUABUS(27)",
         OutTemp       => C405PLBDCUABUS_OUT(27),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(27),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(28),
         GlitchData    => C405PLBDCUABUS28_GlitchData,
         OutSignalName => "C405PLBDCUABUS(28)",
         OutTemp       => C405PLBDCUABUS_OUT(28),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(28),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(29),
         GlitchData    => C405PLBDCUABUS29_GlitchData,
         OutSignalName => "C405PLBDCUABUS(29)",
         OutTemp       => C405PLBDCUABUS_OUT(29),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(29),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(29), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(30),
         GlitchData    => C405PLBDCUABUS30_GlitchData,
         OutSignalName => "C405PLBDCUABUS(30)",
         OutTemp       => C405PLBDCUABUS_OUT(30),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(30),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(30), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUABUS(31),
         GlitchData    => C405PLBDCUABUS31_GlitchData,
         OutSignalName => "C405PLBDCUABUS(31)",
         OutTemp       => C405PLBDCUABUS_OUT(31),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUABUS(31),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUABUS(31), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUBE(0),
         GlitchData    => C405PLBDCUBE0_GlitchData,
         OutSignalName => "C405PLBDCUBE(0)",
         OutTemp       => C405PLBDCUBE_OUT(0),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUBE(0),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUBE(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUBE(1),
         GlitchData    => C405PLBDCUBE1_GlitchData,
         OutSignalName => "C405PLBDCUBE(1)",
         OutTemp       => C405PLBDCUBE_OUT(1),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUBE(1),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUBE(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUBE(2),
         GlitchData    => C405PLBDCUBE2_GlitchData,
         OutSignalName => "C405PLBDCUBE(2)",
         OutTemp       => C405PLBDCUBE_OUT(2),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUBE(2),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUBE(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUBE(3),
         GlitchData    => C405PLBDCUBE3_GlitchData,
         OutSignalName => "C405PLBDCUBE(3)",
         OutTemp       => C405PLBDCUBE_OUT(3),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUBE(3),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUBE(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUBE(4),
         GlitchData    => C405PLBDCUBE4_GlitchData,
         OutSignalName => "C405PLBDCUBE(4)",
         OutTemp       => C405PLBDCUBE_OUT(4),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUBE(4),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUBE(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUBE(5),
         GlitchData    => C405PLBDCUBE5_GlitchData,
         OutSignalName => "C405PLBDCUBE(5)",
         OutTemp       => C405PLBDCUBE_OUT(5),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUBE(5),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUBE(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUBE(6),
         GlitchData    => C405PLBDCUBE6_GlitchData,
         OutSignalName => "C405PLBDCUBE(6)",
         OutTemp       => C405PLBDCUBE_OUT(6),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUBE(6),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUBE(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUBE(7),
         GlitchData    => C405PLBDCUBE7_GlitchData,
         OutSignalName => "C405PLBDCUBE(7)",
         OutTemp       => C405PLBDCUBE_OUT(7),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUBE(7),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUBE(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUPRIORITY(0),
         GlitchData    => C405PLBDCUPRIORITY0_GlitchData,
         OutSignalName => "C405PLBDCUPRIORITY(0)",
         OutTemp       => C405PLBDCUPRIORITY_OUT(0),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUPRIORITY(0),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUPRIORITY(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUPRIORITY(1),
         GlitchData    => C405PLBDCUPRIORITY1_GlitchData,
         OutSignalName => "C405PLBDCUPRIORITY(1)",
         OutTemp       => C405PLBDCUPRIORITY_OUT(1),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUPRIORITY(1),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUPRIORITY(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(0),
         GlitchData    => C405PLBDCUWRDBUS0_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(0)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(0),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(0),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(1),
         GlitchData    => C405PLBDCUWRDBUS1_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(1)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(1),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(1),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(2),
         GlitchData    => C405PLBDCUWRDBUS2_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(2)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(2),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(2),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(3),
         GlitchData    => C405PLBDCUWRDBUS3_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(3)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(3),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(3),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(4),
         GlitchData    => C405PLBDCUWRDBUS4_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(4)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(4),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(4),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(5),
         GlitchData    => C405PLBDCUWRDBUS5_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(5)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(5),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(5),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(6),
         GlitchData    => C405PLBDCUWRDBUS6_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(6)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(6),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(6),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(7),
         GlitchData    => C405PLBDCUWRDBUS7_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(7)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(7),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(7),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(8),
         GlitchData    => C405PLBDCUWRDBUS8_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(8)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(8),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(8),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(9),
         GlitchData    => C405PLBDCUWRDBUS9_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(9)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(9),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(9),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(10),
         GlitchData    => C405PLBDCUWRDBUS10_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(10)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(10),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(10),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(11),
         GlitchData    => C405PLBDCUWRDBUS11_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(11)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(11),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(11),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(12),
         GlitchData    => C405PLBDCUWRDBUS12_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(12)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(12),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(12),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(13),
         GlitchData    => C405PLBDCUWRDBUS13_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(13)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(13),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(13),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(14),
         GlitchData    => C405PLBDCUWRDBUS14_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(14)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(14),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(14),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(15),
         GlitchData    => C405PLBDCUWRDBUS15_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(15)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(15),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(15),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(16),
         GlitchData    => C405PLBDCUWRDBUS16_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(16)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(16),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(16),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(17),
         GlitchData    => C405PLBDCUWRDBUS17_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(17)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(17),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(17),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(18),
         GlitchData    => C405PLBDCUWRDBUS18_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(18)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(18),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(18),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(19),
         GlitchData    => C405PLBDCUWRDBUS19_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(19)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(19),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(19),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(20),
         GlitchData    => C405PLBDCUWRDBUS20_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(20)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(20),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(20),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(21),
         GlitchData    => C405PLBDCUWRDBUS21_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(21)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(21),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(21),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(22),
         GlitchData    => C405PLBDCUWRDBUS22_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(22)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(22),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(22),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(23),
         GlitchData    => C405PLBDCUWRDBUS23_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(23)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(23),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(23),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(24),
         GlitchData    => C405PLBDCUWRDBUS24_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(24)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(24),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(24),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(25),
         GlitchData    => C405PLBDCUWRDBUS25_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(25)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(25),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(25),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(26),
         GlitchData    => C405PLBDCUWRDBUS26_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(26)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(26),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(26),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(27),
         GlitchData    => C405PLBDCUWRDBUS27_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(27)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(27),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(27),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(28),
         GlitchData    => C405PLBDCUWRDBUS28_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(28)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(28),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(28),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(29),
         GlitchData    => C405PLBDCUWRDBUS29_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(29)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(29),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(29),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(29), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(30),
         GlitchData    => C405PLBDCUWRDBUS30_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(30)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(30),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(30),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(30), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(31),
         GlitchData    => C405PLBDCUWRDBUS31_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(31)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(31),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(31),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(31), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(32),
         GlitchData    => C405PLBDCUWRDBUS32_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(32)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(32),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(32),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(32), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(33),
         GlitchData    => C405PLBDCUWRDBUS33_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(33)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(33),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(33),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(33), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(34),
         GlitchData    => C405PLBDCUWRDBUS34_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(34)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(34),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(34),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(34), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(35),
         GlitchData    => C405PLBDCUWRDBUS35_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(35)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(35),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(35),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(35), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(36),
         GlitchData    => C405PLBDCUWRDBUS36_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(36)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(36),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(36),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(36), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(37),
         GlitchData    => C405PLBDCUWRDBUS37_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(37)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(37),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(37),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(37), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(38),
         GlitchData    => C405PLBDCUWRDBUS38_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(38)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(38),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(38),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(38), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(39),
         GlitchData    => C405PLBDCUWRDBUS39_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(39)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(39),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(39),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(39), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(40),
         GlitchData    => C405PLBDCUWRDBUS40_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(40)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(40),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(40),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(40), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(41),
         GlitchData    => C405PLBDCUWRDBUS41_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(41)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(41),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(41),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(41), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(42),
         GlitchData    => C405PLBDCUWRDBUS42_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(42)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(42),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(42),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(42), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(43),
         GlitchData    => C405PLBDCUWRDBUS43_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(43)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(43),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(43),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(43), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(44),
         GlitchData    => C405PLBDCUWRDBUS44_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(44)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(44),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(44),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(44), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(45),
         GlitchData    => C405PLBDCUWRDBUS45_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(45)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(45),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(45),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(45), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(46),
         GlitchData    => C405PLBDCUWRDBUS46_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(46)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(46),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(46),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(46), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(47),
         GlitchData    => C405PLBDCUWRDBUS47_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(47)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(47),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(47),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(47), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(48),
         GlitchData    => C405PLBDCUWRDBUS48_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(48)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(48),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(48),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(48), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(49),
         GlitchData    => C405PLBDCUWRDBUS49_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(49)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(49),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(49),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(49), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(50),
         GlitchData    => C405PLBDCUWRDBUS50_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(50)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(50),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(50),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(50), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(51),
         GlitchData    => C405PLBDCUWRDBUS51_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(51)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(51),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(51),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(51), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(52),
         GlitchData    => C405PLBDCUWRDBUS52_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(52)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(52),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(52),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(52), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(53),
         GlitchData    => C405PLBDCUWRDBUS53_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(53)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(53),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(53),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(53), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(54),
         GlitchData    => C405PLBDCUWRDBUS54_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(54)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(54),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(54),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(54), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(55),
         GlitchData    => C405PLBDCUWRDBUS55_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(55)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(55),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(55),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(55), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(56),
         GlitchData    => C405PLBDCUWRDBUS56_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(56)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(56),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(56),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(56), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(57),
         GlitchData    => C405PLBDCUWRDBUS57_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(57)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(57),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(57),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(57), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(58),
         GlitchData    => C405PLBDCUWRDBUS58_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(58)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(58),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(58),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(58), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(59),
         GlitchData    => C405PLBDCUWRDBUS59_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(59)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(59),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(59),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(59), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(60),
         GlitchData    => C405PLBDCUWRDBUS60_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(60)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(60),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(60),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(60), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(61),
         GlitchData    => C405PLBDCUWRDBUS61_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(61)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(61),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(61),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(61), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(62),
         GlitchData    => C405PLBDCUWRDBUS62_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(62)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(62),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(62),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(62), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBDCUWRDBUS(63),
         GlitchData    => C405PLBDCUWRDBUS63_GlitchData,
         OutSignalName => "C405PLBDCUWRDBUS(63)",
         OutTemp       => C405PLBDCUWRDBUS_OUT(63),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBDCUWRDBUS(63),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBDCUWRDBUS(63), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(0),
         GlitchData    => C405PLBICUABUS0_GlitchData,
         OutSignalName => "C405PLBICUABUS(0)",
         OutTemp       => C405PLBICUABUS_OUT(0),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(0),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(1),
         GlitchData    => C405PLBICUABUS1_GlitchData,
         OutSignalName => "C405PLBICUABUS(1)",
         OutTemp       => C405PLBICUABUS_OUT(1),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(1),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(2),
         GlitchData    => C405PLBICUABUS2_GlitchData,
         OutSignalName => "C405PLBICUABUS(2)",
         OutTemp       => C405PLBICUABUS_OUT(2),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(2),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(3),
         GlitchData    => C405PLBICUABUS3_GlitchData,
         OutSignalName => "C405PLBICUABUS(3)",
         OutTemp       => C405PLBICUABUS_OUT(3),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(3),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(4),
         GlitchData    => C405PLBICUABUS4_GlitchData,
         OutSignalName => "C405PLBICUABUS(4)",
         OutTemp       => C405PLBICUABUS_OUT(4),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(4),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(5),
         GlitchData    => C405PLBICUABUS5_GlitchData,
         OutSignalName => "C405PLBICUABUS(5)",
         OutTemp       => C405PLBICUABUS_OUT(5),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(5),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(6),
         GlitchData    => C405PLBICUABUS6_GlitchData,
         OutSignalName => "C405PLBICUABUS(6)",
         OutTemp       => C405PLBICUABUS_OUT(6),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(6),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(7),
         GlitchData    => C405PLBICUABUS7_GlitchData,
         OutSignalName => "C405PLBICUABUS(7)",
         OutTemp       => C405PLBICUABUS_OUT(7),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(7),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(8),
         GlitchData    => C405PLBICUABUS8_GlitchData,
         OutSignalName => "C405PLBICUABUS(8)",
         OutTemp       => C405PLBICUABUS_OUT(8),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(8),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(9),
         GlitchData    => C405PLBICUABUS9_GlitchData,
         OutSignalName => "C405PLBICUABUS(9)",
         OutTemp       => C405PLBICUABUS_OUT(9),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(9),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(10),
         GlitchData    => C405PLBICUABUS10_GlitchData,
         OutSignalName => "C405PLBICUABUS(10)",
         OutTemp       => C405PLBICUABUS_OUT(10),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(10),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(11),
         GlitchData    => C405PLBICUABUS11_GlitchData,
         OutSignalName => "C405PLBICUABUS(11)",
         OutTemp       => C405PLBICUABUS_OUT(11),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(11),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(12),
         GlitchData    => C405PLBICUABUS12_GlitchData,
         OutSignalName => "C405PLBICUABUS(12)",
         OutTemp       => C405PLBICUABUS_OUT(12),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(12),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(13),
         GlitchData    => C405PLBICUABUS13_GlitchData,
         OutSignalName => "C405PLBICUABUS(13)",
         OutTemp       => C405PLBICUABUS_OUT(13),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(13),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(14),
         GlitchData    => C405PLBICUABUS14_GlitchData,
         OutSignalName => "C405PLBICUABUS(14)",
         OutTemp       => C405PLBICUABUS_OUT(14),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(14),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(15),
         GlitchData    => C405PLBICUABUS15_GlitchData,
         OutSignalName => "C405PLBICUABUS(15)",
         OutTemp       => C405PLBICUABUS_OUT(15),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(15),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(16),
         GlitchData    => C405PLBICUABUS16_GlitchData,
         OutSignalName => "C405PLBICUABUS(16)",
         OutTemp       => C405PLBICUABUS_OUT(16),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(16),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(17),
         GlitchData    => C405PLBICUABUS17_GlitchData,
         OutSignalName => "C405PLBICUABUS(17)",
         OutTemp       => C405PLBICUABUS_OUT(17),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(17),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(18),
         GlitchData    => C405PLBICUABUS18_GlitchData,
         OutSignalName => "C405PLBICUABUS(18)",
         OutTemp       => C405PLBICUABUS_OUT(18),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(18),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(19),
         GlitchData    => C405PLBICUABUS19_GlitchData,
         OutSignalName => "C405PLBICUABUS(19)",
         OutTemp       => C405PLBICUABUS_OUT(19),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(19),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(20),
         GlitchData    => C405PLBICUABUS20_GlitchData,
         OutSignalName => "C405PLBICUABUS(20)",
         OutTemp       => C405PLBICUABUS_OUT(20),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(20),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(21),
         GlitchData    => C405PLBICUABUS21_GlitchData,
         OutSignalName => "C405PLBICUABUS(21)",
         OutTemp       => C405PLBICUABUS_OUT(21),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(21),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(22),
         GlitchData    => C405PLBICUABUS22_GlitchData,
         OutSignalName => "C405PLBICUABUS(22)",
         OutTemp       => C405PLBICUABUS_OUT(22),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(22),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(23),
         GlitchData    => C405PLBICUABUS23_GlitchData,
         OutSignalName => "C405PLBICUABUS(23)",
         OutTemp       => C405PLBICUABUS_OUT(23),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(23),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(24),
         GlitchData    => C405PLBICUABUS24_GlitchData,
         OutSignalName => "C405PLBICUABUS(24)",
         OutTemp       => C405PLBICUABUS_OUT(24),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(24),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(25),
         GlitchData    => C405PLBICUABUS25_GlitchData,
         OutSignalName => "C405PLBICUABUS(25)",
         OutTemp       => C405PLBICUABUS_OUT(25),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(25),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(26),
         GlitchData    => C405PLBICUABUS26_GlitchData,
         OutSignalName => "C405PLBICUABUS(26)",
         OutTemp       => C405PLBICUABUS_OUT(26),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(26),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(27),
         GlitchData    => C405PLBICUABUS27_GlitchData,
         OutSignalName => "C405PLBICUABUS(27)",
         OutTemp       => C405PLBICUABUS_OUT(27),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(27),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(28),
         GlitchData    => C405PLBICUABUS28_GlitchData,
         OutSignalName => "C405PLBICUABUS(28)",
         OutTemp       => C405PLBICUABUS_OUT(28),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(28),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUABUS(29),
         GlitchData    => C405PLBICUABUS29_GlitchData,
         OutSignalName => "C405PLBICUABUS(29)",
         OutTemp       => C405PLBICUABUS_OUT(29),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUABUS(29),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUABUS(29), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUPRIORITY(0),
         GlitchData    => C405PLBICUPRIORITY0_GlitchData,
         OutSignalName => "C405PLBICUPRIORITY(0)",
         OutTemp       => C405PLBICUPRIORITY_OUT(0),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUPRIORITY(0),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUPRIORITY(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUPRIORITY(1),
         GlitchData    => C405PLBICUPRIORITY1_GlitchData,
         OutSignalName => "C405PLBICUPRIORITY(1)",
         OutTemp       => C405PLBICUPRIORITY_OUT(1),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUPRIORITY(1),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUPRIORITY(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUSIZE(2),
         GlitchData    => C405PLBICUSIZE2_GlitchData,
         OutSignalName => "C405PLBICUSIZE(2)",
         OutTemp       => C405PLBICUSIZE_OUT(2),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUSIZE(2),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUSIZE(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405PLBICUSIZE(3),
         GlitchData    => C405PLBICUSIZE3_GlitchData,
         OutSignalName => "C405PLBICUSIZE(3)",
         OutTemp       => C405PLBICUSIZE_OUT(3),
         Paths         => (0 => (PLBCLK_dly_1'last_event, tpd_PLBCLK_C405PLBICUSIZE(3),TRUE)),
	 DefaultDelay =>  tpd_PLBCLK_C405PLBICUSIZE(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCEVENEXECUTIONSTATUS(0),
         GlitchData    => C405TRCEVENEXECUTIONSTATUS0_GlitchData,
         OutSignalName => "C405TRCEVENEXECUTIONSTATUS(0)",
         OutTemp       => C405TRCEVENEXECUTIONSTATUS_OUT(0),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCEVENEXECUTIONSTATUS(0),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCEVENEXECUTIONSTATUS(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCEVENEXECUTIONSTATUS(1),
         GlitchData    => C405TRCEVENEXECUTIONSTATUS1_GlitchData,
         OutSignalName => "C405TRCEVENEXECUTIONSTATUS(1)",
         OutTemp       => C405TRCEVENEXECUTIONSTATUS_OUT(1),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCEVENEXECUTIONSTATUS(1),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCEVENEXECUTIONSTATUS(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCODDEXECUTIONSTATUS(0),
         GlitchData    => C405TRCODDEXECUTIONSTATUS0_GlitchData,
         OutSignalName => "C405TRCODDEXECUTIONSTATUS(0)",
         OutTemp       => C405TRCODDEXECUTIONSTATUS_OUT(0),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCODDEXECUTIONSTATUS(0),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCODDEXECUTIONSTATUS(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCODDEXECUTIONSTATUS(1),
         GlitchData    => C405TRCODDEXECUTIONSTATUS1_GlitchData,
         OutSignalName => "C405TRCODDEXECUTIONSTATUS(1)",
         OutTemp       => C405TRCODDEXECUTIONSTATUS_OUT(1),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCODDEXECUTIONSTATUS(1),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCODDEXECUTIONSTATUS(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRACESTATUS(0),
         GlitchData    => C405TRCTRACESTATUS0_GlitchData,
         OutSignalName => "C405TRCTRACESTATUS(0)",
         OutTemp       => C405TRCTRACESTATUS_OUT(0),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRACESTATUS(0),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRACESTATUS(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRACESTATUS(1),
         GlitchData    => C405TRCTRACESTATUS1_GlitchData,
         OutSignalName => "C405TRCTRACESTATUS(1)",
         OutTemp       => C405TRCTRACESTATUS_OUT(1),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRACESTATUS(1),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRACESTATUS(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRACESTATUS(2),
         GlitchData    => C405TRCTRACESTATUS2_GlitchData,
         OutSignalName => "C405TRCTRACESTATUS(2)",
         OutTemp       => C405TRCTRACESTATUS_OUT(2),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRACESTATUS(2),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRACESTATUS(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRACESTATUS(3),
         GlitchData    => C405TRCTRACESTATUS3_GlitchData,
         OutSignalName => "C405TRCTRACESTATUS(3)",
         OutTemp       => C405TRCTRACESTATUS_OUT(3),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRACESTATUS(3),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRACESTATUS(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRIGGEREVENTTYPE(0),
         GlitchData    => C405TRCTRIGGEREVENTTYPE0_GlitchData,
         OutSignalName => "C405TRCTRIGGEREVENTTYPE(0)",
         OutTemp       => C405TRCTRIGGEREVENTTYPE_OUT(0),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(0),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRIGGEREVENTTYPE(1),
         GlitchData    => C405TRCTRIGGEREVENTTYPE1_GlitchData,
         OutSignalName => "C405TRCTRIGGEREVENTTYPE(1)",
         OutTemp       => C405TRCTRIGGEREVENTTYPE_OUT(1),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(1),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRIGGEREVENTTYPE(2),
         GlitchData    => C405TRCTRIGGEREVENTTYPE2_GlitchData,
         OutSignalName => "C405TRCTRIGGEREVENTTYPE(2)",
         OutTemp       => C405TRCTRIGGEREVENTTYPE_OUT(2),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(2),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRIGGEREVENTTYPE(3),
         GlitchData    => C405TRCTRIGGEREVENTTYPE3_GlitchData,
         OutSignalName => "C405TRCTRIGGEREVENTTYPE(3)",
         OutTemp       => C405TRCTRIGGEREVENTTYPE_OUT(3),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(3),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRIGGEREVENTTYPE(4),
         GlitchData    => C405TRCTRIGGEREVENTTYPE4_GlitchData,
         OutSignalName => "C405TRCTRIGGEREVENTTYPE(4)",
         OutTemp       => C405TRCTRIGGEREVENTTYPE_OUT(4),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(4),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRIGGEREVENTTYPE(5),
         GlitchData    => C405TRCTRIGGEREVENTTYPE5_GlitchData,
         OutSignalName => "C405TRCTRIGGEREVENTTYPE(5)",
         OutTemp       => C405TRCTRIGGEREVENTTYPE_OUT(5),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(5),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRIGGEREVENTTYPE(6),
         GlitchData    => C405TRCTRIGGEREVENTTYPE6_GlitchData,
         OutSignalName => "C405TRCTRIGGEREVENTTYPE(6)",
         OutTemp       => C405TRCTRIGGEREVENTTYPE_OUT(6),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(6),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRIGGEREVENTTYPE(7),
         GlitchData    => C405TRCTRIGGEREVENTTYPE7_GlitchData,
         OutSignalName => "C405TRCTRIGGEREVENTTYPE(7)",
         OutTemp       => C405TRCTRIGGEREVENTTYPE_OUT(7),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(7),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRIGGEREVENTTYPE(8),
         GlitchData    => C405TRCTRIGGEREVENTTYPE8_GlitchData,
         OutSignalName => "C405TRCTRIGGEREVENTTYPE(8)",
         OutTemp       => C405TRCTRIGGEREVENTTYPE_OUT(8),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(8),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRIGGEREVENTTYPE(9),
         GlitchData    => C405TRCTRIGGEREVENTTYPE9_GlitchData,
         OutSignalName => "C405TRCTRIGGEREVENTTYPE(9)",
         OutTemp       => C405TRCTRIGGEREVENTTYPE_OUT(9),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(9),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => C405TRCTRIGGEREVENTTYPE(10),
         GlitchData    => C405TRCTRIGGEREVENTTYPE10_GlitchData,
         OutSignalName => "C405TRCTRIGGEREVENTTYPE(10)",
         OutTemp       => C405TRCTRIGGEREVENTTYPE_OUT(10),
         Paths         => (0 => (CPMC405CLOCK_dly_1'last_event, tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(10),TRUE)),
	 DefaultDelay =>  tpd_CPMC405CLOCK_C405TRCTRIGGEREVENTTYPE(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(8),
         GlitchData    => DSOCMBRAMABUS8_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(8)",
         OutTemp       => DSOCMBRAMABUS_OUT(8),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(8),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(9),
         GlitchData    => DSOCMBRAMABUS9_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(9)",
         OutTemp       => DSOCMBRAMABUS_OUT(9),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(9),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(10),
         GlitchData    => DSOCMBRAMABUS10_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(10)",
         OutTemp       => DSOCMBRAMABUS_OUT(10),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(10),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(11),
         GlitchData    => DSOCMBRAMABUS11_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(11)",
         OutTemp       => DSOCMBRAMABUS_OUT(11),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(11),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(12),
         GlitchData    => DSOCMBRAMABUS12_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(12)",
         OutTemp       => DSOCMBRAMABUS_OUT(12),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(12),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(13),
         GlitchData    => DSOCMBRAMABUS13_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(13)",
         OutTemp       => DSOCMBRAMABUS_OUT(13),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(13),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(14),
         GlitchData    => DSOCMBRAMABUS14_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(14)",
         OutTemp       => DSOCMBRAMABUS_OUT(14),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(14),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(15),
         GlitchData    => DSOCMBRAMABUS15_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(15)",
         OutTemp       => DSOCMBRAMABUS_OUT(15),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(15),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(16),
         GlitchData    => DSOCMBRAMABUS16_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(16)",
         OutTemp       => DSOCMBRAMABUS_OUT(16),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(16),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(17),
         GlitchData    => DSOCMBRAMABUS17_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(17)",
         OutTemp       => DSOCMBRAMABUS_OUT(17),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(17),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(18),
         GlitchData    => DSOCMBRAMABUS18_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(18)",
         OutTemp       => DSOCMBRAMABUS_OUT(18),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(18),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(19),
         GlitchData    => DSOCMBRAMABUS19_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(19)",
         OutTemp       => DSOCMBRAMABUS_OUT(19),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(19),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(20),
         GlitchData    => DSOCMBRAMABUS20_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(20)",
         OutTemp       => DSOCMBRAMABUS_OUT(20),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(20),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(21),
         GlitchData    => DSOCMBRAMABUS21_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(21)",
         OutTemp       => DSOCMBRAMABUS_OUT(21),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(21),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(22),
         GlitchData    => DSOCMBRAMABUS22_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(22)",
         OutTemp       => DSOCMBRAMABUS_OUT(22),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(22),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(23),
         GlitchData    => DSOCMBRAMABUS23_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(23)",
         OutTemp       => DSOCMBRAMABUS_OUT(23),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(23),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(24),
         GlitchData    => DSOCMBRAMABUS24_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(24)",
         OutTemp       => DSOCMBRAMABUS_OUT(24),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(24),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(25),
         GlitchData    => DSOCMBRAMABUS25_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(25)",
         OutTemp       => DSOCMBRAMABUS_OUT(25),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(25),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(26),
         GlitchData    => DSOCMBRAMABUS26_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(26)",
         OutTemp       => DSOCMBRAMABUS_OUT(26),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(26),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(27),
         GlitchData    => DSOCMBRAMABUS27_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(27)",
         OutTemp       => DSOCMBRAMABUS_OUT(27),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(27),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(28),
         GlitchData    => DSOCMBRAMABUS28_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(28)",
         OutTemp       => DSOCMBRAMABUS_OUT(28),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(28),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMABUS(29),
         GlitchData    => DSOCMBRAMABUS29_GlitchData,
         OutSignalName => "DSOCMBRAMABUS(29)",
         OutTemp       => DSOCMBRAMABUS_OUT(29),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(29),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMABUS(29), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMBYTEWRITE(0),
         GlitchData    => DSOCMBRAMBYTEWRITE0_GlitchData,
         OutSignalName => "DSOCMBRAMBYTEWRITE(0)",
         OutTemp       => DSOCMBRAMBYTEWRITE_OUT(0),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMBYTEWRITE(0),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMBYTEWRITE(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMBYTEWRITE(1),
         GlitchData    => DSOCMBRAMBYTEWRITE1_GlitchData,
         OutSignalName => "DSOCMBRAMBYTEWRITE(1)",
         OutTemp       => DSOCMBRAMBYTEWRITE_OUT(1),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMBYTEWRITE(1),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMBYTEWRITE(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMBYTEWRITE(2),
         GlitchData    => DSOCMBRAMBYTEWRITE2_GlitchData,
         OutSignalName => "DSOCMBRAMBYTEWRITE(2)",
         OutTemp       => DSOCMBRAMBYTEWRITE_OUT(2),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMBYTEWRITE(2),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMBYTEWRITE(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMBYTEWRITE(3),
         GlitchData    => DSOCMBRAMBYTEWRITE3_GlitchData,
         OutSignalName => "DSOCMBRAMBYTEWRITE(3)",
         OutTemp       => DSOCMBRAMBYTEWRITE_OUT(3),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMBYTEWRITE(3),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMBYTEWRITE(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(0),
         GlitchData    => DSOCMBRAMWRDBUS0_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(0)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(0),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(0),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(1),
         GlitchData    => DSOCMBRAMWRDBUS1_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(1)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(1),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(1),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(2),
         GlitchData    => DSOCMBRAMWRDBUS2_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(2)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(2),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(2),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(3),
         GlitchData    => DSOCMBRAMWRDBUS3_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(3)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(3),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(3),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(4),
         GlitchData    => DSOCMBRAMWRDBUS4_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(4)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(4),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(4),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(5),
         GlitchData    => DSOCMBRAMWRDBUS5_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(5)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(5),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(5),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(6),
         GlitchData    => DSOCMBRAMWRDBUS6_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(6)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(6),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(6),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(7),
         GlitchData    => DSOCMBRAMWRDBUS7_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(7)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(7),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(7),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(8),
         GlitchData    => DSOCMBRAMWRDBUS8_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(8)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(8),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(8),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(9),
         GlitchData    => DSOCMBRAMWRDBUS9_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(9)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(9),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(9),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(10),
         GlitchData    => DSOCMBRAMWRDBUS10_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(10)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(10),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(10),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(11),
         GlitchData    => DSOCMBRAMWRDBUS11_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(11)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(11),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(11),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(12),
         GlitchData    => DSOCMBRAMWRDBUS12_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(12)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(12),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(12),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(13),
         GlitchData    => DSOCMBRAMWRDBUS13_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(13)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(13),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(13),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(14),
         GlitchData    => DSOCMBRAMWRDBUS14_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(14)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(14),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(14),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(15),
         GlitchData    => DSOCMBRAMWRDBUS15_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(15)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(15),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(15),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(16),
         GlitchData    => DSOCMBRAMWRDBUS16_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(16)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(16),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(16),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(17),
         GlitchData    => DSOCMBRAMWRDBUS17_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(17)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(17),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(17),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(18),
         GlitchData    => DSOCMBRAMWRDBUS18_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(18)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(18),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(18),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(19),
         GlitchData    => DSOCMBRAMWRDBUS19_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(19)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(19),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(19),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(20),
         GlitchData    => DSOCMBRAMWRDBUS20_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(20)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(20),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(20),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(21),
         GlitchData    => DSOCMBRAMWRDBUS21_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(21)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(21),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(21),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(22),
         GlitchData    => DSOCMBRAMWRDBUS22_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(22)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(22),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(22),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(23),
         GlitchData    => DSOCMBRAMWRDBUS23_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(23)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(23),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(23),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(24),
         GlitchData    => DSOCMBRAMWRDBUS24_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(24)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(24),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(24),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(25),
         GlitchData    => DSOCMBRAMWRDBUS25_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(25)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(25),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(25),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(26),
         GlitchData    => DSOCMBRAMWRDBUS26_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(26)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(26),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(26),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(27),
         GlitchData    => DSOCMBRAMWRDBUS27_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(27)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(27),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(27),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(28),
         GlitchData    => DSOCMBRAMWRDBUS28_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(28)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(28),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(28),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(29),
         GlitchData    => DSOCMBRAMWRDBUS29_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(29)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(29),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(29),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(29), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(30),
         GlitchData    => DSOCMBRAMWRDBUS30_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(30)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(30),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(30),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(30), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => DSOCMBRAMWRDBUS(31),
         GlitchData    => DSOCMBRAMWRDBUS31_GlitchData,
         OutSignalName => "DSOCMBRAMWRDBUS(31)",
         OutTemp       => DSOCMBRAMWRDBUS_OUT(31),
         Paths         => (0 => (BRAMDSOCMCLK_dly_1'last_event, tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(31),TRUE)),
	 DefaultDelay =>  tpd_BRAMDSOCMCLK_DSOCMBRAMWRDBUS(31), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRABUS(0),
         GlitchData    => EXTDCRABUS0_GlitchData,
         OutSignalName => "EXTDCRABUS(0)",
         OutTemp       => EXTDCRABUS_OUT(0),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRABUS(0),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRABUS(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRABUS(1),
         GlitchData    => EXTDCRABUS1_GlitchData,
         OutSignalName => "EXTDCRABUS(1)",
         OutTemp       => EXTDCRABUS_OUT(1),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRABUS(1),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRABUS(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRABUS(2),
         GlitchData    => EXTDCRABUS2_GlitchData,
         OutSignalName => "EXTDCRABUS(2)",
         OutTemp       => EXTDCRABUS_OUT(2),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRABUS(2),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRABUS(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRABUS(3),
         GlitchData    => EXTDCRABUS3_GlitchData,
         OutSignalName => "EXTDCRABUS(3)",
         OutTemp       => EXTDCRABUS_OUT(3),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRABUS(3),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRABUS(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRABUS(4),
         GlitchData    => EXTDCRABUS4_GlitchData,
         OutSignalName => "EXTDCRABUS(4)",
         OutTemp       => EXTDCRABUS_OUT(4),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRABUS(4),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRABUS(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRABUS(5),
         GlitchData    => EXTDCRABUS5_GlitchData,
         OutSignalName => "EXTDCRABUS(5)",
         OutTemp       => EXTDCRABUS_OUT(5),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRABUS(5),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRABUS(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRABUS(6),
         GlitchData    => EXTDCRABUS6_GlitchData,
         OutSignalName => "EXTDCRABUS(6)",
         OutTemp       => EXTDCRABUS_OUT(6),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRABUS(6),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRABUS(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRABUS(7),
         GlitchData    => EXTDCRABUS7_GlitchData,
         OutSignalName => "EXTDCRABUS(7)",
         OutTemp       => EXTDCRABUS_OUT(7),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRABUS(7),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRABUS(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRABUS(8),
         GlitchData    => EXTDCRABUS8_GlitchData,
         OutSignalName => "EXTDCRABUS(8)",
         OutTemp       => EXTDCRABUS_OUT(8),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRABUS(8),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRABUS(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRABUS(9),
         GlitchData    => EXTDCRABUS9_GlitchData,
         OutSignalName => "EXTDCRABUS(9)",
         OutTemp       => EXTDCRABUS_OUT(9),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRABUS(9),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRABUS(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(0),
         GlitchData    => EXTDCRDBUSOUT0_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(0)",
         OutTemp       => EXTDCRDBUSOUT_OUT(0),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(0),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(1),
         GlitchData    => EXTDCRDBUSOUT1_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(1)",
         OutTemp       => EXTDCRDBUSOUT_OUT(1),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(1),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(2),
         GlitchData    => EXTDCRDBUSOUT2_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(2)",
         OutTemp       => EXTDCRDBUSOUT_OUT(2),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(2),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(3),
         GlitchData    => EXTDCRDBUSOUT3_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(3)",
         OutTemp       => EXTDCRDBUSOUT_OUT(3),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(3),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(4),
         GlitchData    => EXTDCRDBUSOUT4_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(4)",
         OutTemp       => EXTDCRDBUSOUT_OUT(4),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(4),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(5),
         GlitchData    => EXTDCRDBUSOUT5_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(5)",
         OutTemp       => EXTDCRDBUSOUT_OUT(5),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(5),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(6),
         GlitchData    => EXTDCRDBUSOUT6_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(6)",
         OutTemp       => EXTDCRDBUSOUT_OUT(6),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(6),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(7),
         GlitchData    => EXTDCRDBUSOUT7_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(7)",
         OutTemp       => EXTDCRDBUSOUT_OUT(7),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(7),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(8),
         GlitchData    => EXTDCRDBUSOUT8_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(8)",
         OutTemp       => EXTDCRDBUSOUT_OUT(8),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(8),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(9),
         GlitchData    => EXTDCRDBUSOUT9_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(9)",
         OutTemp       => EXTDCRDBUSOUT_OUT(9),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(9),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(10),
         GlitchData    => EXTDCRDBUSOUT10_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(10)",
         OutTemp       => EXTDCRDBUSOUT_OUT(10),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(10),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(11),
         GlitchData    => EXTDCRDBUSOUT11_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(11)",
         OutTemp       => EXTDCRDBUSOUT_OUT(11),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(11),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(12),
         GlitchData    => EXTDCRDBUSOUT12_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(12)",
         OutTemp       => EXTDCRDBUSOUT_OUT(12),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(12),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(13),
         GlitchData    => EXTDCRDBUSOUT13_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(13)",
         OutTemp       => EXTDCRDBUSOUT_OUT(13),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(13),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(14),
         GlitchData    => EXTDCRDBUSOUT14_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(14)",
         OutTemp       => EXTDCRDBUSOUT_OUT(14),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(14),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(15),
         GlitchData    => EXTDCRDBUSOUT15_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(15)",
         OutTemp       => EXTDCRDBUSOUT_OUT(15),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(15),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(16),
         GlitchData    => EXTDCRDBUSOUT16_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(16)",
         OutTemp       => EXTDCRDBUSOUT_OUT(16),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(16),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(17),
         GlitchData    => EXTDCRDBUSOUT17_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(17)",
         OutTemp       => EXTDCRDBUSOUT_OUT(17),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(17),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(18),
         GlitchData    => EXTDCRDBUSOUT18_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(18)",
         OutTemp       => EXTDCRDBUSOUT_OUT(18),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(18),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(19),
         GlitchData    => EXTDCRDBUSOUT19_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(19)",
         OutTemp       => EXTDCRDBUSOUT_OUT(19),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(19),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(20),
         GlitchData    => EXTDCRDBUSOUT20_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(20)",
         OutTemp       => EXTDCRDBUSOUT_OUT(20),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(20),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(21),
         GlitchData    => EXTDCRDBUSOUT21_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(21)",
         OutTemp       => EXTDCRDBUSOUT_OUT(21),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(21),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(22),
         GlitchData    => EXTDCRDBUSOUT22_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(22)",
         OutTemp       => EXTDCRDBUSOUT_OUT(22),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(22),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(23),
         GlitchData    => EXTDCRDBUSOUT23_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(23)",
         OutTemp       => EXTDCRDBUSOUT_OUT(23),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(23),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(24),
         GlitchData    => EXTDCRDBUSOUT24_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(24)",
         OutTemp       => EXTDCRDBUSOUT_OUT(24),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(24),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(25),
         GlitchData    => EXTDCRDBUSOUT25_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(25)",
         OutTemp       => EXTDCRDBUSOUT_OUT(25),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(25),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(26),
         GlitchData    => EXTDCRDBUSOUT26_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(26)",
         OutTemp       => EXTDCRDBUSOUT_OUT(26),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(26),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(27),
         GlitchData    => EXTDCRDBUSOUT27_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(27)",
         OutTemp       => EXTDCRDBUSOUT_OUT(27),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(27),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(28),
         GlitchData    => EXTDCRDBUSOUT28_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(28)",
         OutTemp       => EXTDCRDBUSOUT_OUT(28),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(28),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(29),
         GlitchData    => EXTDCRDBUSOUT29_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(29)",
         OutTemp       => EXTDCRDBUSOUT_OUT(29),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(29),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(29), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(30),
         GlitchData    => EXTDCRDBUSOUT30_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(30)",
         OutTemp       => EXTDCRDBUSOUT_OUT(30),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(30),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(30), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EXTDCRDBUSOUT(31),
         GlitchData    => EXTDCRDBUSOUT31_GlitchData,
         OutSignalName => "EXTDCRDBUSOUT(31)",
         OutTemp       => EXTDCRDBUSOUT_OUT(31),
         Paths         => (0 => (CPMDCRCLK_dly_1'last_event, tpd_CPMDCRCLK_EXTDCRDBUSOUT(31),TRUE)),
	 DefaultDelay =>  tpd_CPMDCRCLK_EXTDCRDBUSOUT(31), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(8),
         GlitchData    => ISOCMBRAMRDABUS8_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(8)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(8),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(8),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(9),
         GlitchData    => ISOCMBRAMRDABUS9_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(9)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(9),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(9),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(10),
         GlitchData    => ISOCMBRAMRDABUS10_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(10)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(10),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(10),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(11),
         GlitchData    => ISOCMBRAMRDABUS11_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(11)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(11),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(11),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(12),
         GlitchData    => ISOCMBRAMRDABUS12_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(12)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(12),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(12),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(13),
         GlitchData    => ISOCMBRAMRDABUS13_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(13)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(13),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(13),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(14),
         GlitchData    => ISOCMBRAMRDABUS14_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(14)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(14),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(14),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(15),
         GlitchData    => ISOCMBRAMRDABUS15_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(15)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(15),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(15),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(16),
         GlitchData    => ISOCMBRAMRDABUS16_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(16)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(16),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(16),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(17),
         GlitchData    => ISOCMBRAMRDABUS17_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(17)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(17),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(17),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(18),
         GlitchData    => ISOCMBRAMRDABUS18_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(18)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(18),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(18),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(19),
         GlitchData    => ISOCMBRAMRDABUS19_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(19)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(19),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(19),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(20),
         GlitchData    => ISOCMBRAMRDABUS20_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(20)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(20),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(20),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(21),
         GlitchData    => ISOCMBRAMRDABUS21_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(21)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(21),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(21),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(22),
         GlitchData    => ISOCMBRAMRDABUS22_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(22)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(22),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(22),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(23),
         GlitchData    => ISOCMBRAMRDABUS23_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(23)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(23),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(23),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(24),
         GlitchData    => ISOCMBRAMRDABUS24_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(24)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(24),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(24),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(25),
         GlitchData    => ISOCMBRAMRDABUS25_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(25)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(25),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(25),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(26),
         GlitchData    => ISOCMBRAMRDABUS26_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(26)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(26),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(26),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(27),
         GlitchData    => ISOCMBRAMRDABUS27_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(27)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(27),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(27),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMRDABUS(28),
         GlitchData    => ISOCMBRAMRDABUS28_GlitchData,
         OutSignalName => "ISOCMBRAMRDABUS(28)",
         OutTemp       => ISOCMBRAMRDABUS_OUT(28),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(28),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMRDABUS(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(8),
         GlitchData    => ISOCMBRAMWRABUS8_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(8)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(8),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(8),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(9),
         GlitchData    => ISOCMBRAMWRABUS9_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(9)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(9),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(9),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(10),
         GlitchData    => ISOCMBRAMWRABUS10_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(10)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(10),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(10),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(11),
         GlitchData    => ISOCMBRAMWRABUS11_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(11)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(11),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(11),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(12),
         GlitchData    => ISOCMBRAMWRABUS12_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(12)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(12),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(12),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(13),
         GlitchData    => ISOCMBRAMWRABUS13_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(13)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(13),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(13),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(14),
         GlitchData    => ISOCMBRAMWRABUS14_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(14)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(14),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(14),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(15),
         GlitchData    => ISOCMBRAMWRABUS15_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(15)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(15),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(15),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(16),
         GlitchData    => ISOCMBRAMWRABUS16_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(16)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(16),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(16),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(17),
         GlitchData    => ISOCMBRAMWRABUS17_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(17)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(17),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(17),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(18),
         GlitchData    => ISOCMBRAMWRABUS18_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(18)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(18),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(18),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(19),
         GlitchData    => ISOCMBRAMWRABUS19_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(19)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(19),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(19),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(20),
         GlitchData    => ISOCMBRAMWRABUS20_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(20)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(20),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(20),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(21),
         GlitchData    => ISOCMBRAMWRABUS21_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(21)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(21),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(21),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(22),
         GlitchData    => ISOCMBRAMWRABUS22_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(22)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(22),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(22),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(23),
         GlitchData    => ISOCMBRAMWRABUS23_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(23)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(23),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(23),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(24),
         GlitchData    => ISOCMBRAMWRABUS24_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(24)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(24),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(24),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(25),
         GlitchData    => ISOCMBRAMWRABUS25_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(25)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(25),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(25),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(26),
         GlitchData    => ISOCMBRAMWRABUS26_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(26)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(26),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(26),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(27),
         GlitchData    => ISOCMBRAMWRABUS27_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(27)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(27),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(27),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRABUS(28),
         GlitchData    => ISOCMBRAMWRABUS28_GlitchData,
         OutSignalName => "ISOCMBRAMWRABUS(28)",
         OutTemp       => ISOCMBRAMWRABUS_OUT(28),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(28),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRABUS(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(0),
         GlitchData    => ISOCMBRAMWRDBUS0_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(0)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(0),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(0),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(0), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(1),
         GlitchData    => ISOCMBRAMWRDBUS1_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(1)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(1),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(1),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(1), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(2),
         GlitchData    => ISOCMBRAMWRDBUS2_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(2)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(2),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(2),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(2), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(3),
         GlitchData    => ISOCMBRAMWRDBUS3_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(3)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(3),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(3),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(3), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(4),
         GlitchData    => ISOCMBRAMWRDBUS4_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(4)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(4),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(4),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(4), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(5),
         GlitchData    => ISOCMBRAMWRDBUS5_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(5)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(5),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(5),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(5), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(6),
         GlitchData    => ISOCMBRAMWRDBUS6_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(6)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(6),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(6),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(6), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(7),
         GlitchData    => ISOCMBRAMWRDBUS7_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(7)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(7),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(7),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(7), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(8),
         GlitchData    => ISOCMBRAMWRDBUS8_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(8)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(8),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(8),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(8), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(9),
         GlitchData    => ISOCMBRAMWRDBUS9_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(9)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(9),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(9),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(9), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(10),
         GlitchData    => ISOCMBRAMWRDBUS10_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(10)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(10),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(10),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(10), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(11),
         GlitchData    => ISOCMBRAMWRDBUS11_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(11)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(11),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(11),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(11), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(12),
         GlitchData    => ISOCMBRAMWRDBUS12_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(12)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(12),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(12),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(12), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(13),
         GlitchData    => ISOCMBRAMWRDBUS13_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(13)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(13),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(13),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(13), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(14),
         GlitchData    => ISOCMBRAMWRDBUS14_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(14)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(14),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(14),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(14), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(15),
         GlitchData    => ISOCMBRAMWRDBUS15_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(15)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(15),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(15),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(15), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(16),
         GlitchData    => ISOCMBRAMWRDBUS16_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(16)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(16),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(16),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(16), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(17),
         GlitchData    => ISOCMBRAMWRDBUS17_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(17)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(17),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(17),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(17), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(18),
         GlitchData    => ISOCMBRAMWRDBUS18_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(18)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(18),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(18),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(18), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(19),
         GlitchData    => ISOCMBRAMWRDBUS19_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(19)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(19),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(19),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(19), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(20),
         GlitchData    => ISOCMBRAMWRDBUS20_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(20)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(20),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(20),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(20), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(21),
         GlitchData    => ISOCMBRAMWRDBUS21_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(21)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(21),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(21),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(21), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(22),
         GlitchData    => ISOCMBRAMWRDBUS22_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(22)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(22),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(22),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(22), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(23),
         GlitchData    => ISOCMBRAMWRDBUS23_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(23)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(23),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(23),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(23), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(24),
         GlitchData    => ISOCMBRAMWRDBUS24_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(24)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(24),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(24),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(24), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(25),
         GlitchData    => ISOCMBRAMWRDBUS25_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(25)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(25),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(25),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(25), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(26),
         GlitchData    => ISOCMBRAMWRDBUS26_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(26)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(26),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(26),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(26), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(27),
         GlitchData    => ISOCMBRAMWRDBUS27_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(27)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(27),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(27),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(27), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(28),
         GlitchData    => ISOCMBRAMWRDBUS28_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(28)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(28),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(28),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(28), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(29),
         GlitchData    => ISOCMBRAMWRDBUS29_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(29)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(29),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(29),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(29), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(30),
         GlitchData    => ISOCMBRAMWRDBUS30_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(30)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(30),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(30),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(30), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => ISOCMBRAMWRDBUS(31),
         GlitchData    => ISOCMBRAMWRDBUS31_GlitchData,
         OutSignalName => "ISOCMBRAMWRDBUS(31)",
         OutTemp       => ISOCMBRAMWRDBUS_OUT(31),
         Paths         => (0 => (BRAMISOCMCLK_dly_1'last_event, tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(31),TRUE)),
	 DefaultDelay =>  tpd_BRAMISOCMCLK_ISOCMBRAMWRDBUS(31), 
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     
--  Wait signal (input/output pins)
   wait on
     APUFCMDECODED_OUT,
     APUFCMDECUDI_OUT,
     APUFCMDECUDIVALID_OUT,
     APUFCMENDIAN_OUT,
     APUFCMFLUSH_OUT,
     APUFCMINSTRUCTION_OUT,
     APUFCMINSTRVALID_OUT,
     APUFCMLOADBYTEEN_OUT,
     APUFCMLOADDATA_OUT,
     APUFCMLOADDVALID_OUT,
     APUFCMOPERANDVALID_OUT,
     APUFCMRADATA_OUT,
     APUFCMRBDATA_OUT,
     APUFCMWRITEBACKOK_OUT,
     APUFCMXERCA_OUT,
     BRAMDSOCMCLK_dly_1,
     BRAMDSOCMRDDBUS_dly_1,
     BRAMISOCMCLK_dly_1,
     BRAMISOCMDCRRDDBUS_dly_1,
     BRAMISOCMRDDBUS_dly_1,
     C405CPMCORESLEEPREQ_OUT,
     C405CPMMSRCE_OUT,
     C405CPMMSREE_OUT,
     C405CPMTIMERIRQ_OUT,
     C405CPMTIMERRESETREQ_OUT,
     C405DBGLOADDATAONAPUDBUS_OUT,
     C405DBGMSRWE_OUT,
     C405DBGSTOPACK_OUT,
     C405DBGWBCOMPLETE_OUT,
     C405DBGWBFULL_OUT,
     C405DBGWBIAR_OUT,
     C405JTGCAPTUREDR_OUT,
     C405JTGEXTEST_OUT,
     C405JTGPGMOUT_OUT,
     C405JTGSHIFTDR_OUT,
     C405JTGTDO_OUT,
     C405JTGTDOEN_OUT,
     C405JTGUPDATEDR_OUT,
     C405PLBDCUABORT_OUT,
     C405PLBDCUABUS_OUT,
     C405PLBDCUBE_OUT,
     C405PLBDCUCACHEABLE_OUT,
     C405PLBDCUGUARDED_OUT,
     C405PLBDCUPRIORITY_OUT,
     C405PLBDCUREQUEST_OUT,
     C405PLBDCURNW_OUT,
     C405PLBDCUSIZE2_OUT,
     C405PLBDCUU0ATTR_OUT,
     C405PLBDCUWRDBUS_OUT,
     C405PLBDCUWRITETHRU_OUT,
     C405PLBICUABORT_OUT,
     C405PLBICUABUS_OUT,
     C405PLBICUCACHEABLE_OUT,
     C405PLBICUPRIORITY_OUT,
     C405PLBICUREQUEST_OUT,
     C405PLBICUSIZE_OUT,
     C405PLBICUU0ATTR_OUT,
     C405RSTCHIPRESETREQ_OUT,
     C405RSTCORERESETREQ_OUT,
     C405RSTSYSRESETREQ_OUT,
     C405TRCCYCLE_OUT,
     C405TRCEVENEXECUTIONSTATUS_OUT,
     C405TRCODDEXECUTIONSTATUS_OUT,
     C405TRCTRACESTATUS_OUT,
     C405TRCTRIGGEREVENTOUT_OUT,
     C405TRCTRIGGEREVENTTYPE_OUT,
     C405XXXMACHINECHECK_OUT,
     CPMC405CLOCK_dly_1,
     CPMC405CORECLKINACTIVE_dly_1,
     CPMC405CPUCLKEN_dly_1,
     CPMC405JTAGCLKEN_dly_1,
     CPMC405SYNCBYPASS_dly_1,
     CPMC405TIMERCLKEN_dly_1,
     CPMC405TIMERTICK_dly_1,
     CPMDCRCLK_dly_1,
     CPMFCMCLK_dly_1,
     DBGC405DEBUGHALT_dly_1,
     DBGC405EXTBUSHOLDACK_dly_1,
     DBGC405UNCONDDEBUGEVENT_dly_1,
     DCREMACENABLER_OUT,
     DSARCVALUE_dly_1,
     DSCNTLVALUE_dly_1,
     DSOCMBRAMABUS_OUT,
     DSOCMBRAMBYTEWRITE_OUT,
     DSOCMBRAMEN_OUT,
     DSOCMBRAMWRDBUS_OUT,
     DSOCMBUSY_OUT,
     DSOCMRDADDRVALID_OUT,
     DSOCMRWCOMPLETE_dly_1,
     DSOCMWRADDRVALID_OUT,
     EICC405CRITINPUTIRQ_dly_1,
     EICC405EXTINPUTIRQ_dly_1,
     EXTDCRABUS_OUT,
     EXTDCRACK_dly_1,
     EXTDCRDBUSIN_dly_1,
     EXTDCRDBUSOUT_OUT,
     EXTDCRREAD_OUT,
     EXTDCRWRITE_OUT,
     FCMAPUCR_dly_1,
     FCMAPUDCDCREN_dly_1,
     FCMAPUDCDFORCEALIGN_dly_1,
     FCMAPUDCDFORCEBESTEERING_dly_1,
     FCMAPUDCDFPUOP_dly_1,
     FCMAPUDCDGPRWRITE_dly_1,
     FCMAPUDCDLDSTBYTE_dly_1,
     FCMAPUDCDLDSTDW_dly_1,
     FCMAPUDCDLDSTHW_dly_1,
     FCMAPUDCDLDSTQW_dly_1,
     FCMAPUDCDLDSTWD_dly_1,
     FCMAPUDCDLOAD_dly_1,
     FCMAPUDCDPRIVOP_dly_1,
     FCMAPUDCDRAEN_dly_1,
     FCMAPUDCDRBEN_dly_1,
     FCMAPUDCDSTORE_dly_1,
     FCMAPUDCDTRAPBE_dly_1,
     FCMAPUDCDTRAPLE_dly_1,
     FCMAPUDCDUPDATE_dly_1,
     FCMAPUDCDXERCAEN_dly_1,
     FCMAPUDCDXEROVEN_dly_1,
     FCMAPUDECODEBUSY_dly_1,
     FCMAPUDONE_dly_1,
     FCMAPUEXCEPTION_dly_1,
     FCMAPUEXEBLOCKINGMCO_dly_1,
     FCMAPUEXECRFIELD_dly_1,
     FCMAPUEXENONBLOCKINGMCO_dly_1,
     FCMAPUINSTRACK_dly_1,
     FCMAPULOADWAIT_dly_1,
     FCMAPURESULT_dly_1,
     FCMAPURESULTVALID_dly_1,
     FCMAPUSLEEPNOTREADY_dly_1,
     FCMAPUXERCA_dly_1,
     FCMAPUXEROV_dly_1,
     ISARCVALUE_dly_1,
     ISCNTLVALUE_dly_1,
     ISOCMBRAMEN_OUT,
     ISOCMBRAMEVENWRITEEN_OUT,
     ISOCMBRAMODDWRITEEN_OUT,
     ISOCMBRAMRDABUS_OUT,
     ISOCMBRAMWRABUS_OUT,
     ISOCMBRAMWRDBUS_OUT,
     ISOCMDCRBRAMEVENEN_OUT,
     ISOCMDCRBRAMODDEN_OUT,
     ISOCMDCRBRAMRDSELECT_OUT,
     JTGC405BNDSCANTDO_dly_1,
     JTGC405TCK_dly_1,
     JTGC405TDI_dly_1,
     JTGC405TMS_dly_1,
     JTGC405TRSTNEG_dly_1,
     MCBCPUCLKEN_dly_1,
     MCBJTAGEN_dly_1,
     MCBTIMEREN_dly_1,
     MCPPCRST_dly_1,
     PLBC405DCUADDRACK_dly_1,
     PLBC405DCUBUSY_dly_1,
     PLBC405DCUERR_dly_1,
     PLBC405DCURDDACK_dly_1,
     PLBC405DCURDDBUS_dly_1,
     PLBC405DCURDWDADDR_dly_1,
     PLBC405DCUSSIZE1_dly_1,
     PLBC405DCUWRDACK_dly_1,
     PLBC405ICUADDRACK_dly_1,
     PLBC405ICUBUSY_dly_1,
     PLBC405ICUERR_dly_1,
     PLBC405ICURDDACK_dly_1,
     PLBC405ICURDDBUS_dly_1,
     PLBC405ICURDWDADDR_dly_1,
     PLBC405ICUSSIZE1_dly_1,
     PLBCLK_dly_1,
     RSTC405RESETCHIP_dly_1,
     RSTC405RESETCORE_dly_1,
     RSTC405RESETSYS_dly_1,
     TIEAPUCONTROL_dly_1,
     TIEAPUUDI1_dly_1,
     TIEAPUUDI2_dly_1,
     TIEAPUUDI3_dly_1,
     TIEAPUUDI4_dly_1,
     TIEAPUUDI5_dly_1,
     TIEAPUUDI6_dly_1,
     TIEAPUUDI7_dly_1,
     TIEAPUUDI8_dly_1,
     TIEC405DETERMINISTICMULT_dly_1,
     TIEC405DISOPERANDFWD_dly_1,
     TIEC405MMUEN_dly_1,
     TIEDCRADDR_dly_1,
     TIEPVRBIT10_dly_1,
     TIEPVRBIT11_dly_1,
     TIEPVRBIT28_dly_1,
     TIEPVRBIT29_dly_1,
     TIEPVRBIT30_dly_1,
     TIEPVRBIT31_dly_1,
     TIEPVRBIT8_dly_1,
     TIEPVRBIT9_dly_1,
     TRCC405TRACEDISABLE_dly_1,
     TRCC405TRIGGEREVENTIN_dly_1,
     DCREMACWRITE_OUT,
     DCREMACREAD_OUT,
     DCREMACDBUS_OUT,
     DCREMACABUS_OUT,
     DCREMACCLK_OUT,
     EMACDCRDBUS_dly_1,
     EMACDCRACK_dly_1;

   end process TIMING;
--C405PLBICUSIZE <= C405PLBICUSIZE_OUT after OUT_DELAY(tr01);
DCREMACABUS <= DCREMACABUS_OUT;
DCREMACCLK <= DCREMACCLK_OUT;
DCREMACDBUS <= DCREMACDBUS_OUT;
DCREMACENABLER <= DCREMACENABLER_OUT;
DCREMACREAD <= DCREMACREAD_OUT;
DCREMACWRITE <= DCREMACWRITE_OUT;
--DSOCMBRAMABUS <= DSOCMBRAMABUS_OUT after OUT_DELAY(tr01);
--ISOCMBRAMRDABUS <= ISOCMBRAMRDABUS_OUT after OUT_DELAY(tr01);
--ISOCMBRAMWRABUS   <= ISOCMBRAMWRABUS_OUT after OUT_DELAY(tr01);     

end X_PPC405_ADV_V;
