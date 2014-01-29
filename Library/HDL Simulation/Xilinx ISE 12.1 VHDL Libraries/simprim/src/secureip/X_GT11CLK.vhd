-- $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/vhdsclibs/data/simprims/virtex4/SMODEL/X_GT11CLK.vhd,v 1.1 2008/09/11 16:48:09 vandanad Exp $
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Timing Simulation Library Component
--  /   /                  11-Gigabit Transceiver Clock
-- /___/   /\     Filename : X_GT11CLK.vhd
-- \   \  /  \    Timestamp : Fri Jun 18 10:57:24 PDT 2004
--  \___\/\___\
--
-- Revision:
--    03/23/04 - Initial version.

----- CELL X_GT11CLK -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library IEEE;
use IEEE.VITAL_Timing.all;


entity X_GT11CLK is
generic (
        TimingChecksOn : boolean := TRUE;
        InstancePath   : string  := "*";
        Xon            : boolean := TRUE;
        MsgOn          : boolean := FALSE;
   LOC            : string  := "UNPLACED";
        
		REFCLKSEL : string := "MGTCLK";
		SYNCLK1OUTEN : string := "ENABLE";
		SYNCLK2OUTEN : string := "DISABLE";

        tipd_MGTCLKP : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_MGTCLKN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_SYNCLK1IN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_SYNCLK2IN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_REFCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXBCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);        
--  clk-to-output path delays
        tpd_MGTCLKP_SYNCLK1OUT : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tpd_SYNCLK1IN_SYNCLK1OUT : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tpd_SYNCLK2IN_SYNCLK1OUT : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tpd_REFCLK_SYNCLK1OUT : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tpd_RXBCLK_SYNCLK1OUT : VitalDelayType01 := (0.0 ns, 0.0 ns);        
        tpd_MGTCLKP_SYNCLK2OUT : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tpd_SYNCLK1IN_SYNCLK2OUT : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tpd_SYNCLK2IN_SYNCLK2OUT : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tpd_REFCLK_SYNCLK2OUT : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tpd_RXBCLK_SYNCLK2OUT : VitalDelayType01 := (0.0 ns, 0.0 ns)        
  );

port (
		SYNCLK1OUT : out std_ulogic;
		SYNCLK2OUT : out std_ulogic;

		REFCLK : in std_ulogic;
		MGTCLKN : in std_ulogic;
		MGTCLKP : in std_ulogic;
		RXBCLK : in std_ulogic;
		SYNCLK1IN : in std_ulogic;
		SYNCLK2IN : in std_ulogic

     );
end X_GT11CLK;

architecture X_GT11CLK_V of X_GT11CLK is
signal mgtclk_out : std_ulogic;
signal mux_out : std_ulogic;

-- Input/Output Pin signals

        signal   MGTCLKP_ipd  :  std_ulogic;
        signal   MGTCLKN_ipd  :  std_ulogic;
        signal   SYNCLK1IN_ipd  :  std_ulogic;
        signal   SYNCLK2IN_ipd  :  std_ulogic;
        signal   REFCLK_ipd  :  std_ulogic;
        signal   RXBCLK_ipd  :  std_ulogic;

        signal   MGTCLKP_dly  :  std_ulogic;
        signal   MGTCLKN_dly  :  std_ulogic;
        signal   SYNCLK1IN_dly  :  std_ulogic;
        signal   SYNCLK2IN_dly  :  std_ulogic;
        signal   REFCLK_dly  :  std_ulogic;
        signal   RXBCLK_dly  :  std_ulogic;
