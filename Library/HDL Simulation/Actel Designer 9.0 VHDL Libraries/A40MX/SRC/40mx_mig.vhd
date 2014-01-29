-- "$Header: 40mx_mig.vhd@@/main/4 $"
-- Actel Vital 95 library
library IEEE;
use IEEE.STD_LOGIC_1164.all;

library IEEE;
use IEEE.VITAL_Timing.all;

package COMPONENTS is

constant DefaultTimingChecksOn : Boolean := True;
constant DefaultXGenerationOn : Boolean := False;
constant DefaultXon : Boolean := False;
constant DefaultMsgOn : Boolean := True;

component AND2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AND2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AND2B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AND3
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AND3A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AND3B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AND3C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AND4
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AND4A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AND4B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AND4C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AND4D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AO1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AO1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AO1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AO1C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AO2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AO2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AO3
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AO4A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AO5A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AOI1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AOI1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AOI1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AOI2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AOI2B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AOI3A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AOI4
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AX1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AX1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component AX1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component BIBUF
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_E_PAD                      :	VitalDelayType01z := 
               (0.000 ns, 0.000 ns, 1.000 ns, 1.000 ns, 1.000 ns, 1.000 ns);
      tpd_D_PAD                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PAD_Y                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PAD                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      PAD                            :	inout STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component BUF
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component BUFA
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component BUFD
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component BUFF
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component CLKBIBUF
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_E_PAD                      :	VitalDelayType01z := 
               (0.000 ns, 0.000 ns, 1.000 ns, 1.000 ns, 1.000 ns, 1.000 ns);
      tpd_D_PAD                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PAD_Y                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PAD                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      PAD                            :	inout STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component CLKBUF
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PAD_Y                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_PAD                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      PAD                            :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component CM8A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_S1_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_S0_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_SB_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_SA_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B1_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B0_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A1_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A0_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_SA                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_SB                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A0                             :	in    STD_ULOGIC;
      A1                             :	in    STD_ULOGIC;
      SA                             :	in    STD_ULOGIC;
      B0                             :	in    STD_ULOGIC;
      B1                             :	in    STD_ULOGIC;
      SB                             :	in    STD_ULOGIC;
      S0                             :	in    STD_ULOGIC;
      S1                             :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component DF1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DF1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DF1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DF1C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFC1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFC1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFC1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFC1C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFC1D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFC1E
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFC1F
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFC1G
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFE
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFE1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFE1C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFE2D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFE3A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFE3B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFE3C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFE3D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFE4
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFE4A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFE4B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFE4C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFEA
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFEB
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFEC
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFED
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFM
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFM1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFM1C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFM3
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFM3B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFM3E
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFM3F
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFM3G
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFM4
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFM4A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFM4B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFM4C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFM4D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFM4E
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFM5A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFM5B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFMA
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFMB
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFME1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_A_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_B_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_B_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_S_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_S_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_E_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_E_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFP1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFP1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFP1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFP1C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFP1D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFP1E
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFP1F
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFP1G
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DFPC
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DFPCA
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_D_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DL1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DL1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DL1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DL1C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DL2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_negedge_negedge                :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_posedge_negedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_negedge              :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DL2B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_posedge                :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DL2C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_negedge_posedge                :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_posedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DL2D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_negedge                :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_negedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_negedge              :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DLC
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_posedge_negedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_negedge              :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLC1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_negedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_negedge              :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLC1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLC1F
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_negedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_negedge              :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DLC1G
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DLCA
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_posedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLE
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_E_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      thold_D_E_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      tsetup_D_E_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      tperiod_G_negedge              :	VitalDelayType := 0.000 ns;
      tpw_E_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLE1D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_E_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      thold_D_E_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tsetup_D_E_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_E_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DLE2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_E_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_D_E_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_E_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_posedge                :	VitalDelayType := 0.000 ns;
      thold_CLR_E_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_E_negedge_negedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_E_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLE2B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_E_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      thold_D_E_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tsetup_D_E_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      thold_CLR_E_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_posedge_posedge                :	VitalDelayType := 0.000 ns;
      trecovery_CLR_E_posedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_E_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLE2C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_E_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      thold_D_E_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tsetup_D_E_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      thold_CLR_E_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_posedge                :	VitalDelayType := 0.000 ns;
      trecovery_CLR_E_negedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_E_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLE3A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_E_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_D_E_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_E_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_negedge_posedge                :	VitalDelayType := 0.000 ns;
      thold_PRE_E_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_E_negedge_negedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_E_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLE3B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_E_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      thold_D_E_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tsetup_D_E_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      thold_PRE_E_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_negedge_posedge                :	VitalDelayType := 0.000 ns;
      trecovery_PRE_E_negedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_E_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLE3C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_E_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      thold_D_E_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tsetup_D_E_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      thold_PRE_E_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_posedge                :	VitalDelayType := 0.000 ns;
      trecovery_PRE_E_posedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_E_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLEA
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_E_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_E_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_E_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_D_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      tperiod_G_negedge              :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_E_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLEB
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_E_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_E_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_E_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_E_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLEC
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_E_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      thold_D_E_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tsetup_D_E_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_E_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLM
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_S_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_A_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_B_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_B_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_S_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_S_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      tperiod_G_negedge              :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLM2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_S_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_A_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_B_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_B_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_S_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_S_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_CLR_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLMA
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_S_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_A_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_B_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_B_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_S_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_S_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLME1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_S_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_E_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_A_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      thold_A_E_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_A_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tsetup_A_E_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_B_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      thold_B_E_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_B_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tsetup_B_E_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_S_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      thold_S_E_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_S_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tsetup_S_E_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_E_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLP1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_negedge_negedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_negedge              :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLP1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_negedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLP1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_negedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_negedge              :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLP1C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_Q                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component DLP1D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_negedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_negedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_negedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_negedge              :	VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component DLP1E
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_G_QN                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_QN                     :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_D_G_noedge_posedge                      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_noedge_posedge                     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_posedge                :	VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :	VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      QN                             :	out   STD_ULOGIC);
end component; 

