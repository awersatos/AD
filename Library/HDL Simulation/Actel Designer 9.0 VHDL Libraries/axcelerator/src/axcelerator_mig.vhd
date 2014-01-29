--------------------------------------------------------------------
--       Actel axcelerator (migration) Vital Simulation Library
--       NAME: axcelerator_mig.vhd
--       DATE: July 05, 2006
---------------------------------------------------------------------/

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.VITAL_Timing.all;

package COMPONENTS is

constant DefaultTimingChecksOn : Boolean := True;
constant DefaultXGenerationOn : Boolean := False;
constant DefaultXon : Boolean := False;
constant DefaultMsgOn : Boolean := True;



------ Component ADD1 ------
 component ADD1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_FCO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_FCO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_FCO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_FCI		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		FCI		: in    STD_ULOGIC;
		S		: out    STD_ULOGIC;
		FCO		: out    STD_ULOGIC);
 end component;


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


------ Component AFCNTECP1 ------
 component AFCNTECP1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_UD_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_Q_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_Q_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
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
		tipd_UD		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_FCI		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		Q		:  out STD_ULOGIC;
		UD		:  in    STD_ULOGIC;
		FCI		:  in    STD_ULOGIC;
		FCO		:  out    STD_ULOGIC);

 end component;


------ Component ARCNTECP1 ------
 component ARCNTECP1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_UD_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_Q_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_Q_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
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
		tipd_UD		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_FCI		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		Q		:  out STD_ULOGIC;
		UD		:  in    STD_ULOGIC;
		FCI		:  in    STD_ULOGIC;
		FCO		:  out    STD_ULOGIC);

 end component;


------ Component AFCNTELDCP1 ------
 component AFCNTELDCP1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_UD_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_LD_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_LD_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_Q_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_LD_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_LD_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_Q_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
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
		tipd_LD		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_UD		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_FCI		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		LD		:  in    STD_ULOGIC;
		Q		:  out STD_ULOGIC;
		UD		:  in    STD_ULOGIC;
		FCI		:  in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		FCO		:  out    STD_ULOGIC);

 end component;


------ Component ARCNTELDCP1 ------
 component ARCNTELDCP1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_UD_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_LD_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_LD_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_Q_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_LD_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_LD_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_Q_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
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
		tipd_LD		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_UD		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_FCI		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		LD		:  in    STD_ULOGIC;
		Q		:  out STD_ULOGIC;
		UD		:  in    STD_ULOGIC;
		FCI		:  in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		FCO		:  out    STD_ULOGIC);

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
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_S_8 ------
 component BIBUF_S_8
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_S_8D ------
 component BIBUF_S_8D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_S_8U ------
 component BIBUF_S_8U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_S_12 ------
 component BIBUF_S_12
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_S_12D ------
 component BIBUF_S_12D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_S_12U ------
 component BIBUF_S_12U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_S_16 ------
 component BIBUF_S_16
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_S_16D ------
 component BIBUF_S_16D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_S_16U ------
 component BIBUF_S_16U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_S_24 ------
 component BIBUF_S_24
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_S_24D ------
 component BIBUF_S_24D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_S_24U ------
 component BIBUF_S_24U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_F_8 ------
 component BIBUF_F_8
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_F_8D ------
 component BIBUF_F_8D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_F_8U ------
 component BIBUF_F_8U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_F_12 ------
 component BIBUF_F_12
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_F_12D ------
 component BIBUF_F_12D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_F_12U ------
 component BIBUF_F_12U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_F_16 ------
 component BIBUF_F_16
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_F_16D ------
 component BIBUF_F_16D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_F_16U ------
 component BIBUF_F_16U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_F_24 ------
 component BIBUF_F_24
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_F_24D ------
 component BIBUF_F_24D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_F_24U ------
 component BIBUF_F_24U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_LVCMOS25 ------
 component BIBUF_LVCMOS25
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_LVCMOS25D ------
 component BIBUF_LVCMOS25D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_LVCMOS25U ------
 component BIBUF_LVCMOS25U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_LVCMOS18 ------
 component BIBUF_LVCMOS18
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_LVCMOS18D ------
 component BIBUF_LVCMOS18D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_LVCMOS18U ------
 component BIBUF_LVCMOS18U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_LVCMOS15 ------
 component BIBUF_LVCMOS15
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_LVCMOS15D ------
 component BIBUF_LVCMOS15D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_LVCMOS15U ------
 component BIBUF_LVCMOS15U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_PCI ------
 component BIBUF_PCI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_PCIX ------
 component BIBUF_PCIX
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_GTLP33 ------
 component BIBUF_GTLP33
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_GTLP25 ------
 component BIBUF_GTLP25
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component CLKBIBUF ------
 component CLKBIBUF
    generic(
                TimingChecksOn:Boolean := True;
                Xon: Boolean := False;
                InstancePath: STRING :="*";
                MsgOn: Boolean := True;
                tpd_D_PAD               : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
                tpd_PAD_Y               : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_D_Y                 : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_E_Y                 : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tipd_D                  : VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_E                  : VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_PAD                : VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                PAD             : inout  STD_ULOGIC;
                D               : in     STD_ULOGIC;
                E               : in     STD_ULOGIC;
                Y               : out    STD_ULOGIC);
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


------ Component CLKBUF_LVCMOS25 ------
 component CLKBUF_LVCMOS25
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


------ Component CLKBUF_LVCMOS18 ------
 component CLKBUF_LVCMOS18
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


------ Component CLKBUF_LVCMOS15 ------
 component CLKBUF_LVCMOS15
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


------ Component CLKBUF_PCI ------
 component CLKBUF_PCI
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


------ Component CLKBUF_PCIX ------
 component CLKBUF_PCIX
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


------ Component CLKBUF_GTLP33 ------
 component CLKBUF_GTLP33
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


------ Component CLKBUF_GTLP25 ------
 component CLKBUF_GTLP25
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


------ Component CLKBUF_HSTL_I ------
 component CLKBUF_HSTL_I
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


------ Component CLKBUF_SSTL3_I ------
 component CLKBUF_SSTL3_I
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


------ Component CLKBUF_SSTL3_II ------
 component CLKBUF_SSTL3_II
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


------ Component CLKBUF_SSTL2_I ------
 component CLKBUF_SSTL2_I
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


------ Component CLKBUF_SSTL2_II ------
 component CLKBUF_SSTL2_II
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


------ Component CM8BUFF ------
 component CM8BUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
                tpw_A_posedge   : VitalDelayType := 0.000 ns;
                tpw_A_negedge   : VitalDelayType := 0.000 ns;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
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


------ Component DL1A ------
 component DL1A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
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
		QN		:  out    STD_ULOGIC);

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


------ Component DL1C ------
 component DL1C
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
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
		QN		:  out    STD_ULOGIC);

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


------ Component DLC1F ------
 component DLC1F
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
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
		QN		:  out    STD_ULOGIC);

 end component;


------ Component DLC1G ------
 component DLC1G
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
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
		QN		:  out    STD_ULOGIC);

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


------ Component DLE ------
 component DLE
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_negedge		:VitalDelayType := 0.000 ns;
		tpw_G_posedge		:  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		E		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLE1D ------
 component DLE1D
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		E		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		QN		:  out    STD_ULOGIC);

 end component;


------ Component DLE2B ------
 component DLE2B
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
		tsetup_E_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
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
		tsetup_E_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_E_negedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_E_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_posedge		:  VitalDelayType := 0.000 ns;
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
		tsetup_E_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_PRE_posedge		:  VitalDelayType := 0.000 ns;
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
		tsetup_E_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
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


------ Component DLEA ------
 component DLEA
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_negedge		:VitalDelayType := 0.000 ns;
		tpw_G_posedge		:  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		E		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLEB ------
 component DLEB
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		E		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLEC ------
 component DLEC
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D		:  in    STD_ULOGIC;
		E		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLM ------
 component DLM
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_A_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_negedge		:VitalDelayType := 0.000 ns;
		tpw_G_posedge		:  VitalDelayType := 0.000 ns;
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		A		:  in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLM2 ------
 component DLM2
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_A_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_negedge		:VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tpw_G_posedge		:  VitalDelayType := 0.000 ns;
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		A		:  in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		CLR		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLM2B ------
 component DLM2B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_A_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		A		:  in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		CLR		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLM3 ------
 component DLM3
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D0_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S0_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S1_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D0_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D0_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D0_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D0_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S0_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S0_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S0_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S0_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D1_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D1_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D1_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D1_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S1_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S1_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S1_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S1_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D2_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D2_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D2_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D2_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D3_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D3_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D3_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D3_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_negedge		:VitalDelayType := 0.000 ns;
		tpw_G_posedge		:  VitalDelayType := 0.000 ns;
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D0		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S0		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S1		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D0		:  in    STD_ULOGIC;
		S0		:  in    STD_ULOGIC;
		D1		:  in    STD_ULOGIC;
		S1		:  in    STD_ULOGIC;
		D2		:  in    STD_ULOGIC;
		D3		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLM3A ------
 component DLM3A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D0_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S0_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S1_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D0_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D0_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D0_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D0_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S0_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S0_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S0_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S0_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D1_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D1_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D1_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D1_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S1_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S1_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S1_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S1_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D2_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D2_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D2_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D2_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D3_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D3_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D3_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D3_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D0		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S0		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S1		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		D0		:  in    STD_ULOGIC;
		S0		:  in    STD_ULOGIC;
		D1		:  in    STD_ULOGIC;
		S1		:  in    STD_ULOGIC;
		D2		:  in    STD_ULOGIC;
		D3		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLM4 ------
 component DLM4
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S0_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D0_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S10_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S10_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S10_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S10_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S11_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S11_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S11_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S11_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S0_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S0_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S0_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S0_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D0_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D0_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D0_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D0_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D1_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D1_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D1_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D1_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D2_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D2_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D2_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D2_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D3_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D3_G_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D3_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D3_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_negedge		:VitalDelayType := 0.000 ns;
		tpw_G_posedge		:  VitalDelayType := 0.000 ns;
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S0		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D0		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		S10		:  in    STD_ULOGIC;
		S11		:  in    STD_ULOGIC;
		S0		:  in    STD_ULOGIC;
		D0		:  in    STD_ULOGIC;
		D1		:  in    STD_ULOGIC;
		D2		:  in    STD_ULOGIC;
		D3		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLM4A ------
 component DLM4A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S10_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S11_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S0_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D0_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D1_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D2_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D3_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S10_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S10_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S10_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S10_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S11_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S11_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S11_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S11_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S0_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S0_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S0_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S0_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D0_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D0_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D0_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D0_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D1_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D1_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D1_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D1_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D2_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D2_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D2_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D2_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D3_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D3_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D3_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D3_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S10		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S11		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S0		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D0		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D1		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D2		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D3		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		S10		:  in    STD_ULOGIC;
		S11		:  in    STD_ULOGIC;
		S0		:  in    STD_ULOGIC;
		D0		:  in    STD_ULOGIC;
		D1		:  in    STD_ULOGIC;
		D2		:  in    STD_ULOGIC;
		D3		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLMA ------
 component DLMA
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_A_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		A		:  in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		G		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DLME1A ------
 component DLME1A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_G_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_S_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_A_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_G_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_G_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_G_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tperiod_G_posedge		:  VitalDelayType := 0.000 ns;
		tpw_G_negedge		:  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_G		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns));


     port(
		A		:  in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
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


------ Component DLP1D ------
 component DLP1D
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
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
		QN		:  out    STD_ULOGIC);

 end component;


------ Component DLP1E ------
 component DLP1E
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_G_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_QN		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
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
		QN		:  out    STD_ULOGIC);

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


------ Component FCEND_BUFF ------
 component FCEND_BUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_FCI_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_FCI		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		FCI		: in    STD_ULOGIC;
		CO		: out    STD_ULOGIC);
 end component;


------ Component FCEND_INV ------
 component FCEND_INV
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_FCI_CO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_FCI		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		FCI		: in    STD_ULOGIC;
		CO		: out    STD_ULOGIC);
 end component;


------ Component FCINIT_BUFF ------
 component FCINIT_BUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_FCO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		FCO		: out    STD_ULOGIC);
 end component;


------ Component FCINIT_GND ------
 component FCINIT_GND
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True		);
    port(
		FCO		: out    STD_ULOGIC);
 end component;


------ Component FCINIT_INV ------
 component FCINIT_INV
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_FCO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		FCO		: out    STD_ULOGIC);
 end component;


------ Component FCINIT_VCC ------
 component FCINIT_VCC
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True		);
    port(
		FCO		: out    STD_ULOGIC);
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


------ Component HCLKBIBUF ------
 component HCLKBIBUF
    generic(
                TimingChecksOn:Boolean := True;
                Xon: Boolean := False;
                InstancePath: STRING :="*";
                MsgOn: Boolean := True;
                tpd_D_PAD               : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
                tpd_PAD_Y               : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_D_Y                 : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_E_Y                 : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tipd_D                  : VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_E                  : VitalDelayType01 := (0.000 ns, 0.000 ns);
                tipd_PAD                : VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
                PAD             : inout  STD_ULOGIC;
                D               : in     STD_ULOGIC;
                E               : in     STD_ULOGIC;
                Y               : out    STD_ULOGIC);
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


------ Component HCLKBUF_LVCMOS25 ------
 component HCLKBUF_LVCMOS25
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


------ Component HCLKBUF_LVCMOS18 ------
 component HCLKBUF_LVCMOS18
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


------ Component HCLKBUF_LVCMOS15 ------
 component HCLKBUF_LVCMOS15
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


------ Component HCLKBUF_PCI ------
 component HCLKBUF_PCI
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


------ Component HCLKBUF_PCIX ------
 component HCLKBUF_PCIX
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


------ Component HCLKBUF_GTLP33 ------
 component HCLKBUF_GTLP33
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


------ Component HCLKBUF_GTLP25 ------
 component HCLKBUF_GTLP25
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


------ Component HCLKBUF_HSTL_I ------
 component HCLKBUF_HSTL_I
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


------ Component HCLKBUF_SSTL3_I ------
 component HCLKBUF_SSTL3_I
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


------ Component HCLKBUF_SSTL3_II ------
 component HCLKBUF_SSTL3_II
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


------ Component HCLKBUF_SSTL2_I ------
 component HCLKBUF_SSTL2_I
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


------ Component HCLKBUF_SSTL2_II ------
 component HCLKBUF_SSTL2_II
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


------ Component HCLKINT ------
 component HCLKINT
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


------ Component INBUF_LVCMOS25 ------
 component INBUF_LVCMOS25
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


------ Component INBUF_LVCMOS25D ------
 component INBUF_LVCMOS25D
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


------ Component INBUF_LVCMOS25U ------
 component INBUF_LVCMOS25U
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


------ Component INBUF_LVCMOS18 ------
 component INBUF_LVCMOS18
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


