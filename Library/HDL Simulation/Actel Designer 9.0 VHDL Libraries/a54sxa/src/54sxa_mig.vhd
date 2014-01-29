

 --------------------------------------------------------------------

 --       Actel a54sxa (migration) Vital Simulation Library

 --       NAME: 54sxa_mig.vhd
 --       DATE: Friday April 8, 2005

 ---------------------------------------------------------------------/



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.VITAL_Timing.all;

package COMPONENTS is

constant DefaultTimingChecksOn : Boolean := True;
constant DefaultXGenerationOn : Boolean := False;
constant DefaultXon : Boolean := False;
constant DefaultMsgOn : Boolean := True;



------ Component AND2 ------
 component AND2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND2A ------
 component AND2A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND2B ------
 component AND2B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND3 ------
 component AND3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND3A ------
 component AND3A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND3B ------
 component AND3B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND3C ------
 component AND3C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND4 ------
 component AND4
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND4A ------
 component AND4A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND4B ------
 component AND4B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND4C ------
 component AND4C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND4D ------
 component AND4D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND5A ------
 component AND5A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND5B ------
 component AND5B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AND5C ------
 component AND5C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO1 ------
 component AO1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO10 ------
 component AO10
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO11 ------
 component AO11
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO12 ------
 component AO12
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO13 ------
 component AO13
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO14 ------
 component AO14
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO15 ------
 component AO15
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO16 ------
 component AO16
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO17 ------
 component AO17
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO18 ------
 component AO18
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO1A ------
 component AO1A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO1B ------
 component AO1B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO1C ------
 component AO1C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO1D ------
 component AO1D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO1E ------
 component AO1E
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO2 ------
 component AO2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO2A ------
 component AO2A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO2B ------
 component AO2B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO2C ------
 component AO2C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO2D ------
 component AO2D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO2E ------
 component AO2E
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO3 ------
 component AO3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO3A ------
 component AO3A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO3B ------
 component AO3B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO3C ------
 component AO3C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO4A ------
 component AO4A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO5A ------
 component AO5A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO6 ------
 component AO6
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO6A ------
 component AO6A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO7 ------
 component AO7
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO8 ------
 component AO8
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AO9 ------
 component AO9
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AOI1 ------
 component AOI1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AOI1A ------
 component AOI1A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AOI1B ------
 component AOI1B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AOI1C ------
 component AOI1C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AOI1D ------
 component AOI1D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AOI2A ------
 component AOI2A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AOI2B ------
 component AOI2B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AOI3A ------
 component AOI3A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AOI4 ------
 component AOI4
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AOI4A ------
 component AOI4A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AOI5 ------
 component AOI5
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AX1 ------
 component AX1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AX1A ------
 component AX1A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AX1B ------
 component AX1B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AX1C ------
 component AX1C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AX1D ------
 component AX1D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AX1E ------
 component AX1E
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AXO1 ------
 component AXO1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AXO2 ------
 component AXO2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AXO3 ------
 component AXO3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AXO5 ------
 component AXO5
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AXO6 ------
 component AXO6
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AXO7 ------
 component AXO7
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AXOI1 ------
 component AXOI1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AXOI2 ------
 component AXOI2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AXOI3 ------
 component AXOI3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AXOI4 ------
 component AXOI4
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AXOI5 ------
 component AXOI5
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component AXOI7 ------
 component AXOI7
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component BIBUF ------
 component BIBUF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_E_PAD : VitalDelayType01Z := (0.000 ns, 0.000 ns, 0.100 ns, 0.100 ns, 0.100 ns, 0.100 ns);
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
			tpd_D_Y			: VitalDelayType01 := (0.100 ns, 0.100 ns);
			tpd_E_Y			: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: inout STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component BUFA ------
 component BUFA
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component BUFD ------
 component BUFD
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component BUFF ------
 component BUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CLKBUF ------
 component CLKBUF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PAD		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CLKBUFI ------
 component CLKBUFI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PAD		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CLKINT ------
 component CLKINT
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CLKINTI ------
 component CLKINTI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CM7 ------
 component CM7
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S0		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CM8 ------
 component CM8
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CM8INV ------
 component CM8INV
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMA9 ------
 component CMA9
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMAF ------
 component CMAF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMB3 ------
 component CMB3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMB7 ------
 component CMB7
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMBB ------
 component CMBB
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMBF ------
 component CMBF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMEA ------
 component CMEA
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		DB		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMEB ------
 component CMEB
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMEE ------
 component CMEE
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		DB		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMEF ------
 component CMEF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMF1 ------
 component CMF1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMF2 ------
 component CMF2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		DB		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMF3 ------
 component CMF3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMF4 ------
 component CMF4
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		DB		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMF5 ------
 component CMF5
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMF6 ------
 component CMF6
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		DB		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMF7 ------
 component CMF7
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMF8 ------
 component CMF8
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		DB		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMF9 ------
 component CMF9
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMFA ------
 component CMFA
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		DB		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMFB ------
 component CMFB
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMFC ------
 component CMFC
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		DB		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMFD ------
 component CMFD
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		DB		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CMFE ------
 component CMFE
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_DB_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S00_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S01_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_DB		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S00		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S01		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		DB		: in    STD_ULOGIC;
		S00		: in    STD_ULOGIC;
		S01		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S10		: in    STD_ULOGIC;
		S11		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CS1 ------
 component CS1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		S		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CS2 ------
 component CS2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		S		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CY2A ------
 component CY2A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B0		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A1		: in    STD_ULOGIC;
		B1		: in    STD_ULOGIC;
		A0		: in    STD_ULOGIC;
		B0		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CY2B ------
 component CY2B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B0		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A1		: in    STD_ULOGIC;
		B1		: in    STD_ULOGIC;
		A0		: in    STD_ULOGIC;
		B0		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component DF1 ------
 component DF1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DF1_CC ------
 component DF1_CC
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DF1B ------
 component DF1B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFC1B ------
 component DFC1B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFC1B_CC ------
 component DFC1B_CC
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFC1D ------
 component DFC1D
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFE1B ------
 component DFE1B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFE1C ------
 component DFE1C
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFE3C ------
 component DFE3C
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFE3D ------
 component DFE3D
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFE4F ------
 component DFE4F
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFE4G ------
 component DFE4G
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFEG ------
 component DFEG
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFEH ------
 component DFEH
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFP1 ------
 component DFP1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_posedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PRE		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFP1A ------
 component DFP1A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_posedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PRE		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFP1B ------
 component DFP1B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PRE		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFP1B_CC ------
 component DFP1B_CC
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PRE		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFP1D ------
 component DFP1D
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PRE		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFPC ------
 component DFPC
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFPCB ------
 component DFPCB
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFPCC ------
 component DFPCC
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DL1 ------
 component DL1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_negedge		:VitalDelayType := 0.000 ns;
		tpw_G_posedge		:  VitalDelayType := 0.000 ns;
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DL1B ------
 component DL1B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DL2A ------
 component DL2A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_negedge		:VitalDelayType := 0.000 ns;
		tpw_PRE_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tpw_G_posedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		CLR		:  in    STD_ULOGIC;
		PRE		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DL2C ------
 component DL2C
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_PRE_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		CLR		:  in    STD_ULOGIC;
		PRE		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLC ------
 component DLC
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_negedge		:VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tpw_G_posedge		:  VitalDelayType := 0.000 ns;
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		CLR		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLC1 ------
 component DLC1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_negedge		:VitalDelayType := 0.000 ns;
		tpw_CLR_posedge		:  VitalDelayType := 0.000 ns;
		tpw_G_posedge		:  VitalDelayType := 0.000 ns;
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		CLR		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLC1A ------
 component DLC1A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_posedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		CLR		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLCA ------
 component DLCA
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		CLR		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLE2C ------
 component DLE2C
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_E_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_E_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_E_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_E_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_E_negedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_E_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_posedge		:  VitalDelayType := 0.000 ns;
		tpw_E_negedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		CLR		:  in    STD_ULOGIC;
		E		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLE3B ------
 component DLE3B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_E_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_E_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_E_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_E_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_E_negedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_E_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_PRE_posedge		:  VitalDelayType := 0.000 ns;
		tpw_E_negedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		PRE		:  in    STD_ULOGIC;
		E		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLE3C ------
 component DLE3C
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_E_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_E_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_E_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_E_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_E_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_E_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tpw_E_negedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		PRE		:  in    STD_ULOGIC;
		E		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLP1 ------
 component DLP1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_negedge		:VitalDelayType := 0.000 ns;
		tpw_PRE_posedge		:  VitalDelayType := 0.000 ns;
		tpw_G_posedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		PRE		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLP1A ------
 component DLP1A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_PRE_posedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		PRE		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLP1B ------
 component DLP1B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_negedge		:VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tpw_G_posedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		PRE		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLP1C ------
 component DLP1C
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		PRE		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component FA1 ------
 component FA1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CI_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CI_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CI		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		CI		: in    STD_ULOGIC;
		S		: out    STD_ULOGIC;
		CO		: out    STD_ULOGIC);
 end component;


------ Component GAND2 ------
 component GAND2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		G		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component GMX4 ------
 component GMX4
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S0		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		G		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component GNAND2 ------
 component GNAND2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		G		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component GND ------
 component GND
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True		);
    port(
		Y		: out    STD_ULOGIC);
 end component;


------ Component GNOR2 ------
 component GNOR2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		G		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component GOR2 ------
 component GOR2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		G		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component GXOR2 ------
 component GXOR2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		G		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component HA1 ------
 component HA1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		S		: out    STD_ULOGIC;
		CO		: out    STD_ULOGIC);
 end component;


------ Component HA1A ------
 component HA1A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		S		: out    STD_ULOGIC;
		CO		: out    STD_ULOGIC);
 end component;


------ Component HA1B ------
 component HA1B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		S		: out    STD_ULOGIC;
		CO		: out    STD_ULOGIC);
 end component;


------ Component HA1C ------
 component HA1C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		S		: out    STD_ULOGIC;
		CO		: out    STD_ULOGIC);
 end component;


------ Component HCLKBUF ------
 component HCLKBUF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PAD		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component INBUF ------
 component INBUF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PAD		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component INV ------
 component INV
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component INVA ------
 component INVA
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component INVD ------
 component INVD
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component JKF ------
 component JKF
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_J_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_J_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
		tsetup_J_CLK_negedge_posedge           :   VitalDelayType := 0.000 ns;
		thold_J_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
		tsetup_K_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_K_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_K_CLK_negedge_posedge           :   VitalDelayType := 0.000 ns;
		thold_K_CLK_negedge_posedge           :   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge		:  VitalDelayType := 0.000 ns;
		tipd_J      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_K      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK	:   VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		J	:  in    STD_ULOGIC;
		K	:  in    STD_ULOGIC;
	        CLK	:  in    STD_ULOGIC;
		Q	:  out    STD_ULOGIC);

 end component;


------ Component JKF1B ------
 component JKF1B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_J_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_J_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
		tsetup_J_CLK_negedge_negedge           :   VitalDelayType := 0.000 ns;
		thold_J_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
		tsetup_K_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_K_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_K_CLK_negedge_negedge           :   VitalDelayType := 0.000 ns;
		thold_K_CLK_negedge_negedge           :   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge		:  VitalDelayType := 0.000 ns;
		tipd_J      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_K      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK	:   VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		J	:  in    STD_ULOGIC;
		K	:  in    STD_ULOGIC;
	        CLK	:  in    STD_ULOGIC;
		Q	:  out    STD_ULOGIC);

 end component;


------ Component JKF2A ------
 component JKF2A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_J_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_J_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
		tsetup_J_CLK_negedge_posedge           :   VitalDelayType := 0.000 ns;
		thold_J_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
		tsetup_K_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_K_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_K_CLK_negedge_posedge           :   VitalDelayType := 0.000 ns;
		thold_K_CLK_negedge_posedge           :   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge	:  VitalDelayType := 0.000 ns;
		tipd_CLR	:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_J      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_K      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK	:   VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		J	:  in    STD_ULOGIC;
		K	:  in    STD_ULOGIC;
	        CLR	:  in    STD_ULOGIC;
	        CLK	:  in    STD_ULOGIC;
		Q	:  out    STD_ULOGIC);

 end component;


------ Component JKF2B ------
 component JKF2B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_J_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_J_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
		tsetup_J_CLK_negedge_negedge           :   VitalDelayType := 0.000 ns;
		thold_J_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
		tsetup_K_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_K_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_K_CLK_negedge_negedge           :   VitalDelayType := 0.000 ns;
		thold_K_CLK_negedge_negedge           :   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_negedge           :   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge	:  VitalDelayType := 0.000 ns;
		tipd_CLR	:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_J      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_K      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK	:   VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		J	:  in    STD_ULOGIC;
		K	:  in    STD_ULOGIC;
	        CLR	:  in    STD_ULOGIC;
	        CLK	:  in    STD_ULOGIC;
		Q	:  out    STD_ULOGIC);

 end component;


------ Component JKF3A ------
 component JKF3A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_J_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_J_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
		tsetup_J_CLK_negedge_posedge           :   VitalDelayType := 0.000 ns;
		thold_J_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
		tsetup_K_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_K_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_K_CLK_negedge_posedge           :   VitalDelayType := 0.000 ns;
		thold_K_CLK_negedge_posedge           :   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_posedge   	:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge		:  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE	:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_J      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_K      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK	:   VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		J	:  in    STD_ULOGIC;
		K	:  in    STD_ULOGIC;
	        PRE	:  in    STD_ULOGIC;
	        CLK	:  in    STD_ULOGIC;
		Q	:  out    STD_ULOGIC);

 end component;


------ Component JKF3B ------
 component JKF3B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_J_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_J_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
		tsetup_J_CLK_negedge_negedge           :   VitalDelayType := 0.000 ns;
		thold_J_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
		tsetup_K_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_K_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_K_CLK_negedge_negedge           :   VitalDelayType := 0.000 ns;
		thold_K_CLK_negedge_negedge           :   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_negedge   	:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge		:  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE	:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_J      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_K      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK	:   VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		J	:  in    STD_ULOGIC;
		K	:  in    STD_ULOGIC;
	        PRE	:  in    STD_ULOGIC;
	        CLK	:  in    STD_ULOGIC;
		Q	:  out    STD_ULOGIC);

 end component;


------ Component MAJ3 ------
 component MAJ3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component MAJ3X ------
 component MAJ3X
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component MAJ3XI ------
 component MAJ3XI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component MIN3 ------
 component MIN3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component MIN3X ------
 component MIN3X
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component MIN3XI ------
 component MIN3XI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component MX2 ------
 component MX2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		S		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component MX2A ------
 component MX2A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		S		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component MX2B ------
 component MX2B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		S		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component MX2C ------
 component MX2C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		S		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component MX4 ------
 component MX4
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S0_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S1_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S0		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S1		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D0		: in    STD_ULOGIC;
		S0		: in    STD_ULOGIC;
		D1		: in    STD_ULOGIC;
		S1		: in    STD_ULOGIC;
		D2		: in    STD_ULOGIC;
		D3		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND2 ------
 component NAND2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND2A ------
 component NAND2A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND2B ------
 component NAND2B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND3 ------
 component NAND3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND3A ------
 component NAND3A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND3B ------
 component NAND3B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND3C ------
 component NAND3C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND4 ------
 component NAND4
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND4A ------
 component NAND4A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND4B ------
 component NAND4B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND4C ------
 component NAND4C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND4D ------
 component NAND4D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND5B ------
 component NAND5B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NAND5C ------
 component NAND5C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR2 ------
 component NOR2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR2A ------
 component NOR2A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR2B ------
 component NOR2B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR3 ------
 component NOR3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR3A ------
 component NOR3A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR3B ------
 component NOR3B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR3C ------
 component NOR3C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR4 ------
 component NOR4
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR4A ------
 component NOR4A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR4B ------
 component NOR4B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR4C ------
 component NOR4C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR4D ------
 component NOR4D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR5B ------
 component NOR5B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component NOR5C ------
 component NOR5C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA1 ------
 component OA1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA1A ------
 component OA1A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA1B ------
 component OA1B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA1C ------
 component OA1C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA2 ------
 component OA2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA2A ------
 component OA2A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA3 ------
 component OA3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA3A ------
 component OA3A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA3B ------
 component OA3B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA4 ------
 component OA4
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA4A ------
 component OA4A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA5 ------
 component OA5
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OAI1 ------
 component OAI1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OAI2A ------
 component OAI2A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OAI3 ------
 component OAI3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OAI3A ------
 component OAI3A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR2 ------
 component OR2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR2A ------
 component OR2A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR2B ------
 component OR2B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR3 ------
 component OR3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR3A ------
 component OR3A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR3B ------
 component OR3B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR3C ------
 component OR3C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR4 ------
 component OR4
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR4A ------
 component OR4A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR4B ------
 component OR4B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR4C ------
 component OR4C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR4D ------
 component OR4D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR5A ------
 component OR5A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR5B ------
 component OR5B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OR5C ------
 component OR5C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OUTBUF ------
 component OUTBUF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TF1A ------
 component TF1A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_T_CLK_negedge_posedge	:   VitalDelayType := 0.000 ns;
		thold_T_CLK_negedge_posedge	:   VitalDelayType := 0.000 ns;
		tsetup_T_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
		thold_T_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_posedge	:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_posedge	:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge	:  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge	:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge	:  VitalDelayType := 0.000 ns;
		tipd_CLK	:  VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR	:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_T	:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		T	:  in    STD_ULOGIC;
		CLR	:  in    STD_ULOGIC;
	        CLK	:  in    STD_ULOGIC;
		Q	:  out    STD_ULOGIC);

 end component;