component FA1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CI_CO                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CI_S                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CI                        :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      CI                             :	in    STD_ULOGIC;
      CO                             :	out   STD_ULOGIC;
      S                              :	out   STD_ULOGIC);
end component; 

component FA1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CI_S                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CI_CO                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CI                        :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      CI                             :	in    STD_ULOGIC;
      S                              :	out   STD_ULOGIC;
      CO                             :	out   STD_ULOGIC);
end component; 

component FA1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CI_S                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CI_CO                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CI                        :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      CI                             :	in    STD_ULOGIC;
      S                              :	out   STD_ULOGIC;
      CO                             :	out   STD_ULOGIC);
end component; 

component FA2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CI_S                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A1_S                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A0_S                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CI_CO                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A1_CO                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A0_CO                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CI                        :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A0                             :	in    STD_ULOGIC;
      A1                             :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      CI                             :	in    STD_ULOGIC;
      S                              :	out   STD_ULOGIC;
      CO                             :	out   STD_ULOGIC);
end component; 

component GAND2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_G_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component GMX4
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_G_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_S0_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D3_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D2_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D1_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D0_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_D0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D2                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D3                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D0                             :	in    STD_ULOGIC;
      D1                             :	in    STD_ULOGIC;
      D2                             :	in    STD_ULOGIC;
      D3                             :	in    STD_ULOGIC;
      S0                             :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component GNAND2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_G_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component GND
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True);

   port(
      Y                              :	out   STD_ULOGIC := '0');
end component; 

component GNOR2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_G_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component GOR2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_G_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component GXOR2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_G_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      G                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component HA1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      CO                             :	out   STD_ULOGIC;
      S                              :	out   STD_ULOGIC);
end component; 

component HA1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      CO                             :	out   STD_ULOGIC;
      S                              :	out   STD_ULOGIC);
end component; 

component HA1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      CO                             :	out   STD_ULOGIC;
      S                              :	out   STD_ULOGIC);
end component; 