------ Component INBUF_LVCMOS18D ------
 component INBUF_LVCMOS18D
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


------ Component INBUF_LVCMOS18U ------
 component INBUF_LVCMOS18U
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


------ Component INBUF_LVCMOS15 ------
 component INBUF_LVCMOS15
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


------ Component INBUF_LVCMOS15D ------
 component INBUF_LVCMOS15D
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


------ Component INBUF_LVCMOS15U ------
 component INBUF_LVCMOS15U
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


------ Component INBUF_PCI ------
 component INBUF_PCI
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


------ Component INBUF_PCIX ------
 component INBUF_PCIX
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


------ Component INBUF_GTLP33 ------
 component INBUF_GTLP33
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


------ Component INBUF_GTLP25 ------
 component INBUF_GTLP25
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


------ Component INBUF_HSTL_I ------
 component INBUF_HSTL_I
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


------ Component INBUF_SSTL3_I ------
 component INBUF_SSTL3_I
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


------ Component INBUF_SSTL3_II ------
 component INBUF_SSTL3_II
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


------ Component INBUF_SSTL2_I ------
 component INBUF_SSTL2_I
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


------ Component INBUF_SSTL2_II ------
 component INBUF_SSTL2_II
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


------ Component IOI_DFEG ------
 component IOI_DFEG
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


------ Component IOI_DFEH ------
 component IOI_DFEH
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


------ Component IOI_BUFF ------
 component IOI_BUFF
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


------ Component IOOE_BUFF ------
 component IOOE_BUFF
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


------ Component IOOE_DFEG ------
 component IOOE_DFEG
	generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_PRE_Q	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_YOUT	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_PRE_YOUT	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_YOUT	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge	:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_posedge       :   VitalDelayType := 0.000 ns;
		tperiod_CLK_negedge        :  VitalDelayType := 0.000 ns;
		tpw_CLK_posedge        :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge        :  VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_posedge	:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_posedge	:   VitalDelayType := 0.000 ns;
		tpw_CLR_negedge	:  VitalDelayType := 0.000 ns;
		tsetup_E_CLK_posedge_posedge   :   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_negedge_posedge   :   VitalDelayType := 0.000 ns;
		thold_E_CLK_posedge_posedge	:   VitalDelayType := 0.000 ns;
		thold_E_CLK_negedge_posedge       :   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_posedge	:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_posedge	:   VitalDelayType := 0.000 ns;
		tpw_PRE_negedge	:  VitalDelayType := 0.000 ns;
		tipd_D :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_PRE :   VitalDelayType01 := (0.000 ns, 0.000 ns));
    port(
                D         : in    STD_ULOGIC;
                CLK         : in    STD_ULOGIC;
                CLR         : in    STD_ULOGIC;
                E         : in    STD_ULOGIC;
                PRE         : in    STD_ULOGIC;
                Q                : out    STD_ULOGIC;
                YOUT                : out    STD_ULOGIC);
 end component;


------ Component IOOE_DFEH ------
 component IOOE_DFEH
	generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_PRE_Q	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_YOUT	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_PRE_YOUT	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_YOUT	:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_D_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_negedge	:   VitalDelayType := 0.000 ns;
		thold_D_CLK_negedge_negedge       :   VitalDelayType := 0.000 ns;
		tperiod_CLK_negedge        :  VitalDelayType := 0.000 ns;
		tpw_CLK_posedge        :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge        :  VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_negedge	:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_negedge	:   VitalDelayType := 0.000 ns;
		tpw_CLR_negedge	:  VitalDelayType := 0.000 ns;
		tsetup_E_CLK_posedge_negedge   :   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_negedge_negedge   :   VitalDelayType := 0.000 ns;
		thold_E_CLK_posedge_negedge	:   VitalDelayType := 0.000 ns;
		thold_E_CLK_negedge_negedge       :   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_negedge	:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_negedge	:   VitalDelayType := 0.000 ns;
		tpw_PRE_negedge	:  VitalDelayType := 0.000 ns;
		tipd_D :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E :   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_PRE :   VitalDelayType01 := (0.000 ns, 0.000 ns));
    port(
                D         : in    STD_ULOGIC;
                CLK         : in    STD_ULOGIC;
                CLR         : in    STD_ULOGIC;
                E         : in    STD_ULOGIC;
                PRE         : in    STD_ULOGIC;
                Q                : out    STD_ULOGIC;
                YOUT                : out    STD_ULOGIC);
 end component;


------ Component IOPAD_IN ------
 component IOPAD_IN
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
-- DNW: Add the following 2 lines
		tpw_PAD_posedge		: VitalDelayType := 0.000 ns;
		tpw_PAD_negedge		: VitalDelayType := 0.000 ns;
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PAD		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component IOPAD_TRI ------
 component IOPAD_TRI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpw_D_posedge	: VitalDelayType := 0.000 ns;
		tpw_D_negedge	: VitalDelayType := 0.000 ns;
		tpw_E_posedge   : VitalDelayType := 0.000 ns;
		tpw_E_negedge	: VitalDelayType := 0.000 ns;

		tpd_D_PAD       : VitalDelayType01 := (0.100 ns, 0.100 ns);
                tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
          	tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component IOPAD_BI ------
 component IOPAD_BI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		
                tpw_D_posedge           : VitalDelayType := 0.000 ns;
                tpw_D_negedge           : VitalDelayType := 0.000 ns;
                tpw_E_posedge           : VitalDelayType := 0.000 ns;
                tpw_E_negedge           : VitalDelayType := 0.000 ns;
                tpw_PAD_negedge         : VitalDelayType := 0.000 ns;
                tpw_PAD_posedge         : VitalDelayType := 0.000 ns;
  
                tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component MULT1 ------
 component MULT1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_PO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_PO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_PI_PO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_PO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_FCO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_FCO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_PI_FCO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_FCO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_PI		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_FCI		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		PI		: in    STD_ULOGIC;
		FCI		: in    STD_ULOGIC;
		PO		: out    STD_ULOGIC;
		FCO		: out    STD_ULOGIC);
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
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		C		: in    STD_ULOGIC;
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component OA1C ------
 component OA1C
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		C		: in    STD_ULOGIC;
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
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


------ Component OUTBUF_S_8 ------
 component OUTBUF_S_8
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


------ Component OUTBUF_S_12 ------
 component OUTBUF_S_12
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


------ Component OUTBUF_S_16 ------
 component OUTBUF_S_16
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


------ Component OUTBUF_S_24 ------
 component OUTBUF_S_24
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


------ Component OUTBUF_F_8 ------
 component OUTBUF_F_8
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


------ Component OUTBUF_F_12 ------
 component OUTBUF_F_12
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


------ Component OUTBUF_F_16 ------
 component OUTBUF_F_16
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


------ Component OUTBUF_F_24 ------
 component OUTBUF_F_24
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


------ Component OUTBUF_LVCMOS25 ------
 component OUTBUF_LVCMOS25
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


------ Component OUTBUF_LVCMOS18 ------
 component OUTBUF_LVCMOS18
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


------ Component OUTBUF_LVCMOS15 ------
 component OUTBUF_LVCMOS15
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


------ Component OUTBUF_PCI ------
 component OUTBUF_PCI
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


------ Component OUTBUF_PCIX ------
 component OUTBUF_PCIX
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


------ Component OUTBUF_GTLP33 ------
 component OUTBUF_GTLP33
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


------ Component OUTBUF_GTLP25 ------
 component OUTBUF_GTLP25
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


------ Component OUTBUF_HSTL_I ------
 component OUTBUF_HSTL_I
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


------ Component OUTBUF_SSTL3_I ------
 component OUTBUF_SSTL3_I
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


------ Component OUTBUF_SSTL3_II ------
 component OUTBUF_SSTL3_II
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


------ Component OUTBUF_SSTL2_I ------
 component OUTBUF_SSTL2_I
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


------ Component OUTBUF_SSTL2_II ------
 component OUTBUF_SSTL2_II
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


------ Component PLLHCLK ------
 component PLLHCLK
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


------ Component PLLRCLK ------
 component PLLRCLK
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


------ Component SFCNTECP1 ------
 component SFCNTECP1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_UD_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_Q_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_Q_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
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
		tipd_UD		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_FCI		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		Q		:  out STD_ULOGIC;
		UD		:  in    STD_ULOGIC;
		FCI		:  in    STD_ULOGIC;
		FCO		:  out    STD_ULOGIC);

 end component;


------ Component SRCNTECP1 ------
 component SRCNTECP1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_UD_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_Q_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_Q_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
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
		tipd_UD		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_FCI		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		Q		:  out STD_ULOGIC;
		UD		:  in    STD_ULOGIC;
		FCI		:  in    STD_ULOGIC;
		FCO		:  out    STD_ULOGIC);

 end component;


------ Component SFCNTELDCP1 ------
 component SFCNTELDCP1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_UD_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_Q_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_LD_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_LD_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_Q_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_LD_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_LD_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
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
		tipd_UD		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_FCI		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_LD		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		Q		:  out STD_ULOGIC;
		UD		:  in    STD_ULOGIC;
		FCI		:  in    STD_ULOGIC;
		LD		:  in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		FCO		:  out    STD_ULOGIC);

 end component;


------ Component SRCNTELDCP1 ------
 component SRCNTELDCP1
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_UD_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_FCO		:   VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_Q_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_LD_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_LD_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_D_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_Q_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_Q_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_UD_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_UD_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_FCI_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_FCI_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_LD_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_LD_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
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
		tipd_UD		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_FCI		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_LD		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_D		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		Q		:  out STD_ULOGIC;
		UD		:  in    STD_ULOGIC;
		FCI		:  in    STD_ULOGIC;
		LD		:  in    STD_ULOGIC;
		D		:  in    STD_ULOGIC;
		FCO		:  out    STD_ULOGIC);

 end component;


------ Component SUB1 ------
 component SUB1
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_S		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_A_FCO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_FCO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_FCO		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_FCI		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		FCI		: in    STD_ULOGIC;
		S		: out    STD_ULOGIC;
		FCO		: out    STD_ULOGIC);
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
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_S_8 ------
 component TRIBUFF_S_8
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_S_8D ------
 component TRIBUFF_S_8D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_S_8U ------
 component TRIBUFF_S_8U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_S_12 ------
 component TRIBUFF_S_12
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_S_12D ------
 component TRIBUFF_S_12D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_S_12U ------
 component TRIBUFF_S_12U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_S_16 ------
 component TRIBUFF_S_16
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_S_16D ------
 component TRIBUFF_S_16D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_S_16U ------
 component TRIBUFF_S_16U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_S_24 ------
 component TRIBUFF_S_24
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_S_24D ------
 component TRIBUFF_S_24D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_S_24U ------
 component TRIBUFF_S_24U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_F_8 ------
 component TRIBUFF_F_8
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_F_8D ------
 component TRIBUFF_F_8D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_F_8U ------
 component TRIBUFF_F_8U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_F_12 ------
 component TRIBUFF_F_12
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_F_12D ------
 component TRIBUFF_F_12D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_F_12U ------
 component TRIBUFF_F_12U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_F_16 ------
 component TRIBUFF_F_16
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_F_16D ------
 component TRIBUFF_F_16D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_F_16U ------
 component TRIBUFF_F_16U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_F_24 ------
 component TRIBUFF_F_24
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_F_24D ------
 component TRIBUFF_F_24D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_F_24U ------
 component TRIBUFF_F_24U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_LVCMOS25 ------
 component TRIBUFF_LVCMOS25
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_LVCMOS25D ------
 component TRIBUFF_LVCMOS25D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_LVCMOS25U ------
 component TRIBUFF_LVCMOS25U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_LVCMOS18 ------
 component TRIBUFF_LVCMOS18
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_LVCMOS18D ------
 component TRIBUFF_LVCMOS18D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_LVCMOS18U ------
 component TRIBUFF_LVCMOS18U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_LVCMOS15 ------
 component TRIBUFF_LVCMOS15
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_LVCMOS15D ------
 component TRIBUFF_LVCMOS15D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_LVCMOS15U ------
 component TRIBUFF_LVCMOS15U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_PCI ------
 component TRIBUFF_PCI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_PCIX ------
 component TRIBUFF_PCIX
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_GTLP33 ------
 component TRIBUFF_GTLP33
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_GTLP25 ------
 component TRIBUFF_GTLP25
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component XNOR4 ------
 component XNOR4
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


------ Component XOR4 ------
 component XOR4
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


------ Component XOR4_FCI ------
 component XOR4_FCI
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_B_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_C_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_FCI_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_C		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_FCI		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		B		: in    STD_ULOGIC;
		C		: in    STD_ULOGIC;
		FCI		: in    STD_ULOGIC;
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


------ Component IOFIFO_BIBUF ------
 component IOFIFO_BIBUF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_AIN_YIN		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_AOUT_YOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_AIN		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_AOUT		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		AIN		: in    STD_ULOGIC;
		AOUT		: in    STD_ULOGIC;
		YIN		: out    STD_ULOGIC;
		YOUT		: out    STD_ULOGIC);
 end component;


------ Component IOI_FCLK_EN_BUFF ------
 component IOI_FCLK_EN_BUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_EN_ENOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_EN		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		EN		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC;
		ENOUT		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOI_FCLK_BUFF ------
 component IOI_FCLK_BUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOI_RCLK_EN_BUFF ------
 component IOI_RCLK_EN_BUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_EN_ENOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_EN		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		EN		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC;
		ENOUT		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOI_RCLK_BUFF ------
 component IOI_RCLK_BUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOOE_FCLK_EN_BUFF ------
 component IOOE_FCLK_EN_BUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_YOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_EN_ENOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_EN		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		EN		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		YOUT		: out    STD_ULOGIC;
		ENOUT		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOOE_FCLK ------
 component IOOE_FCLK
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLK		: in    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOOE_RCLK_EN_BUFF ------
 component IOOE_RCLK_EN_BUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_YOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_EN_ENOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_EN		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		EN		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		YOUT		: out    STD_ULOGIC;
		ENOUT		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOOE_RCLK_CLR_EN ------
 component IOOE_RCLK_CLR_EN
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_CLR_CLROUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_EN_ENOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_CLR		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_EN		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		: in    STD_ULOGIC;
		EN		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		CLROUT		: out    STD_ULOGIC;
		ENOUT		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOOE_RCLK_BUFF ------
 component IOOE_RCLK_BUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_YOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		YOUT		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOOE_RCLK ------
 component IOOE_RCLK
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLK		: in    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component PLLINT ------
 component PLLINT
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


------ Component PLLOUT ------
 component PLLOUT
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


------ Component BIBUF_HSTL_I ------
 component BIBUF_HSTL_I
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_SSTL3_I ------
 component BIBUF_SSTL3_I
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_SSTL3_II ------
 component BIBUF_SSTL3_II
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_SSTL2_I ------
 component BIBUF_SSTL2_I
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component BIBUF_SSTL2_II ------
 component BIBUF_SSTL2_II
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component CLKINT_W ------
 component CLKINT_W
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