------ Component TF1B ------
 component TF1B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_T_CLK_negedge_negedge	:   VitalDelayType := 0.000 ns;
		thold_T_CLK_negedge_negedge	:   VitalDelayType := 0.000 ns;
		tsetup_T_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
		thold_T_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_negedge	:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_negedge	:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge	:  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge	:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge	:  VitalDelayType := 0.000 ns;
		tipd_CLK	:  VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR	:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_T	:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		T	:  in    STD_ULOGIC;
		CLR	:  in    STD_ULOGIC;
	        CLK	:  in    STD_ULOGIC;
		Q	:  out    STD_ULOGIC);

 end component;


------ Component TRIBUFF ------
 component TRIBUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_E_PAD : VitalDelayType01Z := (0.000 ns, 0.000 ns, 0.100 ns, 0.100 ns, 0.100 ns, 0.100 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component VCC ------
 component VCC
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True		);
    port(
		Y		: out    STD_ULOGIC);
 end component;


------ Component XA1 ------
 component XA1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component XA1A ------
 component XA1A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component XA1B ------
 component XA1B
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component XA1C ------
 component XA1C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component XAI1 ------
 component XAI1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component XAI1A ------
 component XAI1A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component XNOR2 ------
 component XNOR2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component XNOR3 ------
 component XNOR3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component XO1 ------
 component XO1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component XO1A ------
 component XO1A
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component XOR2 ------
 component XOR2
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component XOR3 ------
 component XOR3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component ZOR3 ------
 component ZOR3
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component ZOR3I ------
 component ZOR3I
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CLKBIBUF ------
 component CLKBIBUF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_E_PAD : VitalDelayType01Z := (0.000 ns, 0.000 ns, 0.100 ns, 0.100 ns, 0.100 ns, 0.100 ns);
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
			tpd_D_Y			: VitalDelayType01 := (0.100 ns, 0.100 ns);
			tpd_E_Y			: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: inout STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component CLKBIBUFI ------
 component CLKBIBUFI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_E_PAD : VitalDelayType01Z := (0.000 ns, 0.000 ns, 0.100 ns, 0.100 ns, 0.100 ns, 0.100 ns);
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
			tpd_D_Y			: VitalDelayType01 := (0.100 ns, 0.100 ns);
			tpd_E_Y			: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: inout STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component QCLKBIBUF ------
 component QCLKBIBUF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_E_PAD : VitalDelayType01Z := (0.000 ns, 0.000 ns, 0.100 ns, 0.100 ns, 0.100 ns, 0.100 ns);
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
			tpd_D_Y			: VitalDelayType01 := (0.100 ns, 0.100 ns);
			tpd_E_Y			: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: inout STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component QCLKBIBUFI ------
 component QCLKBIBUFI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_E_PAD : VitalDelayType01Z := (0.000 ns, 0.000 ns, 0.100 ns, 0.100 ns, 0.100 ns, 0.100 ns);
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
			tpd_D_Y			: VitalDelayType01 := (0.100 ns, 0.100 ns);
			tpd_E_Y			: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: inout STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component QCLKBUF ------
 component QCLKBUF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PAD		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component QCLKBUFI ------
 component QCLKBUFI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PAD		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component QCLKINT ------
 component QCLKINT
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component QCLKINTI ------
 component QCLKINTI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;

  component CM8F
     generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_S11_Y                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S10_Y                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S01_Y                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S00_Y                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D3_Y                       :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D2_Y                       :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D1_Y                       :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D0_Y                       :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S11_FY                     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S10_FY                     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S01_FY                     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S00_FY                     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D3_FY                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D2_FY                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D1_FY                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D0_FY                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_D0                        :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D1                        :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D2                        :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D3                        :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S00                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S01                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S10                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S11                       :  VitalDelayType01 := (0.000 ns, 0.000 ns));


   port(
      D0                             :  in    STD_ULOGIC;
      D1                             :  in    STD_ULOGIC;
      D2                             :  in    STD_ULOGIC;
      D3                             :  in    STD_ULOGIC;
      S00                            :  in    STD_ULOGIC;
      S01                            :  in    STD_ULOGIC;
      S10                            :  in    STD_ULOGIC;
      S11                            :  in    STD_ULOGIC;
      FY                             :  out   STD_ULOGIC;
      Y                              :  out   STD_ULOGIC);
 end component;

  component FA1A
     generic(
                TimingChecksOn:Boolean :=True;
                Xon: Boolean :=False;
                InstancePath: STRING :="*";
                MsgOn: Boolean :=True;
                tpd_CI_CO               : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_B_CO                : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_A_CO                : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_CI_S                : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_A_S         : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_B_S         : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tipd_CI         : VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_B          : VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_A          : VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                CI              : in    STD_ULOGIC;
                B               : in    STD_ULOGIC;
                A               : in    STD_ULOGIC;
                CO              : out    STD_ULOGIC;
                S               : out    STD_ULOGIC);
 end component;

 component FA1B
   generic(
                TimingChecksOn:Boolean :=True;
                Xon: Boolean :=False;
                InstancePath: STRING :="*";
                MsgOn: Boolean :=True;
                tpd_A_CO                : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_B_CO                : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_CI_CO               : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_CI_S                : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_A_S         : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_B_S         : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tipd_A          : VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_B          : VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_CI         : VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                A               : in    STD_ULOGIC;
                B               : in    STD_ULOGIC;
                CI              : in    STD_ULOGIC;
                CO              : out    STD_ULOGIC;
                S               : out    STD_ULOGIC);
  end component;

 component FA2A
   generic(
                TimingChecksOn:Boolean :=True;
                Xon: Boolean :=False;
                InstancePath: STRING :="*";
                MsgOn: Boolean :=True;
                tpd_CI_CO               : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_B_CO                : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_A0_CO               : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_A1_CO               : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_A0_S                : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_A1_S                : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_B_S         : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_CI_S                : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tipd_CI         : VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_B          : VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_A0         : VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_A1         : VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                CI              : in    STD_ULOGIC;
                B               : in    STD_ULOGIC;
                A0              : in    STD_ULOGIC;
                A1              : in    STD_ULOGIC;
                CO              : out    STD_ULOGIC;
                S               : out    STD_ULOGIC);
 end component;


component BBDLHS
    port(D, E, GIN, GOUT : in std_logic;  PAD : inout std_logic;  
        Q : out std_logic) ;
end component;
component BBHS
    port(D, E : in std_logic;  PAD : inout std_logic;  Y : out 
        std_logic) ;
end component;

------ Component DL2D ------
 component DL2D
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_G_QN                       :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_PRE_QN                     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLR_QN                     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      thold_D_G_posedge_negedge      :  VitalDelayType := 0.000 ns;
      tsetup_D_G_posedge_negedge     :  VitalDelayType := 0.000 ns;
      thold_D_G_negedge_negedge      :  VitalDelayType := 0.000 ns;
      tsetup_D_G_negedge_negedge     :  VitalDelayType := 0.000 ns;
      thold_PRE_G_posedge_negedge     :  VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_negedge : VitalDelayType := 0.000 ns;
      thold_CLR_G_negedge_negedge     :  VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_negedge : VitalDelayType := 0.000 ns;
      tperiod_G_negedge              :  VitalDelayType := 0.000 ns;
      tpw_G_posedge                  :  VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :  VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :  VitalDelayType := 0.000 ns;
      tipd_D                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :  VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :  in    STD_ULOGIC;
      G                              :  in    STD_ULOGIC;
      PRE                            :  in    STD_ULOGIC;
      CLR                            :  in    STD_ULOGIC;
      QN                             :  out   STD_ULOGIC);

 end component;


------ Component DL2B ------
 component DL2B
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_G_QN                       :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_PRE_QN                     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLR_QN                     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      thold_D_G_posedge_posedge      :  VitalDelayType := 0.000 ns;
      tsetup_D_G_posedge_posedge     :  VitalDelayType := 0.000 ns;
      thold_D_G_negedge_posedge      :  VitalDelayType := 0.000 ns;
      tsetup_D_G_negedge_posedge     :  VitalDelayType := 0.000 ns;
      thold_PRE_G_posedge_posedge     :  VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_posedge : VitalDelayType := 0.000 ns;
      thold_CLR_G_negedge_posedge     :  VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_posedge : VitalDelayType := 0.000 ns;
      tperiod_G_posedge              :  VitalDelayType := 0.000 ns;
      tpw_CLR_posedge                :  VitalDelayType := 0.000 ns;
      tpw_G_negedge                  :  VitalDelayType := 0.000 ns;
      tpw_PRE_negedge                :  VitalDelayType := 0.000 ns;
      tipd_D                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :  VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :  in    STD_ULOGIC;
      G                              :  in    STD_ULOGIC;
      PRE                            :  in    STD_ULOGIC;
      CLR                            :  in    STD_ULOGIC;
      QN                             :  out   STD_ULOGIC);

 end component;


------ Component DF1B_CC ------
 component DF1B_CC
    generic(
                TimingChecksOn: Boolean := True;
                InstancePath: STRING := "*";
                Xon: Boolean := False;
                MsgOn: Boolean := True;
                tpd_CLK_Q     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tsetup_D_CLK_posedge_negedge    :   VitalDelayType := 0.000 ns;
                thold_D_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
                tsetup_D_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                thold_D_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                tperiod_CLK_negedge     :VitalDelayType := 0.000 ns;
                tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
                tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
                tipd_D      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_CLK            :    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                CLK             :   in    STD_ULOGIC;
                D               :  in    STD_ULOGIC;
                Q               :  out    STD_ULOGIC);

 end component;

component DF1A
    port(CLK, D : in std_logic;  QN : out std_logic) ;
end component;
component DF1A_CC
    port(CLK, D : in std_logic;  QN : out std_logic) ;
end component;
component DF1C
    port(CLK, D : in std_logic;  QN : out std_logic) ;
end component;
component DF1C_CC
    port(CLK, D : in std_logic;  QN : out std_logic) ;
end component;
component DFC1
    port(CLK, CLR, D : in std_logic;  Q : out std_logic) ;
end component;
component DFC1A
    port(CLK, CLR, D : in std_logic;  Q : out std_logic) ;
end component;
component DFC1A_CC
    port(CLK, CLR, D : in std_logic;  Q : out std_logic) ;
end component;

------ Component DFC1D_CC ------
 component DFC1D_CC
    generic(
                TimingChecksOn: Boolean := True;
                InstancePath: STRING := "*";
                Xon: Boolean := False;
                MsgOn: Boolean := True;
                tpd_CLR_Q      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_CLK_Q     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tsetup_D_CLK_posedge_negedge    :   VitalDelayType := 0.000 ns;
                thold_D_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
                tsetup_D_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                thold_D_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                thold_CLR_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
                trecovery_CLR_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
                tperiod_CLK_negedge     :VitalDelayType := 0.000 ns;
                tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
                tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
                tpw_CLR_negedge :  VitalDelayType := 0.000 ns;
                tipd_CLR        :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_D      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_CLK            :    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                CLR             :   in    STD_ULOGIC;
                CLK             :   in    STD_ULOGIC;
                D               :  in    STD_ULOGIC;
                Q               :  out    STD_ULOGIC);

 end component;

component DFC1E
    port(CLK, CLR, D : in std_logic;  QN : out std_logic) ;
end component;
component DFC1G
    port(CLK, CLR, D : in std_logic;  QN : out std_logic) ;
end component;
component DFC1_CC
    port(CLK, CLR, D : in std_logic;  Q : out std_logic) ;
end component;
component DFE
    port(CLK, D, E : in std_logic;  Q : out std_logic) ;
end component;

------ Component DFE1B_CC ------
 component DFE1B_CC
    generic(
                TimingChecksOn: Boolean := True;
                InstancePath: STRING := "*";
                Xon: Boolean := False;
                MsgOn: Boolean := True;
                tpd_CLK_Q     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tsetup_D_CLK_posedge_posedge    :   VitalDelayType := 0.000 ns;
                thold_D_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
                tsetup_D_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
                thold_D_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
                tsetup_E_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
                thold_E_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
                tsetup_E_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
                thold_E_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
                tperiod_CLK_posedge     :  VitalDelayType := 0.000 ns;
                tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
                tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
                tipd_E  :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_D      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_CLK            :    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                E               :   in    STD_ULOGIC;
                CLK             :   in    STD_ULOGIC;
                D               :  in    STD_ULOGIC;
                Q               :  out    STD_ULOGIC);

 end component;

------ Component DFE1C_CC ------
 component DFE1C_CC
    generic(
                TimingChecksOn: Boolean := True;
                InstancePath: STRING := "*";
                Xon: Boolean := False;
                MsgOn: Boolean := True;
                tpd_CLK_Q     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tsetup_D_CLK_posedge_negedge    :   VitalDelayType := 0.000 ns;
                thold_D_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
                tsetup_D_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                thold_D_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                tsetup_E_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
                thold_E_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
                tsetup_E_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                thold_E_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                tperiod_CLK_negedge     :VitalDelayType := 0.000 ns;
                tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
                tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
                tipd_E  :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_D      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_CLK            :    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                E               :   in    STD_ULOGIC;
                CLK             :   in    STD_ULOGIC;
                D               :  in    STD_ULOGIC;
                Q               :  out    STD_ULOGIC);

 end component;

component DFE3A
    port(CLK, CLR, D, E : in std_logic;  Q : out std_logic) ;
end component;
component DFE3B
    port(CLK, CLR, D, E : in std_logic;  Q : out std_logic) ;
end component;
component DFEA
    port(CLK, D, E : in std_logic;  Q : out std_logic) ;
end component;
component DFEA_CC
    port(CLK, D, E : in std_logic;  Q : out std_logic) ;
end component;
component DFE_CC
    port(CLK, D, E : in std_logic;  Q : out std_logic) ;