component HA1C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_CO                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_S                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      CO                             :	out   STD_ULOGIC;
      S                              :	out   STD_ULOGIC);
end component; 

component INBUF
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PAD_Y                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_PAD                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      PAD                            :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component INV
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component INVA
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component INVD
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component JKF
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_J_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_J_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_K_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_K_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_J                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_K                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      J                              :	in    STD_ULOGIC;
      K                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component JKF1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_J_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_J_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_K_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_K_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_J                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_K                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      J                              :	in    STD_ULOGIC;
      K                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component JKF2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_J_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_J_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_K_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_K_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_J                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_K                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      J                              :	in    STD_ULOGIC;
      K                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component JKF2B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_J_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_J_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_K_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_K_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_J                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_K                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      J                              :	in    STD_ULOGIC;
      K                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component JKF2C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_J_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_J_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_K_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_K_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_J                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_K                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      J                              :	in    STD_ULOGIC;
      K                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component JKF2D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_J_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_J_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_K_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_K_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_J                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_K                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      J                              :	in    STD_ULOGIC;
      K                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component JKF3A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_J_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_J_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_K_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_K_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_J                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_K                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      J                              :	in    STD_ULOGIC;
      K                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component JKF3B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_J_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_J_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_K_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_K_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :	VitalDelayType := 0.000 ns;
      tipd_J                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_K                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      J                              :	in    STD_ULOGIC;
      K                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component JKF3C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_J_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_J_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_K_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_K_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_J                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_K                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      J                              :	in    STD_ULOGIC;
      K                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component JKF3D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_J_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_J_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_K_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_K_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_J                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_K                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      J                              :	in    STD_ULOGIC;
      K                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component JKF4B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_J_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_J_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_K_CLK_noedge_negedge                    :	VitalDelayType := 0.000 ns;
      tsetup_K_CLK_noedge_negedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge              :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_negedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_J                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_K                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      J                              :	in    STD_ULOGIC;
      K                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component JKFPC
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_PRE_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      thold_J_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_J_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_K_CLK_noedge_posedge                    :	VitalDelayType := 0.000 ns;
      tsetup_K_CLK_noedge_posedge                   :	VitalDelayType := 0.000 ns;
      thold_PRE_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge              :	VitalDelayType := 0.000 ns;
      thold_CLR_CLK_noedge_posedge                  :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_posedge              :	VitalDelayType := 0.000 ns;
      tperiod_CLK_posedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :	VitalDelayType := 0.000 ns;
      tipd_J                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_K                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      J                              :	in    STD_ULOGIC;
      K                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      PRE                            :	in    STD_ULOGIC;
      CLR                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component; 

component MAJ3
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component MX2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_S_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component MX2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_S_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component MX2B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_S_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component MX2C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_S_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component MX4
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_S1_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_S0_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D3_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D2_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D1_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D0_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_D0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D2                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D3                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D0                             :	in    STD_ULOGIC;
      D1                             :	in    STD_ULOGIC;
      D2                             :	in    STD_ULOGIC;
      D3                             :	in    STD_ULOGIC;
      S0                             :	in    STD_ULOGIC;
      S1                             :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component MXC1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_S_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component MXT
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_S1_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_S0B_Y                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_S0A_Y                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D3_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D2_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D1_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D0_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_D0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D2                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D3                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S0A                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S0B                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D0                             :	in    STD_ULOGIC;
      D1                             :	in    STD_ULOGIC;
      D2                             :	in    STD_ULOGIC;
      D3                             :	in    STD_ULOGIC;
      S0A                            :	in    STD_ULOGIC;
      S0B                            :	in    STD_ULOGIC;
      S1                             :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NAND2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NAND2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NAND2B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NAND3
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NAND3A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NAND3B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NAND3C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NAND4
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NAND4A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NAND4B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NAND4C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NAND4D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NOR2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NOR2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NOR2B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NOR3
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NOR3A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NOR3B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NOR3C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NOR4
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NOR4A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NOR4B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NOR4C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component NOR4D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OA1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OA1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OA1B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OA1C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OA2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OA2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OA3
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OA3A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OA3B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OA4A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OA5
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OAI1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OAI2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OAI3
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OAI3A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OR2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OR2A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OR2B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OR3
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OR3A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OR3B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OR3C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OR4
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OR4A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OR4B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OR4C
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OR4D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component OUTBUF
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_PAD                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      PAD                            :	out   STD_ULOGIC);
end component; 