------ Component CLKOUT_E ------
 component CLKOUT_E
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


------ Component CLKOUT_W ------
 component CLKOUT_W
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


------ Component DFM ------
 component DFM
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFM3B ------
 component DFM3B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFM4A ------
 component DFM4A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PRE		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFM4B ------
 component DFM4B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_PRE_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		trecovery_PRE_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_PRE_negedge		:  VitalDelayType := 0.000 ns;
		tipd_PRE		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PRE		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFMA ------
 component DFMA
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFMB ------
 component DFMB
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		trecovery_CLR_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tpw_CLR_negedge		:  VitalDelayType := 0.000 ns;
		tipd_CLR		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFME1A ------
 component DFME1A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFME1B ------
 component DFME1B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_E_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_E_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tpw_CLK_posedge :  VitalDelayType := 0.000 ns;
		tpw_CLK_negedge  :  VitalDelayType := 0.000 ns;
		tipd_E		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFME2A ------
 component DFME2A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
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
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFME2B ------
 component DFME2B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
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
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFME3A ------
 component DFME3A
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
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
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFME3B ------
 component DFME3B
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
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
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFMEG ------
 component DFMEG
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
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
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFMEH ------
 component DFMEH
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
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
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		E		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFMPCA ------
 component DFMPCA
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_posedge		:   VitalDelayType := 0.000 ns;
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
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component DFMPCB ------
 component DFMPCB
    generic(
		TimingChecksOn: Boolean := True;
		InstancePath: STRING := "*";
		Xon: Boolean := False;
		MsgOn: Boolean := True;
		tpd_PRE_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_Q		:  VitalDelayType01 := (0.100 ns, 0.100 ns);
		tsetup_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_posedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_S_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_A_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		tsetup_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
		thold_B_CLK_negedge_negedge		:   VitalDelayType := 0.000 ns;
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
		tipd_S		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_A		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_B		:   VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		:    VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		CLR		:   in    STD_ULOGIC;
		PRE		:   in    STD_ULOGIC;
		CLK		:   in    STD_ULOGIC;
		S		:  in    STD_ULOGIC;
		A		:  in    STD_ULOGIC;
		B		:  in    STD_ULOGIC;
		Q		:  out    STD_ULOGIC);

 end component;


------ Component HCLKMUX ------
 component HCLKMUX
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		
                tpw_A_posedge   : VitalDelayType := 0.000 ns;
                tpw_A_negedge   : VitalDelayType := 0.000 ns;    
                tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component IOFIFO_INBUF ------
 component IOFIFO_INBUF
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


------ Component IOFIFO_OUTBUF ------
 component IOFIFO_OUTBUF
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


------ Component IOOE_FCLK_BUFF ------
 component IOOE_FCLK_BUFF
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_YOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		YOUT		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOOE_OUT_FCLK ------
 component IOOE_OUT_FCLK
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_YOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		YOUT		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOOE_OUT_FCLK_CLR_EN ------
 component IOOE_OUT_FCLK_CLR_EN
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_YOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_EN_ENOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_CLROUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_EN		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		EN		: in    STD_ULOGIC;
		CLR		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		YOUT		: out    STD_ULOGIC;
		ENOUT		: out    STD_ULOGIC;
		CLROUT		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOOE_OUT_RCLK ------
 component IOOE_OUT_RCLK
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_YOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		YOUT		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOOE_OUT_RCLK_CLR_EN ------
 component IOOE_OUT_RCLK_CLR_EN
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_A_YOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_EN_ENOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_CLROUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_EN		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		EN		: in    STD_ULOGIC;
		CLR		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		YOUT		: out    STD_ULOGIC;
		ENOUT		: out    STD_ULOGIC;
		CLROUT		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOOE_FCLK_CLR_EN ------
 component IOOE_FCLK_CLR_EN
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_EN_ENOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLR_CLROUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_CLK_CLKOUT		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_EN		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLR		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_CLK		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		EN		: in    STD_ULOGIC;
		CLR		: in    STD_ULOGIC;
		CLK		: in    STD_ULOGIC;
		ENOUT		: out    STD_ULOGIC;
		CLROUT		: out    STD_ULOGIC;
		CLKOUT		: out    STD_ULOGIC);
 end component;


------ Component IOPAD_IN_U ------
 component IOPAD_IN_U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpw_PAD_posedge		: VitalDelayType := 0.000 ns;
		tpw_PAD_negedge		: VitalDelayType := 0.000 ns;
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PAD		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component IOPAD_IN_D ------
 component IOPAD_IN_D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpw_PAD_posedge		: VitalDelayType := 0.000 ns;
		tpw_PAD_negedge         : VitalDelayType := 0.000 ns;
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_PAD		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		PAD		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component IOPAD_TRI_U ------
 component IOPAD_TRI_U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpw_D_posedge	: VitalDelayType := 0.000 ns;
		tpw_D_negedge	: VitalDelayType := 0.000 ns;
		tpw_E_posedge	: VitalDelayType := 0.000 ns;
		tpw_E_negedge       : VitalDelayType := 0.000 ns;
		
                tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component IOPAD_TRI_D ------
 component IOPAD_TRI_D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpw_D_posedge	: VitalDelayType := 0.000 ns;
	        tpw_D_negedge   : VitalDelayType := 0.000 ns;
		tpw_E_posedge   : VitalDelayType := 0.000 ns;
                tpw_E_negedge 	: VitalDelayType := 0.000 ns;

                tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component IOPAD_BI_U ------
 component IOPAD_BI_U
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;

		tpw_D_posedge	    : VitalDelayType := 0.000 ns;
	        tpw_D_negedge       : VitalDelayType := 0.000 ns;
		tpw_E_posedge       : VitalDelayType := 0.000 ns;
                tpw_E_negedge 	    : VitalDelayType := 0.000 ns;
		tpw_PAD_posedge     : VitalDelayType := 0.000 ns;
                tpw_PAD_negedge     : VitalDelayType := 0.000 ns;

                tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tpd_PAD_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_D_Y			: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_Y			: VitalDelayType01 := (0.100 ns, 0.100 ns);

		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_PAD	: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: inout STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component IOPAD_BI_D ------
 component IOPAD_BI_D
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
	
		tpw_E_posedge       : VitalDelayType := 0.000 ns;
                tpw_E_negedge 	    : VitalDelayType := 0.000 ns;
		tpw_D_posedge       : VitalDelayType := 0.000 ns;
                tpw_D_negedge 	    : VitalDelayType := 0.000 ns;
		tpw_PAD_posedge     : VitalDelayType := 0.000 ns;
                tpw_PAD_negedge     : VitalDelayType := 0.000 ns;

        	tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
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


------ Component RCLKMUX ------
 component RCLKMUX
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
	   
                tpw_A_posedge   : VitalDelayType := 0.000 ns;
                tpw_A_negedge   : VitalDelayType := 0.000 ns;
         	tpd_A_Y		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tipd_A		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		A		: in    STD_ULOGIC;
		Y		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_HSTL_I ------
 component TRIBUFF_HSTL_I
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		
                tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_SSTL3_I ------
 component TRIBUFF_SSTL3_I
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_SSTL3_II ------
 component TRIBUFF_SSTL3_II
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_SSTL2_I ------
 component TRIBUFF_SSTL2_I
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;


------ Component TRIBUFF_SSTL2_II ------
 component TRIBUFF_SSTL2_II
    generic(
		TimingChecksOn:Boolean := True;
		Xon: Boolean := False;
		InstancePath: STRING :="*";
		MsgOn: Boolean := True;
		tpd_D_PAD		: VitalDelayType01 := (0.100 ns, 0.100 ns);
		tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
		tipd_D		: VitalDelayType01 := (0.000 ns, 0.000 ns);
		tipd_E		: VitalDelayType01 := (0.000 ns, 0.000 ns));


    port(
		D		: in    STD_ULOGIC;
		E		: in    STD_ULOGIC;
		PAD		: out    STD_ULOGIC);
 end component;

component BIOFIFO_BIDIRINFIFO 
  GENERIC (
        tipd_A       : VitalDelayType01 := (0.00 ns, 0.00 ns);
        tipd_D       : VitalDelayType01 := (0.00 ns, 0.00 ns);
        tipd_WENB       : VitalDelayType01 := (0.00 ns, 0.00 ns);
        tipd_WCLK     : VitalDelayType01 := (0.00 ns, 0.00 ns);
        tipd_RENB       : VitalDelayType01 := (0.00 ns, 0.00 ns);
        tipd_RCLK     : VitalDelayType01 := (0.00 ns, 0.00 ns);
        tipd_CLRB      : VitalDelayType01 := (0.00 ns, 0.00 ns);
        tpd_A_Y   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_Q   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLRB_Q    : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tsetup_D_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_D_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_D_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_D_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_negedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_RCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        thold_CLRB_WCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_WCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        tpw_RCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_RCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_CLRB_negedge     : VitalDelayType := 0.000 ns;
        TimingCheckOn : BOOLEAN := TRUE;
        InstancePath  : STRING := "*";
        Xon: Boolean := False;
        MsgOn: Boolean := True
        );
  PORT (
        A     : IN STD_ULOGIC ;
        D     : IN STD_ULOGIC ;
        WENB     : IN STD_ULOGIC ;
        WCLK   : IN STD_ULOGIC ;
        RENB     : IN STD_ULOGIC ;
        RCLK   : IN STD_ULOGIC ;
        CLRB    : IN STD_ULOGIC ;
        Q     : OUT STD_ULOGIC ;
        Y     : OUT STD_ULOGIC
        );

  
end component;


component BIOFIFO_BIDIROUTFIFO 
  GENERIC (
        tipd_A       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_D       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_CLRB      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tpd_A_Y   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_Q   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLRB_Q    : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tsetup_D_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_D_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_D_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_D_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_negedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_RCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        thold_CLRB_WCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_WCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        tpw_RCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_RCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_CLRB_negedge     : VitalDelayType := 0.000 ns;
        TimingCheckOn : BOOLEAN := TRUE;
        InstancePath  : STRING := "*";
        Xon: Boolean := False;
        MsgOn: Boolean := True
        );
  PORT (
        A     : IN STD_ULOGIC ;
        D     : IN STD_ULOGIC ;
        WENB     : IN STD_ULOGIC ;
        WCLK   : IN STD_ULOGIC ;
        RENB     : IN STD_ULOGIC ;
        RCLK   : IN STD_ULOGIC ;
        CLRB    : IN STD_ULOGIC ;
        Q     : OUT STD_ULOGIC ;
        Y     : OUT STD_ULOGIC
        );

  
end component;


component BIOFIFO_INFIFO 
  GENERIC (
        tipd_D       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_CLRB      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tpd_RCLK_Q   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLRB_Q    : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tsetup_D_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_D_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_D_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_D_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_negedge_posedge     :   VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_RCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        thold_CLRB_WCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_WCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        tpw_RCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_RCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_CLRB_negedge     : VitalDelayType := 0.000 ns;
        TimingCheckOn : BOOLEAN := TRUE;
        InstancePath  : STRING := "*";
        Xon: Boolean := False;
        MsgOn: Boolean := True
        );
  PORT (
        D     : IN STD_ULOGIC ;
        WENB     : IN STD_ULOGIC ;
        WCLK   : IN STD_ULOGIC ;
        RENB     : IN STD_ULOGIC ;
        RCLK   : IN STD_ULOGIC ;
        CLRB    : IN STD_ULOGIC ;
        Q     : OUT STD_ULOGIC
        );

  
end component;

component BIOFIFO_OUTFIFO 
  GENERIC (
        tipd_D       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_CLRB      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tpd_RCLK_Q   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLRB_Q    : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tsetup_D_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_D_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_D_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_D_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_negedge_posedge     :   VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_RCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        thold_CLRB_WCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_WCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        tpw_RCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_RCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_CLRB_negedge     : VitalDelayType := 0.000 ns;
        TimingCheckOn : BOOLEAN := TRUE;
        InstancePath  : STRING := "*";
        Xon: Boolean := False;
        MsgOn: Boolean := True
        );
  PORT (
        D     : IN STD_ULOGIC ;
        WENB     : IN STD_ULOGIC ;
        WCLK   : IN STD_ULOGIC ;
        RENB     : IN STD_ULOGIC ;
        RCLK   : IN STD_ULOGIC ;
        CLRB    : IN STD_ULOGIC ;
        Q     : OUT STD_ULOGIC
        );


end component;


component IOFIFO_BIDIRINFIFO 
  GENERIC (
        tipd_A       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_D       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_CLRB      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tpd_A_Y   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_Q   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLRB_Q    : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tsetup_D_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_D_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_D_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_D_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_negedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_RCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        thold_CLRB_WCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_WCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        tpw_RCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_RCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_CLRB_negedge     : VitalDelayType := 0.000 ns;
        TimingCheckOn : BOOLEAN := TRUE;
        InstancePath  : STRING := "*";
        Xon: Boolean := False;
        MsgOn: Boolean := True
        );
  PORT (
        A     : IN STD_ULOGIC ;
        D     : IN STD_ULOGIC ;
        WENB     : IN STD_ULOGIC ;
        WCLK   : IN STD_ULOGIC ;
        RENB     : IN STD_ULOGIC ;
        RCLK   : IN STD_ULOGIC ;
        CLRB    : IN STD_ULOGIC ;
        Q     : OUT STD_ULOGIC ;
        Y     : OUT STD_ULOGIC
        );


  
end component;


component IOFIFO_BIDIROUTFIFO 
  GENERIC (
        tipd_A       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_D       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_CLRB      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tpd_A_Y   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_Q   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLRB_Q    : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tsetup_D_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_D_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_D_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_D_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_negedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_RCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        thold_CLRB_WCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_WCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        tpw_RCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_RCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_CLRB_negedge     : VitalDelayType := 0.000 ns;
        TimingCheckOn : BOOLEAN := TRUE;
        InstancePath  : STRING := "*";
        Xon: Boolean := False;
        MsgOn: Boolean := True
        );
  PORT (
        A     : IN STD_ULOGIC ;
        D     : IN STD_ULOGIC ;
        WENB     : IN STD_ULOGIC ;
        WCLK   : IN STD_ULOGIC ;
        RENB     : IN STD_ULOGIC ;
        RCLK   : IN STD_ULOGIC ;
        CLRB    : IN STD_ULOGIC ;
        Q     : OUT STD_ULOGIC ;
        Y     : OUT STD_ULOGIC
        );

  
end component;