end component;
component DFM
    port(A, B, CLK : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end component;
component DFM1B
    port(A, B, CLK, S : in std_logic;  QN : out std_logic) ;
end component;
component DFM1B_CC
    port(A, B, CLK, S : in std_logic;  QN : out std_logic) ;
end component;
component DFM1C
    port(A, B, CLK, S : in std_logic;  QN : out std_logic) ;
end component;
component DFM1C_CC
    port(A, B, CLK, S : in std_logic;  QN : out std_logic) ;
end component;
component DFM3
    port(A, B, CLK, CLR : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end component;
component DFM3B
    port(A, B, CLK, CLR : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end component;
component DFM3E
    port(A, B, CLK, CLR : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end component;
component DFM4C
    port(A, B, CLK, PRE : in std_logic;  QN : out std_logic;  S : 
        in std_logic) ;
end component;
component DFM4D
    port(A, B, CLK, PRE : in std_logic;  QN : out std_logic;  S : 
        in std_logic) ;
end component;
component DFM6A
    port(CLK, CLR, D0, D1, D2, D3 : in std_logic;  Q : out 
        std_logic;  S0, S1 : in std_logic) ;
end component;
component DFM6B
    port(CLK, CLR, D0, D1, D2, D3 : in std_logic;  Q : out 
        std_logic;  S0, S1 : in std_logic) ;
end component;
component DFM7A
    port(CLK, CLR, D0, D1, D2, D3, S0, S10, S11 : in std_logic;  
        Q : out std_logic) ;
end component;
component DFM7B
    port(CLK, CLR, D0, D1, D2, D3 : in std_logic;  Q : out 
        std_logic;  S0, S10, S11 : in std_logic) ;
end component;
component DFM8A
    port(CLK, CLR, D0, D1, D2, D3 : in std_logic;  Q : out 
        std_logic;  S00, S01, S10, S11 : in std_logic) ;
end component;
component DFM8B
    port(CLK, CLR, D0, D1, D2, D3 : in std_logic;  Q : out 
        std_logic;  S00, S01, S10, S11 : in std_logic) ;
end component;
component DFMA
    port(A, B, CLK : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end component;
component DFMA_CC
    port(A, B, CLK : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end component;
component DFMB
    port(A, B, CLK, CLR : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end component;
component DFME1A
    port(A, B, CLK, E : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end component;
component DFM_CC
    port(A, B, CLK : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end component;

------ Component DFP1_CC ------
 component DFP1_CC
    generic(
                TimingChecksOn: Boolean := True;
                InstancePath: STRING := "*";
                Xon: Boolean := False;
                MsgOn: Boolean := True;
                tpd_PRE_Q       :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_CLK_Q     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tsetup_D_CLK_posedge_posedge    :   VitalDelayType := 0.000 ns;
                thold_D_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
                tsetup_D_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
                thold_D_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
                thold_PRE_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
                trecovery_PRE_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
                tperiod_CLK_posedge     :  VitalDelayType := 0.000 ns;
                tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
                tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
                tpw_PRE_posedge :  VitalDelayType := 0.000 ns;
                tipd_PRE        :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_D      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_CLK            :    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                PRE             :   in    STD_ULOGIC;
                CLK             :   in    STD_ULOGIC;
                D               :  in    STD_ULOGIC;
                Q               :  out    STD_ULOGIC);

 end component;

------ Component DFP1A_CC ------
 component DFP1A_CC
    generic(
                TimingChecksOn: Boolean := True;
                InstancePath: STRING := "*";
                Xon: Boolean := False;
                MsgOn: Boolean := True;
                tpd_PRE_Q       :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_CLK_Q     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tsetup_D_CLK_posedge_negedge    :   VitalDelayType := 0.000 ns;
                thold_D_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
                tsetup_D_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                thold_D_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                thold_PRE_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                trecovery_PRE_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                tperiod_CLK_negedge     :VitalDelayType := 0.000 ns;
                tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
                tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
                tpw_PRE_posedge :  VitalDelayType := 0.000 ns;
                tipd_PRE        :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_D      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_CLK            :    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                PRE             :   in    STD_ULOGIC;
                CLK             :   in    STD_ULOGIC;
                D               :  in    STD_ULOGIC;
                Q               :  out    STD_ULOGIC);

 end component;

component DFP1C
    port(CLK, D, PRE : in std_logic;  QN : out std_logic) ;
end component;

------ Component DFP1D_CC ------
 component DFP1D_CC
    generic(
                TimingChecksOn: Boolean := True;
                InstancePath: STRING := "*";
                Xon: Boolean := False;
                MsgOn: Boolean := True;
                tpd_PRE_Q       :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_CLK_Q     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tsetup_D_CLK_posedge_negedge    :   VitalDelayType := 0.000 ns;
                thold_D_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
                tsetup_D_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                thold_D_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
                thold_PRE_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
                trecovery_PRE_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
                tperiod_CLK_negedge     :VitalDelayType := 0.000 ns;
                tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
                tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
                tpw_PRE_negedge :  VitalDelayType := 0.000 ns;
                tipd_PRE        :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_D      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_CLK            :    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                PRE             :   in    STD_ULOGIC;
                CLK             :   in    STD_ULOGIC;
                D               :  in    STD_ULOGIC;
                Q               :  out    STD_ULOGIC);

 end component;

component DFP1E
    port(CLK, D, PRE : in std_logic;  QN : out std_logic) ;
end component;
component DFP1F
    port(CLK, D, PRE : in std_logic;  QN : out std_logic) ;
end component;
component DFP1G
    port(CLK, D, PRE : in std_logic;  QN : out std_logic) ;
end component;

------ Component DFPC_CC ------
 component DFPC_CC
    generic(
                TimingChecksOn: Boolean := True;
                InstancePath: STRING := "*";
                Xon: Boolean := False;
                MsgOn: Boolean := True;
                tpd_PRE_Q       :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_CLR_Q      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_CLK_Q     :  VitalDelayType01 := (0.100 ns, 0.100 ns);
                tsetup_D_CLK_posedge_posedge    :   VitalDelayType := 0.000 ns;
                thold_D_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
                tsetup_D_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
                thold_D_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
                thold_PRE_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
                trecovery_PRE_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
                thold_CLR_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
                trecovery_CLR_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
                tperiod_CLK_posedge     :  VitalDelayType := 0.000 ns;
                tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
                tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
                tpw_PRE_posedge :  VitalDelayType := 0.000 ns;
                tpw_CLR_negedge :  VitalDelayType := 0.000 ns;
                tipd_PRE        :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_CLR        :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_D      :   VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_CLK            :    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                CLR             :   in    STD_ULOGIC;
                PRE             :   in    STD_ULOGIC;
                CLK             :   in    STD_ULOGIC;
                D               :  in    STD_ULOGIC;
                Q               :  out    STD_ULOGIC);

 end component;

------ Component DFPCA ------
 component DFPCA
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLR_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLK_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
      tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
      thold_PRE_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge : VitalDelayType := 0.000 ns;
      thold_CLR_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge : VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :  VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :  VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :  VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :  VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :  VitalDelayType := 0.000 ns;
      tipd_D                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :  VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :  in    STD_ULOGIC;
      CLK                            :  in    STD_ULOGIC;
      PRE                            :  in    STD_ULOGIC;
      CLR                            :  in    STD_ULOGIC;
      Q                              :  out   STD_ULOGIC);

 end component;

------ Component DFPCA_CC ------
 component DFPCA_CC
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLR_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLK_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
      tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
      thold_PRE_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge : VitalDelayType := 0.000 ns;
      thold_CLR_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge : VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :  VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :  VitalDelayType := 0.000 ns;
      tpw_PRE_posedge                :  VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :  VitalDelayType := 0.000 ns;
      tpw_CLR_negedge                :  VitalDelayType := 0.000 ns;
      tipd_D                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PRE                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLR                       :  VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :  in    STD_ULOGIC;
      CLK                            :  in    STD_ULOGIC;
      PRE                            :  in    STD_ULOGIC;
      CLR                            :  in    STD_ULOGIC;
      Q                              :  out   STD_ULOGIC);

 end component;

component DL1A
    port(D, G : in std_logic;  QN : out std_logic) ;
end component;
component DL1C
    port(D, G : in std_logic;  QN : out std_logic) ;
end component;
component DLC1F
    port(CLR, D, G : in std_logic;  QN : out std_logic) ;
end component;
component DLC1G
    port(CLR, D, G : in std_logic;  QN : out std_logic) ;
end component;
component DLE
    port(D, E, G : in std_logic;  Q : out std_logic) ;
end component;
component DLE1D
    port(D, E, G : in std_logic;  QN : out std_logic) ;
end component;
component DLE2B
    port(CLR, D, E, G : in std_logic;  Q : out std_logic) ;
end component;
component DLEA
    port(D, E, G : in std_logic;  Q : out std_logic) ;
end component;
component DLEB
    port(D, E, G : in std_logic;  Q : out std_logic) ;
end component;
component DLEC
    port(D, E, G : in std_logic;  Q : out std_logic) ;
end component;
component DLM
    port(A, B, G : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end component;
component DLM2
    port(A, B, CLR, G : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end component;
component DLM2B
    port(A, B, CLR, G : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end component;
component DLM3
    port(D0, D1, D2, D3, G : in std_logic;  Q : out std_logic;  
        S0, S1 : in std_logic) ;
end component;
component DLM3A
    port(D0, D1, D2, D3, G : in std_logic;  Q : out std_logic;  
        S0, S1 : in std_logic) ;
end component;
component DLM4
    port(D0, D1, D2, D3, G : in std_logic;  Q : out std_logic;  
        S0, S10, S11 : in std_logic) ;
end component;
component DLM4A
    port(D0, D1, D2, D3, G : in std_logic;  Q : out std_logic;  
        S0, S10, S11 : in std_logic) ;
end component;
component DLM8A
    port(CLR, D0, D1, D2, D3, G : in std_logic;  Q : out 
        std_logic;  S00, S01, S10, S11 : in std_logic) ;
end component;
component DLM8B
    port(CLR, D0, D1, D2, D3, G : in std_logic;  Q : out 
        std_logic;  S00, S01, S10, S11 : in std_logic) ;
end component;
component DLMA
    port(A, B, G : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end component;
component DLME1A
    port(A, B, E, G, S : in std_logic;  Q : out std_logic) ;
end component;
component DLP1D
    port(D, G, PRE : in std_logic;  QN : out std_logic) ;
end component;
component DLP1E
    port(D, G, PRE : in std_logic;  QN : out std_logic) ;
end component;
component DXAND7
    port(A, B, C, D, E, F, G : in std_logic;  Y : out std_logic
        ) ;
end component;
component DXAX7
    port(A, B, C, D, E, F, G, H : in std_logic;  Y : out 
        std_logic) ;
end component;
component DXNAND7
    port(A, B, C, D, E, F, G : in std_logic;  Y : out std_logic
        ) ;
end component;
component IBDL
    port(G, PAD : in std_logic;  Q : out std_logic) ;
end component;
component IR
    port(CLK, PAD : in std_logic;  Q : out std_logic) ;
end component;
component IRI
    port(CLK, PAD : in std_logic;  QN : out std_logic) ;
end component;
component JKF2C
    port(CLK, CLR, J, K : in std_logic;  Q : out std_logic) ;
end component;
component JKF2D
    port(CLK, CLR, J, K : in std_logic;  Q : out std_logic) ;
end component;
component MXC1
    port(A, B, C, D, S : in std_logic;  Y : out std_logic) ;
end component;
component MXT
    port(D0, D1, D2, D3, S0A, S0B, S1 : in std_logic;  Y : out 
        std_logic) ;
end component;
component OBDLHS
    port(D, G : in std_logic;  PAD : out std_logic) ;
end component;
component OBHS
    port(PAD : out std_logic;  D : in std_logic) ;
end component;
component ORH
    port(CLK, D : in std_logic;  PAD : out std_logic) ;
end component;
component ORIH
    port(CLK, D : in std_logic;  PAD : out std_logic) ;
end component;
component ORITH
    port(CLK, D, E : in std_logic;  PAD : out std_logic) ;
end component;
component ORTH
    port(CLK, D, E : in std_logic;  PAD : out std_logic) ;
end component;
component TBDLHS
    port(D, E, G : in std_logic;  PAD : out std_logic) ;
end component;
component TBHS
    port(D, E : in std_logic;  PAD : out std_logic) ;
end component;
end COMPONENTS;

----- CELL DF1B_CC -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DF1B_CC is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
      tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
      tperiod_CLK_negedge            :	VitalDelayType := 0.000 ns;
      tpw_CLK_posedge                :	VitalDelayType := 0.000 ns;
      tpw_CLK_negedge                :	VitalDelayType := 0.000 ns;
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_CLK                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
attribute VITAL_LEVEL0 of DF1B_CC : entity is TRUE;
end DF1B_CC;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture VITAL_ACT of DF1B_CC is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLK_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_D_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_CLK	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLK	: VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(0 to 2);
   VARIABLE D_delayed : STD_ULOGIC := 'X';
   VARIABLE CLK_delayed : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Q_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Q_GlitchData	: VitalGlitchDataType;

   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)

   CONSTANT DF1_Q_tab : VitalStateTableType := (
    ( L,  L,  H,  x,  L ),
    ( L,  H,  H,  x,  H ),
    ( H,  x,  x,  x,  S ),
    ( x,  x,  L,  x,  S ));

   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_CLK_negedge,
          TimingData              => Tmkr_D_CLK_negedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName           => "CLK",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_CLK_posedge_negedge,
          SetupLow                => tsetup_D_CLK_negedge_negedge,
          HoldHigh                => thold_D_CLK_posedge_negedge,
          HoldLow                 => thold_D_CLK_negedge_negedge,
          CheckEnabled            => 
                           TRUE,
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DF1B_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLK,
          PeriodData              => PInfo_CLK,
          TestSignal              => CLK_ipd,
          TestSignalName          => "CLK",
          TestDelay               => 0 ns,
          Period                  => tperiod_CLK_negedge,
          PulseWidthHigh          => tpw_CLK_posedge,
          PulseWidthLow           => tpw_CLK_negedge,
          CheckEnabled            => 
                           TRUE,
          HeaderMsg               => InstancePath &"/DF1B_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK_negedge or Pviol_CLK;
      VitalStateTable(
        Result => Q_zd,
        PreviousDataIn => PrevData_Q,
        StateTable => DF1_Q_tab,
        DataIn => (
               CLK_ipd, D_delayed, CLK_delayed));
      Q_zd := Violation XOR Q_zd;
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       GlitchData => Q_GlitchData,
       OutSignalName => "Q",
       OutTemp => Q_zd,
       Paths => (0 => (CLK_ipd'last_event, tpd_CLK_Q, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_DF1B_CC_VITAL of DF1B_CC is
   for VITAL_ACT
   end for;
end CFG_DF1B_CC_VITAL;


----- CELL DFC1D_CC -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DFC1D_CC is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLR_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
      tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
      thold_CLR_CLK_posedge_negedge   :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge : VitalDelayType := 0.000 ns;
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
attribute VITAL_LEVEL0 of DFC1D_CC : entity is TRUE;
end DFC1D_CC;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture VITAL_ACT of DFC1D_CC is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLR_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   VitalWireDelay (CLR_ipd, CLR, tipd_CLR);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLK_ipd, CLR_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_D_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_CLR_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_CLR_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_CLK	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLK	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_CLR	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLR	: VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(0 to 3);
   VARIABLE D_delayed : STD_ULOGIC := 'X';
   VARIABLE CLK_delayed : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Q_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Q_GlitchData	: VitalGlitchDataType;

   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)

   CONSTANT DFC1B_Q_tab : VitalStateTableType := (
    ( L,  x,  x,  x,  x,  L ),
    ( H,  L,  H,  H,  x,  H ),
    ( H,  H,  x,  x,  x,  S ),
    ( H,  x,  x,  L,  x,  S ),
    ( x,  L,  L,  H,  x,  L ),
    ( U,  x,  x,  x,  L,  L ));


   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_CLK_negedge,
          TimingData              => Tmkr_D_CLK_negedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName           => "CLK",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_CLK_posedge_negedge,
          SetupLow                => tsetup_D_CLK_negedge_negedge,
          HoldHigh                => thold_D_CLK_posedge_negedge,
          HoldLow                 => thold_D_CLK_negedge_negedge,
          CheckEnabled            => 
                           TO_X01((NOT CLR_ipd) ) /= '1',
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFC1D_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_CLR_CLK_negedge,
          TimingData              => Tmkr_CLR_CLK_negedge,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName          => "CLK",
          RefDelay                => 0 ns,
          Recovery                => trecovery_CLR_CLK_posedge_negedge,
          Removal                 => thold_CLR_CLK_posedge_negedge,
          ActiveLow               => TRUE,
          CheckEnabled            => 
                           TRUE,
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFC1D_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLK,
          PeriodData              => PInfo_CLK,
          TestSignal              => CLK_ipd,
          TestSignalName          => "CLK",
          TestDelay               => 0 ns,
          Period                  => tperiod_CLK_negedge,
          PulseWidthHigh          => tpw_CLK_posedge,
          PulseWidthLow           => tpw_CLK_negedge,
          CheckEnabled            => 
                           TO_X01((NOT CLR_ipd) ) /= '1',
          HeaderMsg               => InstancePath &"/DFC1D_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLR,
          PeriodData              => PInfo_CLR,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => 0 ns,
          PulseWidthLow           => tpw_CLR_negedge,
          CheckEnabled            => 
                           TRUE,
          HeaderMsg               => InstancePath &"/DFC1D_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK_negedge or Tviol_CLR_CLK_negedge or Pviol_CLR or Pviol_CLK;
      VitalStateTable(
        Result => Q_zd,
        PreviousDataIn => PrevData_Q,
        StateTable => DFC1B_Q_tab,
        DataIn => (
               CLR_ipd, CLK_ipd, D_delayed, CLK_delayed));
      Q_zd := Violation XOR Q_zd;
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       GlitchData => Q_GlitchData,
       OutSignalName => "Q",
       OutTemp => Q_zd,
       Paths => (0 => (CLR_ipd'last_event, tpd_CLR_Q, TRUE),
                 1 => (CLK_ipd'last_event, tpd_CLK_Q, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_DFC1D_CC_VITAL of DFC1D_CC is
   for VITAL_ACT
   end for;
end CFG_DFC1D_CC_VITAL;


----- CELL DFE1B_CC -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DFE1B_CC is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tsetup_D_CLK_posedge_posedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_posedge_posedge    :  VitalDelayType := 0.000 ns;
      tsetup_D_CLK_negedge_posedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_negedge_posedge    :  VitalDelayType := 0.000 ns;
      tsetup_E_CLK_posedge_posedge   :  VitalDelayType := 0.000 ns;
      thold_E_CLK_posedge_posedge    :  VitalDelayType := 0.000 ns;
      tsetup_E_CLK_negedge_posedge   :  VitalDelayType := 0.000 ns;
      thold_E_CLK_negedge_posedge    :  VitalDelayType := 0.000 ns;
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
attribute VITAL_LEVEL0 of DFE1B_CC : entity is TRUE;
end DFE1B_CC;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture VITAL_ACT of DFE1B_CC is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL E_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, E_ipd, CLK_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK_posedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_D_CLK_posedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_E_CLK_posedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_E_CLK_posedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_CLK	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLK	: VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(0 to 4);
   VARIABLE D_delayed : STD_ULOGIC := 'X';
   VARIABLE E_delayed : STD_ULOGIC := 'X';
   VARIABLE CLK_delayed : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Q_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Q_GlitchData	: VitalGlitchDataType;

   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)


   CONSTANT DFE1B_Q_tab : VitalStateTableType := (
    ( L,  L,  L,  x,  H,  x,  L ),
    ( L,  L,  x,  H,  H,  x,  L ),
    ( L,  H,  H,  x,  H,  x,  H ),
    ( L,  H,  x,  H,  H,  x,  H ),
    ( L,  x,  L,  L,  H,  x,  L ),
    ( L,  x,  H,  L,  H,  x,  H ),
    ( H,  x,  x,  x,  x,  x,  S ),
    ( x,  x,  x,  x,  L,  x,  S ));

   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_CLK_posedge,
          TimingData              => Tmkr_D_CLK_posedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName           => "CLK",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_CLK_posedge_posedge,
          SetupLow                => tsetup_D_CLK_negedge_posedge,
          HoldHigh                => thold_D_CLK_posedge_posedge,
          HoldLow                 => thold_D_CLK_negedge_posedge,
          CheckEnabled            => 
                           TO_X01((NOT E_ipd)) /= '0',
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/DFE1B_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalSetupHoldCheck (
          Violation               => Tviol_E_CLK_posedge,
          TimingData              => Tmkr_E_CLK_posedge,
          TestSignal              => E_ipd,
          TestSignalName          => "E",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName           => "CLK",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_E_CLK_posedge_posedge,
          SetupLow                => tsetup_E_CLK_negedge_posedge,
          HoldHigh                => thold_E_CLK_posedge_posedge,
          HoldLow                 => thold_E_CLK_negedge_posedge,
          CheckEnabled            => 
                           TRUE,
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/DFE1B_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLK,
          PeriodData              => PInfo_CLK,
          TestSignal              => CLK_ipd,
          TestSignalName          => "CLK",
          TestDelay               => 0 ns,
          Period                  => tperiod_CLK_posedge,
          PulseWidthHigh          => tpw_CLK_posedge,
          PulseWidthLow           => tpw_CLK_negedge,
          CheckEnabled            => 
                           TRUE,
          HeaderMsg               => InstancePath &"/DFE1B_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK_posedge or Tviol_E_CLK_posedge or Pviol_CLK;
      VitalStateTable(
        Result => Q_zd,
        PreviousDataIn => PrevData_Q,
        StateTable => DFE1B_Q_tab,
        DataIn => (
               CLK_delayed, Q_zd, D_delayed, E_delayed, CLK_ipd));
      Q_zd := Violation XOR Q_zd;
      D_delayed := D_ipd;
      E_delayed := E_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       GlitchData => Q_GlitchData,
       OutSignalName => "Q",
       OutTemp => Q_zd,
       Paths => (0 => (CLK_ipd'last_event, tpd_CLK_Q, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_DFE1B_CC_VITAL of DFE1B_CC is
   for VITAL_ACT
   end for;
end CFG_DFE1B_CC_VITAL;


----- CELL DFE1C_CC -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DFE1C_CC is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_CLK_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
      tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
      tsetup_E_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_E_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
      tsetup_E_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_E_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
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
attribute VITAL_LEVEL0 of DFE1C_CC : entity is TRUE;
end DFE1C_CC;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture VITAL_ACT of DFE1C_CC is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL E_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, E_ipd, CLK_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_D_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_E_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_E_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_CLK	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLK	: VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(0 to 4);
   VARIABLE D_delayed : STD_ULOGIC := 'X';
   VARIABLE E_delayed : STD_ULOGIC := 'X';
   VARIABLE CLK_delayed : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Q_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Q_GlitchData	: VitalGlitchDataType;

   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)

   CONSTANT DFE1B_Q_tab : VitalStateTableType := (
    ( L,  L,  L,  x,  H,  x,  L ),
    ( L,  L,  x,  H,  H,  x,  L ),
    ( L,  H,  H,  x,  H,  x,  H ),
    ( L,  H,  x,  H,  H,  x,  H ),
    ( L,  x,  L,  L,  H,  x,  L ),
    ( L,  x,  H,  L,  H,  x,  H ),
    ( H,  x,  x,  x,  x,  x,  S ),
    ( x,  x,  x,  x,  L,  x,  S ));

   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_CLK_negedge,
          TimingData              => Tmkr_D_CLK_negedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName           => "CLK",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_CLK_posedge_negedge,
          SetupLow                => tsetup_D_CLK_negedge_negedge,
          HoldHigh                => thold_D_CLK_posedge_negedge,
          HoldLow                 => thold_D_CLK_negedge_negedge,
          CheckEnabled            => 
                           TO_X01((NOT E_ipd)) /= '0' ,
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFE1C_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalSetupHoldCheck (
          Violation               => Tviol_E_CLK_negedge,
          TimingData              => Tmkr_E_CLK_negedge,
          TestSignal              => E_ipd,
          TestSignalName          => "E",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName           => "CLK",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_E_CLK_posedge_negedge,
          SetupLow                => tsetup_E_CLK_negedge_negedge,
          HoldHigh                => thold_E_CLK_posedge_negedge,
          HoldLow                 => thold_E_CLK_negedge_negedge,

          CheckEnabled            => 
                           TRUE,
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFE1C_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLK,
          PeriodData              => PInfo_CLK,
          TestSignal              => CLK_ipd,
          TestSignalName          => "CLK",
          TestDelay               => 0 ns,
          Period                  => tperiod_CLK_negedge,
          PulseWidthHigh          => tpw_CLK_posedge,
          PulseWidthLow           => tpw_CLK_negedge,
          CheckEnabled            => 
                           TRUE,
          HeaderMsg               => InstancePath &"/DFE1C_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK_negedge or Tviol_E_CLK_negedge or Pviol_CLK;
      VitalStateTable(
        Result => Q_zd,
        PreviousDataIn => PrevData_Q,
        StateTable => DFE1B_Q_tab,
        DataIn => (
               CLK_ipd, Q_zd, D_delayed, E_delayed, CLK_delayed));
      Q_zd := Violation XOR Q_zd;
      D_delayed := D_ipd;
      E_delayed := E_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       GlitchData => Q_GlitchData,
       OutSignalName => "Q",
       OutTemp => Q_zd,
       Paths => (0 => (CLK_ipd'last_event, tpd_CLK_Q, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_DFE1C_CC_VITAL of DFE1C_CC is
   for VITAL_ACT
   end for;
end CFG_DFE1C_CC_VITAL;


----- CELL DFP1_CC -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DFP1_CC is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tsetup_D_CLK_posedge_posedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_posedge_posedge    :  VitalDelayType := 0.000 ns;
      tsetup_D_CLK_negedge_posedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_negedge_posedge    :  VitalDelayType := 0.000 ns;
      thold_PRE_CLK_negedge_posedge   :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge : VitalDelayType := 0.000 ns;
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
attribute VITAL_LEVEL0 of DFP1_CC : entity is TRUE;
end DFP1_CC;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture VITAL_ACT of DFP1_CC is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'X';
   SIGNAL PRE_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   VitalWireDelay (PRE_ipd, PRE, tipd_PRE);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLK_ipd, PRE_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK_posedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_D_CLK_posedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_PRE_CLK_posedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_PRE_CLK_posedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_CLK	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLK	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_PRE	: STD_ULOGIC := '0';
   VARIABLE PInfo_PRE	: VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(0 to 3);
   VARIABLE D_delayed : STD_ULOGIC := 'X';
   VARIABLE CLK_delayed : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Q_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Q_GlitchData	: VitalGlitchDataType;

   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)

   CONSTANT DFP1_CC_Q_tab : VitalStateTableType := (
    ( L,  L,  L,  H,  x,  L ),
    ( L,  H,  x,  H,  x,  H ),
    ( H,  x,  L,  x,  x,  S ),
    ( x,  x,  L,  L,  x,  S ),
    ( x,  x,  H,  x,  x,  H ),
    ( x,  x,  U,  x,  H,  H ));

   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_CLK_posedge,
          TimingData              => Tmkr_D_CLK_posedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName           => "CLK",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_CLK_posedge_posedge,
          SetupLow                => tsetup_D_CLK_negedge_posedge,
          HoldHigh                => thold_D_CLK_posedge_posedge,
          HoldLow                 => thold_D_CLK_negedge_posedge,
          CheckEnabled            => 
                           TO_X01(PRE_ipd ) /= '1',
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/DFP1_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_PRE_CLK_posedge,
          TimingData              => Tmkr_PRE_CLK_posedge,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName          => "CLK",
          RefDelay                => 0 ns,
          Recovery                => trecovery_PRE_CLK_negedge_posedge,
          Removal                 => thold_PRE_CLK_negedge_posedge,
          ActiveLow               => FALSE,
          CheckEnabled            => 
                           TRUE,
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/DFP1_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLK,
          PeriodData              => PInfo_CLK,
          TestSignal              => CLK_ipd,
          TestSignalName          => "CLK",
          TestDelay               => 0 ns,
          Period                  => tperiod_CLK_posedge,
          PulseWidthHigh          => tpw_CLK_posedge,
          PulseWidthLow           => tpw_CLK_negedge,
          CheckEnabled            => 
                           TO_X01(PRE_ipd ) /= '1',
          HeaderMsg               => InstancePath &"/DFP1_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_PRE,
          PeriodData              => PInfo_PRE,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => tpw_PRE_posedge,
          PulseWidthLow           => 0 ns,
          CheckEnabled            => 
                           TRUE,
          HeaderMsg               => InstancePath &"/DFP1_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK_posedge or Tviol_PRE_CLK_posedge or Pviol_PRE or Pviol_CLK;
      VitalStateTable(
        Result => Q_zd,
        PreviousDataIn => PrevData_Q,
        StateTable => DFP1_CC_Q_tab,
        DataIn => (
               CLK_delayed, D_delayed, PRE_ipd, CLK_ipd));
      Q_zd := Violation XOR Q_zd;
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       GlitchData => Q_GlitchData,
       OutSignalName => "Q",
       OutTemp => Q_zd,
       Paths => (0 => (PRE_ipd'last_event, tpd_PRE_Q, TRUE),
                 1 => (CLK_ipd'last_event, tpd_CLK_Q, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_DFP1_CC_VITAL of DFP1_CC is
   for VITAL_ACT
   end for;
end CFG_DFP1_CC_VITAL;


----- CELL DFP1A_CC -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DFP1A_CC is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
      tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
      thold_PRE_CLK_negedge_negedge   :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge : VitalDelayType := 0.000 ns;
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
attribute VITAL_LEVEL0 of DFP1A_CC : entity is TRUE;
end DFP1A_CC;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture VITAL_ACT of DFP1A_CC is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'X';
   SIGNAL PRE_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   VitalWireDelay (PRE_ipd, PRE, tipd_PRE);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLK_ipd, PRE_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_D_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_PRE_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_PRE_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_CLK	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLK	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_PRE	: STD_ULOGIC := '0';
   VARIABLE PInfo_PRE	: VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(0 to 3);
   VARIABLE D_delayed : STD_ULOGIC := 'X';
   VARIABLE CLK_delayed : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Q_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Q_GlitchData	: VitalGlitchDataType;

   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)

   CONSTANT DFP1_Q_tab : VitalStateTableType := (
    ( L,  L,  L,  H,  x,  L ),
    ( L,  H,  x,  H,  x,  H ),
    ( H,  x,  L,  x,  x,  S ),
    ( x,  x,  L,  L,  x,  S ),
    ( x,  x,  H,  x,  x,  H ),
    ( x,  x,  U,  x,  H,  H ));

   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_CLK_negedge,
          TimingData              => Tmkr_D_CLK_negedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName           => "CLK",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_CLK_posedge_negedge,
          SetupLow                => tsetup_D_CLK_negedge_negedge,
          HoldHigh                => thold_D_CLK_posedge_negedge,
          HoldLow                 => thold_D_CLK_negedge_negedge,
          CheckEnabled            => 
                           TO_X01(PRE_ipd ) /= '1',
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFP1A_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_PRE_CLK_negedge,
          TimingData              => Tmkr_PRE_CLK_negedge,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName          => "CLK",
          RefDelay                => 0 ns,
          Recovery                => trecovery_PRE_CLK_negedge_negedge,
          Removal                 => thold_PRE_CLK_negedge_negedge,
          ActiveLow               => FALSE,
          CheckEnabled            => 
                           TRUE,
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFP1A_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLK,
          PeriodData              => PInfo_CLK,
          TestSignal              => CLK_ipd,
          TestSignalName          => "CLK",
          TestDelay               => 0 ns,
          Period                  => tperiod_CLK_negedge,
          PulseWidthHigh          => tpw_CLK_posedge,
          PulseWidthLow           => tpw_CLK_negedge,
          CheckEnabled            => 
                           TO_X01(PRE_ipd ) /= '1',
          HeaderMsg               => InstancePath &"/DFP1A_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_PRE,
          PeriodData              => PInfo_PRE,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => tpw_PRE_posedge,
          PulseWidthLow           => 0 ns,
          CheckEnabled            => 
                           TRUE,
          HeaderMsg               => InstancePath &"/DFP1A_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK_negedge or Pviol_PRE or Tviol_PRE_CLK_negedge or Pviol_CLK;
      VitalStateTable(
        Result => Q_zd,
        PreviousDataIn => PrevData_Q,
        StateTable => DFP1_Q_tab,
        DataIn => (
               CLK_ipd, D_delayed, PRE_ipd, CLK_delayed));
      Q_zd := Violation XOR Q_zd;
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       GlitchData => Q_GlitchData,
       OutSignalName => "Q",
       OutTemp => Q_zd,
       Paths => (0 => (PRE_ipd'last_event, tpd_PRE_Q, TRUE),
                 1 => (CLK_ipd'last_event, tpd_CLK_Q, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_DFP1A_CC_VITAL of DFP1A_CC is
   for VITAL_ACT
   end for;
end CFG_DFP1A_CC_VITAL;


----- CELL DFP1D_CC -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DFP1D_CC is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
      tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
      thold_PRE_CLK_posedge_negedge   :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_posedge_negedge : VitalDelayType := 0.000 ns;
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
attribute VITAL_LEVEL0 of DFP1D_CC : entity is TRUE;
end DFP1D_CC;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture VITAL_ACT of DFP1D_CC is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'X';
   SIGNAL PRE_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   VitalWireDelay (PRE_ipd, PRE, tipd_PRE);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLK_ipd, PRE_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_D_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_PRE_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_PRE_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_CLK	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLK	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_PRE	: STD_ULOGIC := '0';
   VARIABLE PInfo_PRE	: VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(0 to 3);
   VARIABLE D_delayed : STD_ULOGIC := 'X';
   VARIABLE CLK_delayed : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Q_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Q_GlitchData	: VitalGlitchDataType;

   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)

   CONSTANT DFP1B_Q_tab : VitalStateTableType := (
    ( L,  L,  H,  H,  x,  L ),
    ( L,  H,  x,  H,  x,  H ),
    ( H,  x,  H,  x,  x,  S ),
    ( x,  x,  L,  x,  x,  H ),
    ( x,  x,  H,  L,  x,  S ),
    ( x,  x,  U,  x,  H,  H ));


   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_CLK_negedge,
          TimingData              => Tmkr_D_CLK_negedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName           => "CLK",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_CLK_posedge_negedge,
          SetupLow                => tsetup_D_CLK_negedge_negedge,
          HoldHigh                => thold_D_CLK_posedge_negedge,
          HoldLow                 => thold_D_CLK_negedge_negedge,
          CheckEnabled            => 
                           TO_X01((NOT PRE_ipd) ) /= '1',
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFP1D_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_PRE_CLK_negedge,
          TimingData              => Tmkr_PRE_CLK_negedge,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName          => "CLK",
          RefDelay                => 0 ns,
          Recovery                => trecovery_PRE_CLK_posedge_negedge,
          Removal                 => thold_PRE_CLK_posedge_negedge,
          ActiveLow               => TRUE,
          CheckEnabled            => 
                           TRUE,
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFP1D_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLK,
          PeriodData              => PInfo_CLK,
          TestSignal              => CLK_ipd,
          TestSignalName          => "CLK",
          TestDelay               => 0 ns,
          Period                  => tperiod_CLK_negedge,
          PulseWidthHigh          => tpw_CLK_posedge,
          PulseWidthLow           => tpw_CLK_negedge,
          CheckEnabled            => 
                           TO_X01((NOT PRE_ipd) ) /= '1',
          HeaderMsg               => InstancePath &"/DFP1D_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_PRE,
          PeriodData              => PInfo_PRE,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => 0 ns,
          PulseWidthLow           => tpw_PRE_negedge,
          CheckEnabled            => 
                           TRUE,
          HeaderMsg               => InstancePath &"/DFP1D_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK_negedge or Pviol_PRE or Tviol_PRE_CLK_negedge or Pviol_CLK;
      VitalStateTable(
        Result => Q_zd,
        PreviousDataIn => PrevData_Q,
        StateTable => DFP1B_Q_tab,
        DataIn => (
               CLK_ipd, D_delayed, PRE_ipd, CLK_delayed));
      Q_zd := Violation XOR Q_zd;
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       GlitchData => Q_GlitchData,
       OutSignalName => "Q",
       OutTemp => Q_zd,
       Paths => (0 => (PRE_ipd'last_event, tpd_PRE_Q, TRUE),
                 1 => (CLK_ipd'last_event, tpd_CLK_Q, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_DFP1D_CC_VITAL of DFP1D_CC is
   for VITAL_ACT
   end for;
end CFG_DFP1D_CC_VITAL;


----- CELL DFPC_CC -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DFPC_CC is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tsetup_D_CLK_posedge_posedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_posedge_posedge    :  VitalDelayType := 0.000 ns;
      tsetup_D_CLK_negedge_posedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_negedge_posedge    :  VitalDelayType := 0.000 ns;
      thold_PRE_CLK_negedge_posedge   :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge : VitalDelayType := 0.000 ns;
      thold_CLR_CLK_posedge_posedge   :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_posedge : VitalDelayType := 0.000 ns;
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
attribute VITAL_LEVEL0 of DFPC_CC : entity is TRUE;
end DFPC_CC;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture VITAL_ACT of DFPC_CC is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'X';
   SIGNAL PRE_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLR_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   VitalWireDelay (PRE_ipd, PRE, tipd_PRE);
   VitalWireDelay (CLR_ipd, CLR, tipd_CLR);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLK_ipd, PRE_ipd, CLR_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK_posedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_D_CLK_posedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_PRE_CLK_posedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_PRE_CLK_posedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_CLR_CLK_posedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_CLR_CLK_posedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_CLK	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLK	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_PRE	: STD_ULOGIC := '0';
   VARIABLE PInfo_PRE	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_CLR	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLR	: VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(0 to 4);
   VARIABLE D_delayed : STD_ULOGIC := 'X';
   VARIABLE CLK_delayed : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Q_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Q_GlitchData	: VitalGlitchDataType;

   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)

   CONSTANT DFPC_CC_Q_tab : VitalStateTableType := (
    ( L,  x,  x,  x,  x,  x,  L ),
    ( H,  L,  H,  x,  H,  x,  H ),
    ( H,  H,  x,  L,  x,  x,  S ),
    ( H,  x,  x,  L,  L,  x,  S ),
    ( H,  x,  x,  H,  x,  x,  H ),
    ( x,  L,  L,  L,  H,  x,  L ),
    ( U,  x,  x,  x,  x,  L,  L ),
    ( H,  x,  x,  U,  x,  H,  H ));


   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_CLK_posedge,
          TimingData              => Tmkr_D_CLK_posedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName           => "CLK",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_CLK_posedge_posedge,
          SetupLow                => tsetup_D_CLK_negedge_posedge,
          HoldHigh                => thold_D_CLK_posedge_posedge,
          HoldLow                 => thold_D_CLK_negedge_posedge,
          CheckEnabled            => 
                           TO_X01(( PRE_ipd ) OR ( (NOT CLR_ipd) ) ) /= '1',
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/DFPC_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_PRE_CLK_posedge,
          TimingData              => Tmkr_PRE_CLK_posedge,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName          => "CLK",
          RefDelay                => 0 ns,
          Recovery                => trecovery_PRE_CLK_negedge_posedge,
          Removal                 => thold_PRE_CLK_negedge_posedge,
          ActiveLow               => FALSE,
          CheckEnabled            => 
                           TO_X01( (NOT CLR_ipd) ) /= '1',
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/DFPC_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_CLR_CLK_posedge,
          TimingData              => Tmkr_CLR_CLK_posedge,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName          => "CLK",
          RefDelay                => 0 ns,
          Recovery                => trecovery_CLR_CLK_posedge_posedge,
          Removal                 => thold_CLR_CLK_posedge_posedge,
          ActiveLow               => TRUE,
          CheckEnabled            => 
                           TO_X01(PRE_ipd ) /='1',
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/DFPC_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLK,
          PeriodData              => PInfo_CLK,
          TestSignal              => CLK_ipd,
          TestSignalName          => "CLK",
          TestDelay               => 0 ns,
          Period                  => tperiod_CLK_posedge,
          PulseWidthHigh          => tpw_CLK_posedge,
          PulseWidthLow           => tpw_CLK_negedge,
          CheckEnabled            => 
                           TO_X01(( PRE_ipd ) OR ( (NOT CLR_ipd) ) ) /= '1',
          HeaderMsg               => InstancePath &"/DFPC_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_PRE,
          PeriodData              => PInfo_PRE,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => tpw_PRE_posedge,
          PulseWidthLow           => 0 ns,
          CheckEnabled            => 
                           TO_X01( (NOT CLR_ipd) ) /= '1',
          HeaderMsg               => InstancePath &"/DFPC_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLR,
          PeriodData              => PInfo_CLR,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => 0 ns,
          PulseWidthLow           => tpw_CLR_negedge,
          CheckEnabled            => 
                           TRUE,
          HeaderMsg               => InstancePath &"/DFPC_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK_posedge or Tviol_PRE_CLK_posedge or Tviol_CLR_CLK_posedge or Pviol_PRE or Pviol_CLK or Pviol_CLR;
      VitalStateTable(
        Result => Q_zd,
        PreviousDataIn => PrevData_Q,
        StateTable => DFPC_CC_Q_tab,
        DataIn => (
               CLR_ipd, CLK_delayed, D_delayed, PRE_ipd, CLK_ipd));
      Q_zd := Violation XOR Q_zd;
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       GlitchData => Q_GlitchData,
       OutSignalName => "Q",
       OutTemp => Q_zd,
       Paths => (0 => (PRE_ipd'last_event, tpd_PRE_Q, TRUE),
                 1 => (CLR_ipd'last_event, tpd_CLR_Q, TRUE),
                 2 => (CLK_ipd'last_event, tpd_CLK_Q, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_DFPC_CC_VITAL of DFPC_CC is
   for VITAL_ACT
   end for;
end CFG_DFPC_CC_VITAL;


----- CELL DFPCA -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DFPCA is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
      tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
      thold_PRE_CLK_negedge_negedge   :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge : VitalDelayType := 0.000 ns;
      thold_CLR_CLK_posedge_negedge   :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge : VitalDelayType := 0.000 ns;
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
attribute VITAL_LEVEL0 of DFPCA : entity is TRUE;
end DFPCA;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture VITAL_ACT of DFPCA is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'X';
   SIGNAL PRE_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLR_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   VitalWireDelay (PRE_ipd, PRE, tipd_PRE);
   VitalWireDelay (CLR_ipd, CLR, tipd_CLR);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLK_ipd, PRE_ipd, CLR_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_D_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_PRE_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_PRE_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_CLR_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_CLR_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_CLK	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLK	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_PRE	: STD_ULOGIC := '0';
   VARIABLE PInfo_PRE	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_CLR	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLR	: VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(0 to 4);
   VARIABLE D_delayed : STD_ULOGIC := 'X';
   VARIABLE CLK_delayed : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Q_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Q_GlitchData	: VitalGlitchDataType;

   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)

   CONSTANT DFPCA_tab : VitalStateTableType := (
    ( L,  x,  x,  H,  x,  x,  U ),
    ( L,  x,  x,  L,  x,  x,  L ),
    ( H,  L,  H,  x,  H,  x,  H ),
    ( H,  H,  x,  L,  x,  x,  S ),
    ( H,  x,  x,  L,  L,  x,  S ),
    ( H,  x,  x,  H,  x,  x,  H ),
    ( x,  L,  L,  L,  H,  x,  L ),
    ( U,  x,  x,  L,  x,  L,  L ),
    ( H,  x,  x,  U,  x,  H,  H ));

   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_CLK_negedge,
          TimingData              => Tmkr_D_CLK_negedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName           => "CLK",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_CLK_posedge_negedge,
          SetupLow                => tsetup_D_CLK_negedge_negedge,
          HoldHigh                => thold_D_CLK_posedge_negedge,
          HoldLow                 => thold_D_CLK_negedge_negedge,
          CheckEnabled            => 
                           TO_X01(( PRE_ipd ) OR ( (NOT CLR_ipd) ) ) /= '1',
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFPCA",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_PRE_CLK_negedge,
          TimingData              => Tmkr_PRE_CLK_negedge,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName          => "CLK",
          RefDelay                => 0 ns,
          Recovery                => trecovery_PRE_CLK_negedge_negedge,
          Removal                 => thold_PRE_CLK_negedge_negedge,
          ActiveLow               => FALSE,
          CheckEnabled            => 
                           TO_X01( (NOT CLR_ipd) ) /= '1',
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFPCA",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_CLR_CLK_negedge,
          TimingData              => Tmkr_CLR_CLK_negedge,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName          => "CLK",
          RefDelay                => 0 ns,
          Recovery                => trecovery_CLR_CLK_posedge_negedge,
          Removal                 => thold_CLR_CLK_posedge_negedge,
          ActiveLow               => TRUE,
          CheckEnabled            => 
                           TO_X01( PRE_ipd ) /='1',
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFPCA",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLK,
          PeriodData              => PInfo_CLK,
          TestSignal              => CLK_ipd,
          TestSignalName          => "CLK",
          TestDelay               => 0 ns,
          Period                  => tperiod_CLK_negedge,
          PulseWidthHigh          => tpw_CLK_posedge,
          PulseWidthLow           => tpw_CLK_negedge,
          CheckEnabled            => 
                           TO_X01(( PRE_ipd ) OR ( (NOT CLR_ipd) ) ) /= '1',
          HeaderMsg               => InstancePath &"/DFPCA",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_PRE,
          PeriodData              => PInfo_PRE,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => tpw_PRE_posedge,
          PulseWidthLow           => 0 ns,
          CheckEnabled            => 
                           TO_X01( (NOT CLR_ipd) ) /= '1',
          HeaderMsg               => InstancePath &"/DFPCA",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLR,
          PeriodData              => PInfo_CLR,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => 0 ns,
          PulseWidthLow           => tpw_CLR_negedge,
          CheckEnabled            => 
                           TRUE,
          HeaderMsg               => InstancePath &"/DFPCA",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK_negedge or Pviol_PRE or Tviol_PRE_CLK_negedge or Tviol_CLR_CLK_negedge or Pviol_CLR or Pviol_CLK;
      VitalStateTable(
        Result => Q_zd,
        PreviousDataIn => PrevData_Q,
        StateTable => DFPCA_tab,
        DataIn => (
               CLR_ipd, CLK_ipd, D_delayed, PRE_ipd, CLK_delayed));
      Q_zd := Violation XOR Q_zd;
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       GlitchData => Q_GlitchData,
       OutSignalName => "Q",
       OutTemp => Q_zd,
       Paths => (0 => (PRE_ipd'last_event, tpd_PRE_Q, TRUE),
                 1 => (CLR_ipd'last_event, tpd_CLR_Q, TRUE),
                 2 => (CLK_ipd'last_event, tpd_CLK_Q, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_DFPCA_VITAL of DFPCA is
   for VITAL_ACT
   end for;
end CFG_DFPCA_VITAL;


----- CELL DFPCA_CC -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DFPCA_CC is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PRE_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLR_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLK_Q                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
      tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
      thold_PRE_CLK_negedge_negedge   :	VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge : VitalDelayType := 0.000 ns;
      thold_CLR_CLK_posedge_negedge   :	VitalDelayType := 0.000 ns;
      trecovery_CLR_CLK_posedge_negedge : VitalDelayType := 0.000 ns;
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
attribute VITAL_LEVEL0 of DFPCA_CC : entity is TRUE;
end DFPCA_CC;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture VITAL_ACT of DFPCA_CC is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'X';
   SIGNAL PRE_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLR_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   VitalWireDelay (PRE_ipd, PRE, tipd_PRE);
   VitalWireDelay (CLR_ipd, CLR, tipd_CLR);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLK_ipd, PRE_ipd, CLR_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_D_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_PRE_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_PRE_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_CLR_CLK_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_CLR_CLK_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_CLK	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLK	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_PRE	: STD_ULOGIC := '0';
   VARIABLE PInfo_PRE	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_CLR	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLR	: VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(0 to 4);
   VARIABLE D_delayed : STD_ULOGIC := 'X';
   VARIABLE CLK_delayed : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Q_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Q_GlitchData	: VitalGlitchDataType;

   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)

   CONSTANT DFPCA_CC_tab : VitalStateTableType := (
    ( L,  x,  x,  H,  x,  x,  U ),
    ( L,  x,  x,  L,  x,  x,  L ),
    ( H,  L,  H,  x,  H,  x,  H ),
    ( H,  H,  x,  L,  x,  x,  S ),
    ( H,  x,  x,  L,  L,  x,  S ),
    ( H,  x,  x,  H,  x,  x,  H ),
    ( x,  L,  L,  L,  H,  x,  L ),
    ( U,  x,  x,  L,  x,  L,  L ),
    ( H,  x,  x,  U,  x,  H,  H ));


   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_CLK_negedge,
          TimingData              => Tmkr_D_CLK_negedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName           => "CLK",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_CLK_posedge_negedge,
          SetupLow                => tsetup_D_CLK_negedge_negedge,
          HoldHigh                => thold_D_CLK_posedge_negedge,
          HoldLow                 => thold_D_CLK_negedge_negedge,
          CheckEnabled            => 
                           TO_X01(( PRE_ipd ) OR ( (NOT CLR_ipd) ) ) /= '1',
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFPCA_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_PRE_CLK_negedge,
          TimingData              => Tmkr_PRE_CLK_negedge,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName          => "CLK",
          RefDelay                => 0 ns,
          Recovery                => trecovery_PRE_CLK_negedge_negedge,
          Removal                 => thold_PRE_CLK_negedge_negedge,
          ActiveLow               => FALSE,
          CheckEnabled            => 
                           TO_X01( (NOT CLR_ipd) ) /= '1',
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFPCA_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_CLR_CLK_negedge,
          TimingData              => Tmkr_CLR_CLK_negedge,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          RefSignal               => CLK_ipd,
          RefSignalName          => "CLK",
          RefDelay                => 0 ns,
          Recovery                => trecovery_CLR_CLK_posedge_negedge,
          Removal                 => thold_CLR_CLK_posedge_negedge,
          ActiveLow               => TRUE,
          CheckEnabled            => 
                           TO_X01( PRE_ipd ) /='1',
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DFPCA_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLK,
          PeriodData              => PInfo_CLK,
          TestSignal              => CLK_ipd,
          TestSignalName          => "CLK",
          TestDelay               => 0 ns,
          Period                  => tperiod_CLK_negedge,
          PulseWidthHigh          => tpw_CLK_posedge,
          PulseWidthLow           => tpw_CLK_negedge,
          CheckEnabled            => 
                           TO_X01(( PRE_ipd ) OR ( (NOT CLR_ipd) ) ) /= '1',
          HeaderMsg               => InstancePath &"/DFPCA_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_PRE,
          PeriodData              => PInfo_PRE,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => tpw_PRE_posedge,
          PulseWidthLow           => 0 ns,
          CheckEnabled            => 
                           TO_X01( (NOT CLR_ipd) ) /= '1',
          HeaderMsg               => InstancePath &"/DFPCA_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLR,
          PeriodData              => PInfo_CLR,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => 0 ns,
          PulseWidthLow           => tpw_CLR_negedge,
          CheckEnabled            => 
                           TRUE,
          HeaderMsg               => InstancePath &"/DFPCA_CC",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK_negedge or Pviol_PRE or Tviol_PRE_CLK_negedge or Tviol_CLR_CLK_negedge or Pviol_CLR or Pviol_CLK;
      VitalStateTable(
        Result => Q_zd,
        PreviousDataIn => PrevData_Q,
        StateTable => DFPCA_CC_tab,
        DataIn => (
               CLR_ipd, CLK_ipd, D_delayed, PRE_ipd, CLK_delayed));
      Q_zd := Violation XOR Q_zd;
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       GlitchData => Q_GlitchData,
       OutSignalName => "Q",
       OutTemp => Q_zd,
       Paths => (0 => (PRE_ipd'last_event, tpd_PRE_Q, TRUE),
                 1 => (CLR_ipd'last_event, tpd_CLR_Q, TRUE),
                 2 => (CLK_ipd'last_event, tpd_CLK_Q, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_DFPCA_CC_VITAL of DFPCA_CC is
   for VITAL_ACT
   end for;
end CFG_DFPCA_CC_VITAL;


----- CELL DL2B -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DL2B is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_G_QN                       :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_PRE_QN                     :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLR_QN                     :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      thold_D_G_posedge_posedge      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_posedge_posedge     :	VitalDelayType := 0.000 ns;
      thold_D_G_negedge_posedge      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_negedge_posedge     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_posedge_posedge     :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_posedge :	VitalDelayType := 0.000 ns;
      thold_CLR_G_negedge_posedge     :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_posedge :	VitalDelayType := 0.000 ns;
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
attribute VITAL_LEVEL0 of DL2B : entity is TRUE;
end DL2B;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture VITAL_ACT of DL2B is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL G_ipd	 : STD_ULOGIC := 'X';
   SIGNAL PRE_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLR_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (G_ipd, G, tipd_G);
   VitalWireDelay (PRE_ipd, PRE, tipd_PRE);
   VitalWireDelay (CLR_ipd, CLR, tipd_CLR);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, G_ipd, PRE_ipd, CLR_ipd)

   -- timing check results
   VARIABLE Tviol_D_G_posedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_D_G_posedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_PRE_G_posedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_PRE_G_posedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_CLR_G_posedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_CLR_G_posedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_G	: STD_ULOGIC := '0';
   VARIABLE PInfo_G	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_PRE	: STD_ULOGIC := '0';
   VARIABLE PInfo_PRE	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_CLR	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLR	: VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_QN : STD_LOGIC_VECTOR(0 to 3);
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS QN_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE QN_GlitchData	: VitalGlitchDataType;

   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)

   CONSTANT DL2B_QN_tab : VitalStateTableType := (
    ( L,  L,  x,  x,  x,  L ),
    ( L,  H,  H,  x,  x,  S ),
    ( L,  x,  L,  H,  x,  L ),
    ( H,  x,  x,  x,  x,  H ),
    ( x,  H,  L,  L,  x,  H ),
    ( U,  x,  x,  x,  H,  H ),
    ( L,  U,  x,  x,  L,  L ),
    ( L,  H,  x,  H,  L,  L ));
    
   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_G_posedge,
          TimingData              => Tmkr_D_G_posedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => G_ipd,
          RefSignalName          => "G",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_G_posedge_posedge,
          SetupLow                => tsetup_D_G_negedge_posedge,
          HoldHigh                => thold_D_G_posedge_posedge,
          HoldLow                 => thold_D_G_negedge_posedge,
          CheckEnabled            => 
                           TO_X01(( (NOT PRE_ipd) ) OR ( CLR_ipd ) ) /= '1',
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/DL2B",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_PRE_G_posedge,
          TimingData              => Tmkr_PRE_G_posedge,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          RefSignal               => G_ipd,
          RefSignalName          => "G",
          RefDelay                => 0 ns,
          Recovery                => trecovery_PRE_G_posedge_posedge,
          Removal                 => thold_PRE_G_posedge_posedge,
          ActiveLow               => TRUE,
          CheckEnabled            => 
                           TO_X01( ( CLR_ipd ) ) /= '1',
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/DL2B",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_CLR_G_posedge,
          TimingData              => Tmkr_CLR_G_posedge,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          RefSignal               => G_ipd,
          RefSignalName          => "G",
          RefDelay                => 0 ns,
          Recovery                => trecovery_CLR_G_negedge_posedge,
          Removal                 => thold_CLR_G_negedge_posedge,
          ActiveLow               => FALSE,
          CheckEnabled            => 
                           TO_X01(NOT PRE_ipd) /='1',
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/DL2B",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_G,
          PeriodData              => PInfo_G,
          TestSignal              => G_ipd,
          TestSignalName          => "G",
          TestDelay               => 0 ns,
          Period                  => tperiod_G_posedge,
          PulseWidthHigh          => 0 ns,
          PulseWidthLow           => tpw_G_negedge,
          CheckEnabled            => 
                           TO_X01(( (NOT PRE_ipd) ) OR ( CLR_ipd ) ) /= '1',
          HeaderMsg               => InstancePath &"/DL2B",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_PRE,
          PeriodData              => PInfo_PRE,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => 0 ns,
          PulseWidthLow           => tpw_PRE_negedge,
          CheckEnabled            => 
                           TO_X01( ( CLR_ipd ) ) /= '1',
          HeaderMsg               => InstancePath &"/DL2B",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLR,
          PeriodData              => PInfo_CLR,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => tpw_CLR_posedge,
          PulseWidthLow           => 0 ns,
          CheckEnabled            => 
                           TRUE,
          HeaderMsg               => InstancePath &"/DL2B",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_G_posedge or Tviol_PRE_G_posedge or Tviol_CLR_G_posedge or Pviol_PRE or Pviol_G or Pviol_CLR;
      VitalStateTable(
        Result => QN_zd,
        PreviousDataIn => PrevData_QN,
        StateTable => DL2B_QN_tab,
        DataIn => (
               CLR_ipd, PRE_ipd, G_ipd, D_ipd));
      QN_zd := Violation XOR QN_zd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => QN,
       GlitchData => QN_GlitchData,
       OutSignalName => "QN",
       OutTemp => QN_zd,
       Paths => (0 => (D_ipd'last_event, tpd_D_QN, TRUE),
                 1 => (G_ipd'last_event, tpd_G_QN, TRUE),
                 2 => (PRE_ipd'last_event, tpd_PRE_QN, TRUE),
                 3 => (CLR_ipd'last_event, tpd_CLR_QN, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_DL2B_VITAL of DL2B is
   for VITAL_ACT
   end for;
end CFG_DL2B_VITAL;


----- CELL DL2D -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DL2D is
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_QN                       :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_G_QN                       :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_PRE_QN                     :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_CLR_QN                     :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      thold_D_G_posedge_negedge      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_posedge_negedge     :	VitalDelayType := 0.000 ns;
      thold_D_G_negedge_negedge      :	VitalDelayType := 0.000 ns;
      tsetup_D_G_negedge_negedge     :	VitalDelayType := 0.000 ns;
      thold_PRE_G_posedge_negedge     :	VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_negedge :	VitalDelayType := 0.000 ns;
      thold_CLR_G_negedge_negedge     :	VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_negedge :	VitalDelayType := 0.000 ns;
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
attribute VITAL_LEVEL0 of DL2D : entity is TRUE;
end DL2D;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture VITAL_ACT of DL2D is
   attribute VITAL_LEVEL1 of VITAL_ACT : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL G_ipd	 : STD_ULOGIC := 'X';
   SIGNAL PRE_ipd	 : STD_ULOGIC := 'X';
   SIGNAL CLR_ipd	 : STD_ULOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (G_ipd, G, tipd_G);
   VitalWireDelay (PRE_ipd, PRE, tipd_PRE);
   VitalWireDelay (CLR_ipd, CLR, tipd_CLR);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, G_ipd, PRE_ipd, CLR_ipd)

   -- timing check results
   VARIABLE Tviol_D_G_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_D_G_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_PRE_G_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_PRE_G_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Tviol_CLR_G_negedge	: STD_ULOGIC := '0';
   VARIABLE Tmkr_CLR_G_negedge	: VitalTimingDataType := VitalTimingDataInit;
   VARIABLE Pviol_G	: STD_ULOGIC := '0';
   VARIABLE PInfo_G	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_PRE	: STD_ULOGIC := '0';
   VARIABLE PInfo_PRE	: VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE Pviol_CLR	: STD_ULOGIC := '0';
   VARIABLE PInfo_CLR	: VitalPeriodDataType := VitalPeriodDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_QN : STD_LOGIC_VECTOR(0 to 3);
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS QN_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE QN_GlitchData	: VitalGlitchDataType;

   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)

   CONSTANT DL2D_QN_tab : VitalStateTableType := (
    ( L,  L,  x,  x,  x,  L ),
    ( L,  H,  x,  L,  x,  S ),
    ( L,  x,  H,  H,  x,  L ),
    ( H,  x,  x,  x,  x,  H ),
    ( x,  H,  L,  H,  x,  H ),
    ( U,  x,  x,  x,  H,  H ),
    ( L,  U,  x,  x,  L,  L ),
    ( L,  H,  H,  x,  L,  L ));

   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
          Violation               => Tviol_D_G_negedge,
          TimingData              => Tmkr_D_G_negedge,
          TestSignal              => D_ipd,
          TestSignalName          => "D",
          TestDelay               => 0 ns,
          RefSignal               => G_ipd,
          RefSignalName          => "G",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_D_G_posedge_negedge,
          SetupLow                => tsetup_D_G_negedge_negedge,
          HoldHigh                => thold_D_G_posedge_negedge,
          HoldLow                 => thold_D_G_negedge_negedge,
          CheckEnabled            => 
                           TO_X01(( (NOT PRE_ipd) ) OR ( CLR_ipd ) ) /= '1',
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DL2D",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_PRE_G_negedge,
          TimingData              => Tmkr_PRE_G_negedge,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          RefSignal               => G_ipd,
          RefSignalName          => "G",
          RefDelay                => 0 ns,
          Recovery                => trecovery_PRE_G_posedge_negedge,
          Removal                 => thold_PRE_G_posedge_negedge,
          ActiveLow               => TRUE,
          CheckEnabled            => 
                           TO_X01( ( CLR_ipd ) ) /= '1',
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DL2D",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalRecoveryRemovalCheck (
          Violation               => Tviol_CLR_G_negedge,
          TimingData              => Tmkr_CLR_G_negedge,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          RefSignal               => G_ipd,
          RefSignalName          => "G",
          RefDelay                => 0 ns,
          Recovery                => trecovery_CLR_G_negedge_negedge,
          Removal                 => thold_CLR_G_negedge_negedge,
          ActiveLow               => FALSE,
          CheckEnabled            => 
                           TO_X01(NOT PRE_ipd) /='1',
          RefTransition           => 'F',
          HeaderMsg               => InstancePath & "/DL2D",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_G,
          PeriodData              => PInfo_G,
          TestSignal              => G_ipd,
          TestSignalName          => "G",
          TestDelay               => 0 ns,
          Period                  => tperiod_G_negedge,
          PulseWidthHigh          => tpw_G_posedge,
          PulseWidthLow           => 0 ns,
          CheckEnabled            => 
                           TO_X01(( (NOT PRE_ipd) ) OR ( CLR_ipd ) ) /= '1',
          HeaderMsg               => InstancePath &"/DL2D",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_PRE,
          PeriodData              => PInfo_PRE,
          TestSignal              => PRE_ipd,
          TestSignalName          => "PRE",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => 0 ns,
          PulseWidthLow           => tpw_PRE_negedge,
          CheckEnabled            => 
                           TO_X01( ( CLR_ipd ) ) /= '1',
          HeaderMsg               => InstancePath &"/DL2D",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
         VitalPeriodPulseCheck (
          Violation               => Pviol_CLR,
          PeriodData              => PInfo_CLR,
          TestSignal              => CLR_ipd,
          TestSignalName          => "CLR",
          TestDelay               => 0 ns,
          Period                  => 0 ns,
          PulseWidthHigh          => tpw_CLR_posedge,
          PulseWidthLow           => 0 ns,
          CheckEnabled            => 
                           TRUE,
          HeaderMsg               => InstancePath &"/DL2D",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_G_negedge or Tviol_PRE_G_negedge or Pviol_PRE or Tviol_CLR_G_negedge or Pviol_CLR or Pviol_G;
      VitalStateTable(
        Result => QN_zd,
        PreviousDataIn => PrevData_QN,
        StateTable => DL2D_QN_tab,
        DataIn => (
               CLR_ipd, PRE_ipd, D_ipd, G_ipd));
      QN_zd := Violation XOR QN_zd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => QN,
       GlitchData => QN_GlitchData,
       OutSignalName => "QN",
       OutTemp => QN_zd,
       Paths => (0 => (D_ipd'last_event, tpd_D_QN, TRUE),
                 1 => (G_ipd'last_event, tpd_G_QN, TRUE),
                 2 => (PRE_ipd'last_event, tpd_PRE_QN, TRUE),
                 3 => (CLR_ipd'last_event, tpd_CLR_QN, TRUE)),
       Mode => OnDetect,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end VITAL_ACT;

configuration CFG_DL2D_VITAL of DL2D is
   for VITAL_ACT
   end for;
end CFG_DL2D_VITAL;


library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity BBDLHS is 
    port(D, E, GIN, GOUT : in std_logic;  PAD : inout std_logic;  
        Q : out std_logic) ;
end BBDLHS;


architecture DEF_ARCH of  BBDLHS is

    component BIBUF
        port(PAD : inout std_logic := 'U'; D, E : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component DL1B
        port(D, G : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component DL1
        port(D, G : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    signal NET0, NET1 : std_logic ;
    begin   

    U2 : BIBUF
   port map(PAD => PAD, D => NET1, E => E, Y => NET0);
    U1 : DL1B
   port map(D => NET0, G => GIN, Q => Q);
    U0 : DL1
   port map(D => D, G => GOUT, Q => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity BBHS is 
    port(D, E : in std_logic;  PAD : inout std_logic;  Y : out 
        std_logic) ;
end BBHS;


architecture DEF_ARCH of  BBHS is

    component BIBUF
        port(PAD : inout std_logic := 'U'; D, E : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component BUFF
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U2 : BIBUF
   port map(PAD => PAD, D => D, E => E, Y => NET0);
    U1 : BUFF
   port map(A => NET0, Y => Y);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DF1A is 
    port(CLK, D : in std_logic;  QN : out std_logic) ;
end DF1A;


architecture DEF_ARCH of  DF1A is

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1
   port map(D => NET0, CLK => CLK, Q => QN);
    U0 : INV
   port map(A => D, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DF1A_CC is 
    port(CLK, D : in std_logic;  QN : out std_logic) ;
end DF1A_CC;


architecture DEF_ARCH of  DF1A_CC is

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1
   port map(D => NET0, CLK => CLK, Q => QN);
    U0 : INV
   port map(A => D, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DF1C is 
    port(CLK, D : in std_logic;  QN : out std_logic) ;
end DF1C;


architecture DEF_ARCH of  DF1C is

    component DF1B
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1B
   port map(D => NET0, CLK => CLK, Q => QN);
    U0 : INV
   port map(A => D, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DF1C_CC is 
    port(CLK, D : in std_logic;  QN : out std_logic) ;
end DF1C_CC;


architecture DEF_ARCH of  DF1C_CC is

    component DF1B
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1B
   port map(D => NET0, CLK => CLK, Q => QN);
    U0 : INV
   port map(A => D, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFC1 is 
    port(CLK, CLR, D : in std_logic;  Q : out std_logic) ;
end DFC1;


architecture DEF_ARCH of  DFC1 is

    component DFC1B
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DFC1B
   port map(D => D, CLK => CLK, CLR => NET0, Q => Q);
    U0 : INV
   port map(A => CLR, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFC1A is 
    port(CLK, CLR, D : in std_logic;  Q : out std_logic) ;
end DFC1A;


architecture DEF_ARCH of  DFC1A is

    component DFC1D
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET1 : std_logic ;
    begin   

    U2 : DFC1D
   port map(D => D, CLK => CLK, CLR => NET1, Q => Q);
    U1 : INV
   port map(A => CLR, Y => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFC1A_CC is 
    port(CLK, CLR, D : in std_logic;  Q : out std_logic) ;
end DFC1A_CC;


architecture DEF_ARCH of  DFC1A_CC is

    component DFC1D
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET1 : std_logic ;
    begin   

    U2 : DFC1D
   port map(D => D, CLK => CLK, CLR => NET1, Q => Q);
    U1 : INV
   port map(A => CLR, Y => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFC1E is 
    port(CLK, CLR, D : in std_logic;  QN : out std_logic) ;
end DFC1E;


architecture DEF_ARCH of  DFC1E is

    component DFC1B
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DFC1B
   port map(D => D, CLK => CLK, CLR => CLR, Q => NET0);
    U0 : INV
   port map(A => NET0, Y => QN);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFC1G is 
    port(CLK, CLR, D : in std_logic;  QN : out std_logic) ;
end DFC1G;


architecture DEF_ARCH of  DFC1G is

    component DFC1D
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DFC1D
   port map(D => D, CLK => CLK, CLR => CLR, Q => NET0);
    U0 : INV
   port map(A => NET0, Y => QN);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFC1_CC is 
    port(CLK, CLR, D : in std_logic;  Q : out std_logic) ;
end DFC1_CC;


architecture DEF_ARCH of  DFC1_CC is

    component DFC1B
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DFC1B
   port map(D => D, CLK => CLK, CLR => NET0, Q => Q);
    U0 : INV
   port map(A => CLR, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFE is 
    port(CLK, D, E : in std_logic;  Q : out std_logic) ;
end DFE;


architecture DEF_ARCH of  DFE is

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET1, Q_1_net : std_logic ;
    begin   

    Q <= Q_1_net;
    
    U2 : DF1
   port map(D => NET1, CLK => CLK, Q => Q_1_net);
    U1 : MX2
   port map(A => Q_1_net, B => D, S => E, Y => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFE3A is 
    port(CLK, CLR, D, E : in std_logic;  Q : out std_logic) ;
end DFE3A;


architecture DEF_ARCH of  DFE3A is

    component DFC1B
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET1, Q_1_net : std_logic ;
    begin   

    Q <= Q_1_net;
    
    U2 : DFC1B
   port map(D => NET1, CLK => CLK, CLR => CLR, Q => Q_1_net);
    U1 : MX2
   port map(A => Q_1_net, B => D, S => E, Y => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFE3B is 
    port(CLK, CLR, D, E : in std_logic;  Q : out std_logic) ;
end DFE3B;


architecture DEF_ARCH of  DFE3B is

    component DFC1D
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET1, Q_1_net : std_logic ;
    begin   

    Q <= Q_1_net;
    
    U2 : DFC1D
   port map(D => NET1, CLK => CLK, CLR => CLR, Q => Q_1_net);
    U1 : MX2
   port map(A => Q_1_net, B => D, S => E, Y => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFEA is 
    port(CLK, D, E : in std_logic;  Q : out std_logic) ;
end DFEA;


architecture DEF_ARCH of  DFEA is

    component DF1B
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET1, Q_1_net : std_logic ;
    begin   

    Q <= Q_1_net;
    
    U2 : DF1B
   port map(D => NET1, CLK => CLK, Q => Q_1_net);
    U1 : MX2
   port map(A => Q_1_net, B => D, S => E, Y => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFEA_CC is 
    port(CLK, D, E : in std_logic;  Q : out std_logic) ;
end DFEA_CC;


architecture DEF_ARCH of  DFEA_CC is

    component DF1B
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET1, Q_1_net : std_logic ;
    begin   

    Q <= Q_1_net;
    
    U2 : DF1B
   port map(D => NET1, CLK => CLK, Q => Q_1_net);
    U1 : MX2
   port map(A => Q_1_net, B => D, S => E, Y => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFE_CC is 
    port(CLK, D, E : in std_logic;  Q : out std_logic) ;
end DFE_CC;


architecture DEF_ARCH of  DFE_CC is

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET1, Q_1_net : std_logic ;
    begin   

    Q <= Q_1_net;
    
    U2 : DF1
   port map(D => NET1, CLK => CLK, Q => Q_1_net);
    U1 : MX2
   port map(A => Q_1_net, B => D, S => E, Y => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM is 
    port(A, B, CLK : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end DFM;


architecture DEF_ARCH of  DFM is

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1
   port map(D => NET0, CLK => CLK, Q => Q);
    U0 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM1B is 
    port(A, B, CLK, S : in std_logic;  QN : out std_logic) ;
end DFM1B;


architecture DEF_ARCH of  DFM1B is

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component MX2C
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1
   port map(D => NET0, CLK => CLK, Q => QN);
    U0 : MX2C
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM1B_CC is 
    port(A, B, CLK, S : in std_logic;  QN : out std_logic) ;
end DFM1B_CC;


architecture DEF_ARCH of  DFM1B_CC is

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component MX2C
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1
   port map(D => NET0, CLK => CLK, Q => QN);
    U0 : MX2C
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM1C is 
    port(A, B, CLK, S : in std_logic;  QN : out std_logic) ;
end DFM1C;


architecture DEF_ARCH of  DFM1C is

    component DF1B
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component MX2C
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1B
   port map(D => NET0, CLK => CLK, Q => QN);
    U0 : MX2C
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM1C_CC is 
    port(A, B, CLK, S : in std_logic;  QN : out std_logic) ;
end DFM1C_CC;


architecture DEF_ARCH of  DFM1C_CC is

    component DF1B
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component MX2C
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1B
   port map(D => NET0, CLK => CLK, Q => QN);
    U0 : MX2C
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM3 is 
    port(A, B, CLK, CLR : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end DFM3;


architecture DEF_ARCH of  DFM3 is

    component DFC1B
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0, NET1 : std_logic ;
    begin   

    U2 : DFC1B
   port map(D => NET0, CLK => CLK, CLR => NET1, Q => Q);
    U1 : INV
   port map(A => CLR, Y => NET1);
    U0 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM3B is 
    port(A, B, CLK, CLR : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end DFM3B;


architecture DEF_ARCH of  DFM3B is

    component DFC1D
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DFC1D
   port map(D => NET0, CLK => CLK, CLR => CLR, Q => Q);
    U0 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM3E is 
    port(A, B, CLK, CLR : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end DFM3E;


architecture DEF_ARCH of  DFM3E is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DFC1D
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0, NET3 : std_logic ;
    begin   

    U2 : INV
   port map(A => CLR, Y => NET3);
    U1 : DFC1D
   port map(D => NET0, CLK => CLK, CLR => NET3, Q => Q);
    U0 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM4C is 
    port(A, B, CLK, PRE : in std_logic;  QN : out std_logic;  S : 
        in std_logic) ;
end DFM4C;


architecture DEF_ARCH of  DFM4C is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DFP1B
        port(D, CLK, PRE : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0, NET1 : std_logic ;
    begin   

    U2 : INV
   port map(A => NET1, Y => QN);
    U1 : DFP1B
   port map(D => NET0, CLK => CLK, PRE => PRE, Q => NET1);
    U0 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM4D is 
    port(A, B, CLK, PRE : in std_logic;  QN : out std_logic;  S : 
        in std_logic) ;
end DFM4D;


architecture DEF_ARCH of  DFM4D is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DFP1D
        port(D, CLK, PRE : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0, NET1 : std_logic ;
    begin   

    U2 : INV
   port map(A => NET1, Y => QN);
    U1 : DFP1D
   port map(D => NET0, CLK => CLK, PRE => PRE, Q => NET1);
    U0 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM6A is 
    port(CLK, CLR, D0, D1, D2, D3 : in std_logic;  Q : out 
        std_logic;  S0, S1 : in std_logic) ;
end DFM6A;


architecture DEF_ARCH of  DFM6A is

    component DFC1B
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component MX4
        port(D0, D1, D2, D3, S0, S1 : in std_logic := 'U'; Y : 
        out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DFC1B
   port map(D => NET0, CLK => CLK, CLR => CLR, Q => Q);
    U0 : MX4
   port map(D0 => D0, D1 => D1, D2 => D2, D3 => D3, S0 => S0, 
        S1 => S1, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM6B is 
    port(CLK, CLR, D0, D1, D2, D3 : in std_logic;  Q : out 
        std_logic;  S0, S1 : in std_logic) ;
end DFM6B;


architecture DEF_ARCH of  DFM6B is

    component DFC1D
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component MX4
        port(D0, D1, D2, D3, S0, S1 : in std_logic := 'U'; Y : 
        out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DFC1D
   port map(D => NET0, CLK => CLK, CLR => CLR, Q => Q);
    U0 : MX4
   port map(D0 => D0, D1 => D1, D2 => D2, D3 => D3, S0 => S0, 
        S1 => S1, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM7A is 
    port(CLK, CLR, D0, D1, D2, D3, S0, S10, S11 : in std_logic;  
        Q : out std_logic) ;
end DFM7A;


architecture DEF_ARCH of  DFM7A is

    component DFC1B
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    signal NET0, VDD : std_logic ;
    begin   

    VCC_1_net : VCC port map(Y => VDD);
    U1 : DFC1B
   port map(D => NET0, CLK => CLK, CLR => CLR, Q => Q);
    U0 : CM8
   port map(D0 => D0, D1 => D1, D2 => D2, D3 => D3, S00 => S0, 
        S01 => VDD, S10 => S10, S11 => S11, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM7B is 
    port(CLK, CLR, D0, D1, D2, D3 : in std_logic;  Q : out 
        std_logic;  S0, S10, S11 : in std_logic) ;
end DFM7B;


architecture DEF_ARCH of  DFM7B is

    component DFC1D
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DFC1D
   port map(D => NET0, CLK => CLK, CLR => CLR, Q => Q);
    U0 : CM8
   port map(D0 => D0, D1 => D1, D2 => D2, D3 => D3, S00 => S0, 
        S01 => S0, S10 => S10, S11 => S11, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM8A is 
    port(CLK, CLR, D0, D1, D2, D3 : in std_logic;  Q : out 
        std_logic;  S00, S01, S10, S11 : in std_logic) ;
end DFM8A;


architecture DEF_ARCH of  DFM8A is

    component DFC1B
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DFC1B
   port map(D => NET0, CLK => CLK, CLR => CLR, Q => Q);
    U0 : CM8
   port map(D0 => D0, D1 => D1, D2 => D2, D3 => D3, S00 => S00, 
        S01 => S01, S10 => S10, S11 => S11, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM8B is 
    port(CLK, CLR, D0, D1, D2, D3 : in std_logic;  Q : out 
        std_logic;  S00, S01, S10, S11 : in std_logic) ;
end DFM8B;


architecture DEF_ARCH of  DFM8B is

    component DFC1D
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DFC1D
   port map(D => NET0, CLK => CLK, CLR => CLR, Q => Q);
    U0 : CM8
   port map(D0 => D0, D1 => D1, D2 => D2, D3 => D3, S00 => S00, 
        S01 => S01, S10 => S10, S11 => S11, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFMA is 
    port(A, B, CLK : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end DFMA;


architecture DEF_ARCH of  DFMA is

    component DF1B
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1B
   port map(D => NET0, CLK => CLK, Q => Q);
    U0 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFMA_CC is 
    port(A, B, CLK : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end DFMA_CC;


architecture DEF_ARCH of  DFMA_CC is

    component DF1B
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1B
   port map(D => NET0, CLK => CLK, Q => Q);
    U0 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFMB is 
    port(A, B, CLK, CLR : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end DFMB;


architecture DEF_ARCH of  DFMB is

    component DFC1B
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DFC1B
   port map(D => NET0, CLK => CLK, CLR => CLR, Q => Q);
    U0 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFME1A is 
    port(A, B, CLK, E : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end DFME1A;


architecture DEF_ARCH of  DFME1A is

    component DFE1B
        port(D, CLK, E : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DFE1B
   port map(D => NET0, CLK => CLK, E => E, Q => Q);
    U0 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFM_CC is 
    port(A, B, CLK : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end DFM_CC;


architecture DEF_ARCH of  DFM_CC is

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1
   port map(D => NET0, CLK => CLK, Q => Q);
    U0 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFP1C is 
    port(CLK, D, PRE : in std_logic;  QN : out std_logic) ;
end DFP1C;


architecture DEF_ARCH of  DFP1C is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DFP1B
        port(D, CLK, PRE : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    signal NET0, NET1 : std_logic ;
    begin   

    U2 : INV
   port map(A => NET1, Y => QN);
    U1 : INV
   port map(A => PRE, Y => NET0);
    U0 : DFP1B
   port map(D => D, CLK => CLK, PRE => NET0, Q => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFP1E is 
    port(CLK, D, PRE : in std_logic;  QN : out std_logic) ;
end DFP1E;


architecture DEF_ARCH of  DFP1E is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DFP1B
        port(D, CLK, PRE : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : INV
   port map(A => NET0, Y => QN);
    U0 : DFP1B
   port map(D => D, CLK => CLK, PRE => PRE, Q => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFP1F is 
    port(CLK, D, PRE : in std_logic;  QN : out std_logic) ;
end DFP1F;


architecture DEF_ARCH of  DFP1F is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DFP1D
        port(D, CLK, PRE : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    signal NET0, NET1 : std_logic ;
    begin   

    U2 : INV
   port map(A => NET1, Y => QN);
    U1 : INV
   port map(A => PRE, Y => NET0);
    U0 : DFP1D
   port map(D => D, CLK => CLK, PRE => NET0, Q => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DFP1G is 
    port(CLK, D, PRE : in std_logic;  QN : out std_logic) ;
end DFP1G;


architecture DEF_ARCH of  DFP1G is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DFP1D
        port(D, CLK, PRE : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : INV
   port map(A => NET0, Y => QN);
    U0 : DFP1D
   port map(D => D, CLK => CLK, PRE => PRE, Q => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DL1A is 
    port(D, G : in std_logic;  QN : out std_logic) ;
end DL1A;


architecture DEF_ARCH of  DL1A is

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, QN_1_net, VDD : std_logic ;
    begin   

    QN <= QN_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U0 : CM8
   port map(D0 => QN_1_net, D1 => QN_1_net, D2 => VDD, D3 => 
        GND_1_net, S00 => D, S01 => VDD, S10 => G, S11 => 
        GND_1_net, Y => QN_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DL1C is 
    port(D, G : in std_logic;  QN : out std_logic) ;
end DL1C;


architecture DEF_ARCH of  DL1C is

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, QN_1_net, VDD : std_logic ;
    begin   

    QN <= QN_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U0 : CM8
   port map(D0 => VDD, D1 => GND_1_net, D2 => QN_1_net, D3 => 
        QN_1_net, S00 => VDD, S01 => D, S10 => G, S11 => 
        GND_1_net, Y => QN_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLC1F is 
    port(CLR, D, G : in std_logic;  QN : out std_logic) ;
end DLC1F;


architecture DEF_ARCH of  DLC1F is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, QN_1_net, VDD : std_logic ;
    begin   

    QN <= QN_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : INV
   port map(A => D, Y => NET0);
    U0 : CM8
   port map(D0 => QN_1_net, D1 => NET0, D2 => VDD, D3 => VDD, 
        S00 => VDD, S01 => G, S10 => CLR, S11 => GND_1_net, Y => 
        QN_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLC1G is 
    port(CLR, D, G : in std_logic;  QN : out std_logic) ;
end DLC1G;


architecture DEF_ARCH of  DLC1G is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, QN_1_net, VDD : std_logic ;
    begin   

    QN <= QN_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : INV
   port map(A => D, Y => NET0);
    U0 : CM8
   port map(D0 => NET0, D1 => QN_1_net, D2 => VDD, D3 => VDD, 
        S00 => VDD, S01 => G, S10 => CLR, S11 => GND_1_net, Y => 
        QN_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLE is 
    port(D, E, G : in std_logic;  Q : out std_logic) ;
end DLE;


architecture DEF_ARCH of  DLE is

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U0 : CM8
   port map(D0 => Q_1_net, D1 => Q_1_net, D2 => Q_1_net, D3 => D, 
        S00 => G, S01 => VDD, S10 => E, S11 => GND_1_net, Y => 
        Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLE1D is 
    port(D, E, G : in std_logic;  QN : out std_logic) ;
end DLE1D;


architecture DEF_ARCH of  DLE1D is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, QN_1_net, VDD : std_logic ;
    begin   

    QN <= QN_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : INV
   port map(A => D, Y => NET0);
    U0 : CM8
   port map(D0 => NET0, D1 => QN_1_net, D2 => QN_1_net, D3 => 
        QN_1_net, S00 => VDD, S01 => G, S10 => E, S11 => 
        GND_1_net, Y => QN_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLE2B is 
    port(CLR, D, E, G : in std_logic;  Q : out std_logic) ;
end DLE2B;


architecture DEF_ARCH of  DLE2B is

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : CM8
   port map(D0 => GND_1_net, D1 => NET0, D2 => GND_1_net, D3 => 
        Q_1_net, S00 => VDD, S01 => CLR, S10 => GND_1_net, S11 => 
        G, Y => Q_1_net);
    U0 : CM8
   port map(D0 => GND_1_net, D1 => D, D2 => GND_1_net, D3 => 
        Q_1_net, S00 => VDD, S01 => CLR, S10 => GND_1_net, S11 => 
        E, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLEA is 
    port(D, E, G : in std_logic;  Q : out std_logic) ;
end DLEA;


architecture DEF_ARCH of  DLEA is

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U0 : CM8
   port map(D0 => Q_1_net, D1 => D, D2 => Q_1_net, D3 => Q_1_net, 
        S00 => G, S01 => VDD, S10 => E, S11 => GND_1_net, Y => 
        Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLEB is 
    port(D, E, G : in std_logic;  Q : out std_logic) ;
end DLEB;


architecture DEF_ARCH of  DLEB is

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U0 : CM8
   port map(D0 => Q_1_net, D1 => Q_1_net, D2 => D, D3 => Q_1_net, 
        S00 => G, S01 => VDD, S10 => E, S11 => GND_1_net, Y => 
        Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLEC is 
    port(D, E, G : in std_logic;  Q : out std_logic) ;
end DLEC;


architecture DEF_ARCH of  DLEC is

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U0 : CM8
   port map(D0 => D, D1 => Q_1_net, D2 => Q_1_net, D3 => Q_1_net, 
        S00 => G, S01 => VDD, S10 => E, S11 => GND_1_net, Y => 
        Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLM is 
    port(A, B, G : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end DLM;


architecture DEF_ARCH of  DLM is

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
    U0 : CM8
   port map(D0 => Q_1_net, D1 => NET0, D2 => GND_1_net, D3 => 
        GND_1_net, S00 => VDD, S01 => G, S10 => GND_1_net, S11 => 
        GND_1_net, Y => Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLM2 is 
    port(A, B, CLR, G : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end DLM2;


architecture DEF_ARCH of  DLM2 is

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
    U0 : CM8
   port map(D0 => GND_1_net, D1 => GND_1_net, D2 => Q_1_net, 
        D3 => NET0, S00 => VDD, S01 => G, S10 => CLR, S11 => 
        GND_1_net, Y => Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLM2B is 
    port(A, B, CLR, G : in std_logic;  Q : out std_logic;  S : 
        in std_logic) ;
end DLM2B;


architecture DEF_ARCH of  DLM2B is

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
    U0 : CM8
   port map(D0 => GND_1_net, D1 => GND_1_net, D2 => NET0, D3 => 
        Q_1_net, S00 => G, S01 => VDD, S10 => CLR, S11 => 
        GND_1_net, Y => Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLM3 is 
    port(D0, D1, D2, D3, G : in std_logic;  Q : out std_logic;  
        S0, S1 : in std_logic) ;
end DLM3;


architecture DEF_ARCH of  DLM3 is

    component MX4
        port(D0, D1, D2, D3, S0, S1 : in std_logic := 'U'; Y : 
        out std_logic) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : MX4
   port map(D0 => D0, D1 => D1, D2 => D2, D3 => D3, S0 => S0, 
        S1 => S1, Y => NET0);
    U0 : CM8
   port map(D0 => Q_1_net, D1 => NET0, D2 => GND_1_net, D3 => 
        GND_1_net, S00 => VDD, S01 => G, S10 => GND_1_net, S11 => 
        GND_1_net, Y => Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLM3A is 
    port(D0, D1, D2, D3, G : in std_logic;  Q : out std_logic;  
        S0, S1 : in std_logic) ;
end DLM3A;


architecture DEF_ARCH of  DLM3A is

    component MX4
        port(D0, D1, D2, D3, S0, S1 : in std_logic := 'U'; Y : 
        out std_logic) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : MX4
   port map(D0 => D0, D1 => D1, D2 => D2, D3 => D3, S0 => S0, 
        S1 => S1, Y => NET0);
    U0 : CM8
   port map(D0 => NET0, D1 => Q_1_net, D2 => GND_1_net, D3 => 
        GND_1_net, S00 => VDD, S01 => G, S10 => GND_1_net, S11 => 
        GND_1_net, Y => Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLM4 is 
    port(D0, D1, D2, D3, G : in std_logic;  Q : out std_logic;  
        S0, S10, S11 : in std_logic) ;
end DLM4;


architecture DEF_ARCH of  DLM4 is

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : CM8
   port map(D0 => D0, D1 => D1, D2 => D2, D3 => D3, S00 => S0, 
        S01 => S0, S10 => S10, S11 => S11, Y => NET0);
    U0 : CM8
   port map(D0 => Q_1_net, D1 => NET0, D2 => GND_1_net, D3 => 
        GND_1_net, S00 => VDD, S01 => G, S10 => GND_1_net, S11 => 
        GND_1_net, Y => Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLM4A is 
    port(D0, D1, D2, D3, G : in std_logic;  Q : out std_logic;  
        S0, S10, S11 : in std_logic) ;
end DLM4A;


architecture DEF_ARCH of  DLM4A is

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : CM8
   port map(D0 => D0, D1 => D1, D2 => D2, D3 => D3, S00 => S0, 
        S01 => S0, S10 => S10, S11 => S11, Y => NET0);
    U0 : CM8
   port map(D0 => NET0, D1 => Q_1_net, D2 => GND_1_net, D3 => 
        GND_1_net, S00 => VDD, S01 => G, S10 => GND_1_net, S11 => 
        GND_1_net, Y => Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLM8A is 
    port(CLR, D0, D1, D2, D3, G : in std_logic;  Q : out 
        std_logic;  S00, S01, S10, S11 : in std_logic) ;
end DLM8A;


architecture DEF_ARCH of  DLM8A is

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : CM8
   port map(D0 => GND_1_net, D1 => GND_1_net, D2 => Q_1_net, 
        D3 => NET0, S00 => VDD, S01 => G, S10 => CLR, S11 => 
        GND_1_net, Y => Q_1_net);
    U0 : CM8
   port map(D0 => D0, D1 => D1, D2 => D2, D3 => D3, S00 => S00, 
        S01 => S01, S10 => S10, S11 => S11, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLM8B is 
    port(CLR, D0, D1, D2, D3, G : in std_logic;  Q : out 
        std_logic;  S00, S01, S10, S11 : in std_logic) ;
end DLM8B;


architecture DEF_ARCH of  DLM8B is

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : CM8
   port map(D0 => D0, D1 => D1, D2 => D2, D3 => D3, S00 => S00, 
        S01 => S01, S10 => S10, S11 => S11, Y => NET0);
    U0 : CM8
   port map(D0 => GND_1_net, D1 => GND_1_net, D2 => NET0, D3 => 
        Q_1_net, S00 => G, S01 => VDD, S10 => CLR, S11 => 
        GND_1_net, Y => Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLMA is 
    port(A, B, G : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end DLMA;


architecture DEF_ARCH of  DLMA is

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : MX2
   port map(A => A, B => B, S => S, Y => NET0);
    U0 : CM8
   port map(D0 => NET0, D1 => Q_1_net, D2 => GND_1_net, D3 => 
        GND_1_net, S00 => VDD, S01 => G, S10 => GND_1_net, S11 => 
        GND_1_net, Y => Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLME1A is 
    port(A, B, E, G, S : in std_logic;  Q : out std_logic) ;
end DLME1A;


architecture DEF_ARCH of  DLME1A is

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, Q_1_net, VDD : std_logic ;
    begin   

    Q <= Q_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : CM8
   port map(D0 => NET0, D1 => GND_1_net, D2 => Q_1_net, D3 => 
        GND_1_net, S00 => GND_1_net, S01 => GND_1_net, S10 => G, 
        S11 => GND_1_net, Y => Q_1_net);
    U0 : CM8
   port map(D0 => A, D1 => B, D2 => Q_1_net, D3 => Q_1_net, 
        S00 => S, S01 => VDD, S10 => E, S11 => GND_1_net, Y => 
        NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLP1D is 
    port(D, G, PRE : in std_logic;  QN : out std_logic) ;
end DLP1D;


architecture DEF_ARCH of  DLP1D is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, QN_1_net, VDD : std_logic ;
    begin   

    QN <= QN_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : INV
   port map(A => D, Y => NET0);
    U0 : CM8
   port map(D0 => GND_1_net, D1 => GND_1_net, D2 => QN_1_net, 
        D3 => NET0, S00 => VDD, S01 => G, S10 => PRE, S11 => 
        GND_1_net, Y => QN_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DLP1E is 
    port(D, G, PRE : in std_logic;  QN : out std_logic) ;
end DLP1E;


architecture DEF_ARCH of  DLP1E is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component CM8
        port(D0, D1, D2, D3, S00, S01, S10, S11 : in std_logic := 
        'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal GND_1_net, NET0, QN_1_net, VDD : std_logic ;
    begin   

    QN <= QN_1_net;
    
    VCC_1_net : VCC port map(Y => VDD);
    GND_2_net : GND port map(Y => GND_1_net);
    U1 : INV
   port map(A => D, Y => NET0);
    U0 : CM8
   port map(D0 => GND_1_net, D1 => GND_1_net, D2 => NET0, D3 => 
        QN_1_net, S00 => VDD, S01 => G, S10 => PRE, S11 => 
        GND_1_net, Y => QN_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DXAND7 is 
    port(A, B, C, D, E, F, G : in std_logic;  Y : out std_logic
        ) ;
end DXAND7;


architecture DEF_ARCH of  DXAND7 is

    component AND4
        port(A, B, C, D : in std_logic := 'U'; Y : out std_logic
        ) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : AND4
   port map(A => NET0, B => E, C => F, D => G, Y => Y);
    U0 : AND4
   port map(A => A, B => B, C => C, D => D, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DXAX7 is 
    port(A, B, C, D, E, F, G, H : in std_logic;  Y : out 
        std_logic) ;
end DXAX7;


architecture DEF_ARCH of  DXAX7 is

    component XOR2
        port(A, B : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component AND4
        port(A, B, C, D : in std_logic := 'U'; Y : out std_logic
        ) ;
    end component;

    signal NET0, NET1 : std_logic ;
    begin   

    U2 : XOR2
   port map(A => NET1, B => H, Y => Y);
    U1 : AND4
   port map(A => NET0, B => E, C => F, D => G, Y => NET1);
    U0 : AND4
   port map(A => A, B => B, C => C, D => D, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity DXNAND7 is 
    port(A, B, C, D, E, F, G : in std_logic;  Y : out std_logic
        ) ;
end DXNAND7;


architecture DEF_ARCH of  DXNAND7 is

    component NAND4
        port(A, B, C, D : in std_logic := 'U'; Y : out std_logic
        ) ;
    end component;

    component AND4
        port(A, B, C, D : in std_logic := 'U'; Y : out std_logic
        ) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : NAND4
   port map(A => NET0, B => E, C => F, D => G, Y => Y);
    U0 : AND4
   port map(A => A, B => B, C => C, D => D, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity IBDL is 
    port(G, PAD : in std_logic;  Q : out std_logic) ;
end IBDL;


architecture DEF_ARCH of  IBDL is

    component DL1B
        port(D, G : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component INBUF
        port(PAD : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DL1B
   port map(D => NET0, G => G, Q => Q);
    U0 : INBUF
   port map(PAD => PAD, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity IR is 
    port(CLK, PAD : in std_logic;  Q : out std_logic) ;
end IR;


architecture DEF_ARCH of  IR is

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component INBUF
        port(PAD : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : DF1
   port map(D => NET0, CLK => CLK, Q => Q);
    U0 : INBUF
   port map(PAD => PAD, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity IRI is 
    port(CLK, PAD : in std_logic;  QN : out std_logic) ;
end IRI;


architecture DEF_ARCH of  IRI is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    component INBUF
        port(PAD : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0, NET1 : std_logic ;
    begin   

    U2 : INV
   port map(A => NET1, Y => QN);
    U1 : DF1
   port map(D => NET0, CLK => CLK, Q => NET1);
    U0 : INBUF
   port map(PAD => PAD, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity JKF2C is 
    port(CLK, CLR, J, K : in std_logic;  Q : out std_logic) ;
end JKF2C;


architecture DEF_ARCH of  JKF2C is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DFC1B
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    signal NET0, NET1, Q_1_net : std_logic ;
    begin   

    Q <= Q_1_net;
    
    U2 : INV
   port map(A => CLR, Y => NET1);
    U1 : MX2
   port map(A => J, B => K, S => Q_1_net, Y => NET0);
    U0 : DFC1B
   port map(D => NET0, CLK => CLK, CLR => NET1, Q => Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity JKF2D is 
    port(CLK, CLR, J, K : in std_logic;  Q : out std_logic) ;
end JKF2D;


architecture DEF_ARCH of  JKF2D is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DFC1D
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    signal NET0, NET1, Q_1_net : std_logic ;
    begin   

    Q <= Q_1_net;
    
    U2 : INV
   port map(A => CLR, Y => NET1);
    U1 : MX2
   port map(A => J, B => K, S => Q_1_net, Y => NET0);
    U0 : DFC1D
   port map(D => NET0, CLK => CLK, CLR => NET1, Q => Q_1_net);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity MXC1 is 
    port(A, B, C, D, S : in std_logic;  Y : out std_logic) ;
end MXC1;


architecture DEF_ARCH of  MXC1 is

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal X : std_logic ;
    begin   

    U1 : MX2
   port map(A => C, B => D, S => X, Y => Y);
    U0 : MX2
   port map(A => A, B => B, S => S, Y => X);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity MXT is 
    port(D0, D1, D2, D3, S0A, S0B, S1 : in std_logic;  Y : out 
        std_logic) ;
end MXT;


architecture DEF_ARCH of  MXT is

    component MX4
        port(D0, D1, D2, D3, S0, S1 : in std_logic := 'U'; Y : 
        out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal X : std_logic ;
    begin   

    U1 : MX4
   port map(D0 => X, D1 => X, D2 => D2, D3 => D3, S0 => S0B, 
        S1 => S1, Y => Y);
    U0 : MX2
   port map(A => D0, B => D1, S => S0A, Y => X);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity OBDLHS is 
    port(D, G : in std_logic;  PAD : out std_logic) ;
end OBDLHS;


architecture DEF_ARCH of  OBDLHS is

    component OUTBUF
        port(PAD : out std_logic;  D : in std_logic := 'U') ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : OUTBUF
   port map(PAD => PAD, D => NET0);
    U0 : MX2
   port map(A => NET0, B => D, S => G, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity OBHS is 
    port(PAD : out std_logic;  D : in std_logic) ;
end OBHS;


architecture DEF_ARCH of  OBHS is

    component OUTBUF
        port(PAD : out std_logic;  D : in std_logic := 'U') ;
    end component;

begin   

    U0 : OUTBUF
   port map(PAD => PAD, D => D);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity ORH is 
    port(CLK, D : in std_logic;  PAD : out std_logic) ;
end ORH;


architecture DEF_ARCH of  ORH is

    component OUTBUF
        port(PAD : out std_logic;  D : in std_logic := 'U') ;
    end component;

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : OUTBUF
   port map(PAD => PAD, D => NET0);
    U0 : DF1
   port map(D => D, CLK => CLK, Q => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity ORIH is 
    port(CLK, D : in std_logic;  PAD : out std_logic) ;
end ORIH;


architecture DEF_ARCH of  ORIH is

    component OUTBUF
        port(PAD : out std_logic;  D : in std_logic := 'U') ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    signal NET0, NET1 : std_logic ;
    begin   

    U2 : OUTBUF
   port map(PAD => PAD, D => NET1);
    U1 : INV
   port map(A => NET0, Y => NET1);
    U0 : DF1
   port map(D => D, CLK => CLK, Q => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity ORITH is 
    port(CLK, D, E : in std_logic;  PAD : out std_logic) ;
end ORITH;


architecture DEF_ARCH of  ORITH is

    component TRIBUFF
        port(PAD : out std_logic;  D, E : in std_logic := 'U') ;
    end component;

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    signal NET0, NET1 : std_logic ;
    begin   

    U2 : TRIBUFF
   port map(PAD => PAD, D => NET1, E => E);
    U1 : INV
   port map(A => NET0, Y => NET1);
    U0 : DF1
   port map(D => D, CLK => CLK, Q => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity ORTH is 
    port(CLK, D, E : in std_logic;  PAD : out std_logic) ;
end ORTH;


architecture DEF_ARCH of  ORTH is

    component TRIBUFF
        port(PAD : out std_logic;  D, E : in std_logic := 'U') ;
    end component;

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    signal NET1 : std_logic ;
    begin   

    U2 : TRIBUFF
   port map(PAD => PAD, D => NET1, E => E);
    U0 : DF1
   port map(D => D, CLK => CLK, Q => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity TBDLHS is 
    port(D, E, G : in std_logic;  PAD : out std_logic) ;
end TBDLHS;


architecture DEF_ARCH of  TBDLHS is

    component TRIBUFF
        port(PAD : out std_logic;  D, E : in std_logic := 'U') ;
    end component;

    component DL1
        port(D, G : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    signal NET1 : std_logic ;
    begin   

    U2 : TRIBUFF
   port map(PAD => PAD, D => NET1, E => E);
    U1 : DL1
   port map(D => D, G => G, Q => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library a54sxa;
 
entity TBHS is 
    port(D, E : in std_logic;  PAD : out std_logic) ;
end TBHS;


architecture DEF_ARCH of  TBHS is

    component TRIBUFF
        port(PAD : out std_logic;  D, E : in std_logic := 'U') ;
    end component;

begin   

    U0 : TRIBUFF
   port map(PAD => PAD, D => D, E => E);
end DEF_ARCH;