begin
   WireDelay : block
       begin
              VitalWireDelay (MGTCLKP_ipd,MGTCLKP,tipd_MGTCLKP);
              VitalWireDelay (MGTCLKN_ipd,MGTCLKN,tipd_MGTCLKN);
              VitalWireDelay (SYNCLK1IN_ipd,SYNCLK1IN,tipd_SYNCLK1IN);
              VitalWireDelay (SYNCLK2IN_ipd,SYNCLK2IN,tipd_SYNCLK2IN);
              VitalWireDelay (REFCLK_ipd,REFCLK,tipd_REFCLK);
              VitalWireDelay (RXBCLK_ipd,RXBCLK,tipd_RXBCLK);              
       end block;

   MGTCLKP_dly <= MGTCLKP_ipd;
   MGTCLKN_dly <= MGTCLKN_ipd;
   SYNCLK1IN_dly <= SYNCLK1IN_ipd;
   SYNCLK2IN_dly <= SYNCLK2IN_ipd;
   RXBCLK_dly <= RXBCLK_ipd;
       
  gen_mgtclk_out : process
  begin
    if ((MGTCLKP_dly = '1') and (MGTCLKN_dly = '0')) then
      mgtclk_out <= MGTCLKP_dly;
    elsif ((MGTCLKP_dly = '0') and (MGTCLKN_dly = '1')) then
      mgtclk_out <= MGTCLKP_dly;       
    end if;
    wait on MGTCLKN_dly, MGTCLKP_dly;
  end process;
  
  INITPROC : process
    variable first_time : boolean := true;
     
  begin
    if (first_time = true) then
      if((REFCLKSEL = "MGTCLK") or (REFCLKSEL = "mgtclk")) then
      elsif((REFCLKSEL = "SYNCLK1IN") or (REFCLKSEL = "synclk1in")) then
      elsif((REFCLKSEL = "SYNCLK2IN") or (REFCLKSEL = "synclk2in")) then
      elsif((REFCLKSEL = "REFCLK") or (REFCLKSEL = "grefclk")) then
      elsif((REFCLKSEL = "RXBCLK") or (REFCLKSEL = "rxbclk")) then
      else
        assert FALSE report "Error : REFCLKSEL = is not MGTCLK, SYNCLK1IN, SYNCLK2IN, REFCLK, RXBCLK." severity error;
      end if;
      
      if((SYNCLK1OUTEN = "ENABLE") or (SYNCLK1OUTEN = "enable")) then
      elsif((SYNCLK1OUTEN = "DISABLE") or (SYNCLK1OUTEN = "disable")) then
      else
        assert FALSE report "Error : SYNCLK1OUTEN = is not ENABLE, DISABLE." severity error;
      end if;

      if((SYNCLK2OUTEN = "ENABLE") or (SYNCLK2OUTEN = "enable")) then
      elsif((SYNCLK2OUTEN = "DISABLE") or (SYNCLK2OUTEN = "disable")) then
      else
        assert FALSE report "Error : SYNCLK2OUTEN = is not ENABLE, DISABLE." severity error;
      end if;
      first_time := false;
    end if;
    if (mgtclk_out'event) then
      if((REFCLKSEL = "MGTCLK") or (REFCLKSEL = "mgtclk")) then
        mux_out <= mgtclk_out;
      end if;          
    end if;

    if (SYNCLK1IN_dly'event) then
      if((REFCLKSEL = "SYNCLK1IN") or (REFCLKSEL = "synclk1in")) then
        mux_out <= SYNCLK1IN_dly;
      end if;          
    end if;

    if (SYNCLK2IN_dly'event) then
      if((REFCLKSEL = "SYNCLK2IN") or (REFCLKSEL = "synclk2in")) then
        mux_out <= SYNCLK2IN_dly;
      end if;          
    end if;    

    if (REFCLK_dly'event) then
      if((REFCLKSEL = "REFCLK") or (REFCLKSEL = "refclk")) then
        mux_out <= REFCLK_dly;
      end if;      
    end if;

    if (RXBCLK_dly'event) then
      if((REFCLKSEL = "RXBCLK") or (REFCLKSEL = "RXBCLK")) then
        mux_out <= RXBCLK_dly;
      end if;          
    end if;    
    wait on mgtclk_out, SYNCLK1IN_dly, SYNCLK2IN_dly, REFCLK_dly, RXBCLK_dly;    
  end process INITPROC;
       
   TIMING : process
     variable  SYNCLK1OUT_out  :  std_ulogic;
     variable  SYNCLK2OUT_out  :  std_ulogic;
     
     variable  SYNCLK1OUT_GlitchData : VitalGlitchDataType;
     variable  SYNCLK2OUT_GlitchData : VitalGlitchDataType;
begin
--  Output-to-Clock path delay
    if ((SYNCLK1OUTEN = "ENABLE") or (SYNCLK1OUTEN = "enable")) then
      SYNCLK1OUT_out := mux_out;
      VitalPathDelay01
        (
          OutSignal     => SYNCLK1OUT,
          GlitchData    => SYNCLK1OUT_GlitchData,
          OutSignalName => "SYNCLK1OUT",
          OutTemp       => SYNCLK1OUT_OUT,
          Paths         => (0 => (MGTCLKP_dly'last_event, tpd_MGTCLKP_SYNCLK1OUT, ((REFCLKSEL = "MGTCLK") or (REFCLKSEL = "mgtclk"))),
                            1 => (SYNCLK1IN_dly'last_event, tpd_SYNCLK1IN_SYNCLK1OUT, ((REFCLKSEL = "SYNCLK1IN") or (REFCLKSEL = "synclk1in"))),
                            2 => (SYNCLK2IN_dly'last_event, tpd_SYNCLK2IN_SYNCLK1OUT, ((REFCLKSEL = "SYNCLK2IN") or (REFCLKSEL = "synclk2in"))),
                            3 => (REFCLK_dly'last_event, tpd_REFCLK_SYNCLK1OUT, ((REFCLKSEL = "REFCLK") or (REFCLKSEL = "grefclk"))),
                            4 => (RXBCLK_dly'last_event, tpd_RXBCLK_SYNCLK1OUT, ((REFCLKSEL = "RXBCLK") or (REFCLKSEL = "rxbclk")))
                            ),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn         => false,
          MsgSeverity   => WARNING
          );
      else
        SYNCLK1OUT <= 'Z';
      end if;

      if ((SYNCLK2OUTEN = "ENABLE") or (SYNCLK2OUTEN = "enable")) then
      SYNCLK2OUT_out := mux_out;        
        VitalPathDelay01
          (
            OutSignal     => SYNCLK2OUT,
            GlitchData    => SYNCLK2OUT_GlitchData,
            OutSignalName => "SYNCLK2OUT",
            OutTemp       => SYNCLK2OUT_OUT,
            Paths         => (0 => (MGTCLKP_dly'last_event, tpd_MGTCLKP_SYNCLK2OUT, ((REFCLKSEL = "MGTCLK") or (REFCLKSEL = "mgtclk"))),
                            1 => (SYNCLK1IN_dly'last_event, tpd_SYNCLK1IN_SYNCLK2OUT, ((REFCLKSEL = "SYNCLK1IN") or (REFCLKSEL = "synclk1in"))),
                            2 => (SYNCLK2IN_dly'last_event, tpd_SYNCLK2IN_SYNCLK2OUT, ((REFCLKSEL = "SYNCLK2IN") or (REFCLKSEL = "synclk2in"))),
                            3 => (REFCLK_dly'last_event, tpd_REFCLK_SYNCLK2OUT, ((REFCLKSEL = "REFCLK") or (REFCLKSEL = "grefclk"))),
                            4 => (RXBCLK_dly'last_event, tpd_RXBCLK_SYNCLK2OUT, ((REFCLKSEL = "RXBCLK") or (REFCLKSEL = "rxbclk")))
                            ),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn         => false,
            MsgSeverity   => WARNING
            );
        else
          SYNCLK2OUT <= 'Z';
        end if;
--  Wait signal (input/output pins)
        wait on mux_out;
   end process TIMING;       
end X_GT11CLK_V;