component IOFIFO_INFIFO 
  GENERIC (
        tipd_D       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_CLRB      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tpd_RCLK_Q   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLRB_Q    : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tsetup_D_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_D_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_D_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_D_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_negedge_posedge     :   VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_RCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        thold_CLRB_WCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_WCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        tpw_RCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_RCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_CLRB_negedge     : VitalDelayType := 0.000 ns;
        TimingCheckOn : BOOLEAN := TRUE;
        InstancePath  : STRING := "*";
        Xon: Boolean := False;
        MsgOn: Boolean := True
        );
  PORT (
        D     : IN STD_ULOGIC ;
        WENB     : IN STD_ULOGIC ;
        WCLK   : IN STD_ULOGIC ;
        RENB     : IN STD_ULOGIC ;
        RCLK   : IN STD_ULOGIC ;
        CLRB    : IN STD_ULOGIC ;
        Q     : OUT STD_ULOGIC
        );

  
end component;

component IOFIFO_OUTFIFO 
  GENERIC (
        tipd_D       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RENB       : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_CLRB      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tpd_RCLK_Q   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLRB_Q    : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tsetup_D_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_D_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_D_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_D_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RENB_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WENB_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RENB_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WENB_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_negedge_posedge     :   VitalDelayType := 0.000 ns;
        thold_CLRB_RCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_RCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        thold_CLRB_WCLK_posedge_posedge     :   VitalDelayType := 0.000 ns;
        trecovery_CLRB_WCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        tpw_RCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_RCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_CLRB_negedge     : VitalDelayType := 0.000 ns;
        TimingCheckOn : BOOLEAN := TRUE;
        InstancePath  : STRING := "*";
        Xon: Boolean := False;
        MsgOn: Boolean := True
        );
  PORT (
        D     : IN STD_ULOGIC ;
        WENB     : IN STD_ULOGIC ;
        WCLK   : IN STD_ULOGIC ;
        RENB     : IN STD_ULOGIC ;
        RCLK   : IN STD_ULOGIC ;
        CLRB    : IN STD_ULOGIC ;
        Q     : OUT STD_ULOGIC
        );

  
end component;

component IOPADP_IN
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      
      tpw_PAD_posedge 		: VitalDelayType := 0.000 ns;
      tpw_PAD_negedge           : VitalDelayType := 0.000 ns;
      tpw_N2PIN_posedge 	: VitalDelayType := 0.000 ns;
      tpw_N2PIN_negedge         : VitalDelayType := 0.000 ns;   

      tpd_PAD_Y                 :        VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_N2PIN_Y               :        VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_PAD         	     :        VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_N2PIN       	     :        VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      PAD                            :        in    STD_ULOGIC;
      N2PIN                          :        in    STD_ULOGIC;
      Y                              :        out   STD_ULOGIC);

end component;


component IOPADN_IN 
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      
      tpw_PAD_posedge 		: VitalDelayType := 0.000 ns;
      tpw_PAD_negedge           : VitalDelayType := 0.000 ns;
 
      tpd_PAD_N2POUT                 :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_PAD                       	     :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      PAD                            :	in    STD_ULOGIC;
      N2POUT                         :	out   STD_ULOGIC);

end component;

component IOPADP_TRI 
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpw_E_posedge           : VitalDelayType := 0.000 ns;
      tpw_E_negedge           : VitalDelayType := 0.000 ns;
      tpw_D_posedge           : VitalDelayType := 0.000 ns;
      tpw_D_negedge           : VitalDelayType := 0.000 ns;
      
      tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_D_PAD                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      PAD                            :	out   STD_ULOGIC);

end component;

component IOPADN_TRI 
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      
      tpw_DB_posedge 	    :   VitalDelayType := 0.000 ns;
      tpw_DB_negedge            :   VitalDelayType := 0.000 ns;
      tpw_E_posedge 		: VitalDelayType := 0.000 ns;
      tpw_E_negedge           : VitalDelayType := 0.000 ns;

      tpd_E_PAD : VitalDelayType01Z := (0.0 ns, 0.0 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_DB_PAD                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_DB                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      DB                             :	in    STD_ULOGIC;
      E                              :	in    STD_ULOGIC;
      PAD                            :	out   STD_ULOGIC);

end component;


component CLKBUF_LVDS 
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PADP_Y                    :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_PADN_Y                    :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_PADP                             :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PADN                             :  VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      PADP                           :  in    STD_ULOGIC;
      PADN                           :  in    STD_ULOGIC;
      Y                              :  out   STD_ULOGIC);

end component;

component CLKBUF_LVPECL 
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PADP_Y                    :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_PADN_Y                    :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_PADP                             :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PADN                             :  VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      PADP                           :  in    STD_ULOGIC;
      PADN                           :  in    STD_ULOGIC;
      Y                              :  out   STD_ULOGIC);

end component;

component HCLKBUF_LVDS 
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PADP_Y                    :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_PADN_Y                    :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_PADP                             :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PADN                             :  VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      PADP                           :  in    STD_ULOGIC;
      PADN                           :  in    STD_ULOGIC;
      Y                              :  out   STD_ULOGIC);

end component;

component HCLKBUF_LVPECL 
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PADP_Y                    :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_PADN_Y                    :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_PADP                             :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PADN                             :  VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      PADP                           :  in    STD_ULOGIC;
      PADN                           :  in    STD_ULOGIC;
      Y                              :  out   STD_ULOGIC);

end component;

component INBUF_LVDS 
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PADP_Y                    :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_PADN_Y                    :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_PADP                             :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PADN                             :  VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      PADP                           :  in    STD_ULOGIC;
      PADN                           :  in    STD_ULOGIC;
      Y                              :  out   STD_ULOGIC);

end component;

component INBUF_LVPECL 
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_PADP_Y                    :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_PADN_Y                    :  VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_PADP                             :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_PADN                             :  VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      PADP                           :  in    STD_ULOGIC;
      PADN                           :  in    STD_ULOGIC;
      Y                              :  out   STD_ULOGIC);

end component;

component OUTBUF_LVDS 
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_PADP                     :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D_PADN                     :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_D                                 :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      PADP                           :	out   STD_ULOGIC;
      PADN                           :	out   STD_ULOGIC);

end component;

component OUTBUF_LVPECL 
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_D_PADP                     :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D_PADN                     :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_D                         :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D                              :	in    STD_ULOGIC;
      PADP                           :	out   STD_ULOGIC;
      PADN                           :	out   STD_ULOGIC);

end component;


component CM8F
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;
      tpd_S11_Y                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S10_Y                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S01_Y                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S00_Y                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D3_Y                       :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D2_Y                       :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D1_Y                       :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D0_Y                       :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S11_FY                     :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S10_FY                     :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S01_FY                     :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_S00_FY                     :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D3_FY                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D2_FY                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D1_FY                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tpd_D0_FY                      :	VitalDelayType01 := (0.100 ns, 0.100 ns);
      tipd_D0                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D1                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D2                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D3                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S00                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S01                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S10                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_S11                       :	VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      D0                             :	in    STD_ULOGIC;
      D1                             :	in    STD_ULOGIC;
      D2                             :	in    STD_ULOGIC;
      D3                             :	in    STD_ULOGIC;
      S00                            :	in    STD_ULOGIC;
      S01                            :	in    STD_ULOGIC;
      S10                            :	in    STD_ULOGIC;
      S11                            :	in    STD_ULOGIC;
      FY                             :	out   STD_ULOGIC;
      Y                              :	out   STD_ULOGIC);
end component; 

component FIFO64K36 
  GENERIC (
        tipd_DEPTH3   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_DEPTH2   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_DEPTH1   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_DEPTH0   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WIDTH2   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WIDTH1   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WIDTH0   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL7   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL6   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL5   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL4   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL3   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL2   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL1   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL0   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL7   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL6   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL5   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL4   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL3   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL2   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL1   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL0   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_REN      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD35     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD34     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD33     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD32     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD31     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD30     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD29     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD28     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD27     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD26     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD25     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD24     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD23     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD22     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD21     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD20     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD19     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD18     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD17     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD16     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD15     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD14     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD13     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD12     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD11     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD10     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD9      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD8      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD7      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD6      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD5      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD4      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD3      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD2      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD1      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD0      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WEN      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_CLR      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tpd_RCLK_RD0  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD1  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD2  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD3  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD4  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD5  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD6  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD7  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD8  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD9  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD10 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD11 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD12 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD13 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD14 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD15 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD16 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD17 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD18 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD19 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD20 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD21 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD22 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD23 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD24 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD25 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD26 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD27 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD28 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD29 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD30 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD31 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD32 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD33 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD34 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD35 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_FULL   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_AFULL  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_EMPTY  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_AEMPTY : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLR_FULL   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLR_AFULL  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLR_EMPTY  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLR_AEMPTY : VitalDelayType01 := (0.100 ns, 0.100 ns);


        tsetup_WD35_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD34_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD33_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD32_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD31_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD30_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD29_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD28_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD27_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD26_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD25_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD24_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD23_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD22_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD21_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD20_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD19_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD18_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD17_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD16_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD15_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD14_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD13_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD12_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD11_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD10_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD9_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD8_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD7_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD6_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD5_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD4_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD3_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD2_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD1_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD0_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD35_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD34_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD33_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD32_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD31_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD30_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD29_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD28_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD27_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD26_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD25_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD24_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD23_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD22_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD21_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD20_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD19_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD18_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD17_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD16_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD15_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD14_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD13_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD12_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD11_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD10_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD9_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD8_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD7_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD6_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD5_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD4_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD3_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD2_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD1_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD0_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;

        tsetup_WEN_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        tsetup_WEN_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        tsetup_DEPTH3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        tsetup_WIDTH2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_AEVAL7_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL6_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL5_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL4_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL7_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL6_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL5_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL4_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_AFVAL7_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL6_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL5_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL4_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL7_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL6_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL5_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL4_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_DEPTH3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        tsetup_WIDTH2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        tsetup_AEVAL7_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL6_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL5_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL4_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL7_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL6_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL5_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL4_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_AFVAL7_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL6_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL5_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL4_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL7_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL6_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL5_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL4_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_REN_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        tsetup_REN_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        thold_WD35_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD34_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD33_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD32_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD31_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD30_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD29_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD28_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD27_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD26_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD25_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD24_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD23_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD22_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD21_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD20_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD19_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD18_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD17_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD16_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD15_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD14_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD13_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD12_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD11_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD10_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD9_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD8_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD7_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD6_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD5_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD4_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD3_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD2_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD1_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD0_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD35_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD34_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD33_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD32_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD31_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD30_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD29_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD28_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD27_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD26_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD25_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD24_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD23_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD22_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD21_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD20_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD19_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD18_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD17_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD16_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD15_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD14_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD13_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD12_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD11_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD10_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD9_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD8_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD7_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD6_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD5_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD4_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD3_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD2_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD1_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD0_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;


        thold_WEN_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WEN_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        thold_DEPTH3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        thold_WIDTH2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        thold_AEVAL7_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL6_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL5_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL4_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL7_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL6_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL5_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL4_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        thold_AFVAL7_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL6_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL5_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL4_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL7_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL6_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL5_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL4_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;



        thold_DEPTH3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        thold_WIDTH2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        thold_AEVAL7_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL6_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL5_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL4_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL7_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL6_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL5_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL4_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        thold_AFVAL7_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL6_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL5_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL4_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL7_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL6_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL5_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL4_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        thold_REN_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_REN_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        trecovery_CLR_RCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        thold_CLR_RCLK_posedge_posedge      :  VitalDelayType := 0.000 ns;

        trecovery_CLR_WCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        thold_CLR_WCLK_posedge_posedge      :  VitalDelayType := 0.000 ns;
        tpw_RCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_RCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_CLR_negedge     : VitalDelayType := 0.000 ns;
        TimingCheckOn : BOOLEAN := TRUE;
        InstancePath  : STRING := "*";
        Xon: Boolean := False;
        MsgOn: Boolean := True
        );
  PORT (
        DEPTH3 : IN STD_ULOGIC ;
        DEPTH2 : IN STD_ULOGIC ;
        DEPTH1 : IN STD_ULOGIC ;
        DEPTH0 : IN STD_ULOGIC ;
        WIDTH2 : IN STD_ULOGIC ;
        WIDTH1 : IN STD_ULOGIC ;
        WIDTH0 : IN STD_ULOGIC ;
        AEVAL7 : IN STD_ULOGIC ;
        AEVAL6 : IN STD_ULOGIC ;
        AEVAL5 : IN STD_ULOGIC ;
        AEVAL4 : IN STD_ULOGIC ;
        AEVAL3 : IN STD_ULOGIC ;
        AEVAL2 : IN STD_ULOGIC ;
        AEVAL1 : IN STD_ULOGIC ;
        AEVAL0 : IN STD_ULOGIC ;
        AFVAL7 : IN STD_ULOGIC ;
        AFVAL6 : IN STD_ULOGIC ;
        AFVAL5 : IN STD_ULOGIC ;
        AFVAL4 : IN STD_ULOGIC ;
        AFVAL3 : IN STD_ULOGIC ;
        AFVAL2 : IN STD_ULOGIC ;
        AFVAL1 : IN STD_ULOGIC ;
        AFVAL0 : IN STD_ULOGIC ;
        REN    : IN STD_ULOGIC ;
        RCLK   : IN STD_ULOGIC ;
        WD35   : IN STD_ULOGIC ;
        WD34   : IN STD_ULOGIC ;
        WD33   : IN STD_ULOGIC ;
        WD32   : IN STD_ULOGIC ;
        WD31   : IN STD_ULOGIC ;
        WD30   : IN STD_ULOGIC ;
        WD29   : IN STD_ULOGIC ;
        WD28   : IN STD_ULOGIC ;
        WD27   : IN STD_ULOGIC ;
        WD26   : IN STD_ULOGIC ;
        WD25   : IN STD_ULOGIC ;
        WD24   : IN STD_ULOGIC ;
        WD23   : IN STD_ULOGIC ;
        WD22   : IN STD_ULOGIC ;
        WD21   : IN STD_ULOGIC ;
        WD20   : IN STD_ULOGIC ;
        WD19   : IN STD_ULOGIC ;
        WD18   : IN STD_ULOGIC ;
        WD17   : IN STD_ULOGIC ;
        WD16   : IN STD_ULOGIC ;
        WD15   : IN STD_ULOGIC ;
        WD14   : IN STD_ULOGIC ;
        WD13   : IN STD_ULOGIC ;
        WD12   : IN STD_ULOGIC ;
        WD11   : IN STD_ULOGIC ;
        WD10   : IN STD_ULOGIC ;
        WD9    : IN STD_ULOGIC ;
        WD8    : IN STD_ULOGIC ;
        WD7    : IN STD_ULOGIC ;
        WD6    : IN STD_ULOGIC ;
        WD5    : IN STD_ULOGIC ;
        WD4    : IN STD_ULOGIC ;
        WD3    : IN STD_ULOGIC ;
        WD2    : IN STD_ULOGIC ;
        WD1    : IN STD_ULOGIC ;
        WD0    : IN STD_ULOGIC ;
        WEN    : IN STD_ULOGIC ;
        WCLK   : IN STD_ULOGIC ;
        CLR    : IN STD_ULOGIC ;
        RD35   : OUT STD_ULOGIC ;
        RD34   : OUT STD_ULOGIC ;
        RD33   : OUT STD_ULOGIC ;
        RD32   : OUT STD_ULOGIC ;
        RD31   : OUT STD_ULOGIC ;
        RD30   : OUT STD_ULOGIC ;
        RD29   : OUT STD_ULOGIC ;
        RD28   : OUT STD_ULOGIC ;
        RD27   : OUT STD_ULOGIC ;
        RD26   : OUT STD_ULOGIC ;
        RD25   : OUT STD_ULOGIC ;
        RD24   : OUT STD_ULOGIC ;
        RD23   : OUT STD_ULOGIC ;
        RD22   : OUT STD_ULOGIC ;
        RD21   : OUT STD_ULOGIC ;
        RD20   : OUT STD_ULOGIC ;
        RD19   : OUT STD_ULOGIC ;
        RD18   : OUT STD_ULOGIC ;
        RD17   : OUT STD_ULOGIC ;
        RD16   : OUT STD_ULOGIC ;
        RD15   : OUT STD_ULOGIC ;
        RD14   : OUT STD_ULOGIC ;
        RD13   : OUT STD_ULOGIC ;
        RD12   : OUT STD_ULOGIC ;
        RD11   : OUT STD_ULOGIC ;
        RD10   : OUT STD_ULOGIC ;
        RD9    : OUT STD_ULOGIC ;
        RD8    : OUT STD_ULOGIC ;
        RD7    : OUT STD_ULOGIC ;
        RD6    : OUT STD_ULOGIC ;
        RD5    : OUT STD_ULOGIC ;
        RD4    : OUT STD_ULOGIC ;
        RD3    : OUT STD_ULOGIC ;
        RD2    : OUT STD_ULOGIC ;
        RD1    : OUT STD_ULOGIC ;
        RD0    : OUT STD_ULOGIC ;
        FULL   : OUT STD_ULOGIC ;
        AFULL  : OUT STD_ULOGIC ;
        EMPTY  : OUT STD_ULOGIC ;
        AEMPTY : OUT STD_ULOGIC
        );


  