component TA153
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_EN_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C3_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C2_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C1_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C0_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_C0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C2                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C3                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_EN                        :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      C0                             :	in    STD_ULOGIC;
      C1                             :	in    STD_ULOGIC;
      C2                             :	in    STD_ULOGIC;
      C3                             :	in    STD_ULOGIC;
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      EN                             :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component TA157
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_S_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_EN_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_EN                        :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      EN                             :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component TRIBUFF
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_E_PAD                      :	VitalDelayType01z := 
               (0.000 ns, 0.000 ns, 1.000 ns, 1.000 ns, 1.000 ns, 1.000 ns);
      tpd_D_PAD                      :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      PAD                            :	out   STD_ULOGIC);
end component; 

component VCC
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True);

   port(
      Y                              :	out   STD_ULOGIC := '1');
end component; 

component XA1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component XA1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component XNOR2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component XNORb
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);

   -- real names
   -- REAL_NAME of XNORb is "XNOR"
end component; 

component XO1
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component XO1A
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      C                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component XOR2
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component XORb
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);

   -- real names
   -- REAL_NAME of XORb is "XOR"
end component; 

end COMPONENTS;
----- CELL BUF -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity BUF is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
attribute VITAL_LEVEL0 of BUF : entity is TRUE;
end BUF;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
library a40mx;
use a40mx.VTABLES.all;
architecture VITAL_ACT of BUF is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL A_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := TO_X01(A_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       GlitchData => Y_GlitchData,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Y, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_BUF_VITAL of BUF is
   for VITAL_ACT
   end for;
end CFG_BUF_VITAL;


----- CELL TA153 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity TA153 is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_EN_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C3_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C2_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C1_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_C0_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_C0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C2                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C3                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_EN                        :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      C0                             :	in    STD_ULOGIC;
      C1                             :	in    STD_ULOGIC;
      C2                             :	in    STD_ULOGIC;
      C3                             :	in    STD_ULOGIC;
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      EN                             :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
attribute VITAL_LEVEL0 of TA153 : entity is TRUE;
end TA153;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
--library a40mx;
--use a40mx.VTABLES.all;
architecture VITAL_ACT of TA153 is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL C0_ipd	 : STD_ULOGIC := 'X';
   SIGNAL C1_ipd	 : STD_ULOGIC := 'X';
   SIGNAL C2_ipd	 : STD_ULOGIC := 'X';
   SIGNAL C3_ipd	 : STD_ULOGIC := 'X';
   SIGNAL A_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B_ipd	 : STD_ULOGIC := 'X';
   SIGNAL EN_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (C0_ipd, C0, tipd_C0);
   VitalWireDelay (C1_ipd, C1, tipd_C1);
   VitalWireDelay (C2_ipd, C2, tipd_C2);
   VitalWireDelay (C3_ipd, C3, tipd_C3);
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (EN_ipd, EN, tipd_EN);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (C0_ipd, C1_ipd, C2_ipd, C3_ipd, A_ipd, B_ipd, EN_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_LOGIC is Results(1);
   VARIABLE MUX1_Out, MUX2_Out, MUX3_Out : std_ulogic;

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      --Y_zd :=
      -- ((((NOT B_ipd)) AND (C1_ipd) AND (A_ipd)) OR (((NOT B_ipd)) AND
      --   (C0_ipd) AND ((NOT A_ipd))) OR ((B_ipd) AND (C2_ipd) AND ((NOT
      --   A_ipd))) OR ((B_ipd) AND (C3_ipd) AND (A_ipd))) AND ((NOT EN_ipd));
      MUX1_Out := VitalMUX2(C1_ipd, C0_ipd, A_ipd);
      MUX2_Out := VitalMUX2(C3_ipd, C2_ipd, A_ipd);
      MUX3_Out := VitalMUX2(MUX2_Out, MUX1_Out, B_ipd);
      Y_zd := VitalAND2((NOT EN_ipd), MUX3_Out);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       GlitchData => Y_GlitchData,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_Y, TRUE),
                 1 => (A_ipd'last_event, tpd_A_Y, TRUE),
                 2 => (EN_ipd'last_event, tpd_EN_Y, TRUE),
                 3 => (C3_ipd'last_event, tpd_C3_Y, TRUE),
                 4 => (C2_ipd'last_event, tpd_C2_Y, TRUE),
                 5 => (C1_ipd'last_event, tpd_C1_Y, TRUE),
                 6 => (C0_ipd'last_event, tpd_C0_Y, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_TA153_VITAL of TA153 is
   for VITAL_ACT
   end for;
end CFG_TA153_VITAL;


----- CELL TA157 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity TA157 is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_S_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_EN_Y                       :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_EN                        :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      EN                             :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
attribute VITAL_LEVEL0 of TA157 : entity is TRUE;
end TA157;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
--library a40mx;
--use a40mx.VTABLES.all;
architecture VITAL_ACT of TA157 is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL A_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B_ipd	 : STD_ULOGIC := 'X';
   SIGNAL S_ipd	 : STD_ULOGIC := 'X';
   SIGNAL EN_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (S_ipd, S, tipd_S);
   VitalWireDelay (EN_ipd, EN, tipd_EN);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, S_ipd, EN_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_LOGIC is Results(1);
   VARIABLE MUX1_Out : std_ulogic;

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      --Y_zd :=
      -- ((S_ipd) AND ((NOT EN_ipd)) AND (B_ipd)) OR (((NOT S_ipd)) AND ((NOT
      --   EN_ipd)) AND (A_ipd));
      MUX1_Out := VitalMUX2(B_ipd, A_ipd, S_ipd);
      Y_zd := VitalAND2((NOT EN_ipd), MUX1_Out);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       GlitchData => Y_GlitchData,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (S_ipd'last_event, tpd_S_Y, TRUE),
                 1 => (EN_ipd'last_event, tpd_EN_Y, TRUE),
                 2 => (B_ipd'last_event, tpd_B_Y, TRUE),
                 3 => (A_ipd'last_event, tpd_A_Y, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_TA157_VITAL of TA157 is
   for VITAL_ACT
   end for;
end CFG_TA157_VITAL;


----- CELL XNORb -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity XNORb is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
attribute VITAL_LEVEL0 of XNORb : entity is TRUE;

   -- real names
   -- REAL_NAME of XNORb is "XNOR"
end XNORb;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
library a40mx;
use a40mx.VTABLES.all;
architecture VITAL_ACT of XNORb is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL A_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := (NOT ((B_ipd) XOR (A_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       GlitchData => Y_GlitchData,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_Y, TRUE),
                 1 => (A_ipd'last_event, tpd_A_Y, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_XNORb_VITAL of XNORb is
   for VITAL_ACT
   end for;
end CFG_XNORb_VITAL;


----- CELL XORb -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity XORb is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_B_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tpd_A_Y                        :	VitalDelayType01 := (1.000 ns, 1.000 ns);
      tipd_A                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      A                              :	in    STD_ULOGIC;
      B                              :	in    STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
attribute VITAL_LEVEL0 of XORb : entity is TRUE;

   -- real names
   -- REAL_NAME of XORb is "XOR"
end XORb;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
library a40mx;
use a40mx.VTABLES.all;
architecture VITAL_ACT of XORb is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL A_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := (B_ipd) XOR (A_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       GlitchData => Y_GlitchData,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_Y, TRUE),
                 1 => (A_ipd'last_event, tpd_A_Y, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_XORb_VITAL of XORb is
   for VITAL_ACT
   end for;
end CFG_XORb_VITAL;