end component;

component FIFO64K36P
  GENERIC (
        tipd_DEPTH3   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_DEPTH2   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_DEPTH1   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_DEPTH0   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WIDTH2   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WIDTH1   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WIDTH0   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL7   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL6   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL5   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL4   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL3   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL2   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL1   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AEVAL0   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL7   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL6   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL5   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL4   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL3   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL2   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL1   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_AFVAL0   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_REN      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD35     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD34     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD33     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD32     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD31     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD30     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD29     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD28     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD27     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD26     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD25     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD24     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD23     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD22     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD21     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD20     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD19     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD18     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD17     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD16     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD15     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD14     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD13     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD12     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD11     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD10     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD9      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD8      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD7      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD6      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD5      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD4      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD3      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD2      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD1      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD0      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WEN      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_CLR      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tpd_RCLK_RD0  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD1  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD2  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD3  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD4  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD5  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD6  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD7  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD8  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD9  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD10 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD11 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD12 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD13 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD14 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD15 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD16 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD17 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD18 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD19 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD20 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD21 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD22 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD23 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD24 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD25 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD26 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD27 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD28 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD29 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD30 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD31 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD32 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD33 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD34 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD35 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_FULL   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_AFULL  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_EMPTY  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_AEMPTY : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLR_FULL   : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLR_AFULL  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLR_EMPTY  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_CLR_AEMPTY : VitalDelayType01 := (0.100 ns, 0.100 ns);


        tsetup_WD35_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD34_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD33_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD32_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD31_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD30_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD29_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD28_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD27_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD26_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD25_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD24_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD23_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD22_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD21_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD20_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD19_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD18_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD17_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD16_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD15_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD14_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD13_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD12_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD11_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD10_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD9_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD8_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD7_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD6_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD5_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD4_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD3_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD2_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD1_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD0_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD35_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD34_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD33_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD32_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD31_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD30_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD29_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD28_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD27_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD26_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD25_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD24_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD23_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD22_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD21_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD20_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD19_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD18_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD17_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD16_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD15_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD14_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD13_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD12_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD11_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD10_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD9_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD8_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD7_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD6_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD5_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD4_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD3_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD2_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD1_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD0_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;

        tsetup_WEN_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        tsetup_WEN_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        tsetup_DEPTH3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        tsetup_WIDTH2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_AEVAL7_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL6_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL5_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL4_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL7_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL6_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL5_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL4_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_AFVAL7_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL6_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL5_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL4_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL7_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL6_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL5_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL4_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_DEPTH3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_DEPTH0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        tsetup_WIDTH2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WIDTH0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        tsetup_AEVAL7_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL6_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL5_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL4_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL7_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL6_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL5_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL4_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AEVAL0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_AFVAL7_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL6_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL5_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL4_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL7_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL6_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL5_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL4_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_AFVAL0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_REN_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        tsetup_REN_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        thold_WD35_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD34_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD33_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD32_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD31_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD30_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD29_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD28_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD27_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD26_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD25_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD24_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD23_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD22_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD21_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD20_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD19_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD18_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD17_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD16_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD15_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD14_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD13_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD12_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD11_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD10_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD9_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD8_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD7_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD6_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD5_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD4_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD3_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD2_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD1_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD0_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD35_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD34_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD33_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD32_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD31_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD30_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD29_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD28_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD27_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD26_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD25_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD24_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD23_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD22_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD21_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD20_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD19_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD18_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD17_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD16_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD15_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD14_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD13_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD12_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD11_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD10_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD9_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD8_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD7_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD6_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD5_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD4_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD3_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD2_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD1_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD0_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;


        thold_WEN_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WEN_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        thold_DEPTH3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        thold_WIDTH2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        thold_AEVAL7_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL6_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL5_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL4_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL7_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL6_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL5_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL4_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        thold_AFVAL7_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL6_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL5_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL4_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL7_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL6_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL5_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL4_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;



        thold_DEPTH3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        thold_WIDTH2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WIDTH0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        thold_AEVAL7_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL6_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL5_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL4_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL7_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL6_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL5_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL4_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AEVAL0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        thold_AFVAL7_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL6_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL5_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL4_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL7_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL6_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL5_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL4_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_AFVAL0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        thold_REN_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_REN_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        trecovery_CLR_RCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        thold_CLR_RCLK_posedge_posedge      :  VitalDelayType := 0.000 ns;

        trecovery_CLR_WCLK_posedge_posedge :  VitalDelayType := 0.000 ns;
        thold_CLR_WCLK_posedge_posedge      :  VitalDelayType := 0.000 ns;
        tpw_RCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_RCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_CLR_negedge     : VitalDelayType := 0.000 ns;
        TimingCheckOn : BOOLEAN := TRUE;
        InstancePath  : STRING := "*";
        Xon: Boolean := False;
        MsgOn: Boolean := True
        );
  PORT (
        DEPTH3 : IN STD_ULOGIC ;
        DEPTH2 : IN STD_ULOGIC ;
        DEPTH1 : IN STD_ULOGIC ;
        DEPTH0 : IN STD_ULOGIC ;
        WIDTH2 : IN STD_ULOGIC ;
        WIDTH1 : IN STD_ULOGIC ;
        WIDTH0 : IN STD_ULOGIC ;
        AEVAL7 : IN STD_ULOGIC ;
        AEVAL6 : IN STD_ULOGIC ;
        AEVAL5 : IN STD_ULOGIC ;
        AEVAL4 : IN STD_ULOGIC ;
        AEVAL3 : IN STD_ULOGIC ;
        AEVAL2 : IN STD_ULOGIC ;
        AEVAL1 : IN STD_ULOGIC ;
        AEVAL0 : IN STD_ULOGIC ;
        AFVAL7 : IN STD_ULOGIC ;
        AFVAL6 : IN STD_ULOGIC ;
        AFVAL5 : IN STD_ULOGIC ;
        AFVAL4 : IN STD_ULOGIC ;
        AFVAL3 : IN STD_ULOGIC ;
        AFVAL2 : IN STD_ULOGIC ;
        AFVAL1 : IN STD_ULOGIC ;
        AFVAL0 : IN STD_ULOGIC ;
        REN    : IN STD_ULOGIC ;
        RCLK   : IN STD_ULOGIC ;
        WD35   : IN STD_ULOGIC ;
        WD34   : IN STD_ULOGIC ;
        WD33   : IN STD_ULOGIC ;
        WD32   : IN STD_ULOGIC ;
        WD31   : IN STD_ULOGIC ;
        WD30   : IN STD_ULOGIC ;
        WD29   : IN STD_ULOGIC ;
        WD28   : IN STD_ULOGIC ;
        WD27   : IN STD_ULOGIC ;
        WD26   : IN STD_ULOGIC ;
        WD25   : IN STD_ULOGIC ;
        WD24   : IN STD_ULOGIC ;
        WD23   : IN STD_ULOGIC ;
        WD22   : IN STD_ULOGIC ;
        WD21   : IN STD_ULOGIC ;
        WD20   : IN STD_ULOGIC ;
        WD19   : IN STD_ULOGIC ;
        WD18   : IN STD_ULOGIC ;
        WD17   : IN STD_ULOGIC ;
        WD16   : IN STD_ULOGIC ;
        WD15   : IN STD_ULOGIC ;
        WD14   : IN STD_ULOGIC ;
        WD13   : IN STD_ULOGIC ;
        WD12   : IN STD_ULOGIC ;
        WD11   : IN STD_ULOGIC ;
        WD10   : IN STD_ULOGIC ;
        WD9    : IN STD_ULOGIC ;
        WD8    : IN STD_ULOGIC ;
        WD7    : IN STD_ULOGIC ;
        WD6    : IN STD_ULOGIC ;
        WD5    : IN STD_ULOGIC ;
        WD4    : IN STD_ULOGIC ;
        WD3    : IN STD_ULOGIC ;
        WD2    : IN STD_ULOGIC ;
        WD1    : IN STD_ULOGIC ;
        WD0    : IN STD_ULOGIC ;
        WEN    : IN STD_ULOGIC ;
        WCLK   : IN STD_ULOGIC ;
        CLR    : IN STD_ULOGIC ;
        RD35   : OUT STD_ULOGIC ;
        RD34   : OUT STD_ULOGIC ;
        RD33   : OUT STD_ULOGIC ;
        RD32   : OUT STD_ULOGIC ;
        RD31   : OUT STD_ULOGIC ;
        RD30   : OUT STD_ULOGIC ;
        RD29   : OUT STD_ULOGIC ;
        RD28   : OUT STD_ULOGIC ;
        RD27   : OUT STD_ULOGIC ;
        RD26   : OUT STD_ULOGIC ;
        RD25   : OUT STD_ULOGIC ;
        RD24   : OUT STD_ULOGIC ;
        RD23   : OUT STD_ULOGIC ;
        RD22   : OUT STD_ULOGIC ;
        RD21   : OUT STD_ULOGIC ;
        RD20   : OUT STD_ULOGIC ;
        RD19   : OUT STD_ULOGIC ;
        RD18   : OUT STD_ULOGIC ;
        RD17   : OUT STD_ULOGIC ;
        RD16   : OUT STD_ULOGIC ;
        RD15   : OUT STD_ULOGIC ;
        RD14   : OUT STD_ULOGIC ;
        RD13   : OUT STD_ULOGIC ;
        RD12   : OUT STD_ULOGIC ;
        RD11   : OUT STD_ULOGIC ;
        RD10   : OUT STD_ULOGIC ;
        RD9    : OUT STD_ULOGIC ;
        RD8    : OUT STD_ULOGIC ;
        RD7    : OUT STD_ULOGIC ;
        RD6    : OUT STD_ULOGIC ;
        RD5    : OUT STD_ULOGIC ;
        RD4    : OUT STD_ULOGIC ;
        RD3    : OUT STD_ULOGIC ;
        RD2    : OUT STD_ULOGIC ;
        RD1    : OUT STD_ULOGIC ;
        RD0    : OUT STD_ULOGIC ;
        FULL   : OUT STD_ULOGIC ;
        AFULL  : OUT STD_ULOGIC ;
        EMPTY  : OUT STD_ULOGIC ;
        AEMPTY : OUT STD_ULOGIC
        );


  
end component;

component RAM64K36 
  GENERIC (
        TimingCheckOn   : Boolean := True;
        InstancePath    : String  := "*";
        Xon             : Boolean := False;
        MsgOn           : Boolean := True;
        MEMORYFILE      : String  := "";

        tipd_DEPTH3   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_DEPTH2   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_DEPTH1   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_DEPTH0   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD15   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD14   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD13   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD12   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD11   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD10   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD9    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD8    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD7    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD6    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD5    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD4    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD3    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD2    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD1    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD0    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD35     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD34     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD33     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD32     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD31     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD30     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD29     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD28     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD27     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD26     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD25     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD24     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD23     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD22     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD21     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD20     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD19     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD18     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD17     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD16     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD15     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD14     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD13     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD12     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD11     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD10     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD9      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD8      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD7      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD6      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD5      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD4      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD3      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD2      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD1      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD0      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WW2      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WW1      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WW0      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WEN      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD15   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD14   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD13   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD12   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD11   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD10   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD9    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD8    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD7    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD6    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD5    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD4    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD3    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD2    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD1    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD0    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RW2      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RW1      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RW0      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_REN      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);


        tpd_RCLK_RD0  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD1  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD2  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD3  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD4  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD5  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD6  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD7  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD8  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD9  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD10 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD11 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD12 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD13 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD14 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD15 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD16 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD17 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD18 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD19 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD20 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD21 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD22 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD23 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD24 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD25 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD26 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD27 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD28 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD29 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD30 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD31 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD32 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD33 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD34 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD35 : VitalDelayType01 := (0.100 ns, 0.100 ns);


        tsetup_RDAD15_RCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD14_RCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD13_RCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD12_RCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD11_RCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD10_RCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD9_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD8_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD7_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD6_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD5_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD4_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_RDAD15_RCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD14_RCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD13_RCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD12_RCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD11_RCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD10_RCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD9_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD8_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD7_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD6_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD5_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD4_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        tsetup_RW2_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RW1_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RW0_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RW2_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RW1_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RW0_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;


        tsetup_DEPTH3_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH2_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH1_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH0_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH3_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH2_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH1_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH0_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;



        tsetup_WRAD15_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD14_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD13_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD12_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD11_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD10_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD9_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD8_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD7_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD6_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD5_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD4_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_WRAD15_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD14_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD13_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD12_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD11_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD10_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD9_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD8_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD7_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD6_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD5_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD4_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_WD35_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD34_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD33_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD32_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD31_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD30_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD29_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD28_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD27_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD26_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD25_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD24_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD23_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD22_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD21_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD20_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD19_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD18_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD17_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD16_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD15_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD14_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD13_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD12_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD11_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD10_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD9_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD8_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD7_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD6_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD5_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD4_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD3_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD2_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD1_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD0_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD35_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD34_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD33_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD32_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD31_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD30_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD29_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD28_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD27_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD26_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD25_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD24_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD23_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD22_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD21_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD20_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD19_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD18_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD17_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD16_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD15_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD14_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD13_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD12_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD11_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD10_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD9_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD8_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD7_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD6_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD5_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD4_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD3_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD2_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD1_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD0_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;


        tsetup_WW2_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WW1_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WW0_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WW2_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WW1_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WW0_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;


        thold_RDAD15_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD14_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD13_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD12_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD11_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD10_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD9_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD8_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD7_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD6_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD5_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD4_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD3_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD2_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD1_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD0_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;

        thold_RDAD15_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD14_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD13_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD12_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD11_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD10_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD9_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD8_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD7_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD6_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD5_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD4_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD3_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD2_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD1_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD0_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;



        thold_RW2_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RW1_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RW0_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RW2_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RW1_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RW0_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        thold_DEPTH3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;

        thold_WRAD15_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD14_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD13_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD12_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD11_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD10_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD9_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD8_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD7_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD6_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD5_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD4_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;

        thold_WRAD15_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD14_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD13_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD12_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD11_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD10_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD9_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD8_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD7_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD6_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD5_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD4_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        thold_WD35_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD34_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD33_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD32_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD31_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD30_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD29_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD28_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD27_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD26_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD25_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD24_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD23_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD22_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD21_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD20_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD19_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD18_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD17_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD16_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD15_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD14_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD13_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD12_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD11_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD10_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD9_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD8_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD7_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD6_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD5_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD4_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD3_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD2_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD1_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD0_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD35_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD34_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD33_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD32_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD31_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD30_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD29_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD28_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD27_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD26_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD25_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD24_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD23_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD22_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD21_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD20_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD19_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD18_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD17_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD16_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD15_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD14_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD13_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD12_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD11_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD10_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD9_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD8_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD7_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD6_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD5_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD4_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD3_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD2_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD1_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD0_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;


        thold_WW2_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WW1_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WW0_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WW2_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WW1_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WW0_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        tsetup_REN_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WEN_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_REN_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WEN_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        tsetup_REN_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WEN_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_REN_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WEN_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        tpw_RCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_RCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_negedge    : VitalDelayType := 0.000 ns

        );
  PORT (
        DEPTH3 : IN STD_ULOGIC ;
        DEPTH2 : IN STD_ULOGIC ;
        DEPTH1 : IN STD_ULOGIC ;
        DEPTH0 : IN STD_ULOGIC ;
        WRAD15 : IN STD_ULOGIC ;
        WRAD14 : IN STD_ULOGIC ;
        WRAD13 : IN STD_ULOGIC ;
        WRAD12 : IN STD_ULOGIC ;
        WRAD11 : IN STD_ULOGIC ;
        WRAD10 : IN STD_ULOGIC ;
        WRAD9  : IN STD_ULOGIC ;
        WRAD8  : IN STD_ULOGIC ;
        WRAD7  : IN STD_ULOGIC ;
        WRAD6  : IN STD_ULOGIC ;
        WRAD5  : IN STD_ULOGIC ;
        WRAD4  : IN STD_ULOGIC ;
        WRAD3  : IN STD_ULOGIC ;
        WRAD2  : IN STD_ULOGIC ;
        WRAD1  : IN STD_ULOGIC ;
        WRAD0  : IN STD_ULOGIC ;
        WD35   : IN STD_ULOGIC ;
        WD34   : IN STD_ULOGIC ;
        WD33   : IN STD_ULOGIC ;
        WD32   : IN STD_ULOGIC ;
        WD31   : IN STD_ULOGIC ;
        WD30   : IN STD_ULOGIC ;
        WD29   : IN STD_ULOGIC ;
        WD28   : IN STD_ULOGIC ;
        WD27   : IN STD_ULOGIC ;
        WD26   : IN STD_ULOGIC ;
        WD25   : IN STD_ULOGIC ;
        WD24   : IN STD_ULOGIC ;
        WD23   : IN STD_ULOGIC ;
        WD22   : IN STD_ULOGIC ;
        WD21   : IN STD_ULOGIC ;
        WD20   : IN STD_ULOGIC ;
        WD19   : IN STD_ULOGIC ;
        WD18   : IN STD_ULOGIC ;
        WD17   : IN STD_ULOGIC ;
        WD16   : IN STD_ULOGIC ;
        WD15   : IN STD_ULOGIC ;
        WD14   : IN STD_ULOGIC ;
        WD13   : IN STD_ULOGIC ;
        WD12   : IN STD_ULOGIC ;
        WD11   : IN STD_ULOGIC ;
        WD10   : IN STD_ULOGIC ;
        WD9    : IN STD_ULOGIC ;
        WD8    : IN STD_ULOGIC ;
        WD7    : IN STD_ULOGIC ;
        WD6    : IN STD_ULOGIC ;
        WD5    : IN STD_ULOGIC ;
        WD4    : IN STD_ULOGIC ;
        WD3    : IN STD_ULOGIC ;
        WD2    : IN STD_ULOGIC ;
        WD1    : IN STD_ULOGIC ;
        WD0    : IN STD_ULOGIC ;
        WW2    : IN STD_ULOGIC ;
        WW1    : IN STD_ULOGIC ;
        WW0    : IN STD_ULOGIC ;
        WEN    : IN STD_ULOGIC ;
        WCLK   : IN STD_ULOGIC ;
        RDAD15 : IN STD_ULOGIC ;
        RDAD14 : IN STD_ULOGIC ;
        RDAD13 : IN STD_ULOGIC ;
        RDAD12 : IN STD_ULOGIC ;
        RDAD11 : IN STD_ULOGIC ;
        RDAD10 : IN STD_ULOGIC ;
        RDAD9  : IN STD_ULOGIC ;
        RDAD8  : IN STD_ULOGIC ;
        RDAD7  : IN STD_ULOGIC ;
        RDAD6  : IN STD_ULOGIC ;
        RDAD5  : IN STD_ULOGIC ;
        RDAD4  : IN STD_ULOGIC ;
        RDAD3  : IN STD_ULOGIC ;
        RDAD2  : IN STD_ULOGIC ;
        RDAD1  : IN STD_ULOGIC ;
        RDAD0  : IN STD_ULOGIC ;
        RW2    : IN STD_ULOGIC ;
        RW1    : IN STD_ULOGIC ;
        RW0    : IN STD_ULOGIC ;
        REN    : IN STD_ULOGIC ;
        RCLK   : IN STD_ULOGIC ;
        RD35   : OUT STD_ULOGIC ;
        RD34   : OUT STD_ULOGIC ;
        RD33   : OUT STD_ULOGIC ;
        RD32   : OUT STD_ULOGIC ;
        RD31   : OUT STD_ULOGIC ;
        RD30   : OUT STD_ULOGIC ;
        RD29   : OUT STD_ULOGIC ;
        RD28   : OUT STD_ULOGIC ;
        RD27   : OUT STD_ULOGIC ;
        RD26   : OUT STD_ULOGIC ;
        RD25   : OUT STD_ULOGIC ;
        RD24   : OUT STD_ULOGIC ;
        RD23   : OUT STD_ULOGIC ;
        RD22   : OUT STD_ULOGIC ;
        RD21   : OUT STD_ULOGIC ;
        RD20   : OUT STD_ULOGIC ;
        RD19   : OUT STD_ULOGIC ;
        RD18   : OUT STD_ULOGIC ;
        RD17   : OUT STD_ULOGIC ;
        RD16   : OUT STD_ULOGIC ;
        RD15   : OUT STD_ULOGIC ;
        RD14   : OUT STD_ULOGIC ;
        RD13   : OUT STD_ULOGIC ;
        RD12   : OUT STD_ULOGIC ;
        RD11   : OUT STD_ULOGIC ;
        RD10   : OUT STD_ULOGIC ;
        RD9    : OUT STD_ULOGIC ;
        RD8    : OUT STD_ULOGIC ;
        RD7    : OUT STD_ULOGIC ;
        RD6    : OUT STD_ULOGIC ;
        RD5    : OUT STD_ULOGIC ;
        RD4    : OUT STD_ULOGIC ;
        RD3    : OUT STD_ULOGIC ;
        RD2    : OUT STD_ULOGIC ;
        RD1    : OUT STD_ULOGIC ;
        RD0    : OUT STD_ULOGIC
        );


end component;


component RAM64K36P 
  GENERIC (
        TimingCheckOn   : Boolean := True;
        InstancePath    : String  := "*";
        Xon             : Boolean := False;
        MsgOn           : Boolean := True;
        MEMORYFILE      : String  := "";

        tipd_DEPTH3   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_DEPTH2   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_DEPTH1   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_DEPTH0   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD15   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD14   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD13   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD12   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD11   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD10   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD9    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD8    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD7    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD6    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD5    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD4    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD3    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD2    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD1    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WRAD0    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD35     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD34     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD33     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD32     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD31     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD30     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD29     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD28     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD27     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD26     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD25     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD24     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD23     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD22     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD21     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD20     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD19     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD18     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD17     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD16     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD15     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD14     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD13     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD12     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD11     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD10     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD9      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD8      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD7      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD6      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD5      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD4      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD3      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD2      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD1      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WD0      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WW2      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WW1      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WW0      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WEN      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_WCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD15   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD14   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD13   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD12   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD11   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD10   : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD9    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD8    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD7    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD6    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD5    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD4    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD3    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD2    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD1    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RDAD0    : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RW2      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RW1      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RW0      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_REN      : VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_RCLK     : VitalDelayType01 := (0.000 ns, 0.000 ns);


        tpd_RCLK_RD0  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD1  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD2  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD3  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD4  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD5  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD6  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD7  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD8  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD9  : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD10 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD11 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD12 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD13 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD14 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD15 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD16 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD17 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD18 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD19 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD20 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD21 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD22 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD23 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD24 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD25 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD26 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD27 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD28 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD29 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD30 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD31 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD32 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD33 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD34 : VitalDelayType01 := (0.100 ns, 0.100 ns);
        tpd_RCLK_RD35 : VitalDelayType01 := (0.100 ns, 0.100 ns);


        tsetup_RDAD15_RCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD14_RCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD13_RCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD12_RCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD11_RCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD10_RCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD9_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD8_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD7_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD6_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD5_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD4_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD3_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD2_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD1_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD0_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_RDAD15_RCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD14_RCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD13_RCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD12_RCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD11_RCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD10_RCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_RDAD9_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD8_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD7_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD6_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD5_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD4_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD3_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD2_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD1_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_RDAD0_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;



        tsetup_RW2_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RW1_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RW0_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RW2_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RW1_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_RW0_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;


        tsetup_DEPTH3_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH2_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH1_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH0_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH3_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH2_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH1_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_DEPTH0_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;



        tsetup_WRAD15_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD14_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD13_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD12_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD11_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD10_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD9_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD8_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD7_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD6_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD5_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD4_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;

        tsetup_WRAD15_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD14_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD13_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD12_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD11_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD10_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        tsetup_WRAD9_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD8_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD7_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD6_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD5_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD4_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        tsetup_WRAD0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        tsetup_WD35_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD34_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD33_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD32_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD31_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD30_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD29_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD28_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD27_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD26_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD25_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD24_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD23_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD22_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD21_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD20_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD19_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD18_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD17_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD16_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD15_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD14_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD13_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD12_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD11_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD10_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD9_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD8_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD7_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD6_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD5_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD4_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD3_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD2_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD1_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD0_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD35_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD34_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD33_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD32_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD31_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD30_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD29_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD28_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD27_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD26_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD25_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD24_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD23_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD22_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD21_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD20_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD19_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD18_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD17_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD16_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD15_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD14_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD13_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD12_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD11_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD10_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        tsetup_WD9_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD8_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD7_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD6_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD5_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD4_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD3_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD2_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD1_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WD0_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;



        tsetup_WW2_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WW1_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WW0_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WW2_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WW1_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WW0_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;


        thold_RDAD15_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD14_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD13_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD12_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD11_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD10_RCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD9_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD8_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD7_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD6_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD5_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD4_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD3_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD2_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD1_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD0_RCLK_posedge_posedge    : VitalDelayType := 0.000 ns;

        thold_RDAD15_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD14_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD13_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD12_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD11_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD10_RCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_RDAD9_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD8_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD7_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD6_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD5_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD4_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD3_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD2_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD1_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_RDAD0_RCLK_negedge_posedge    : VitalDelayType := 0.000 ns;

        thold_RW2_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RW1_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RW0_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RW2_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RW1_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_RW0_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        thold_DEPTH3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_DEPTH0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        thold_WRAD15_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD14_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD13_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD12_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD11_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD10_WCLK_posedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD9_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD8_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD7_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD6_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD5_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD4_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD3_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD2_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD1_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD0_WCLK_posedge_posedge   : VitalDelayType := 0.000 ns;

        thold_WRAD15_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD14_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD13_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD12_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD11_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD10_WCLK_negedge_posedge  : VitalDelayType := 0.000 ns;
        thold_WRAD9_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD8_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD7_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD6_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD5_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD4_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD3_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD2_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD1_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;
        thold_WRAD0_WCLK_negedge_posedge   : VitalDelayType := 0.000 ns;


        thold_WD35_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD34_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD33_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD32_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD31_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD30_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD29_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD28_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD27_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD26_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD25_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD24_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD23_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD22_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD21_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD20_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD19_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD18_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD17_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD16_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD15_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD14_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD13_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD12_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD11_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD10_WCLK_posedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD9_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD8_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD7_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD6_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD5_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD4_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD3_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD2_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD1_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD0_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD35_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD34_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD33_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD32_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD31_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD30_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD29_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD28_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD27_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD26_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD25_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD24_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD23_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD22_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD21_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD20_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD19_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD18_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD17_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD16_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD15_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD14_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD13_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD12_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD11_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD10_WCLK_negedge_posedge    : VitalDelayType := 0.000 ns;
        thold_WD9_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD8_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD7_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD6_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD5_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD4_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD3_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD2_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD1_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_WD0_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;


        thold_WW2_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WW1_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WW0_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WW2_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WW1_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WW0_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        tsetup_REN_RCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WEN_WCLK_posedge_posedge     : VitalDelayType := 0.000 ns;
        thold_REN_RCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WEN_WCLK_posedge_posedge      : VitalDelayType := 0.000 ns;
        tsetup_REN_RCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        tsetup_WEN_WCLK_negedge_posedge     : VitalDelayType := 0.000 ns;
        thold_REN_RCLK_negedge_posedge      : VitalDelayType := 0.000 ns;
        thold_WEN_WCLK_negedge_posedge      : VitalDelayType := 0.000 ns;

        tpw_RCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_RCLK_negedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_posedge    : VitalDelayType := 0.000 ns;
        tpw_WCLK_negedge    : VitalDelayType := 0.000 ns

        );
  PORT (
        DEPTH3 : IN STD_ULOGIC ;
        DEPTH2 : IN STD_ULOGIC ;
        DEPTH1 : IN STD_ULOGIC ;
        DEPTH0 : IN STD_ULOGIC ;
        WRAD15 : IN STD_ULOGIC ;
        WRAD14 : IN STD_ULOGIC ;
        WRAD13 : IN STD_ULOGIC ;
        WRAD12 : IN STD_ULOGIC ;
        WRAD11 : IN STD_ULOGIC ;
        WRAD10 : IN STD_ULOGIC ;
        WRAD9  : IN STD_ULOGIC ;
        WRAD8  : IN STD_ULOGIC ;
        WRAD7  : IN STD_ULOGIC ;
        WRAD6  : IN STD_ULOGIC ;
        WRAD5  : IN STD_ULOGIC ;
        WRAD4  : IN STD_ULOGIC ;
        WRAD3  : IN STD_ULOGIC ;
        WRAD2  : IN STD_ULOGIC ;
        WRAD1  : IN STD_ULOGIC ;
        WRAD0  : IN STD_ULOGIC ;
        WD35   : IN STD_ULOGIC ;
        WD34   : IN STD_ULOGIC ;
        WD33   : IN STD_ULOGIC ;
        WD32   : IN STD_ULOGIC ;
        WD31   : IN STD_ULOGIC ;
        WD30   : IN STD_ULOGIC ;
        WD29   : IN STD_ULOGIC ;
        WD28   : IN STD_ULOGIC ;
        WD27   : IN STD_ULOGIC ;
        WD26   : IN STD_ULOGIC ;
        WD25   : IN STD_ULOGIC ;
        WD24   : IN STD_ULOGIC ;
        WD23   : IN STD_ULOGIC ;
        WD22   : IN STD_ULOGIC ;
        WD21   : IN STD_ULOGIC ;
        WD20   : IN STD_ULOGIC ;
        WD19   : IN STD_ULOGIC ;
        WD18   : IN STD_ULOGIC ;
        WD17   : IN STD_ULOGIC ;
        WD16   : IN STD_ULOGIC ;
        WD15   : IN STD_ULOGIC ;
        WD14   : IN STD_ULOGIC ;
        WD13   : IN STD_ULOGIC ;
        WD12   : IN STD_ULOGIC ;
        WD11   : IN STD_ULOGIC ;
        WD10   : IN STD_ULOGIC ;
        WD9    : IN STD_ULOGIC ;
        WD8    : IN STD_ULOGIC ;
        WD7    : IN STD_ULOGIC ;
        WD6    : IN STD_ULOGIC ;
        WD5    : IN STD_ULOGIC ;
        WD4    : IN STD_ULOGIC ;
        WD3    : IN STD_ULOGIC ;
        WD2    : IN STD_ULOGIC ;
        WD1    : IN STD_ULOGIC ;
        WD0    : IN STD_ULOGIC ;
        WW2    : IN STD_ULOGIC ;
        WW1    : IN STD_ULOGIC ;
        WW0    : IN STD_ULOGIC ;
        WEN    : IN STD_ULOGIC ;
        WCLK   : IN STD_ULOGIC ;
        RDAD15 : IN STD_ULOGIC ;
        RDAD14 : IN STD_ULOGIC ;
        RDAD13 : IN STD_ULOGIC ;
        RDAD12 : IN STD_ULOGIC ;
        RDAD11 : IN STD_ULOGIC ;
        RDAD10 : IN STD_ULOGIC ;
        RDAD9  : IN STD_ULOGIC ;
        RDAD8  : IN STD_ULOGIC ;
        RDAD7  : IN STD_ULOGIC ;
        RDAD6  : IN STD_ULOGIC ;
        RDAD5  : IN STD_ULOGIC ;
        RDAD4  : IN STD_ULOGIC ;
        RDAD3  : IN STD_ULOGIC ;
        RDAD2  : IN STD_ULOGIC ;
        RDAD1  : IN STD_ULOGIC ;
        RDAD0  : IN STD_ULOGIC ;
        RW2    : IN STD_ULOGIC ;
        RW1    : IN STD_ULOGIC ;
        RW0    : IN STD_ULOGIC ;
        REN    : IN STD_ULOGIC ;
        RCLK   : IN STD_ULOGIC ;
        RD35   : OUT STD_ULOGIC ;
        RD34   : OUT STD_ULOGIC ;
        RD33   : OUT STD_ULOGIC ;
        RD32   : OUT STD_ULOGIC ;
        RD31   : OUT STD_ULOGIC ;
        RD30   : OUT STD_ULOGIC ;
        RD29   : OUT STD_ULOGIC ;
        RD28   : OUT STD_ULOGIC ;
        RD27   : OUT STD_ULOGIC ;
        RD26   : OUT STD_ULOGIC ;
        RD25   : OUT STD_ULOGIC ;
        RD24   : OUT STD_ULOGIC ;
        RD23   : OUT STD_ULOGIC ;
        RD22   : OUT STD_ULOGIC ;
        RD21   : OUT STD_ULOGIC ;
        RD20   : OUT STD_ULOGIC ;
        RD19   : OUT STD_ULOGIC ;
        RD18   : OUT STD_ULOGIC ;
        RD17   : OUT STD_ULOGIC ;
        RD16   : OUT STD_ULOGIC ;
        RD15   : OUT STD_ULOGIC ;
        RD14   : OUT STD_ULOGIC ;
        RD13   : OUT STD_ULOGIC ;
        RD12   : OUT STD_ULOGIC ;
        RD11   : OUT STD_ULOGIC ;
        RD10   : OUT STD_ULOGIC ;
        RD9    : OUT STD_ULOGIC ;
        RD8    : OUT STD_ULOGIC ;
        RD7    : OUT STD_ULOGIC ;
        RD6    : OUT STD_ULOGIC ;
        RD5    : OUT STD_ULOGIC ;
        RD4    : OUT STD_ULOGIC ;
        RD3    : OUT STD_ULOGIC ;
        RD2    : OUT STD_ULOGIC ;
        RD1    : OUT STD_ULOGIC ;
        RD0    : OUT STD_ULOGIC
        );

 
  
end component;

component DDR_OUT
    port(DR, DF, E, CLK, PRE, CLR : in std_logic;  Q : out std_logic) ;
end component; 

component DDR_REG
    port(D, E, CLK, CLR, PRE : in std_logic;  QR, QF : out std_logic) ;
end component; 

component PLL
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;

      f_REFCLK_LOCK          :	Integer := 3; -- Number of REFCLK pulses after which LOCK is raised

      tipd_PWRDWN            :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_REFCLK            :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_LOWFREQ           :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_OSC2              :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_OSC1              :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_OSC0              :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVI5             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVI4             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVI3             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVI2             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVI1             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVI0             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVJ5             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVJ4             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVJ3             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVJ2             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVJ1             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVJ0             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DELAYLINE4        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DELAYLINE3        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DELAYLINE2        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DELAYLINE1        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DELAYLINE0        :	VitalDelayType01 := (0.000 ns, 0.000 ns);

      tpd_REFCLK_CLK1        :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_REFCLK_CLK2        :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_REFCLK_LOCK        :  VitalDelayType01 := (0.000 ns, 0.000 ns));

   port(
      PWRDWN                  :	in    STD_ULOGIC; -- Active high
      REFCLK                  :	in    STD_ULOGIC;
      LOWFREQ                 : in    STD_ULOGIC; 
      OSC2                    : in    STD_ULOGIC; 
      OSC1                    : in    STD_ULOGIC; 
      OSC0                    : in    STD_ULOGIC; 
      DIVI5                   : in    STD_ULOGIC; -- Clock multiplier
      DIVI4                   : in    STD_ULOGIC; -- Clock multiplier
      DIVI3                   : in    STD_ULOGIC; -- Clock multiplier
      DIVI2                   : in    STD_ULOGIC; -- Clock multiplier
      DIVI1                   : in    STD_ULOGIC; -- Clock multiplier
      DIVI0                   : in    STD_ULOGIC; -- Clock multiplier
      DIVJ5                   : in    STD_ULOGIC; -- Clock divider
      DIVJ4                   : in    STD_ULOGIC; -- Clock divider
      DIVJ3                   : in    STD_ULOGIC; -- Clock divider
      DIVJ2                   : in    STD_ULOGIC; -- Clock divider
      DIVJ1                   : in    STD_ULOGIC; -- Clock divider
      DIVJ0                   : in    STD_ULOGIC; -- Clock divider
      DELAYLINE4              : in    STD_ULOGIC; -- Delay Value
      DELAYLINE3              : in    STD_ULOGIC; -- Delay Value
      DELAYLINE2              : in    STD_ULOGIC; -- Delay Value
      DELAYLINE1              : in    STD_ULOGIC; -- Delay Value
      DELAYLINE0              : in    STD_ULOGIC; -- Delay Value
      LOCK                    :	out   STD_ULOGIC;
      CLK1                    :	out   STD_ULOGIC;
      CLK2                    :	out   STD_ULOGIC);

end component; 

component PLLFB
   generic(
      TimingChecksOn: Boolean := True;
      InstancePath: STRING := "*";
      Xon: Boolean := False;
      MsgOn: Boolean := True;

      f_REFCLK_LOCK          :	Integer := 3; -- Number of REFCLK pulses after which LOCK is raised

      tipd_PWRDWN            :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_REFCLK            :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_FB                :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_LOWFREQ           :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_OSC2              :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_OSC1              :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_OSC0              :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVI5             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVI4             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVI3             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVI2             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVI1             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVI0             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVJ5             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVJ4             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVJ3             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVJ2             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVJ1             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DIVJ0             :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DELAYLINE4        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DELAYLINE3        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DELAYLINE2        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DELAYLINE1        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_DELAYLINE0        :	VitalDelayType01 := (0.000 ns, 0.000 ns);

      tpd_REFCLK_CLK1        :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_REFCLK_CLK2        :  VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_REFCLK_LOCK        :  VitalDelayType01 := (0.000 ns, 0.000 ns));


   port(
      PWRDWN                  :	in    STD_ULOGIC; -- Active high
      REFCLK                  :	in    STD_ULOGIC;
      FB                      :	in    STD_ULOGIC;
      LOWFREQ                 : in    STD_ULOGIC; 
      OSC2                    : in    STD_ULOGIC; 
      OSC1                    : in    STD_ULOGIC; 
      OSC0                    : in    STD_ULOGIC; 
      DIVI5                   : in    STD_ULOGIC; -- Clock multiplier
      DIVI4                   : in    STD_ULOGIC; -- Clock multiplier
      DIVI3                   : in    STD_ULOGIC; -- Clock multiplier
      DIVI2                   : in    STD_ULOGIC; -- Clock multiplier
      DIVI1                   : in    STD_ULOGIC; -- Clock multiplier
      DIVI0                   : in    STD_ULOGIC; -- Clock multiplier
      DIVJ5                   : in    STD_ULOGIC; -- Clock divider
      DIVJ4                   : in    STD_ULOGIC; -- Clock divider
      DIVJ3                   : in    STD_ULOGIC; -- Clock divider
      DIVJ2                   : in    STD_ULOGIC; -- Clock divider
      DIVJ1                   : in    STD_ULOGIC; -- Clock divider
      DIVJ0                   : in    STD_ULOGIC; -- Clock divider
      DELAYLINE4              : in    STD_ULOGIC; -- Delay Value
      DELAYLINE3              : in    STD_ULOGIC; -- Delay Value
      DELAYLINE2              : in    STD_ULOGIC; -- Delay Value
      DELAYLINE1              : in    STD_ULOGIC; -- Delay Value
      DELAYLINE0              : in    STD_ULOGIC; -- Delay Value
      LOCK                    :	out   STD_ULOGIC;
      CLK1                    :	out   STD_ULOGIC;
      CLK2                    :	out   STD_ULOGIC);

end component; 


---------------- CELL:NOR5D ---------------

COMPONENT NOR5D
   port(
          A     : in std_logic;
          B     : in std_logic;
          C     : in std_logic;
          D     : in std_logic;
          E     : in std_logic;
          Y             : out std_logic);
END COMPONENT;




------ Component ADDSUB1 ------
 component ADDSUB1
    port(
                A               : in    STD_ULOGIC;
                FCI             : in    STD_ULOGIC;
                B               : in    STD_ULOGIC;
                AS              : in    STD_ULOGIC;
                S               : out    STD_ULOGIC;
                FCO             : out    STD_ULOGIC);
 end component;



---------------- CELL:NAND5D ---------------

COMPONENT NAND5D
   port(
          A     : in std_logic;
          B     : in std_logic;
          C     : in std_logic;
          D     : in std_logic;
          E     : in std_logic;
          Y             : out std_logic);
END COMPONENT;



------ Component FA1A ------
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



------ Component FA1B ------
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



------ Component FA2A ------
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
 component DF1B_CC is
    generic(
       TimingChecksOn: Boolean := True;
       InstancePath: STRING := "*";
       Xon: Boolean := False;
       MsgOn: Boolean := True;
       tpd_CLK_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
       tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
       tperiod_CLK_negedge            :  VitalDelayType := 0.000 ns;
       tpw_CLK_posedge                :  VitalDelayType := 0.000 ns;
       tpw_CLK_negedge                :  VitalDelayType := 0.000 ns;
       tipd_D                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
       tipd_CLK                       :  VitalDelayType01 := (0.000 ns, 0.000 ns));

    port(
       D                              :  in    STD_ULOGIC;
       CLK                            :  in    STD_ULOGIC;
       Q                              :  out   STD_ULOGIC);
 end component;


 ------ Component DFC1D_CC ------
 component DFC1D_CC is
    generic(
       TimingChecksOn: Boolean := True;
       InstancePath: STRING := "*";
       Xon: Boolean := False;
       MsgOn: Boolean := True;
       tpd_CLR_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tpd_CLK_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
       tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
       thold_CLR_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
       trecovery_CLR_CLK_posedge_negedge : VitalDelayType := 0.000 ns;
       tperiod_CLK_negedge            :  VitalDelayType := 0.000 ns;
       tpw_CLK_posedge                :  VitalDelayType := 0.000 ns;
       tpw_CLK_negedge                :  VitalDelayType := 0.000 ns;
       tpw_CLR_negedge                :  VitalDelayType := 0.000 ns;
       tipd_D                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
       tipd_CLK                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
       tipd_CLR                       :  VitalDelayType01 := (0.000 ns, 0.000 ns));

    port(
       D                              :  in    STD_ULOGIC;
       CLK                            :  in    STD_ULOGIC;
       CLR                            :  in    STD_ULOGIC;
       Q                              :  out   STD_ULOGIC);
 end component;

 ------ Component DFE1B_CC ------
 component DFE1B_CC is
    generic(
       TimingChecksOn: Boolean := True;
       InstancePath: STRING := "*";
       Xon: Boolean := False;
       MsgOn: Boolean := True;
       tpd_CLK_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tsetup_D_CLK_posedge_posedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_posedge_posedge    :  VitalDelayType := 0.000 ns;
       tsetup_D_CLK_negedge_posedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_negedge_posedge    :  VitalDelayType := 0.000 ns;
       tsetup_E_CLK_posedge_posedge   :  VitalDelayType := 0.000 ns;
       thold_E_CLK_posedge_posedge    :  VitalDelayType := 0.000 ns;
       tsetup_E_CLK_negedge_posedge   :  VitalDelayType := 0.000 ns;
       thold_E_CLK_negedge_posedge    :  VitalDelayType := 0.000 ns;
       tperiod_CLK_posedge            :  VitalDelayType := 0.000 ns;
       tpw_CLK_posedge                :  VitalDelayType := 0.000 ns;
       tpw_CLK_negedge                :  VitalDelayType := 0.000 ns;
       tipd_D                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
       tipd_E                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
       tipd_CLK                       :  VitalDelayType01 := (0.000 ns, 0.000 ns));
 
    port(
       D                              :  in    STD_ULOGIC;
       E                              :  in    STD_ULOGIC;
       CLK                            :  in    STD_ULOGIC;
       Q                              :  out   STD_ULOGIC);
 end component;

 ------ Component DFE1C_CC ------
 component DFE1C_CC is
    generic(
       TimingChecksOn: Boolean := True;
       InstancePath: STRING := "*";
       Xon: Boolean := False;
       MsgOn: Boolean := True;
       tpd_CLK_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
       tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
       tsetup_E_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
       thold_E_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
       tsetup_E_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
       thold_E_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
       tperiod_CLK_negedge            :  VitalDelayType := 0.000 ns;
       tpw_CLK_posedge                :  VitalDelayType := 0.000 ns;
       tpw_CLK_negedge                :  VitalDelayType := 0.000 ns;
       tipd_D                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
       tipd_E                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
       tipd_CLK                       :  VitalDelayType01 := (0.000 ns, 0.000 ns));

    port(
       D                              :  in    STD_ULOGIC;
       E                              :  in    STD_ULOGIC;
       CLK                            :  in    STD_ULOGIC;
       Q                              :  out   STD_ULOGIC);
 end component;

 ------ Component DFP1_CC ------
 component DFP1_CC is
    generic(
       TimingChecksOn: Boolean := True;
       InstancePath: STRING := "*";
       Xon: Boolean := False;
       MsgOn: Boolean := True;
       tpd_PRE_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tpd_CLK_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tsetup_D_CLK_posedge_posedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_posedge_posedge    :  VitalDelayType := 0.000 ns;
       tsetup_D_CLK_negedge_posedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_negedge_posedge    :  VitalDelayType := 0.000 ns;
       thold_PRE_CLK_negedge_posedge   :  VitalDelayType := 0.000 ns;
       trecovery_PRE_CLK_negedge_posedge : VitalDelayType := 0.000 ns;
       tperiod_CLK_posedge            :  VitalDelayType := 0.000 ns;
       tpw_CLK_posedge                :  VitalDelayType := 0.000 ns;
       tpw_PRE_posedge                :  VitalDelayType := 0.000 ns;
       tpw_CLK_negedge                :  VitalDelayType := 0.000 ns;
       tipd_D                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
       tipd_CLK                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
       tipd_PRE                       :  VitalDelayType01 := (0.000 ns, 0.000 ns));
 
    port(
       D                              :  in    STD_ULOGIC;
       CLK                            :  in    STD_ULOGIC;
       PRE                            :  in    STD_ULOGIC;
       Q                              :  out   STD_ULOGIC);
 end component;

 ------ Component DFP1A_CC ------
 component DFP1A_CC is
    generic(
       TimingChecksOn: Boolean := True;
       InstancePath: STRING := "*";
       Xon: Boolean := False;
       MsgOn: Boolean := True;
       tpd_PRE_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tpd_CLK_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
       tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
       thold_PRE_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
       trecovery_PRE_CLK_negedge_negedge : VitalDelayType := 0.000 ns;
       tperiod_CLK_negedge            :  VitalDelayType := 0.000 ns;
       tpw_CLK_posedge                :  VitalDelayType := 0.000 ns;
       tpw_PRE_posedge                :  VitalDelayType := 0.000 ns;
       tpw_CLK_negedge                :  VitalDelayType := 0.000 ns;
       tipd_D                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
       tipd_CLK                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
        tipd_PRE                       :  VitalDelayType01 := (0.000 ns, 0.000 ns));
 
    port(
       D                              :  in    STD_ULOGIC;
       CLK                            :  in    STD_ULOGIC;
       PRE                            :  in    STD_ULOGIC;
       Q                              :  out   STD_ULOGIC);
 end component;

 ------ Component DFP1D_CC ------
 component DFP1D_CC is
    generic(
       TimingChecksOn: Boolean := True;
       InstancePath: STRING := "*";
       Xon: Boolean := False;
       MsgOn: Boolean := True;
       tpd_PRE_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tpd_CLK_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tsetup_D_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_posedge_negedge    :  VitalDelayType := 0.000 ns;
       tsetup_D_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_negedge_negedge    :  VitalDelayType := 0.000 ns;
       thold_PRE_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
       trecovery_PRE_CLK_posedge_negedge : VitalDelayType := 0.000 ns;
       tperiod_CLK_negedge            :  VitalDelayType := 0.000 ns;
       tpw_CLK_posedge                :  VitalDelayType := 0.000 ns;
       tpw_CLK_negedge                :  VitalDelayType := 0.000 ns;
       tpw_PRE_negedge                :  VitalDelayType := 0.000 ns;
       tipd_D                         :  VitalDelayType01 := (0.000 ns, 0.000 ns);
       tipd_CLK                       :  VitalDelayType01 := (0.000 ns, 0.000 ns);
       tipd_PRE                       :  VitalDelayType01 := (0.000 ns, 0.000 ns));
 
    port(
       D                              :  in    STD_ULOGIC;
       CLK                            :  in    STD_ULOGIC;
       PRE                            :  in    STD_ULOGIC;
       Q                              :  out   STD_ULOGIC);
 end component;

 ------ Component DFPC_CC ------
 component DFPC_CC is
    generic(
       TimingChecksOn: Boolean := True;
       InstancePath: STRING := "*";
       Xon: Boolean := False;
       MsgOn: Boolean := True;
       tpd_PRE_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tpd_CLR_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tpd_CLK_Q                      :  VitalDelayType01 := (0.100 ns, 0.100 ns);
       tsetup_D_CLK_posedge_posedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_posedge_posedge    :  VitalDelayType := 0.000 ns;
       tsetup_D_CLK_negedge_posedge   :  VitalDelayType := 0.000 ns;
       thold_D_CLK_negedge_posedge    :  VitalDelayType := 0.000 ns;
       thold_PRE_CLK_negedge_posedge   :  VitalDelayType := 0.000 ns;
       trecovery_PRE_CLK_negedge_posedge : VitalDelayType := 0.000 ns;
       thold_CLR_CLK_posedge_posedge   :  VitalDelayType := 0.000 ns;
       trecovery_CLR_CLK_posedge_posedge : VitalDelayType := 0.000 ns;
       tperiod_CLK_posedge            :  VitalDelayType := 0.000 ns;
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

 ------ Component DFPCA ------
 component DFPCA is
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
 component DFPCA_CC is
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

component BBDLHS
    port(D, E, GIN, GOUT : in std_logic;  PAD : inout std_logic;  
        Q : out std_logic) ;
end component;
component BBHS
    port(D, E : in std_logic;  PAD : inout std_logic;  Y : out 
        std_logic) ;
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
component DFMA_CC
    port(A, B, CLK : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end component;
component DFM_CC
    port(A, B, CLK : in std_logic;  Q : out std_logic;  S : in 
        std_logic) ;
end component;
component DFP1C
    port(CLK, D, PRE : in std_logic;  QN : out std_logic) ;
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
component DLM8A
    port(CLR, D0, D1, D2, D3, G : in std_logic;  Q : out 
        std_logic;  S00, S01, S10, S11 : in std_logic) ;
end component;
component DLM8B
    port(CLR, D0, D1, D2, D3, G : in std_logic;  Q : out 
        std_logic;  S00, S01, S10, S11 : in std_logic) ;
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
      thold_CLR_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
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
      thold_PRE_CLK_negedge_posedge   :  VitalDelayType := 0.000 ns;
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
      thold_PRE_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
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
      thold_PRE_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
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
      thold_PRE_CLK_negedge_posedge   :  VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_posedge : VitalDelayType := 0.000 ns;
      thold_CLR_CLK_posedge_posedge   :  VitalDelayType := 0.000 ns;
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
                            TO_X01( PRE_ipd ) /='1',
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
      thold_PRE_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge : VitalDelayType := 0.000 ns;
      thold_CLR_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
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
      thold_PRE_CLK_negedge_negedge   :  VitalDelayType := 0.000 ns;
      trecovery_PRE_CLK_negedge_negedge : VitalDelayType := 0.000 ns;
      thold_CLR_CLK_posedge_negedge   :  VitalDelayType := 0.000 ns;
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
      thold_D_G_posedge_posedge      :  VitalDelayType := 0.000 ns;
      tsetup_D_G_posedge_posedge     :  VitalDelayType := 0.000 ns;
      thold_D_G_negedge_posedge      :  VitalDelayType := 0.000 ns;
      tsetup_D_G_negedge_posedge     :  VitalDelayType := 0.000 ns;
      thold_PRE_G_posedge_posedge     :  VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_posedge : VitalDelayType := 0.000 ns;
      thold_CLR_G_negedge_posedge     :  VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_posedge : VitalDelayType := 0.000 ns;
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
    ( L,  U,  x,  x,  L,  L ));

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
          RefSignalName           => "G",
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
                           TO_X01(NOT PRE_ipd ) /='1',
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
      thold_D_G_posedge_negedge      :  VitalDelayType := 0.000 ns;
      tsetup_D_G_posedge_negedge     :  VitalDelayType := 0.000 ns;
      thold_D_G_negedge_negedge      :  VitalDelayType := 0.000 ns;
      tsetup_D_G_negedge_negedge     :  VitalDelayType := 0.000 ns;
      thold_PRE_G_posedge_negedge     :  VitalDelayType := 0.000 ns;
      trecovery_PRE_G_posedge_negedge : VitalDelayType := 0.000 ns;
      thold_CLR_G_negedge_negedge     :  VitalDelayType := 0.000 ns;
      trecovery_CLR_G_negedge_negedge : VitalDelayType := 0.000 ns;
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
    ( L,  U,  x,  x,  L,  L ));

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
          RefSignalName           => "G",
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
                           TO_X01(NOT PRE_ipd)  /='1',
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
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
library axcelerator;
 
entity OBDLHS is 
    port(D, G : in std_logic;  PAD : out std_logic) ;
end OBDLHS;


architecture DEF_ARCH of  OBDLHS is

    component OUTBUF
        port(D : in std_logic := 'U'; PAD : out std_logic) ;
    end component;

    component MX2
        port(A, B, S : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : OUTBUF
   port map(D => NET0, PAD => PAD);
    U0 : MX2
   port map(A => NET0, B => D, S => G, Y => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library axcelerator;
 
entity OBHS is 
    port(PAD : out std_logic;  D : in std_logic) ;
end OBHS;


architecture DEF_ARCH of  OBHS is

    component OUTBUF
        port(D : in std_logic := 'U'; PAD : out std_logic) ;
    end component;

begin   

    U0 : OUTBUF
   port map(D => D, PAD => PAD);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library axcelerator;
 
entity ORH is 
    port(CLK, D : in std_logic;  PAD : out std_logic) ;
end ORH;


architecture DEF_ARCH of  ORH is

    component OUTBUF
        port(D : in std_logic := 'U'; PAD : out std_logic) ;
    end component;

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    signal NET0 : std_logic ;
    begin   

    U1 : OUTBUF
   port map(D => NET0, PAD => PAD);
    U0 : DF1
   port map(D => D, CLK => CLK, Q => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library axcelerator;
 
entity ORIH is 
    port(CLK, D : in std_logic;  PAD : out std_logic) ;
end ORIH;


architecture DEF_ARCH of  ORIH is

    component OUTBUF
        port(D : in std_logic := 'U'; PAD : out std_logic) ;
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
   port map(D => NET1, PAD => PAD);
    U1 : INV
   port map(A => NET0, Y => NET1);
    U0 : DF1
   port map(D => D, CLK => CLK, Q => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library axcelerator;
 
entity ORITH is 
    port(CLK, D, E : in std_logic;  PAD : out std_logic) ;
end ORITH;


architecture DEF_ARCH of  ORITH is

    component TRIBUFF
        port(D, E : in std_logic := 'U'; PAD : out std_logic) ;
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
   port map(D => NET1, E => E, PAD => PAD);
    U1 : INV
   port map(A => NET0, Y => NET1);
    U0 : DF1
   port map(D => D, CLK => CLK, Q => NET0);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library axcelerator;
 
entity ORTH is 
    port(CLK, D, E : in std_logic;  PAD : out std_logic) ;
end ORTH;


architecture DEF_ARCH of  ORTH is

    component TRIBUFF
        port(D, E : in std_logic := 'U'; PAD : out std_logic) ;
    end component;

    component DF1
        port(D, CLK : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    signal NET1 : std_logic ;
    begin   

    U2 : TRIBUFF
   port map(D => NET1, E => E, PAD => PAD);
    U0 : DF1
   port map(D => D, CLK => CLK, Q => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library axcelerator;
 
entity TBDLHS is 
    port(D, E, G : in std_logic;  PAD : out std_logic) ;
end TBDLHS;


architecture DEF_ARCH of  TBDLHS is

    component TRIBUFF
        port(D, E : in std_logic := 'U'; PAD : out std_logic) ;
    end component;

    component DL1
        port(D, G : in std_logic := 'U'; Q : out std_logic) ;
    end component;

    signal NET1 : std_logic ;
    begin   

    U2 : TRIBUFF
   port map(D => NET1, E => E, PAD => PAD);
    U1 : DL1
   port map(D => D, G => G, Q => NET1);
end DEF_ARCH;
library ieee;
use ieee.std_logic_1164.all;
library axcelerator;
 
entity TBHS is 
    port(D, E : in std_logic;  PAD : out std_logic) ;
end TBHS;


architecture DEF_ARCH of  TBHS is

    component TRIBUFF
        port(D, E : in std_logic := 'U'; PAD : out std_logic) ;
    end component;

begin   

    U0 : TRIBUFF
   port map(D => D, E => E, PAD => PAD);
end DEF_ARCH;
