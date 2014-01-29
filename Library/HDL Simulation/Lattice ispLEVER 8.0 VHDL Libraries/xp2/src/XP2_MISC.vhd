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

--
-----cell dp16kb----
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use ieee.std_logic_unsigned.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY dp16kb IS
   GENERIC (
        DATA_WIDTH_A               : Integer  := 18;
        DATA_WIDTH_B               : Integer  := 18;
        REGMODE_A                  : String  := "NOREG";
        REGMODE_B                  : String  := "NOREG";
        RESETMODE                  : String  := "SYNC";
        CSDECODE_A                 : std_logic_vector(2 downto 0)  := "000";
        CSDECODE_B                 : std_logic_vector(2 downto 0)  := "000";
        WRITEMODE_A                : String  := "NORMAL";
        WRITEMODE_B                : String  := "NORMAL";
        GSR                        : String  := "DISABLED";
        initval_00 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_20 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_21 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_22 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_23 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_24 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_25 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_26 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_27 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_28 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_29 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_30 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_31 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_32 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_33 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_34 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_35 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_36 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_37 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_38 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_39 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";

        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string  := "dp16kb";

        -- input SIGNAL delays
        tipd_ada13 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada9 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada8 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada7 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada6 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada5 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada4 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia17 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia16 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia15 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia14 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia13 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia9  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia8  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clka  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cea  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wea : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csa0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csa1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csa2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rsta : VitalDelayType01 := (0.0 ns, 0.0 ns);

        tipd_adb13 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb9 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb8 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb7 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb6 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb5 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb4 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib17 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib16 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib15 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib14 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib13 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib9  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib8  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clkb  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ceb  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_web : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csb0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csb1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csb2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rstb : VitalDelayType01 := (0.0 ns, 0.0 ns)
  );

   PORT(
        dia0, dia1, dia2, dia3, dia4, dia5, dia6, dia7, dia8            : in std_logic := 'X';
        dia9, dia10, dia11, dia12, dia13, dia14, dia15, dia16, dia17    : in std_logic := 'X';
        ada0, ada1, ada2, ada3, ada4, ada5, ada6, ada7, ada8            : in std_logic := 'X';
        ada9, ada10, ada11, ada12, ada13                                : in std_logic := 'X';
        cea, clka, wea, csa0, csa1, csa2, rsta                         : in std_logic := 'X';
        dib0, dib1, dib2, dib3, dib4, dib5, dib6, dib7, dib8            : in std_logic := 'X';
        dib9, dib10, dib11, dib12, dib13, dib14, dib15, dib16, dib17    : in std_logic := 'X';
        adb0, adb1, adb2, adb3, adb4, adb5, adb6, adb7, adb8            : in std_logic := 'X';
        adb9, adb10, adb11, adb12, adb13                                : in std_logic := 'X';
        ceb, clkb, web, csb0, csb1, csb2, rstb                         : in std_logic := 'X';

        doa0, doa1, doa2, doa3, doa4, doa5, doa6, doa7, doa8            : out std_logic := 'X';
        doa9, doa10, doa11, doa12, doa13, doa14, doa15, doa16, doa17    : out std_logic := 'X';
        dob0, dob1, dob2, dob3, dob4, dob5, dob6, dob7, dob8            : out std_logic := 'X';
        dob9, dob10, dob11, dob12, dob13, dob14, dob15, dob16, dob17    : out std_logic := 'X'
  );

      ATTRIBUTE Vital_Level0 OF dp16kb : ENTITY IS TRUE;

END dp16kb ;

-- ARCHITECTURE body --
ARCHITECTURE V OF dp16kb IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

--SIGNAL DECLARATIONS----

    SIGNAL ada_ipd   : std_logic_vector(13 downto 0) := (others => '0');
    SIGNAL dia_ipd   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL clka_ipd  : std_logic := '0';
    SIGNAL cea_ipd   : std_logic := '0';
    SIGNAL wrea_ipd  : std_logic := '0';
    SIGNAL csa_ipd   : std_logic_vector(2 downto 0) := "000";
    SIGNAL rsta_ipd  : std_logic := '0';
    SIGNAL adb_ipd   : std_logic_vector(13 downto 0) := "XXXXXXXXXXXXXX";
    SIGNAL dib_ipd   : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
    SIGNAL clkb_ipd  : std_logic := '0';
    SIGNAL ceb_ipd   : std_logic := '0';
    SIGNAL wreb_ipd  : std_logic := '0';
    SIGNAL csb_ipd   : std_logic_vector(2 downto 0) := "000";
    SIGNAL rstb_ipd  : std_logic := '0';
    SIGNAL csa_en    : std_logic := '0';
    SIGNAL csb_en    : std_logic := '0';
    SIGNAL g_reset   : std_logic := '0';
    CONSTANT ADDR_WIDTH_A : integer := data2addr_w(DATA_WIDTH_A); 
    CONSTANT ADDR_WIDTH_B : integer := data2addr_w(DATA_WIDTH_B); 
    CONSTANT new_data_width_a : integer := data2data_w(DATA_WIDTH_A); 
    CONSTANT new_data_width_b : integer := data2data_w(DATA_WIDTH_B); 
    CONSTANT div_a    : integer := data2data(DATA_WIDTH_A); 
    CONSTANT div_b    : integer := data2data(DATA_WIDTH_B); 
    SIGNAL dia_node   : std_logic_vector((new_data_width_a - 1) downto 0) := (others => '0');
    SIGNAL dib_node   : std_logic_vector((new_data_width_b - 1) downto 0) := (others => '0');
    SIGNAL ada_node   : std_logic_vector((ADDR_WIDTH_A - 1) downto 0);
    SIGNAL adb_node   : std_logic_vector((ADDR_WIDTH_B - 1) downto 0);
    SIGNAL diab_node  : std_logic_vector(35 downto 0) := (others => '0');
    SIGNAL rsta_int   : std_logic := '0';
    SIGNAL rstb_int   : std_logic := '0';
    SIGNAL rsta_reg   : std_logic := '0';
    SIGNAL rstb_reg   : std_logic := '0';
    SIGNAL reseta     : std_logic := '0';
    SIGNAL resetb     : std_logic := '0';
    SIGNAL dia_reg    : std_logic_vector((new_data_width_a - 1) downto 0) := (others => '0');
    SIGNAL dib_reg    : std_logic_vector((new_data_width_b - 1) downto 0) := (others => '0');
    SIGNAL ada_reg    : std_logic_vector((ADDR_WIDTH_A - 1) downto 0);
    SIGNAL adb_reg    : std_logic_vector((ADDR_WIDTH_B - 1) downto 0);
    SIGNAL diab_reg   : std_logic_vector(35 downto 0) := (others => '0');
    SIGNAL bwa0_reg   : std_logic_vector(1 downto 0) := (others => '0');
    SIGNAL bwa1_reg   : std_logic_vector(1 downto 0) := (others => '0');
    SIGNAL bwb_reg    : std_logic_vector(1 downto 0) := (others => '0');
    SIGNAL wrena_reg  : std_logic := '0';
    SIGNAL clka_valid : std_logic := '0';
    SIGNAL clkb_valid : std_logic := '0';
    SIGNAL clka_valid1 : std_logic := '0';
    SIGNAL clkb_valid1 : std_logic := '0';
    SIGNAL last_clka_valid1 : std_logic := '0';
    SIGNAL last_clkb_valid1 : std_logic := '0';
    SIGNAL wrenb_reg  : std_logic := '0';
    SIGNAL rena_reg   : std_logic := '0';
    SIGNAL renb_reg   : std_logic := '0';
    SIGNAL rsta_sig   : std_logic := '0';
    SIGNAL rstb_sig   : std_logic := '0';
    SIGNAL doa_node   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_node_tr   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_node_wt   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_node_rbr   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_node   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_node_tr   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_node_wt   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_node_rbr   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_reg    : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_reg    : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doab_reg   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_int    : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_int    : std_logic_vector(17 downto 0) := (others => '0');

	 --write & read/write collision flags
	 signal wr_a_wr_b_coll : std_logic := '0';
	 signal wr_a_rd_b_coll : std_logic := '0';
	 signal rd_a_wr_b_coll : std_logic := '0';
	 --lower & upper collision addresses
    signal dn_coll_addr, up_coll_addr : integer;

    CONSTANT initval   : string(5120 downto 1) := (
      initval_3f(3 to 82)&initval_3e(3 to 82)&initval_3d(3 to 82)&initval_3c(3 to 82)&
      initval_3b(3 to 82)&initval_3a(3 to 82)&initval_39(3 to 82)&initval_38(3 to 82)&
      initval_37(3 to 82)&initval_36(3 to 82)&initval_35(3 to 82)&initval_34(3 to 82)&
      initval_33(3 to 82)&initval_32(3 to 82)&initval_31(3 to 82)&initval_30(3 to 82)&
      initval_2f(3 to 82)&initval_2e(3 to 82)&initval_2d(3 to 82)&initval_2c(3 to 82)&
      initval_2b(3 to 82)&initval_2a(3 to 82)&initval_29(3 to 82)&initval_28(3 to 82)&
      initval_27(3 to 82)&initval_26(3 to 82)&initval_25(3 to 82)&initval_24(3 to 82)&
      initval_23(3 to 82)&initval_22(3 to 82)&initval_21(3 to 82)&initval_20(3 to 82)&
      initval_1f(3 to 82)&initval_1e(3 to 82)&initval_1d(3 to 82)&initval_1c(3 to 82)&
      initval_1b(3 to 82)&initval_1a(3 to 82)&initval_19(3 to 82)&initval_18(3 to 82)&
      initval_17(3 to 82)&initval_16(3 to 82)&initval_15(3 to 82)&initval_14(3 to 82)&
      initval_13(3 to 82)&initval_12(3 to 82)&initval_11(3 to 82)&initval_10(3 to 82)&
      initval_0f(3 to 82)&initval_0e(3 to 82)&initval_0d(3 to 82)&initval_0c(3 to 82)&
      initval_0b(3 to 82)&initval_0a(3 to 82)&initval_09(3 to 82)&initval_08(3 to 82)&
      initval_07(3 to 82)&initval_06(3 to 82)&initval_05(3 to 82)&initval_04(3 to 82)&
      initval_03(3 to 82)&initval_02(3 to 82)&initval_01(3 to 82)&initval_00(3 to 82));
    SIGNAL MEM       : std_logic_vector(18431 downto 0) := init_ram (initval);
    SIGNAL j         : integer := 0;
BEGIN

   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(ada_ipd(0), ada0, tipd_ada0);
   VitalWireDelay(ada_ipd(1), ada1, tipd_ada1);
   VitalWireDelay(ada_ipd(2), ada2, tipd_ada2);
   VitalWireDelay(ada_ipd(3), ada3, tipd_ada3);
   VitalWireDelay(ada_ipd(4), ada4, tipd_ada4);
   VitalWireDelay(ada_ipd(5), ada5, tipd_ada5);
   VitalWireDelay(ada_ipd(6), ada6, tipd_ada6);
   VitalWireDelay(ada_ipd(7), ada7, tipd_ada7);
   VitalWireDelay(ada_ipd(8), ada8, tipd_ada8);
   VitalWireDelay(ada_ipd(9), ada9, tipd_ada9);
   VitalWireDelay(ada_ipd(10), ada10, tipd_ada10);
   VitalWireDelay(ada_ipd(11), ada11, tipd_ada11);
   VitalWireDelay(ada_ipd(12), ada12, tipd_ada12);
   VitalWireDelay(ada_ipd(13), ada13, tipd_ada13);
   VitalWireDelay(dia_ipd(0), dia0, tipd_dia0);
   VitalWireDelay(dia_ipd(1), dia1, tipd_dia1);
   VitalWireDelay(dia_ipd(2), dia2, tipd_dia2);
   VitalWireDelay(dia_ipd(3), dia3, tipd_dia3);
   VitalWireDelay(dia_ipd(4), dia4, tipd_dia4);
   VitalWireDelay(dia_ipd(5), dia5, tipd_dia5);
   VitalWireDelay(dia_ipd(6), dia6, tipd_dia6);
   VitalWireDelay(dia_ipd(7), dia7, tipd_dia7);
   VitalWireDelay(dia_ipd(8), dia8, tipd_dia8);
   VitalWireDelay(dia_ipd(9), dia9, tipd_dia9);
   VitalWireDelay(dia_ipd(10), dia10, tipd_dia10);
   VitalWireDelay(dia_ipd(11), dia11, tipd_dia11);
   VitalWireDelay(dia_ipd(12), dia12, tipd_dia12);
   VitalWireDelay(dia_ipd(13), dia13, tipd_dia13);
   VitalWireDelay(dia_ipd(14), dia14, tipd_dia14);
   VitalWireDelay(dia_ipd(15), dia15, tipd_dia15);
   VitalWireDelay(dia_ipd(16), dia16, tipd_dia16);
   VitalWireDelay(dia_ipd(17), dia17, tipd_dia17);
   VitalWireDelay(clka_ipd, clka, tipd_clka);
   VitalWireDelay(wrea_ipd, wea, tipd_wea);
   VitalWireDelay(cea_ipd, cea, tipd_cea);
   VitalWireDelay(csa_ipd(0), csa0, tipd_csa0);
   VitalWireDelay(csa_ipd(1), csa1, tipd_csa1);
   VitalWireDelay(csa_ipd(2), csa2, tipd_csa2);
   VitalWireDelay(rsta_ipd, rsta, tipd_rsta);
   VitalWireDelay(adb_ipd(0), adb0, tipd_adb0);
   VitalWireDelay(adb_ipd(1), adb1, tipd_adb1);
   VitalWireDelay(adb_ipd(2), adb2, tipd_adb2);
   VitalWireDelay(adb_ipd(3), adb3, tipd_adb3);
   VitalWireDelay(adb_ipd(4), adb4, tipd_adb4);
   VitalWireDelay(adb_ipd(5), adb5, tipd_adb5);
   VitalWireDelay(adb_ipd(6), adb6, tipd_adb6);
   VitalWireDelay(adb_ipd(7), adb7, tipd_adb7);
   VitalWireDelay(adb_ipd(8), adb8, tipd_adb8);
   VitalWireDelay(adb_ipd(9), adb9, tipd_adb9);
   VitalWireDelay(adb_ipd(10), adb10, tipd_adb10);
   VitalWireDelay(adb_ipd(11), adb11, tipd_adb11);
   VitalWireDelay(adb_ipd(12), adb12, tipd_adb12);
   VitalWireDelay(adb_ipd(13), adb13, tipd_adb13);
   VitalWireDelay(dib_ipd(0), dib0, tipd_dib0);
   VitalWireDelay(dib_ipd(1), dib1, tipd_dib1);
   VitalWireDelay(dib_ipd(2), dib2, tipd_dib2);
   VitalWireDelay(dib_ipd(3), dib3, tipd_dib3);
   VitalWireDelay(dib_ipd(4), dib4, tipd_dib4);
   VitalWireDelay(dib_ipd(5), dib5, tipd_dib5);
   VitalWireDelay(dib_ipd(6), dib6, tipd_dib6);
   VitalWireDelay(dib_ipd(7), dib7, tipd_dib7);
   VitalWireDelay(dib_ipd(8), dib8, tipd_dib8);
   VitalWireDelay(dib_ipd(9), dib9, tipd_dib9);
   VitalWireDelay(dib_ipd(10), dib10, tipd_dib10);
   VitalWireDelay(dib_ipd(11), dib11, tipd_dib11);
   VitalWireDelay(dib_ipd(12), dib12, tipd_dib12);
   VitalWireDelay(dib_ipd(13), dib13, tipd_dib13);
   VitalWireDelay(dib_ipd(14), dib14, tipd_dib14);
   VitalWireDelay(dib_ipd(15), dib15, tipd_dib15);
   VitalWireDelay(dib_ipd(16), dib16, tipd_dib16);
   VitalWireDelay(dib_ipd(17), dib17, tipd_dib17);
   VitalWireDelay(clkb_ipd, clkb, tipd_clkb);
   VitalWireDelay(wreb_ipd, web, tipd_web);
   VitalWireDelay(ceb_ipd, ceb, tipd_ceb);
   VitalWireDelay(csb_ipd(0), csb0, tipd_csb0);
   VitalWireDelay(csb_ipd(1), csb1, tipd_csb1);
   VitalWireDelay(csb_ipd(2), csb2, tipd_csb2);
   VitalWireDelay(rstb_ipd, rstb, tipd_rstb);
   END BLOCK;

   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (GSR =  "DISABLED") THEN
         g_reset <= purnet;
      ELSE
         g_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

  rsta_sig <= rsta_ipd or (not g_reset);
  rstb_sig <= rstb_ipd or (not g_reset);

--   set_reset <= g_reset and (not reset_ipd);
  ada_node <= ada_ipd(13 downto (14 - ADDR_WIDTH_A));
  adb_node <= adb_ipd(13 downto (14 - ADDR_WIDTH_B));

-- chip select A decode
  P1 : PROCESS(csa_ipd)
  BEGIN
     IF (csa_ipd = "000" and CSDECODE_A = "000") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "001" and CSDECODE_A = "001") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "010" and CSDECODE_A = "010") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "011" and CSDECODE_A = "011") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "100" and CSDECODE_A = "100") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "101" and CSDECODE_A = "101") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "110" and CSDECODE_A = "110") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "111" and CSDECODE_A = "111") THEN
        csa_en <= '1';
     ELSE
        csa_en <= '0';
     END IF;
  END PROCESS;

  P2 : PROCESS(csb_ipd)
  BEGIN
     IF (csb_ipd = "000" and CSDECODE_B = "000") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "001" and CSDECODE_B = "001") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "010" and CSDECODE_B = "010") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "011" and CSDECODE_B = "011") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "100" and CSDECODE_B = "100") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "101" and CSDECODE_B = "101") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "110" and CSDECODE_B = "110") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "111" and CSDECODE_B = "111") THEN
        csb_en <= '1';
     ELSE
        csb_en <= '0';
     END IF;
  END PROCESS;

  P3 : PROCESS(dia_ipd)
  BEGIN
     CASE DATA_WIDTH_A IS
       WHEN 1 =>
        dia_node <= dia_ipd(11 downto 11);
       WHEN 2 =>
        dia_node <= (dia_ipd(1), dia_ipd(11));
       WHEN 4 =>
        dia_node <= dia_ipd(3 downto 0); 
       WHEN 9 =>
        dia_node <= dia_ipd(8 downto 0);
       WHEN 18 =>
        dia_node <= dia_ipd;
       WHEN 36 =>
        dia_node <= dia_ipd;
       WHEN others =>
          NULL;
     END CASE;
  END PROCESS;

  P4 : PROCESS(dib_ipd)
  BEGIN
     CASE DATA_WIDTH_B IS
       WHEN 1 =>
        dib_node <= dib_ipd(11 downto 11);
       WHEN 2 =>
        dib_node <= (dib_ipd(1), dib_ipd(11));
       WHEN 4 =>
        dib_node <= dib_ipd(3 downto 0); 
       WHEN 9 =>
        dib_node <= dib_ipd(8 downto 0);
       WHEN 18 =>
        dib_node <= dib_ipd;
       WHEN 36 =>
        dib_node <= dib_ipd;
       WHEN others =>
          NULL;
     END CASE;
  END PROCESS;

  diab_node <= (dib_ipd & dia_ipd);

  P107 : PROCESS(clka_ipd)
  BEGIN
     IF (clka_ipd'event and clka_ipd = '1') THEN
        IF ((g_reset = '0') or (rsta_ipd = '1')) THEN
           clka_valid <= '0';
        ELSE
           IF (cea_ipd = '1') THEN
              IF (csa_en = '1') THEN
                 clka_valid <= '1', '0' after 0.2 ns;
              ELSE
                 clka_valid <= '0';
              END IF;
           ELSE
              clka_valid <= '0';
           END IF;
        END IF;
     END IF;
  END PROCESS;
 
  P108 : PROCESS(clkb_ipd)
  BEGIN
     IF (clkb_ipd'event and clkb_ipd = '1') THEN
        IF ((g_reset = '0') or (rstb_ipd = '1')) THEN
           clkb_valid <= '0';
        ELSE
           IF (ceb_ipd = '1') THEN
              IF (csb_en = '1') THEN 
                 clkb_valid <= '1', '0' after 0.2 ns;
              ELSE
                 clkb_valid <= '0';
              END IF;
           ELSE
              clkb_valid <= '0';
           END IF;
        END IF;
     END IF;
  END PROCESS;

  clka_valid1 <= clka_valid;
  clkb_valid1 <= clkb_valid;
  last_clka_valid1 <= clka_valid1;
  last_clkb_valid1 <= clkb_valid1;

  P7 : PROCESS(g_reset, rsta_ipd, rstb_ipd, clka_ipd, clkb_ipd)
  BEGIN
     IF (g_reset = '0') THEN
        dia_reg <= (others => '0');
        diab_reg <= (others => '0');
        ada_reg <= (others => '0');
        bwa0_reg <= (others => '0');
        bwa1_reg <= (others => '0');
        wrena_reg <= '0';
        rena_reg <= '0';
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rsta_ipd = '1') THEN
           dia_reg <= (others => '0');
           diab_reg <= (others => '0');
           ada_reg <= (others => '0');
           bwa0_reg <= (others => '0');
           bwa1_reg <= (others => '0');
           wrena_reg <= '0';
           rena_reg <= '0';
        ELSIF (clka_ipd'event and clka_ipd = '1') THEN
           IF (cea_ipd = '1') THEN
              dia_reg <= dia_node;
              diab_reg <= diab_node;
              ada_reg <= ada_node;
              bwa0_reg <= (ada_ipd(1), ada_ipd(0));
              bwa1_reg <= (ada_ipd(3), ada_ipd(2));
              wrena_reg <= (wrea_ipd and csa_en);
              rena_reg <= ((not wrea_ipd) and csa_en);
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN 
        IF (clka_ipd'event and clka_ipd = '1') THEN
           IF (rsta_ipd = '1') THEN
              dia_reg <= (others => '0');
              diab_reg <= (others => '0');
              ada_reg <= (others => '0');
              bwa0_reg <= (others => '0');
              bwa1_reg <= (others => '0');
              wrena_reg <= '0';
              rena_reg <= '0';
           ELSIF (cea_ipd = '1') THEN
              dia_reg <= dia_node; 
              diab_reg <= diab_node; 
              ada_reg <= ada_node;
              bwa0_reg <= (ada_ipd(1), ada_ipd(0));
              bwa1_reg <= (ada_ipd(3), ada_ipd(2));
              wrena_reg <= (wrea_ipd and csa_en);
              rena_reg <= ((not wrea_ipd) and csa_en);
           END IF;
        END IF;
     END IF;

     IF (g_reset = '0') THEN
        dib_reg <= (others => '0');
        adb_reg <= (others => '0');
        bwb_reg <= (others => '0');
        wrenb_reg <= '0';
        renb_reg <= '0';
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rstb_ipd = '1') THEN
           dib_reg <= (others => '0');
           adb_reg <= (others => '0');
           bwb_reg <= (others => '0');
           wrenb_reg <= '0';
           renb_reg <= '0';
        ELSIF (clkb_ipd'event and clkb_ipd = '1') THEN
           IF (ceb_ipd = '1') THEN
              dib_reg <= dib_node;
              adb_reg <= adb_node;
              bwb_reg <= (adb_ipd(1), adb_ipd(0));
              wrenb_reg <= (wreb_ipd and csb_en);
              renb_reg <= ((not wreb_ipd) and csb_en);
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN
        IF (clkb_ipd'event and clkb_ipd = '1') THEN
           IF (rstb_ipd = '1') THEN
              dib_reg <= (others => '0');
              adb_reg <= (others => '0');
              bwb_reg <= (others => '0');
              wrenb_reg <= '0';
              renb_reg <= '0';
           ELSIF (ceb_ipd = '1') THEN
              dib_reg <= dib_node;
              adb_reg <= adb_node;
              bwb_reg <= (adb_ipd(1), adb_ipd(0));
              wrenb_reg <= (wreb_ipd and csb_en);
              renb_reg <= ((not wreb_ipd) and csb_en);
           END IF;
        END IF;
     END IF;
  END PROCESS;

-- Warning for collision

  PW : PROCESS(ada_reg, adb_reg, wrena_reg, wrenb_reg, clka_valid, clkb_valid, rena_reg, 
       renb_reg) 
  VARIABLE WADDR_A_VALID : boolean := TRUE;
  VARIABLE WADDR_B_VALID : boolean := TRUE;
  VARIABLE ADDR_A : integer := 0;
  VARIABLE ADDR_B : integer := 0;
  VARIABLE DN_ADDR_A : integer := 0;
  VARIABLE UP_ADDR_A : integer := 0;
  VARIABLE DN_ADDR_B : integer := 0;
  VARIABLE UP_ADDR_B : integer := 0;
  BEGIN
     WADDR_A_VALID := Valid_Address (ada_reg);
     WADDR_B_VALID := Valid_Address (adb_reg);

     IF (WADDR_A_VALID = TRUE) THEN
        ADDR_A := conv_integer(ada_reg);
     END IF;
     IF (WADDR_B_VALID = TRUE) THEN
        ADDR_B := conv_integer(adb_reg);
     END IF;
  
     --DN_ADDR_A := (ADDR_A * DATA_WIDTH_A);
     --UP_ADDR_A := (((ADDR_A + 1) * DATA_WIDTH_A) - 1);
     --DN_ADDR_B := (ADDR_B * DATA_WIDTH_B);
     --UP_ADDR_B := (((ADDR_B + 1) * DATA_WIDTH_B) - 1);

	  DN_ADDR_A := (ADDR_A * DATA_WIDTH_A) + (ADDR_A / div_a);
	  UP_ADDR_A := DN_ADDR_A + (DATA_WIDTH_A - 1);
	  DN_ADDR_B := (ADDR_B * DATA_WIDTH_B) + (ADDR_B / div_b);
	  UP_ADDR_B := DN_ADDR_B + (DATA_WIDTH_B - 1);

          IF (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) THEN
             IF (wr_a_wr_b_coll = '1') THEN
                IF (clka_valid = '0' and clkb_valid = '0') THEN
                   wr_a_wr_b_coll <= '0';
                END IF;
             END IF;
          ELSE
             wr_a_wr_b_coll <= '0';
          END IF;

          IF (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) THEN
             IF (wr_a_rd_b_coll = '1') THEN
                IF (clka_valid = '0' and clkb_valid = '0') THEN
                   wr_a_rd_b_coll <= '0';
                END IF;
             END IF;
          ELSE
             wr_a_rd_b_coll <= '0';
          END IF;

          IF (not((UP_ADDR_A < DN_ADDR_B) or (DN_ADDR_A > UP_ADDR_B))) THEN
             IF (rd_a_wr_b_coll = '1') THEN
                IF (clka_valid = '0' and clkb_valid = '0') THEN
                   rd_a_wr_b_coll <= '0';
                END IF;
             END IF;
          ELSE
             rd_a_wr_b_coll <= '0';
          END IF;


	  if (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) then
		  if ((DN_ADDR_A > DN_ADDR_B) and (UP_ADDR_A < UP_ADDR_B)) then
			  dn_coll_addr <= DN_ADDR_A;
			  up_coll_addr <= UP_ADDR_A;
		  elsif ((DN_ADDR_B > DN_ADDR_A) and (UP_ADDR_B < UP_ADDR_A)) then
			  dn_coll_addr <= DN_ADDR_B;
			  up_coll_addr <= UP_ADDR_B;
		  elsif ((UP_ADDR_A - DN_ADDR_B) <= (UP_ADDR_B - DN_ADDR_A)) then
			  dn_coll_addr <= DN_ADDR_B;
			  up_coll_addr <= UP_ADDR_A;
		  else
			  dn_coll_addr <= DN_ADDR_A;
			  up_coll_addr <= UP_ADDR_B;
		  end if;
	  end if;

     IF ((wrena_reg = '1' and clka_valid = '1') and (wrenb_reg = '1' and clkb_valid = '1')) THEN 
        IF (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) THEN
--           assert false
--           report " Write collision! Writing in the same memory location using Port A and Port B will cause the memory content invalid."
--           severity warning;
			  wr_a_wr_b_coll <= '1';
        END IF;
     END IF;

     IF ((wrena_reg = '1' and clka_valid = '1') and (renb_reg = '1' and clkb_valid = '1')) THEN 
        IF (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) THEN
--           assert false
--           report " Write/Read collision! Writing through Port A and reading through Port B from the same memory location may give wrong output."
--           severity warning;
			  wr_a_rd_b_coll <= '1';
        END IF;
     END IF;

     IF ((rena_reg = '1' and clka_valid = '1') and (wrenb_reg = '1' and clkb_valid = '1')) THEN 
        IF (not((UP_ADDR_A < DN_ADDR_B) or (DN_ADDR_A > UP_ADDR_B))) THEN
--           assert false
--           report " Write/Read collision! Writing through Port B and reading through Port A from the same memory location may give wrong output."
--           severity warning;
			  rd_a_wr_b_coll <= '1';
        END IF;
     END IF;
  END PROCESS;

-- Writing to the memory

  P8 : PROCESS(ada_reg, dia_reg, diab_reg, bwa0_reg, bwa1_reg, wrena_reg, dib_reg, adb_reg,
               bwb_reg, wrenb_reg, clka_valid, clkb_valid,
					wr_a_wr_b_coll)
  VARIABLE WADDR_A_VALID : boolean := TRUE;
  VARIABLE WADDR_B_VALID : boolean := TRUE;
  VARIABLE WADDR_A : integer := 0;
  VARIABLE WADDR_B : integer := 0;
  VARIABLE dout_node_rbr : std_logic_vector(35 downto 0);
  BEGIN
     WADDR_A_VALID := Valid_Address (ada_reg);
     WADDR_B_VALID := Valid_Address (adb_reg);

     IF (WADDR_A_VALID = TRUE) THEN
        WADDR_A := conv_integer(ada_reg);
     END IF;
     IF (WADDR_B_VALID = TRUE) THEN
        WADDR_B := conv_integer(adb_reg);
     END IF;
    
     IF (DATA_WIDTH_A = 36) THEN
        IF (wrena_reg = '1' and clka_valid = '1') THEN
           FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
              dout_node_rbr(i) := MEM((WADDR_A * DATA_WIDTH_A) + i);
           END LOOP;
           doa_node_rbr <= dout_node_rbr(17 downto 0);
           dob_node_rbr <= dout_node_rbr(35 downto 18);

           IF (bwa0_reg(0) = '1') THEN
              FOR i IN 0 TO 8 LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i) <= diab_reg(i);
              END LOOP;
           END IF;
           IF (bwa0_reg(1) = '1') THEN
              FOR i IN 0 TO 8 LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i + 9) <= diab_reg(i + 9);
              END LOOP;
           END IF;
           IF (bwa1_reg(0) = '1') THEN
              FOR i IN 0 TO 8 LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i + 18) <= diab_reg(i + 18);
              END LOOP;
           END IF;
           IF (bwa1_reg(1) = '1') THEN
              FOR i IN 0 TO 8 LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i + 27) <= diab_reg(i + 27);
              END LOOP;
           END IF;
        END IF;
     ELSE
        IF (DATA_WIDTH_A = 18) THEN
           IF (wrena_reg = '1' and clka_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
              doa_node_rbr(i) <= MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i);
              END LOOP;

              IF (bwa0_reg(0) = '1') THEN
                 FOR i IN 0 TO 8 LOOP
                    MEM((WADDR_A * DATA_WIDTH_A) + i) <= dia_reg(i);
						  if ( (wr_a_wr_b_coll = '1') and
								 (((WADDR_A * DATA_WIDTH_A) + i) >= dn_coll_addr) and
								 (((WADDR_A * DATA_WIDTH_A) + i) <= up_coll_addr) and
								 ( (DATA_WIDTH_B < 18) or ((DATA_WIDTH_B = 18) and (bwb_reg(0) = '1')) ) ) then
							  MEM((WADDR_A * DATA_WIDTH_A) + i) <= 'X';
						  end if;
                 END LOOP;
              END IF;
              IF (bwa0_reg(1) = '1') THEN
                 FOR i IN 0 TO 8 LOOP
                    MEM((WADDR_A * DATA_WIDTH_A) + i + 9) <= dia_reg(i + 9);
						  if ( (wr_a_wr_b_coll = '1') and
								 (((WADDR_A * DATA_WIDTH_A) + i + 9) >= dn_coll_addr) and 
								 (((WADDR_A * DATA_WIDTH_A) + i + 9) <= up_coll_addr) and
								 ( (DATA_WIDTH_B < 18) or ((DATA_WIDTH_B = 18) and (bwb_reg(1) = '1')) ) ) then
							  MEM((WADDR_A * DATA_WIDTH_A) + i + 9) <= 'X';
						  end if;
                 END LOOP;
              END IF;
           END IF;
        ELSIF (DATA_WIDTH_A = 9) THEN
           IF (wrena_reg = '1' and clka_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
              doa_node_rbr(i) <= MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i);
              END LOOP;

              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i) <= dia_reg(i);
					  if ( (wr_a_wr_b_coll = '1') and
							 (((WADDR_A * DATA_WIDTH_A) + i) >= dn_coll_addr) and
							 (((WADDR_A * DATA_WIDTH_A) + i) <= up_coll_addr) and
							 ( (DATA_WIDTH_B < 18) or
								( (DATA_WIDTH_B = 18) and
								  ( ((bwb_reg(0) = '1') and (((WADDR_A * DATA_WIDTH_A) rem 18) = 0)) or
								    ((bwb_reg(1) = '1') and (((WADDR_A * DATA_WIDTH_A) rem 18) = 9)) ) ) ) ) then
						  MEM((WADDR_A * DATA_WIDTH_A) + i) <= 'X';
					  end if;
              END LOOP;
           END IF;
        ELSE
           IF (wrena_reg = '1' and clka_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
              doa_node_rbr(i) <= MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i);
              END LOOP;

              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i) <= dia_reg(i);
					  if ( (wr_a_wr_b_coll = '1') and
						    (((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i) >= dn_coll_addr) and
						    (((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i) <= up_coll_addr) and
							  ( (DATA_WIDTH_B < 18) or
								 ( (DATA_WIDTH_B = 18) and
								   ( ((bwb_reg(0) = '1') and ((((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a)) rem 18) < 9)) or
								     ((bwb_reg(1) = '1') and ((((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a)) rem 18) >= 9))
									) ) ) ) then
						  MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i) <= 'X';
					  end if;
              END LOOP;
           END IF;
        END IF;

        IF (DATA_WIDTH_B = 18) THEN
           IF (wrenb_reg = '1' and clkb_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
              dob_node_rbr(i) <= MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i);
              END LOOP;

              IF (bwb_reg(0) = '1') THEN
                 FOR i IN 0 TO 8 LOOP
                    MEM((WADDR_B * DATA_WIDTH_B) + i) <= dib_reg(i);
						  if ( (wr_a_wr_b_coll = '1') and
							    (((WADDR_B * DATA_WIDTH_B) + i) >= dn_coll_addr) and
							    (((WADDR_B * DATA_WIDTH_B) + i) <= up_coll_addr) and
								 ( (DATA_WIDTH_A < 18) or ((DATA_WIDTH_A = 18) and (bwa0_reg(0) = '1')) ) ) then
							  MEM((WADDR_B * DATA_WIDTH_B) + i) <= 'X';
						  end if;
                 END LOOP;
              END IF;
              IF (bwb_reg(1) = '1') THEN
                 FOR i IN 0 TO 8 LOOP
                    MEM((WADDR_B * DATA_WIDTH_B) + i + 9) <= dib_reg(i + 9);
						  if ( (wr_a_wr_b_coll = '1') and
							    (((WADDR_B * DATA_WIDTH_B) + i + 9) >= dn_coll_addr) and
							    (((WADDR_B * DATA_WIDTH_B) + i + 9) <= up_coll_addr) and
								 ( (DATA_WIDTH_A < 18) or ((DATA_WIDTH_A = 18) and (bwa0_reg(1) = '1')) ) ) then
							  MEM((WADDR_B * DATA_WIDTH_B) + i + 9) <= 'X';
						  end if;
                 END LOOP;
              END IF;
           END IF;
        ELSIF (DATA_WIDTH_B = 9) THEN
           IF (wrenb_reg = '1' and clkb_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
              dob_node_rbr(i) <= MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i);
              END LOOP;

              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
                  MEM((WADDR_B * DATA_WIDTH_B) + i) <= dib_reg(i);
						if ( (wr_a_wr_b_coll = '1') and
							  (((WADDR_B * DATA_WIDTH_B) + i) >= dn_coll_addr) and
							  (((WADDR_B * DATA_WIDTH_B) + i) <= up_coll_addr) and
							  ( (DATA_WIDTH_A < 18) or
								 ( (DATA_WIDTH_A = 18) and
									( ((bwa0_reg(0) = '1') and (((WADDR_B * DATA_WIDTH_B) rem 18) = 0)) or
									  ((bwa0_reg(1) = '1') and (((WADDR_B * DATA_WIDTH_B) rem 18) = 9)) ) ) ) ) then
							MEM((WADDR_B * DATA_WIDTH_B) + i) <= 'X';
						end if;
              END LOOP;
           END IF;
        ELSE
           IF (wrenb_reg = '1' and clkb_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
              dob_node_rbr(i) <= MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i);
              END LOOP;

              FOR i IN 0 TO (DATA_WIDTH_B - 1)  LOOP
                  MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i) <= dib_reg(i);
						if ( (wr_a_wr_b_coll = '1') and
							  (((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i) >= dn_coll_addr) and
							  (((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i) <= up_coll_addr) and
							  ( (DATA_WIDTH_A < 18) or
								 ( (DATA_WIDTH_A = 18) and
									( ((bwa0_reg(0) = '1') and ((((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b)) rem 18) < 9)) or
									  ((bwa0_reg(1) = '1') and ((((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b)) rem 18) >= 9))
									) ) ) ) then
							MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i) <= 'X';
						end if;
              END LOOP;
           END IF;
        END IF;
     END IF;
  END PROCESS;

  P9 : PROCESS(ada_reg, rena_reg, adb_reg, renb_reg, MEM, clka_valid1, clkb_valid1, rsta_sig, rstb_sig,
               doa_node_rbr, dob_node_rbr,
					wr_a_rd_b_coll, rd_a_wr_b_coll) 
  VARIABLE RADDR_A_VALID : boolean := TRUE;
  VARIABLE RADDR_B_VALID : boolean := TRUE;
  VARIABLE RADDR_A : integer := 0;
  VARIABLE RADDR_B : integer := 0;
  VARIABLE dout_node_tr : std_logic_vector(35 downto 0);
  VARIABLE dout_node_wt : std_logic_vector(35 downto 0);
  BEGIN
     RADDR_A_VALID := Valid_Address (ada_reg);
     RADDR_B_VALID := Valid_Address (adb_reg);

     IF (RADDR_A_VALID = TRUE) THEN
        RADDR_A := conv_integer(ada_reg);
     END IF;
     IF (RADDR_B_VALID = TRUE) THEN
        RADDR_B := conv_integer(adb_reg);
     END IF;

     IF (DATA_WIDTH_B = 36) THEN
        IF (rstb_sig = '1') THEN
           IF (RESETMODE = "SYNC") THEN
              IF (clkb_ipd = '1') THEN
                 doa_node <= (others => '0');
                 dob_node <= (others => '0');
              END IF;
           ELSIF (RESETMODE = "ASYNC") THEN
              doa_node <= (others => '0');
              dob_node <= (others => '0');
           END IF;
        ELSIF (clkb_valid1'event and clkb_valid1 = '1') THEN
           IF (renb_reg = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
                 dout_node_tr(i) := MEM((RADDR_B * DATA_WIDTH_B) + i);
					  if ( (wr_a_rd_b_coll = '1') and
							 (((RADDR_B * DATA_WIDTH_B) + i) >= dn_coll_addr) and
							 (((RADDR_B * DATA_WIDTH_B) + i) <= up_coll_addr) and
							 ( (DATA_WIDTH_A < 18) or
								( (DATA_WIDTH_A = 18) and
								  ( ((bwa0_reg(0) = '1') and ((((RADDR_B * DATA_WIDTH_B) + i) rem 18) < 9)) or
								    ((bwa0_reg(1) = '1') and ((((RADDR_B * DATA_WIDTH_B) + i) rem 18) >= 9)) ) ) or
								( (DATA_WIDTH_A = 36) and
								  ( ((bwa0_reg(0) = '1') and ((((RADDR_B * DATA_WIDTH_B) + i) rem 36) < 9)) or
								    ((bwa0_reg(1) = '1') and ((((RADDR_B * DATA_WIDTH_B) + i) rem 36) >= 9)
										                   and ((((RADDR_B * DATA_WIDTH_B) + i) rem 36) < 18)) or
								    ((bwa1_reg(0) = '1') and ((((RADDR_B * DATA_WIDTH_B) + i) rem 36) >= 18)
										                   and ((((RADDR_B * DATA_WIDTH_B) + i) rem 36) < 27)) or
								    ((bwa1_reg(1) = '1') and ((((RADDR_B * DATA_WIDTH_B) + i) rem 36) >= 27)) ) )
								 ) ) then
						  dout_node_tr(i) := 'X';
					  end if;
              END LOOP;
              doa_node <= dout_node_tr(17 downto 0);
              dob_node <= dout_node_tr(35 downto 18);
           ELSIF (renb_reg = '0') THEN
              IF (WRITEMODE_B = "WRITETHROUGH") THEN
                 FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
                    dout_node_wt(i) := MEM((RADDR_B * DATA_WIDTH_B) + i);
                 END LOOP;
                 doa_node <= dout_node_wt(17 downto 0);
                 dob_node <= dout_node_wt(35 downto 18);
              ELSIF (WRITEMODE_B = "READBEFOREWRITE") THEN
                 ASSERT false
                 report "WRITEMODE of READBEFOREWRITE is not supported !!"
                 severity ERROR;
                 doa_node <= doa_node_rbr;
                 dob_node <= dob_node_rbr;
              END IF;
           END IF;
        END IF;
     ELSE
        IF (rsta_sig = '1') THEN
           IF (RESETMODE = "SYNC") THEN
              IF (clka_ipd = '1') THEN
                 doa_node <= (others => '0');
              END IF;
           ELSIF (RESETMODE = "ASYNC") THEN
              doa_node <= (others => '0');
           END IF;
        ELSIF (clka_valid1 = '1') THEN
           IF (rena_reg = '1') THEN
              IF ( last_clka_valid1 = '0') THEN
                 FOR i IN 0 TO (new_data_width_a - 1)  LOOP
                    doa_node(i) <= MEM((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i);
					  if ( (rd_a_wr_b_coll = '1') and
							 (((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i) >= dn_coll_addr) and
							 (((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i) <= up_coll_addr) and
							 ( (DATA_WIDTH_B < 18) or
								( (DATA_WIDTH_B = 18) and
								  ( ((bwb_reg(0) = '1') and ((((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i) rem 18) < 9)) or
									 ((bwb_reg(1) = '1') and ((((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i) rem 18) >= 9))
								  ) ) ) ) then
						  doa_node(i) <= 'X';
					  end if;
                 END LOOP;
              END IF;
           ELSIF (rena_reg = '0') THEN
              IF (WRITEMODE_A = "WRITETHROUGH") THEN
                 IF (DATA_WIDTH_A <= 9) THEN
                    FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
                       doa_node(i) <= MEM((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i);
                    END LOOP;
                 ELSIF (DATA_WIDTH_A = 18) THEN
                    IF (bwa0_reg(0) = '1') THEN
                       FOR i IN 0 TO 8 LOOP
                          doa_node(i) <= MEM((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i);
                       END LOOP;
                    END IF;
                    IF (bwa0_reg(1) = '1') THEN
                       FOR i IN 9 TO 17 LOOP
                          doa_node(i) <= MEM((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i);
                       END LOOP;
                    END IF;
                 END IF;
              ELSIF (WRITEMODE_A = "READBEFOREWRITE") THEN
                 ASSERT false
                 report "WRITEMODE of READBEFOREWRITE is not supported !!"
                 severity ERROR;
                 IF ( last_clka_valid1 = '0') THEN
                    doa_node <= doa_node_rbr;
                 END IF;
              END IF;
           END IF;
        END IF;

        IF (rstb_sig = '1') THEN
           IF (RESETMODE = "SYNC") THEN
              IF (clkb_ipd = '1') THEN
                 dob_node <= (others => '0');
              END IF;
           ELSIF (RESETMODE = "ASYNC") THEN
              dob_node <= (others => '0');
           END IF;
        ELSIF (clkb_valid1 = '1') THEN
           IF (renb_reg = '1') THEN
              IF ( last_clkb_valid1 = '0') THEN
                 FOR i IN 0 TO (DATA_WIDTH_B - 1)  LOOP
                    dob_node(i) <= MEM((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i);
					  if ( (wr_a_rd_b_coll = '1') and
							 (((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) >= dn_coll_addr) and
							 (((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) <= up_coll_addr) and
							 ( (DATA_WIDTH_A < 18) or
								( (DATA_WIDTH_A = 18) and
								  ( ((bwa0_reg(0) = '1') and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 18) < 9)) or
								    ((bwa0_reg(1) = '1') and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 18) >= 9))
								  ) ) or
								( (DATA_WIDTH_A = 36) and
								  ( ((bwa0_reg(0) = '1') and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 36) < 9)) or
								    ((bwa0_reg(1) = '1') and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 36) >= 9)
										                   and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 36) < 18)) or
								    ((bwa1_reg(0) = '1') and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 36) >= 18)
										                   and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 36) < 27)) or
								    ((bwa1_reg(1) = '1') and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 36) >= 27))
								  ) ) ) ) then
						  dob_node(i) <= 'X';
					  end if;
                 END LOOP;
              END IF;
           ELSIF (renb_reg = '0') THEN
              IF (WRITEMODE_B = "WRITETHROUGH") THEN
                 IF (DATA_WIDTH_B <= 9) THEN
                    FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
                       dob_node(i) <= MEM((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i);
                    END LOOP;
                 ELSIF (DATA_WIDTH_B = 18) THEN
                    IF (bwb_reg(0) = '1') THEN
                       FOR i IN 0 TO 8 LOOP
                          dob_node(i) <= MEM((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i);
                       END LOOP;
                    END IF;
                    IF (bwb_reg(1) = '1') THEN
                       FOR i IN 9 TO 17 LOOP
                          dob_node(i) <= MEM((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i);
                       END LOOP;
                    END IF;
                 END IF;
              ELSIF (WRITEMODE_B = "READBEFOREWRITE") THEN
                 ASSERT false
                 report "WRITEMODE of READBEFOREWRITE is not supported !!"
                 severity ERROR;
                 IF ( last_clkb_valid1 = '0') THEN
                    dob_node <= dob_node_rbr;
                 END IF;
              END IF;
           END IF;
        END IF;
     END IF;
  END PROCESS;

  P10 : PROCESS(g_reset, rsta_ipd, rstb_ipd, clka_ipd, clkb_ipd)
  BEGIN
     IF (g_reset = '0') THEN
        doa_reg <= (others => '0');
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rsta_ipd = '1') THEN
           doa_reg <= (others => '0');
        ELSIF (clka_ipd'event and clka_ipd = '1') THEN
           IF (cea_ipd = '1') THEN
              doa_reg <= doa_node;
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN
        IF (clka_ipd'event and clka_ipd = '1') THEN
           IF (cea_ipd = '1') THEN
              IF (rsta_ipd = '1') THEN
                 doa_reg <= (others => '0');
              ELSIF (rsta_ipd = '0') THEN
                 doa_reg <= doa_node;
              END IF;
           END IF;
        END IF;
     END IF;

     IF (g_reset = '0') THEN
        dob_reg <= (others => '0');
        doab_reg <= (others => '0');
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rstb_ipd = '1') THEN
           dob_reg <= (others => '0');
           doab_reg <= (others => '0');
        ELSIF (clkb_ipd'event and clkb_ipd = '1') THEN
           IF (ceb_ipd = '1') THEN
              dob_reg <= dob_node;
              doab_reg <= doa_node;
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN
        IF (clkb_ipd'event and clkb_ipd = '1') THEN
           IF (ceb_ipd = '1') THEN
              IF (rstb_ipd = '1') THEN
                 dob_reg <= (others => '0');
                 doab_reg <= (others => '0');
              ELSIF (rstb_ipd = '0') THEN
                 dob_reg <= dob_node;
                 doab_reg <= doa_node;
              END IF;
           END IF;
        END IF;
     END IF;
  END PROCESS;

  P11 : PROCESS(doa_node, dob_node, doa_reg, dob_reg, doab_reg)
  BEGIN
     IF (REGMODE_A = "OUTREG") THEN 
        IF (DATA_WIDTH_B = 36) THEN
           doa_int <= doab_reg;
        ELSE
           doa_int <= doa_reg;
        END IF;
     ELSE
        doa_int <= doa_node;
     END IF;

     IF (REGMODE_B = "OUTREG") THEN 
        dob_int <= dob_reg;
     ELSE
        dob_int <= dob_node;
     END IF;
  END PROCESS;

  (doa17, doa16, doa15, doa14, doa13, doa12, doa11, doa10, doa9, doa8, doa7, doa6,
   doa5, doa4, doa3, doa2, doa1, doa0) <= doa_int;

  (dob17, dob16, dob15, dob14, dob13, dob12, dob11, dob10, dob9, dob8, dob7, dob6,
   dob5, dob4, dob3, dob2, dob1, dob0) <= dob_int;

END V;


--
-----cell sp16kb----
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use ieee.std_logic_unsigned.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY sp16kb IS
   GENERIC (
        DATA_WIDTH               : Integer  := 18;
        REGMODE                  : String  := "NOREG";
        RESETMODE                : String  := "SYNC";
        CSDECODE                 : std_logic_vector(2 downto 0)  := "000";
        WRITEMODE                : String  := "NORMAL";
        GSR                      : String  := "DISABLED";
        initval_00 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_20 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_21 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_22 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_23 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_24 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_25 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_26 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_27 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_28 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_29 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_30 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_31 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_32 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_33 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_34 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_35 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_36 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_37 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_38 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_39 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000");

   PORT(
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        ad0, ad1, ad2, ad3, ad4, ad5, ad6, ad7, ad8            : in std_logic := 'X';
        ad9, ad10, ad11, ad12, ad13                                : in std_logic := 'X';
        ce, clk, we, cs0, cs1, cs2, rst                         : in std_logic := 'X';

        do0, do1, do2, do3, do4, do5, do6, do7, do8            : out std_logic := 'X';
        do9, do10, do11, do12, do13, do14, do15, do16, do17    : out std_logic := 'X'
  );

      ATTRIBUTE Vital_Level0 OF sp16kb : ENTITY IS TRUE;

END sp16kb ;

architecture V of sp16kb is

signal lo: std_logic := '0';
signal hi: std_logic := '1';

component dp16kb
GENERIC(
        DATA_WIDTH_A : in Integer;
        DATA_WIDTH_B : in Integer;
        REGMODE_A    : in String;
        REGMODE_B    : in String;
        RESETMODE    : in String;
        CSDECODE_A   : in std_logic_vector(2 downto 0);
        CSDECODE_B   : in std_logic_vector(2 downto 0);
        WRITEMODE_A  : in String;
        WRITEMODE_B  : in String;
        GSR : in String;
        initval_00 : in string;
        initval_01 : in string;
        initval_02 : in string;
        initval_03 : in string;
        initval_04 : in string;
        initval_05 : in string;
        initval_06 : in string;
        initval_07 : in string;
        initval_08 : in string;
        initval_09 : in string;
        initval_0a : in string;
        initval_0b : in string;
        initval_0c : in string;
        initval_0d : in string;
        initval_0e : in string;
        initval_0f : in string;
        initval_10 : in string;
        initval_11 : in string;
        initval_12 : in string;
        initval_13 : in string;
        initval_14 : in string;
        initval_15 : in string;
        initval_16 : in string;
        initval_17 : in string;
        initval_18 : in string;
        initval_19 : in string;
        initval_1a : in string;
        initval_1b : in string;
        initval_1c : in string;
        initval_1d : in string;
        initval_1e : in string;
        initval_1f : in string;
        initval_20 : in string;
        initval_21 : in string;
        initval_22 : in string;
        initval_23 : in string;
        initval_24 : in string;
        initval_25 : in string;
        initval_26 : in string;
        initval_27 : in string;
        initval_28 : in string;
        initval_29 : in string;
        initval_2a : in string;
        initval_2b : in string;
        initval_2c : in string;
        initval_2d : in string;
        initval_2e : in string;
        initval_2f : in string;
        initval_30 : in string;
        initval_31 : in string;
        initval_32 : in string;
        initval_33 : in string;
        initval_34 : in string;
        initval_35 : in string;
        initval_36 : in string;
        initval_37 : in string;
        initval_38 : in string;
        initval_39 : in string;
        initval_3a : in string;
        initval_3b : in string;
        initval_3c : in string;
        initval_3d : in string;
        initval_3e : in string;
        initval_3f : in string);

PORT(
        dia0, dia1, dia2, dia3, dia4, dia5, dia6, dia7, dia8            : in std_logic;
        dia9, dia10, dia11, dia12, dia13, dia14, dia15, dia16, dia17    : in std_logic;
        ada0, ada1, ada2, ada3, ada4, ada5, ada6, ada7, ada8            : in std_logic;
        ada9, ada10, ada11, ada12, ada13                                : in std_logic;
        cea, clka, wea, csa0, csa1, csa2, rsta                         : in std_logic;
        dib0, dib1, dib2, dib3, dib4, dib5, dib6, dib7, dib8            : in std_logic;
        dib9, dib10, dib11, dib12, dib13, dib14, dib15, dib16, dib17    : in std_logic;
        adb0, adb1, adb2, adb3, adb4, adb5, adb6, adb7, adb8            : in std_logic;
        adb9, adb10, adb11, adb12, adb13                                : in std_logic;
        ceb, clkb, web, csb0, csb1, csb2, rstb                         : in std_logic;

        doa0, doa1, doa2, doa3, doa4, doa5, doa6, doa7, doa8            : out std_logic;
        doa9, doa10, doa11, doa12, doa13, doa14, doa15, doa16, doa17    : out std_logic;
        dob0, dob1, dob2, dob3, dob4, dob5, dob6, dob7, dob8            : out std_logic;
        dob9, dob10, dob11, dob12, dob13, dob14, dob15, dob16, dob17    : out std_logic
  );
END COMPONENT;

begin
    -- component instantiation statements
  dp16kb_inst : dp16kb
  generic map (DATA_WIDTH_A => DATA_WIDTH,
               DATA_WIDTH_B => DATA_WIDTH,
               REGMODE_A    => REGMODE,
               REGMODE_B    => REGMODE,
               RESETMODE    => RESETMODE,
               CSDECODE_A   => CSDECODE,
               CSDECODE_B   => CSDECODE,
               WRITEMODE_A  => WRITEMODE,
               WRITEMODE_B  => WRITEMODE,
               GSR => GSR,
        initval_00 => initval_00,
        initval_01 => initval_01,
        initval_02 => initval_02,
        initval_03 => initval_03,
        initval_04 => initval_04,
        initval_05 => initval_05,
        initval_06 => initval_06,
        initval_07 => initval_07,
        initval_08 => initval_08,
        initval_09 => initval_09,
        initval_0a => initval_0a,
        initval_0b => initval_0b,
        initval_0c => initval_0c,
        initval_0d => initval_0d,
        initval_0e => initval_0e,
        initval_0f => initval_0f,
        initval_10 => initval_10,
        initval_11 => initval_11,
        initval_12 => initval_12,
        initval_13 => initval_13,
        initval_14 => initval_14,
        initval_15 => initval_15,
        initval_16 => initval_16,
        initval_17 => initval_17,
        initval_18 => initval_18,
        initval_19 => initval_19,
        initval_1a => initval_1a,
        initval_1b => initval_1b,
        initval_1c => initval_1c,
        initval_1d => initval_1d,
        initval_1e => initval_1e,
        initval_1f => initval_1f,
        initval_20 => initval_20,
        initval_21 => initval_21,
        initval_22 => initval_22,
        initval_23 => initval_23,
        initval_24 => initval_24,
        initval_25 => initval_25,
        initval_26 => initval_26,
        initval_27 => initval_27,
        initval_28 => initval_28,
        initval_29 => initval_29,
        initval_2a => initval_2a,
        initval_2b => initval_2b,
        initval_2c => initval_2c,
        initval_2d => initval_2d,
        initval_2e => initval_2e,
        initval_2f => initval_2f,
        initval_30 => initval_30,
        initval_31 => initval_31,
        initval_32 => initval_32,
        initval_33 => initval_33,
        initval_34 => initval_34,
        initval_35 => initval_35,
        initval_36 => initval_36,
        initval_37 => initval_37,
        initval_38 => initval_38,
        initval_39 => initval_39,
        initval_3a => initval_3a,
        initval_3b => initval_3b,
        initval_3c => initval_3c,
        initval_3d => initval_3d,
        initval_3e => initval_3e,
        initval_3f => initval_3f)
  port map (dia0 => di0, dia1 => di1, dia2 => di2, dia3 => di3,
  dia4 => di4, dia5 => di5, dia6 => di6, dia7 => di7, dia8 => di8,
  dia9 => di9, dia10 => di10, dia11 => di11, dia12 => di12, dia13 => di13,
  dia14 => di14, dia15 => di15, dia16 => di16, dia17 => di17, dib0 => lo,
  dib1 => lo, dib2 => lo, dib3 => lo, dib4 => lo, dib5 => lo,
  dib6 => lo, dib7 => lo, dib8 => lo, dib9 => lo, dib10 => lo,
  dib11 => lo, dib12 => lo, dib13 => lo, dib14 => lo, dib15 => lo,
  dib16 => lo, dib17 => lo,
  cea => ce, clka => clk, wea => we, csa0 => cs0, csa1 => cs1, csa2 => cs2,
  rsta => rst, ada0 => ad0, ada1 => ad1, ada2 => ad2, ada3 => ad3,
  ada4 => ad4, ada5 => ad5, ada6 => ad6, ada7 => ad7, ada8 => ad8,
  ada9 => ad9, ada10 => ad10, ada11 => ad11, ada12 => ad12, ada13 => ad13,
  ceb => lo, clkb => lo, web => lo, csb0 => lo, csb1 => lo, csb2 => lo,
  rstb => hi, adb0 => lo, adb1 => lo, adb2 => lo, adb3 => lo,
  adb4 => lo, adb5 => lo, adb6 => lo, adb7 => lo, adb8 => lo,
  adb9 => lo, adb10 => lo, adb11 => lo, adb12 => lo, adb13 => lo,
  dob0 => open, dob1 => open, dob2 => open, dob3 => open,
  dob4 => open, dob5 => open, dob6 => open, dob7 => open, dob8 => open,
  dob9 => open, dob10 => open, dob11 => open, dob12 => open, dob13 => open,
  dob14 => open, dob15 => open, dob16 => open, dob17 => open, doa0 => do0,
  doa1 => do1, doa2 => do2, doa3 => do3, doa4 => do4, doa5 => do5,
  doa6 => do6, doa7 => do7, doa8 => do8, doa9 => do9, doa10 => do10,
  doa11 => do11, doa12 => do12, doa13 => do13, doa14 => do14, doa15 => do15,
  doa16 => do16, doa17 => do17);

end V;

--
-----cell pdpw16kb----
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use ieee.std_logic_unsigned.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY pdpw16kb IS
   GENERIC (
        DATA_WIDTH_W              : Integer  := 18;
        DATA_WIDTH_R              : Integer  := 18;
        REGMODE                   : String  := "NOREG";
        RESETMODE                  : String  := "SYNC";
        CSDECODE_W                 : std_logic_vector(2 downto 0)  := "000";
        CSDECODE_R                 : std_logic_vector(2 downto 0)  := "000";
        GSR                        : String  := "DISABLED";
        initval_00 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_20 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_21 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_22 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_23 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_24 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_25 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_26 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_27 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_28 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_29 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_30 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_31 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_32 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_33 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_34 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_35 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_36 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_37 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_38 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_39 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000");

   PORT(
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        di18, di19, di20, di21, di22, di23, di24, di25, di26   : in std_logic := 'X';
        di27, di28, di29, di30, di31, di32, di33, di34, di35   : in std_logic := 'X';
        adw0, adw1, adw2, adw3, adw4, adw5, adw6, adw7, adw8   : in std_logic := 'X';
        be0, be1, be2, be3                                     : in std_logic := 'X';
        cew, clkw, csw0, csw1, csw2                        : in std_logic := 'X';
        adr0, adr1, adr2, adr3, adr4, adr5, adr6, adr7, adr8   : in std_logic := 'X';
        adr9, adr10, adr11, adr12, adr13                       : in std_logic := 'X';
        cer, clkr, csr0, csr1, csr2, rst                       : in std_logic := 'X';

        do0, do1, do2, do3, do4, do5, do6, do7, do8            : out std_logic := 'X';
        do9, do10, do11, do12, do13, do14, do15, do16, do17    : out std_logic := 'X';
        do18, do19, do20, do21, do22, do23, do24, do25, do26   : out std_logic := 'X';
        do27, do28, do29, do30, do31, do32, do33, do34, do35   : out std_logic := 'X'
  );

      ATTRIBUTE Vital_Level0 OF pdpw16kb : ENTITY IS TRUE;

END pdpw16kb ;

architecture V of pdpw16kb is

signal lo: std_logic := '0';
signal hi : std_logic := '1';

component dp16kb
GENERIC(
        DATA_WIDTH_A : in Integer;
        DATA_WIDTH_B : in Integer;
        REGMODE_A    : in String;
        REGMODE_B    : in String;
        RESETMODE    : in String;
        CSDECODE_A   : in std_logic_vector(2 downto 0);
        CSDECODE_B   : in std_logic_vector(2 downto 0);
        GSR : in String;
        initval_00 : in string;
        initval_01 : in string;
        initval_02 : in string;
        initval_03 : in string;
        initval_04 : in string;
        initval_05 : in string;
        initval_06 : in string;
        initval_07 : in string;
        initval_08 : in string;
        initval_09 : in string;
        initval_0a : in string;
        initval_0b : in string;
        initval_0c : in string;
        initval_0d : in string;
        initval_0e : in string;
        initval_0f : in string;
        initval_10 : in string;
        initval_11 : in string;
        initval_12 : in string;
        initval_13 : in string;
        initval_14 : in string;
        initval_15 : in string;
        initval_16 : in string;
        initval_17 : in string;
        initval_18 : in string;
        initval_19 : in string;
        initval_1a : in string;
        initval_1b : in string;
        initval_1c : in string;
        initval_1d : in string;
        initval_1e : in string;
        initval_1f : in string;
        initval_20 : in string;
        initval_21 : in string;
        initval_22 : in string;
        initval_23 : in string;
        initval_24 : in string;
        initval_25 : in string;
        initval_26 : in string;
        initval_27 : in string;
        initval_28 : in string;
        initval_29 : in string;
        initval_2a : in string;
        initval_2b : in string;
        initval_2c : in string;
        initval_2d : in string;
        initval_2e : in string;
        initval_2f : in string;
        initval_30 : in string;
        initval_31 : in string;
        initval_32 : in string;
        initval_33 : in string;
        initval_34 : in string;
        initval_35 : in string;
        initval_36 : in string;
        initval_37 : in string;
        initval_38 : in string;
        initval_39 : in string;
        initval_3a : in string;
        initval_3b : in string;
        initval_3c : in string;
        initval_3d : in string;
        initval_3e : in string;
        initval_3f : in string);

PORT(
        dia0, dia1, dia2, dia3, dia4, dia5, dia6, dia7, dia8            : in std_logic;
        dia9, dia10, dia11, dia12, dia13, dia14, dia15, dia16, dia17    : in std_logic;
        ada0, ada1, ada2, ada3, ada4, ada5, ada6, ada7, ada8            : in std_logic;
        ada9, ada10, ada11, ada12, ada13                                : in std_logic;
        cea, clka, wea, csa0, csa1, csa2, rsta                          : in std_logic;
        dib0, dib1, dib2, dib3, dib4, dib5, dib6, dib7, dib8            : in std_logic;
        dib9, dib10, dib11, dib12, dib13, dib14, dib15, dib16, dib17    : in std_logic;
        adb0, adb1, adb2, adb3, adb4, adb5, adb6, adb7, adb8            : in std_logic;
        adb9, adb10, adb11, adb12, adb13                                : in std_logic;
        ceb, clkb, web, csb0, csb1, csb2, rstb                          : in std_logic;

        doa0, doa1, doa2, doa3, doa4, doa5, doa6, doa7, doa8            : out std_logic;
        doa9, doa10, doa11, doa12, doa13, doa14, doa15, doa16, doa17    : out std_logic;
        dob0, dob1, dob2, dob3, dob4, dob5, dob6, dob7, dob8            : out std_logic;
        dob9, dob10, dob11, dob12, dob13, dob14, dob15, dob16, dob17    : out std_logic
  );
END COMPONENT;

begin
    -- component instantiation statements
  dp16kb_inst : dp16kb
  generic map (DATA_WIDTH_A => DATA_WIDTH_W,
               DATA_WIDTH_B => DATA_WIDTH_R,
               REGMODE_A    => REGMODE,
               REGMODE_B    => REGMODE,
               RESETMODE    => RESETMODE,
               CSDECODE_A   => CSDECODE_W,
               CSDECODE_B   => CSDECODE_R,
               GSR => GSR,
        initval_00 => initval_00,
        initval_01 => initval_01,
        initval_02 => initval_02,
        initval_03 => initval_03,
        initval_04 => initval_04,
        initval_05 => initval_05,
        initval_06 => initval_06,
        initval_07 => initval_07,
        initval_08 => initval_08,
        initval_09 => initval_09,
        initval_0a => initval_0a,
        initval_0b => initval_0b,
        initval_0c => initval_0c,
        initval_0d => initval_0d,
        initval_0e => initval_0e,
        initval_0f => initval_0f,
        initval_10 => initval_10,
        initval_11 => initval_11,
        initval_12 => initval_12,
        initval_13 => initval_13,
        initval_14 => initval_14,
        initval_15 => initval_15,
        initval_16 => initval_16,
        initval_17 => initval_17,
        initval_18 => initval_18,
        initval_19 => initval_19,
        initval_1a => initval_1a,
        initval_1b => initval_1b,
        initval_1c => initval_1c,
        initval_1d => initval_1d,
        initval_1e => initval_1e,
        initval_1f => initval_1f,
        initval_20 => initval_20,
        initval_21 => initval_21,
        initval_22 => initval_22,
        initval_23 => initval_23,
        initval_24 => initval_24,
        initval_25 => initval_25,
        initval_26 => initval_26,
        initval_27 => initval_27,
        initval_28 => initval_28,
        initval_29 => initval_29,
        initval_2a => initval_2a,
        initval_2b => initval_2b,
        initval_2c => initval_2c,
        initval_2d => initval_2d,
        initval_2e => initval_2e,
        initval_2f => initval_2f,
        initval_30 => initval_30,
        initval_31 => initval_31,
        initval_32 => initval_32,
        initval_33 => initval_33,
        initval_34 => initval_34,
        initval_35 => initval_35,
        initval_36 => initval_36,
        initval_37 => initval_37,
        initval_38 => initval_38,
        initval_39 => initval_39,
        initval_3a => initval_3a,
        initval_3b => initval_3b,
        initval_3c => initval_3c,
        initval_3d => initval_3d,
        initval_3e => initval_3e,
        initval_3f => initval_3f)
  port map (dia0 => di0, dia1 => di1, dia2 => di2, dia3 => di3,
  dia4 => di4, dia5 => di5, dia6 => di6, dia7 => di7, dia8 => di8,
  dia9 => di9, dia10 => di10, dia11 => di11, dia12 => di12, dia13 => di13,
  dia14 => di14, dia15 => di15, dia16 => di16, dia17 => di17, dib0 => di18,
  dib1 => di19, dib2 => di20, dib3 => di21, dib4 => di22, dib5 => di23,
  dib6 => di24, dib7 => di25, dib8 => di26, dib9 => di27, dib10 => di28,
  dib11 => di29, dib12 => di30, dib13 => di31, dib14 => di32, dib15 => di33,
  dib16 => di34, dib17 => di35,
  cea => cew, clka => clkw, wea => hi, csa0 => csw0, csa1 => csw1, csa2 => csw2,
  rsta => rst, ada0 => be0, ada1 => be1, ada2 => be2, ada3 => be3,
  ada4 => lo, ada5 => adw0, ada6 => adw1, ada7 => adw2, ada8 => adw3,
  ada9 => adw4, ada10 => adw5, ada11 => adw6, ada12 => adw7, ada13 => adw8,
  ceb => cer, clkb => clkr, web => lo, csb0 => csr0, csb1 => csr1, csb2 => csr2,
  rstb => rst, adb0 => adr0, adb1 => adr1, adb2 => adr2, adb3 => adr3,
  adb4 => adr4, adb5 => adr5, adb6 => adr6, adb7 => adr7, adb8 => adr8,
  adb9 => adr9, adb10 => adr10, adb11 => adr11, adb12 => adr12, adb13 => adr13,
  dob0 => do0, dob1 => do1, dob2 => do2, dob3 => do3,
  dob4 => do4, dob5 => do5, dob6 => do6, dob7 => do7, dob8 => do8,
  dob9 => do9, dob10 => do10, dob11 => do11, dob12 => do12, dob13 => do13,
  dob14 => do14, dob15 => do15, dob16 => do16, dob17 => do17, doa0 => do18,
  doa1 => do19, doa2 => do20, doa3 => do21, doa4 => do22, doa5 => do23,
  doa6 => do24, doa7 => do25, doa8 => do26, doa9 => do27, doa10 => do28,
  doa11 => do29, doa12 => do30, doa13 => do31, doa14 => do32, doa15 => do33,
  doa16 => do34, doa17 => do35);

end V;

----- cell dcs -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY dcs IS
   GENERIC(
      DCSMODE         : String  := "NEG";
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "dcs";
      tipd_clk0         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_clk1         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sel         : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      clk0              : IN    std_logic;
      clk1              : IN    std_logic;
      sel              : IN    std_logic;
      dcsout               : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF dcs : ENTITY IS TRUE;

END dcs;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF dcs IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL clk0_ipd         : std_logic := 'X';
   SIGNAL clk1_ipd         : std_logic := 'X';
   SIGNAL sel_ipd         : std_logic := 'X';
   SIGNAL sel_int1        : std_logic := '0';
   SIGNAL sel_int2        : std_logic := '0';
   SIGNAL sel_int3        : std_logic_vector(1 downto 0) := "00";
   SIGNAL dcsout_int1         : std_logic := '0';
   SIGNAL sel_int4        : std_logic := '0';
   SIGNAL sel_int5        : std_logic := '0';
   SIGNAL sel_int6        : std_logic_vector(1 downto 0) := "00";
   SIGNAL dcsout_int2         : std_logic := '0';
   SIGNAL sel_int7        : std_logic := '0';
   SIGNAL sel_int8        : std_logic := '0';
   SIGNAL sel_int9        : std_logic := '0';
   SIGNAL sel_int10       : std_logic := '0';
   SIGNAL dcsout_int3         : std_logic := '0';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (clk0_ipd, clk0, tipd_clk0);
   VitalWireDelay (clk1_ipd, clk1, tipd_clk1);
   VitalWireDelay (sel_ipd, sel, tipd_sel);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   P1 : PROCESS (clk0_ipd, clk1_ipd)
   BEGIN
        IF (clk0_ipd'event and clk0_ipd = '0') THEN
           IF (sel_ipd = '1') THEN
              sel_int1 <= sel_ipd;
           END IF;
--           ELSIF (sel_ipd = '0') THEN
           IF (sel_int1 = '0') THEN
              sel_int2 <= sel_int1;
           END IF;
        END IF;
        IF (clk1_ipd'event and clk1_ipd = '0') THEN
           IF (sel_ipd = '0') THEN
              sel_int1 <= sel_ipd;
           END IF;
--           ELSIF (sel_ipd = '1') THEN
           IF (sel_int1 = '1') THEN
              sel_int2 <= sel_int1;
           END IF;
        END IF;
   END PROCESS;       

   sel_int3 <= (sel_int2, sel_int1);

   P2 : PROCESS (clk0_ipd, clk1_ipd, sel_int3)
   BEGIN
        case sel_int3 is
           when "00" => dcsout_int1 <= clk0_ipd;
           when "01" => dcsout_int1 <= '0';
           when "10" => dcsout_int1 <= '0';
           when "11" => dcsout_int1 <= clk1_ipd;
           when others => NULL;
        end case;
   END PROCESS;

   P3 : PROCESS (clk0_ipd, clk1_ipd)
   BEGIN
        IF (clk0_ipd'event and clk0_ipd = '1') THEN
           IF (sel_ipd = '1') THEN
              sel_int4 <= sel_ipd;
           END IF;
           IF (sel_int4 = '0') THEN
              sel_int5 <= sel_int4;
           END IF;
        END IF;
        IF (clk1_ipd'event and clk1_ipd = '1') THEN
           IF (sel_ipd = '0') THEN
              sel_int4 <= sel_ipd;
           END IF;
           IF (sel_int4 = '1') THEN
              sel_int5 <= sel_int4;
           END IF;
        END IF;
   END PROCESS;

   sel_int6 <= (sel_int5, sel_int4);

   P4 : PROCESS (clk0_ipd, clk1_ipd, sel_int6)
   BEGIN
        case sel_int6 is
           when "00" => dcsout_int2 <= clk0_ipd;
           when "01" => dcsout_int2 <= '1';
           when "10" => dcsout_int2 <= '1';
           when "11" => dcsout_int2 <= clk1_ipd;
           when others => NULL;
        end case;
   END PROCESS;

   P7 : PROCESS (clk1_ipd)
   BEGIN
      IF (clk1_ipd'event and clk1_ipd = '0') THEN
            sel_int7 <= sel_ipd;
      END IF;
   END PROCESS;

   P8 : PROCESS (clk0_ipd)
   BEGIN
      IF (clk0_ipd'event and clk0_ipd = '0') THEN
            sel_int8 <= sel_ipd;
      END IF;
   END PROCESS;

   P9 : PROCESS (clk1_ipd)
   BEGIN
      IF (clk1_ipd'event and clk1_ipd = '1') THEN
            sel_int9 <= sel_ipd;
      END IF;
   END PROCESS;

   P10 : PROCESS (clk0_ipd)
   BEGIN
      IF (clk0_ipd'event and clk0_ipd = '1') THEN
            sel_int10 <= sel_ipd;
      END IF;
   END PROCESS;

   P11 : PROCESS (clk0_ipd, clk1_ipd, sel_ipd, sel_int7, sel_int8, sel_int9, sel_int10)
   BEGIN
      IF (DCSMODE = "HIGH_LOW") THEN
        dcsout_int3 <= vitalmux 
                          (data => (clk1_ipd, '0'),
                           dselect => (0 => sel_int7));
      ELSIF (DCSMODE = "HIGH_HIGH") THEN
        dcsout_int3 <= vitalmux 
                          (data => (clk1_ipd, '1'),
                           dselect => (0 => sel_int9));
      ELSIF (DCSMODE = "LOW_LOW") THEN
        dcsout_int3 <= vitalmux 
                          (data => ('0', clk0_ipd),
                           dselect => (0 => sel_int8));
      ELSIF (DCSMODE = "LOW_HIGH") THEN
        dcsout_int3 <= vitalmux 
                          (data => ('1', clk0_ipd),
                           dselect => (0 => sel_int10));
      ELSIF (DCSMODE = "CLK0") THEN
        dcsout_int3 <= vitalmux 
                          (data => (clk0_ipd, clk0_ipd),
                           dselect => (0 => sel_ipd));
      ELSIF (DCSMODE = "CLK1") THEN
        dcsout_int3 <= vitalmux 
                          (data => (clk1_ipd, clk1_ipd),
                           dselect => (0 => sel_ipd));
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (dcsout_int1, dcsout_int2, dcsout_int3)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS dcsout_zd       : std_ulogic IS results(1);

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
   IF (DCSMODE = "NEG") THEN
      dcsout_zd := dcsout_int1;
   ELSIF (DCSMODE = "POS") THEN
      dcsout_zd := dcsout_int2;
   ELSE
      dcsout_zd := dcsout_int3;
   END IF;       

   dcsout <= dcsout_zd;

END PROCESS;

END v;



--*********************************************************************
----- CELL MULT2 -----
--*********************************************************************
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity MULT2 is

   port(
      A0                             :	in    STD_ULOGIC;
      A1                             :	in    STD_ULOGIC;
      A2                             :	in    STD_ULOGIC;
      A3                             :	in    STD_ULOGIC;
      B0                             :	in    STD_ULOGIC;
      B1                             :	in    STD_ULOGIC;
      B2                             :	in    STD_ULOGIC;
      B3                             :	in    STD_ULOGIC;
      CI                            :	in    STD_ULOGIC;
      P0                             :	out   STD_ULOGIC;
      P1                             :	out   STD_ULOGIC;
      CO                           :	out   STD_ULOGIC);

   attribute VITAL_LEVEL0 of MULT2 : entity is TRUE;
end MULT2;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of MULT2 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

begin

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0, B0, A1, B1, A2, B2, A3, B3, CI)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 3) := (others => 'X');
   ALIAS P0_zd : STD_LOGIC is Results(1);
   ALIAS P1_zd : STD_LOGIC is Results(2);
   ALIAS CO_zd : STD_LOGIC is Results(3);

   VARIABLE C_int         : STD_LOGIC := 'X';

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      P0_zd := ((B0) AND (A0)) XOR ((B1) AND (A1)) XOR (CI);
      C_int := (A0 AND B0 AND A1 AND B1) OR (A0 AND B0 AND CI) OR (A1 AND B1 AND CI);

      P1_zd := ((B2) AND (A2)) XOR ((B3) AND (A3)) XOR (C_int);
      CO_zd := (A2 AND B2 AND A3 AND B3) OR (A2 AND B2 AND C_int) OR (A3 AND B3 AND C_int);

      P0 <= P0_zd;
      P1 <= P1_zd;
      CO <= CO_zd;

   end process;

end V;

configuration CFG_MULT2_V of MULT2 is
   for V
   end for;
end CFG_MULT2_V;


------CELL ODDRXC------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
entity ODDRXC is
    GENERIC (
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ODDRXC";
        -- input SIGNAL delays
        tipd_da                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_db                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rst                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clk                : VitalDelayType01 := (0.0 ns, 0.0 ns));

    port(
          da            :       in      STD_LOGIC;
          db            :       in      STD_LOGIC;
          clk           :       in      STD_LOGIC;
          rst           :       in      STD_LOGIC;
          q             :       out     STD_LOGIC
        );

attribute VITAL_LEVEL0 of ODDRXC : entity is TRUE;
end ODDRXC;

-- architecture body --

architecture V of ODDRXC is
  attribute VITAL_LEVEL0 of V : architecture is TRUE;
    SIGNAL da_ipd    : std_logic := '0';
    SIGNAL db_ipd    : std_logic := '0';
    SIGNAL clk_ipd    : std_logic := '0';
    SIGNAL rst_ipd  : std_logic := '0';
    SIGNAL QP0       : std_logic := '0';
    SIGNAL QP1       : std_logic := '0';
    SIGNAL QN       : std_logic := '0';

begin
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(da_ipd, da, tipd_da);
       VitalWireDelay(db_ipd, db, tipd_db);
       VitalWireDelay(clk_ipd, clk, tipd_clk);
       VitalWireDelay(rst_ipd, rst, tipd_rst);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------

  P1: PROCESS(clk_ipd)
  BEGIN
     IF (clk_ipd = 'X') THEN
         IF (QN /= da_ipd) THEN
            QN <= 'X';
         END IF;
      ELSIF (clk_ipd'event and clk_ipd'last_value = '0' and clk_ipd = '1') THEN
         IF (rst_ipd = '1') THEN
            QN <= '0';
         ELSE
            QN <= da_ipd;
         END IF;
      END IF;
   END PROCESS;

  P2: PROCESS(clk_ipd)
  BEGIN
     IF (clk_ipd = 'X') THEN
         IF (QP0 /= db_ipd) THEN
            QP0 <= 'X';
         END IF;
      ELSIF (clk_ipd'event and clk_ipd'last_value = '0' and clk_ipd = '1') THEN
         QP0 <= db_ipd;
      END IF;
   END PROCESS;

  P3: PROCESS(clk_ipd, QP0)
  BEGIN
     IF (clk_ipd = 'X') THEN
         IF (QP1 /= QP0) THEN
            QP1 <= 'X';
         END IF;
      ELSIF (clk_ipd = '0') THEN
         QP1 <= QP0;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (clk_ipd, QP1, QN)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      q <= vitalmux
                 (data => (QP1, QN),
                  dselect => (0 => clk_ipd));

   END PROCESS;

END v;


------CELL ODDRMXA------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
entity ODDRMXA is
    GENERIC (
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ODDRMXA";
        -- input SIGNAL delays
        tipd_da                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_db                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rst                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dqsxfer                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clk                : VitalDelayType01 := (0.0 ns, 0.0 ns));

    port(
          da            :       in      STD_LOGIC;
          db            :       in      STD_LOGIC;
          clk           :       in      STD_LOGIC;
          dqsxfer          :       in      STD_LOGIC;
          rst           :       in      STD_LOGIC;
          q             :       out     STD_LOGIC
        );

attribute VITAL_LEVEL0 of ODDRMXA : entity is TRUE;
end ODDRMXA;

-- architecture body --

architecture V of ODDRMXA is
  attribute VITAL_LEVEL0 of V : architecture is TRUE;
    SIGNAL da_ipd    : std_logic := '0';
    SIGNAL db_ipd    : std_logic := '0';
    SIGNAL clk_ipd    : std_logic := '0';
    SIGNAL dqsxfer_ipd    : std_logic := '0';
    SIGNAL rst_ipd  : std_logic := '0';
    SIGNAL QP0       : std_logic := '0';
    SIGNAL QP1       : std_logic := '0';
    SIGNAL QN       : std_logic := '0';

begin
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(da_ipd, da, tipd_da);
       VitalWireDelay(db_ipd, db, tipd_db);
       VitalWireDelay(clk_ipd, clk, tipd_clk);
       VitalWireDelay(dqsxfer_ipd, dqsxfer, tipd_dqsxfer);
       VitalWireDelay(rst_ipd, rst, tipd_rst);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------

  P1: PROCESS(clk_ipd)
  BEGIN
     IF (clk_ipd = 'X') THEN
         IF (QN /= da_ipd) THEN
            QN <= 'X';
         END IF;
      ELSIF (clk_ipd'event and clk_ipd'last_value = '0' and clk_ipd = '1') THEN
         IF (rst_ipd = '1') THEN
            QN <= '0';
         ELSE
            QN <= da_ipd;
         END IF;
      END IF;
   END PROCESS;

  P2: PROCESS(clk_ipd)
  BEGIN
     IF (clk_ipd = 'X') THEN
         IF (QP0 /= db_ipd) THEN
            QP0 <= 'X';
         END IF;
      ELSIF (clk_ipd'event and clk_ipd'last_value = '0' and clk_ipd = '1') THEN
         QP0 <= db_ipd;
      END IF;
   END PROCESS;

  P3: PROCESS(clk_ipd, QP0)
  BEGIN
     IF (clk_ipd = 'X') THEN
         IF (QP1 /= QP0) THEN
            QP1 <= 'X';
         END IF;
      ELSIF (clk_ipd = '0') THEN
         QP1 <= QP0;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (dqsxfer_ipd, QP1, QN)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      q <= vitalmux
                 (data => (QN, QP1),
                  dselect => (0 => dqsxfer_ipd));

   END PROCESS;

END v;



------CELL ODDRX2B------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
entity ODDRX2B is
    GENERIC (
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ODDRX2B";
        -- input SIGNAL delays
        tipd_da0                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_db0                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_da1                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_db1                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rst                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk                : VitalDelayType01 := (0.0 ns, 0.0 ns));

    port(
          da0            :       in      STD_LOGIC;
          db0            :       in      STD_LOGIC;
          da1            :       in      STD_LOGIC;
          db1            :       in      STD_LOGIC;
          eclk           :       in      STD_LOGIC;
          sclk           :       in      STD_LOGIC;
          rst           :       in      STD_LOGIC;
          q             :       out     STD_LOGIC
        );

attribute VITAL_LEVEL0 of ODDRX2B : entity is TRUE;
end ODDRX2B;

-- architecture body --

architecture V of ODDRX2B is
  attribute VITAL_LEVEL0 of V : architecture is TRUE;
    SIGNAL da0_ipd    : std_logic := '0';
    SIGNAL db0_ipd    : std_logic := '0';
    SIGNAL da1_ipd    : std_logic := '0';
    SIGNAL db1_ipd    : std_logic := '0';
    SIGNAL eclk_ipd    : std_logic := '0';
    SIGNAL sclk_ipd    : std_logic := '0';
    SIGNAL rst_ipd  : std_logic := '0';
    SIGNAL Q0B0       : std_logic := '0';
    SIGNAL Q1B1       : std_logic := '0';
    SIGNAL Q2B1       : std_logic := '0';
    SIGNAL Q0A0       : std_logic := '0';
    SIGNAL Q1A1       : std_logic := '0';
    SIGNAL Q2A1       : std_logic := '0';
    SIGNAL Q_b       : std_logic := '0';
    SIGNAL Q_a       : std_logic := '0';
    SIGNAL Q_a_0       : std_logic := '0';
    SIGNAL Q_b_0       : std_logic := '0';
    SIGNAL Q_b_1       : std_logic := '0';

begin
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
--       VitalWireDelay(da0_ipd, db1, tipd_da0);    -- ONEG1
--       VitalWireDelay(db0_ipd, da1, tipd_db0);    -- ONEG0
--       VitalWireDelay(da1_ipd, db0, tipd_da1);    -- OPOS1
--       VitalWireDelay(db1_ipd, da0, tipd_db1);    -- OPOS0
       VitalWireDelay(da0_ipd, da0, tipd_da0);     -- ONEG1
       VitalWireDelay(db0_ipd, db0, tipd_db0);     -- ONEG0
       VitalWireDelay(da1_ipd, da1, tipd_da1);     -- OPOS1
       VitalWireDelay(db1_ipd, db1, tipd_db1);     -- OPOS0
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(rst_ipd, rst, tipd_rst);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------

  P1: PROCESS(sclk_ipd)
  BEGIN
     IF (sclk_ipd = 'X') THEN
         IF (Q0A0 /= da0_ipd) THEN
            Q0A0 <= 'X';
         END IF;
      ELSIF (sclk_ipd'event and sclk_ipd'last_value = '0' and sclk_ipd = '1') THEN
         Q0A0 <= da0_ipd;
      END IF;
   END PROCESS;

  P2: PROCESS(sclk_ipd)
  BEGIN
     IF (sclk_ipd = 'X') THEN
         IF (Q1A1 /= da1_ipd) THEN
            Q1A1 <= 'X';
         END IF;
      ELSIF (sclk_ipd'event and sclk_ipd'last_value = '0' and sclk_ipd = '1') THEN
         Q1A1 <= da1_ipd;
      END IF;
   END PROCESS;

  P3: PROCESS(sclk_ipd, Q1A1)
  BEGIN
     IF (sclk_ipd = 'X') THEN
         IF (Q2A1 /= Q1A1) THEN
            Q2A1 <= 'X';
         END IF;
      ELSIF (sclk_ipd = '0') THEN
         Q2A1 <= Q1A1;
      END IF;
   END PROCESS;

  P4: PROCESS(sclk_ipd)
  BEGIN
     IF (sclk_ipd = 'X') THEN
         IF (Q0B0 /= db0_ipd) THEN
            Q0B0 <= 'X';
         END IF;
      ELSIF (sclk_ipd'event and sclk_ipd'last_value = '0' and sclk_ipd = '1') THEN
         Q0B0 <= db0_ipd;
      END IF;
   END PROCESS;

  P5: PROCESS(sclk_ipd)
  BEGIN
     IF (sclk_ipd = 'X') THEN
         IF (Q1B1 /= db1_ipd) THEN
            Q1B1 <= 'X';
         END IF;
      ELSIF (sclk_ipd'event and sclk_ipd'last_value = '0' and sclk_ipd = '1') THEN
         Q1B1 <= db1_ipd;
      END IF;
   END PROCESS;

  P6: PROCESS(sclk_ipd, Q1B1)
  BEGIN
     IF (sclk_ipd = 'X') THEN
         IF (Q2B1 /= Q1B1) THEN
            Q2B1 <= 'X';
         END IF;
      ELSIF (sclk_ipd = '0') THEN
         Q2B1 <= Q1B1;
      END IF;
   END PROCESS;

  P7: PROCESS(Q0A0, Q2A1, sclk_ipd)
  BEGIN
   Q_a <= vitalmux
              (data => (Q2A1, Q0A0),
               dselect => (0 => sclk_ipd));
   END PROCESS;

  P8: PROCESS(Q0B0, Q2B1, sclk_ipd)
  BEGIN
   Q_b <= vitalmux
              (data => (Q2B1, Q0B0),
               dselect => (0 => sclk_ipd));
   END PROCESS;

  P9: PROCESS(eclk_ipd)
  BEGIN
     IF (eclk_ipd = 'X') THEN
         IF (Q_a_0 /= Q_a) THEN
            Q_a_0 <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '0' and eclk_ipd = '1') THEN
         IF (rst_ipd = '1') THEN
            Q_a_0 <= '0';
         ELSE
            Q_a_0 <= Q_a;
         END IF;
      END IF;
   END PROCESS;

  P10: PROCESS(eclk_ipd)
  BEGIN
     IF (eclk_ipd = 'X') THEN
         IF (Q_b_0 /= Q_b) THEN
            Q_b_0 <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '0' and eclk_ipd = '1') THEN
         Q_b_0 <= Q_b;
      END IF;
   END PROCESS;

  P11: PROCESS(eclk_ipd, Q_b_0)
  BEGIN
     IF (eclk_ipd = 'X') THEN
         IF (Q_b_1 /= Q_b_0) THEN
            Q_b_1 <= 'X';
         END IF;
      ELSIF (eclk_ipd = '0') THEN
         Q_b_1 <= Q_b_0;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (eclk_ipd, Q_a_0, Q_b_1)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      q <= vitalmux
                 (data => (Q_b_1, Q_a_0),
                  dselect => (0 => eclk_ipd));

   END PROCESS;

END v;

--
----- cell IDDRXC -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY IDDRXC IS
    GENERIC (
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "IDDRXC";
        -- input SIGNAL delays
        tipd_d                  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rst                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ce                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clk                : VitalDelayType01 := (0.0 ns, 0.0 ns));

    PORT (
        d               : IN std_logic;
        clk             : IN std_logic;
        ce              : IN std_logic;
        rst             : IN std_logic;
        qa              : OUT std_logic;
        qb              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF IDDRXC : ENTITY IS TRUE;

END IDDRXC ;

-- architecture body --
ARCHITECTURE v OF IDDRXC IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL clk_ipd  : std_logic := '0';
    SIGNAL rst_ipd : std_logic := '0';
    SIGNAL ce_ipd : std_logic := '0';
    SIGNAL IPOS0  : std_logic := '0';
    SIGNAL IPOS1  : std_logic := '0';
    SIGNAL QN0  : std_logic := '0';
    SIGNAL QN1  : std_logic := '0';
    SIGNAL QP0  : std_logic := '0';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(clk_ipd, clk, tipd_clk);
       VitalWireDelay(rst_ipd, rst, tipd_rst);
       VitalWireDelay(ce_ipd, ce, tipd_ce);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   P1 : PROCESS (clk_ipd)
   BEGIN
      IF (clk_ipd = 'X') THEN
         IF (QN0 /= d_ipd) THEN
            QN0 <= 'X';
         END IF;
      ELSIF (clk_ipd'event and clk_ipd'last_value = '1' and clk_ipd = '0') THEN
         QN0 <= d_ipd;
      END IF;
   END PROCESS;

   P2 : PROCESS (clk_ipd)
   BEGIN
      IF (clk_ipd = 'X') THEN
         IF (QP0 /= d_ipd) THEN
            QP0 <= 'X';
         END IF;
      ELSIF (clk_ipd'event and clk_ipd'last_value = '0' and clk_ipd = '1') THEN
         QP0 <= d_ipd;
      END IF;
   END PROCESS;

   P3 : PROCESS (clk_ipd)
   BEGIN
      IF (clk_ipd = 'X') THEN
         IF (QN1 /= QP0) THEN
            QN1 <= 'X';
         END IF;
      ELSIF (clk_ipd'event and clk_ipd'last_value = '1' and clk_ipd = '0') THEN
         QN1 <= QP0;
      END IF;
   END PROCESS;

   P4 : PROCESS (clk_ipd)
   BEGIN
      IF (clk_ipd = 'X') THEN
         IF (IPOS0 /= QN0) THEN
            IPOS0 <= 'X';
         END IF;
      ELSIF (clk_ipd'event and clk_ipd'last_value = '0' and clk_ipd = '1') THEN
         IF (rst_ipd = '1') THEN
            IPOS0 <= '0';
         ELSE 
            IF (ce_ipd = '1') THEN
               IPOS0 <= QN0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (clk_ipd)
   BEGIN
      IF (clk_ipd = 'X') THEN
         IF (IPOS1 /= QN1) THEN
            IPOS1 <= 'X';
         END IF;
      ELSIF (clk_ipd'event and clk_ipd'last_value = '0' and clk_ipd = '1') THEN
         IF (rst_ipd = '1') THEN
            IPOS1 <= '0';
         ELSE 
            IF (ce_ipd = '1') THEN
               IPOS1 <= QN1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (IPOS0, IPOS1)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      qa <= VitalBUF(IPOS1);
      qb <= VitalBUF(IPOS0);

   END PROCESS;

END v;


--
----- cell IDDRFXA -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY IDDRFXA IS
    GENERIC (
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "IDDRFXA";
        -- input SIGNAL delays
        tipd_d                  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rst                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ce                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clk1                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clk2                : VitalDelayType01 := (0.0 ns, 0.0 ns));

    PORT (
        d               : IN std_logic;
        clk1            : IN std_logic;
        clk2            : IN std_logic;
        ce              : IN std_logic;
        rst             : IN std_logic;
        qa              : OUT std_logic;
        qb              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF IDDRFXA : ENTITY IS TRUE;

END IDDRFXA ;

-- architecture body --
ARCHITECTURE v OF IDDRFXA IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL clk1_ipd  : std_logic := '0';
    SIGNAL clk2_ipd  : std_logic := '0';
    SIGNAL rst_ipd : std_logic := '0';
    SIGNAL ce_ipd : std_logic := '0';
    SIGNAL IPOS0  : std_logic := '0';
    SIGNAL IPOS1  : std_logic := '0';
    SIGNAL QPOS0  : std_logic := '0';
    SIGNAL QPOS1  : std_logic := '0';
    SIGNAL QN0  : std_logic := '0';
    SIGNAL QN1  : std_logic := '0';
    SIGNAL QP0  : std_logic := '0';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(clk1_ipd, clk1, tipd_clk1);
       VitalWireDelay(clk2_ipd, clk2, tipd_clk2);
       VitalWireDelay(rst_ipd, rst, tipd_rst);
       VitalWireDelay(ce_ipd, ce, tipd_ce);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   P1 : PROCESS (clk1_ipd)
   BEGIN
      IF (clk1_ipd = 'X') THEN
         IF (QN0 /= d_ipd) THEN
            QN0 <= 'X';
         END IF;
      ELSIF (clk1_ipd'event and clk1_ipd'last_value = '1' and clk1_ipd = '0') THEN
         QN0 <= d_ipd;
      END IF;
   END PROCESS;

   P2 : PROCESS (clk1_ipd)
   BEGIN
      IF (clk1_ipd = 'X') THEN
         IF (QP0 /= d_ipd) THEN
            QP0 <= 'X';
         END IF;
      ELSIF (clk1_ipd'event and clk1_ipd'last_value = '0' and clk1_ipd = '1') THEN
         QP0 <= d_ipd;
      END IF;
   END PROCESS;

   P3 : PROCESS (clk1_ipd)
   BEGIN
      IF (clk1_ipd = 'X') THEN
         IF (QN1 /= QP0) THEN
            QN1 <= 'X';
         END IF;
      ELSIF (clk1_ipd'event and clk1_ipd'last_value = '1' and clk1_ipd = '0') THEN
         QN1 <= QP0;
      END IF;
   END PROCESS;

   P4 : PROCESS (clk1_ipd)
   BEGIN
      IF (clk1_ipd = 'X') THEN
         IF (IPOS0 /= QN0) THEN
            IPOS0 <= 'X';
         END IF;
      ELSIF (clk1_ipd'event and clk1_ipd'last_value = '0' and clk1_ipd = '1') THEN
         IF (rst_ipd = '1') THEN
            IPOS0 <= '0';
         ELSE 
            IF (ce_ipd = '1') THEN
               IPOS0 <= QN0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (clk1_ipd)
   BEGIN
      IF (clk1_ipd = 'X') THEN
         IF (IPOS1 /= QN1) THEN
            IPOS1 <= 'X';
         END IF;
      ELSIF (clk1_ipd'event and clk1_ipd'last_value = '0' and clk1_ipd = '1') THEN
         IF (rst_ipd = '1') THEN
            IPOS1 <= '0';
         ELSE 
            IF (ce_ipd = '1') THEN
               IPOS1 <= QN1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P6 : PROCESS (clk2_ipd)
   BEGIN
      IF (clk2_ipd = 'X') THEN
         IF (QPOS0 /= IPOS0) THEN
            QPOS0 <= 'X';
         END IF;
      ELSIF (clk2_ipd'event and clk2_ipd'last_value = '0' and clk2_ipd = '1') THEN
         IF (ce_ipd = '1') THEN
            QPOS0 <= IPOS0;
         END IF;
      END IF;
   END PROCESS;

   P7 : PROCESS (clk2_ipd)
   BEGIN
      IF (clk2_ipd = 'X') THEN
         IF (QPOS1 /= IPOS1) THEN
            QPOS1 <= 'X';
         END IF;
      ELSIF (clk2_ipd'event and clk2_ipd'last_value = '0' and clk2_ipd = '1') THEN
         IF (ce_ipd = '1') THEN
            QPOS1 <= IPOS1;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (QPOS0, QPOS1)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      qa <= VitalBUF(QPOS1);
      qb <= VitalBUF(QPOS0);

   END PROCESS;

END v;



--
----- cell IDDRMX1A -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY IDDRMX1A IS
    GENERIC (
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "IDDRMX1A";
        -- input SIGNAL delays
        tipd_d                  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rst                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ce                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ddrclkpol                : VitalDelayType01 := (0.0 ns, 0.0 ns));

    PORT (
        d               : IN std_logic;
        eclk             : IN std_logic;
        sclk             : IN std_logic;
        ce              : IN std_logic;
        rst             : IN std_logic;
        ddrclkpol       : IN std_logic;
        qa              : OUT std_logic;
        qb              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF IDDRMX1A : ENTITY IS TRUE;

END IDDRMX1A ;

-- architecture body --
ARCHITECTURE v OF IDDRMX1A IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL eclk_ipd  : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL rst_ipd : std_logic := '0';
    SIGNAL ce_ipd : std_logic := '0';
    SIGNAL ddrclkpol_ipd : std_logic := '0';
    SIGNAL IPOS0  : std_logic := '0';
    SIGNAL IPOS1  : std_logic := '0';
    SIGNAL QN0  : std_logic := '0';
    SIGNAL QN1  : std_logic := '0';
    SIGNAL QP0  : std_logic := '0';
    SIGNAL sclk_pol  : std_logic := '0';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(rst_ipd, rst, tipd_rst);
       VitalWireDelay(ce_ipd, ce, tipd_ce);
       VitalWireDelay(ddrclkpol_ipd, ddrclkpol, tipd_ddrclkpol);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   S1 : PROCESS (sclk_ipd, ddrclkpol_ipd)
   BEGIN
      IF (ddrclkpol_ipd = '1') THEN
         sclk_pol <= not sclk_ipd;
      ELSIF (ddrclkpol_ipd = '0') THEN
         sclk_pol <= sclk_ipd;
      END IF;
   END PROCESS;

   P1 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (QN0 /= d_ipd) THEN
            QN0 <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '1' and eclk_ipd = '0') THEN
         QN0 <= d_ipd;
      END IF;
   END PROCESS;

   P2 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (QP0 /= d_ipd) THEN
            QP0 <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '0' and eclk_ipd = '1') THEN
         QP0 <= d_ipd;
      END IF;
   END PROCESS;

   P3 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (QN1 /= QP0) THEN
            QN1 <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '1' and eclk_ipd = '0') THEN
         QN1 <= QP0;
      END IF;
   END PROCESS;

   P4 : PROCESS (sclk_pol)
   BEGIN
      IF (sclk_pol = 'X') THEN
         IF (IPOS0 /= QN0) THEN
            IPOS0 <= 'X';
         END IF;
      ELSIF (sclk_pol'event and sclk_pol'last_value = '0' and sclk_pol = '1') THEN
         IF (rst_ipd = '1') THEN
            IPOS0 <= '0';
         ELSE 
            IF (ce_ipd = '1') THEN
               IPOS0 <= QN0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (sclk_pol)
   BEGIN
      IF (sclk_pol = 'X') THEN
         IF (IPOS1 /= QN1) THEN
            IPOS1 <= 'X';
         END IF;
      ELSIF (sclk_pol'event and sclk_pol'last_value = '0' and sclk_pol = '1') THEN
         IF (rst_ipd = '1') THEN
            IPOS1 <= '0';
         ELSE 
            IF (ce_ipd = '1') THEN
               IPOS1 <= QN1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (IPOS0, IPOS1)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      qa <= VitalBUF(IPOS1);
      qb <= VitalBUF(IPOS0);

   END PROCESS;

END v;



--
----- cell IDDRMFX1A -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY IDDRMFX1A IS
    GENERIC (
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "IDDRMFX1A";
        -- input SIGNAL delays
        tipd_d                  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rst                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ce                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clk1                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clk2                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ddrclkpol                : VitalDelayType01 := (0.0 ns, 0.0 ns));

    PORT (
        d               : IN std_logic;
        eclk             : IN std_logic;
        clk1             : IN std_logic;
        clk2             : IN std_logic;
        ce              : IN std_logic;
        rst             : IN std_logic;
        ddrclkpol       : IN std_logic;
        qa              : OUT std_logic;
        qb              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF IDDRMFX1A : ENTITY IS TRUE;

END IDDRMFX1A ;

-- architecture body --
ARCHITECTURE v OF IDDRMFX1A IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL eclk_ipd  : std_logic := '0';
    SIGNAL clk1_ipd  : std_logic := '0';
    SIGNAL clk2_ipd  : std_logic := '0';
    SIGNAL rst_ipd : std_logic := '0';
    SIGNAL ce_ipd : std_logic := '0';
    SIGNAL ddrclkpol_ipd : std_logic := '0';
    SIGNAL IPOS0  : std_logic := '0';
    SIGNAL IPOS1  : std_logic := '0';
    SIGNAL QPOS0  : std_logic := '0';
    SIGNAL QPOS1  : std_logic := '0';
    SIGNAL QN0  : std_logic := '0';
    SIGNAL QN1  : std_logic := '0';
    SIGNAL QP0  : std_logic := '0';
    SIGNAL sclk_pol  : std_logic := '0';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(clk1_ipd, clk1, tipd_clk1);
       VitalWireDelay(clk2_ipd, clk2, tipd_clk2);
       VitalWireDelay(rst_ipd, rst, tipd_rst);
       VitalWireDelay(ce_ipd, ce, tipd_ce);
       VitalWireDelay(ddrclkpol_ipd, ddrclkpol, tipd_ddrclkpol);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   S1 : PROCESS (clk1_ipd, ddrclkpol_ipd)
   BEGIN
      IF (ddrclkpol_ipd = '1') THEN
         sclk_pol <= not clk1_ipd;
      ELSIF (ddrclkpol_ipd = '0') THEN
         sclk_pol <= clk1_ipd;
      END IF;
   END PROCESS;

   P1 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (QN0 /= d_ipd) THEN
            QN0 <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '1' and eclk_ipd = '0') THEN
         QN0 <= d_ipd;
      END IF;
   END PROCESS;

   P2 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (QP0 /= d_ipd) THEN
            QP0 <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '0' and eclk_ipd = '1') THEN
         QP0 <= d_ipd;
      END IF;
   END PROCESS;

   P3 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (QN1 /= QP0) THEN
            QN1 <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '1' and eclk_ipd = '0') THEN
         QN1 <= QP0;
      END IF;
   END PROCESS;

   P4 : PROCESS (sclk_pol)
   BEGIN
      IF (sclk_pol = 'X') THEN
         IF (IPOS0 /= QN0) THEN
            IPOS0 <= 'X';
         END IF;
      ELSIF (sclk_pol'event and sclk_pol'last_value = '0' and sclk_pol = '1') THEN
         IF (rst_ipd = '1') THEN
            IPOS0 <= '0';
         ELSE 
            IF (ce_ipd = '1') THEN
               IPOS0 <= QN0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (sclk_pol)
   BEGIN
      IF (sclk_pol = 'X') THEN
         IF (IPOS1 /= QN1) THEN
            IPOS1 <= 'X';
         END IF;
      ELSIF (sclk_pol'event and sclk_pol'last_value = '0' and sclk_pol = '1') THEN
         IF (rst_ipd = '1') THEN
            IPOS1 <= '0';
         ELSE 
            IF (ce_ipd = '1') THEN
               IPOS1 <= QN1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P6 : PROCESS (clk2_ipd)
   BEGIN
      IF (clk2_ipd = 'X') THEN
         IF (QPOS0 /= IPOS0) THEN
            QPOS0 <= 'X';
         END IF;
      ELSIF (clk2_ipd'event and clk2_ipd'last_value = '0' and clk2_ipd = '1') THEN
         IF (ce_ipd = '1') THEN
            QPOS0 <= IPOS0;
         END IF;
      END IF;
   END PROCESS;

   P7 : PROCESS (clk2_ipd)
   BEGIN
      IF (clk2_ipd = 'X') THEN
         IF (QPOS1 /= IPOS1) THEN
            QPOS1 <= 'X';
         END IF;
      ELSIF (clk2_ipd'event and clk2_ipd'last_value = '0' and clk2_ipd = '1') THEN
         IF (ce_ipd = '1') THEN
            QPOS1 <= IPOS1;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (QPOS0, QPOS1)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      qa <= VitalBUF(QPOS1);
      qb <= VitalBUF(QPOS0);

   END PROCESS;

END v;



--
----- cell IDDRX2B -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY IDDRX2B IS
    GENERIC (
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "IDDRX2B";
        -- input SIGNAL delays
        tipd_d                  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rst                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ce                 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk                : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk                : VitalDelayType01 := (0.0 ns, 0.0 ns));

    PORT (
        d               : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        ce              : IN std_logic;
        rst             : IN std_logic;
        qa0              : OUT std_logic;
        qa1              : OUT std_logic;
        qb0              : OUT std_logic;
        qb1              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF IDDRX2B : ENTITY IS TRUE;

END IDDRX2B ;

-- architecture body --
ARCHITECTURE v OF IDDRX2B IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL eclk_ipd  : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL rst_ipd : std_logic := '0';
    SIGNAL ce_ipd : std_logic := '0';
    SIGNAL IPOS0A  : std_logic := '0';
    SIGNAL IPOS1A  : std_logic := '0';
    SIGNAL QPOS0A  : std_logic := '0';
    SIGNAL QPOS1A  : std_logic := '0';
    SIGNAL IPOS0B  : std_logic := '0';
    SIGNAL IPOS1B  : std_logic := '0';
    SIGNAL QPOS0B  : std_logic := '0';
    SIGNAL QPOS1B  : std_logic := '0';
    SIGNAL QN0  : std_logic := '0';
    SIGNAL QN1  : std_logic := '0';
    SIGNAL QP0  : std_logic := '0';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(rst_ipd, rst, tipd_rst);
       VitalWireDelay(ce_ipd, ce, tipd_ce);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   P1 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (QN0 /= d_ipd) THEN
            QN0 <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '1' and eclk_ipd = '0') THEN
         QN0 <= d_ipd;
      END IF;
   END PROCESS;

   P2 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (QP0 /= d_ipd) THEN
            QP0 <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '0' and eclk_ipd = '1') THEN
         QP0 <= d_ipd;
      END IF;
   END PROCESS;

   P3 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (QN1 /= QP0) THEN
            QN1 <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '1' and eclk_ipd = '0') THEN
         QN1 <= QP0;
      END IF;
   END PROCESS;

   P4 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (IPOS0A /= QN0) THEN
            IPOS0A <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '0' and eclk_ipd = '1') THEN
         IF (rst_ipd = '1') THEN
            IPOS0A <= '0';
         ELSE 
            IF (ce_ipd = '1') THEN
               IPOS0A <= QN0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P5 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (IPOS1A /= QN1) THEN
            IPOS1A <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '0' and eclk_ipd = '1') THEN
         IF (rst_ipd = '1') THEN
            IPOS1A <= '0';
         ELSE 
            IF (ce_ipd = '1') THEN
               IPOS1A <= QN1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P6 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (IPOS0B /= IPOS0A) THEN
            IPOS0B <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '0' and eclk_ipd = '1') THEN
         IF (rst_ipd = '1') THEN
            IPOS0B <= '0';
         ELSE
            IF (ce_ipd = '1') THEN
               IPOS0B <= IPOS0A;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P7 : PROCESS (eclk_ipd)
   BEGIN
      IF (eclk_ipd = 'X') THEN
         IF (IPOS1B /= IPOS1A) THEN
            IPOS1B <= 'X';
         END IF;
      ELSIF (eclk_ipd'event and eclk_ipd'last_value = '0' and eclk_ipd = '1') THEN
         IF (rst_ipd = '1') THEN
            IPOS1B <= '0';
         ELSE
            IF (ce_ipd = '1') THEN
               IPOS1B <= IPOS1A;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P8 : PROCESS (sclk_ipd)
   BEGIN
      IF (sclk_ipd = 'X') THEN
         IF (QPOS0A /= IPOS0A) THEN
            QPOS0A <= 'X';
         END IF;
      ELSIF (sclk_ipd'event and sclk_ipd'last_value = '0' and sclk_ipd = '1') THEN
         IF (ce_ipd = '1') THEN
            QPOS0A <= IPOS0A;
         END IF;
      END IF;
   END PROCESS;

   P9 : PROCESS (sclk_ipd)
   BEGIN
      IF (sclk_ipd = 'X') THEN
         IF (QPOS1A /= IPOS1A) THEN
            QPOS1A <= 'X';
         END IF;
      ELSIF (sclk_ipd'event and sclk_ipd'last_value = '0' and sclk_ipd = '1') THEN
         IF (ce_ipd = '1') THEN
            QPOS1A <= IPOS1A;
         END IF;
      END IF;
   END PROCESS;

   P10 : PROCESS (sclk_ipd)
   BEGIN
      IF (sclk_ipd = 'X') THEN
         IF (QPOS0B /= IPOS0B) THEN
            QPOS0B <= 'X';
         END IF;
      ELSIF (sclk_ipd'event and sclk_ipd'last_value = '0' and sclk_ipd = '1') THEN
         IF (ce_ipd = '1') THEN
            QPOS0B <= IPOS0B;
         END IF;
      END IF;
   END PROCESS;

   P11 : PROCESS (sclk_ipd)
   BEGIN
      IF (sclk_ipd = 'X') THEN
         IF (QPOS1B /= IPOS1B) THEN
            QPOS1B <= 'X';
         END IF;
      ELSIF (sclk_ipd'event and sclk_ipd'last_value = '0' and sclk_ipd = '1') THEN
         IF (ce_ipd = '1') THEN
            QPOS1B <= IPOS1B;
         END IF;
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (QPOS0A, QPOS1A, QPOS0B, QPOS1B)

   BEGIN

    -----------------------------------
    -- functionality section.
    -----------------------------------
      qa0 <= VitalBUF(QPOS1B);
      qb0 <= VitalBUF(QPOS0B);
      qa1 <= VitalBUF(QPOS1A);
      qb1 <= VitalBUF(QPOS0A);

   END PROCESS;

END v;


------cell dqsbufc------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.components.all;

-- entity declaration --
ENTITY dqsbufc IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      DQS_LI_DEL_ADJ : string  := "PLUS";
      DQS_LI_DEL_VAL : string := "4";
      DQS_LO_DEL_ADJ : string  := "PLUS";
      DQS_LO_DEL_VAL : string := "4";
      InstancePath    : string := "dqsbufc";
      tipd_dqsi       : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_clk        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_xclk        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_read       : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_dqsdel     : VitalDelayType01 := (0.0 ns, 0.0 ns));

    PORT(
          dqsi          :       IN      std_logic;
          clk           :       IN      std_logic;
          xclk           :       IN      std_logic;
          read          :       IN      std_logic;
          dqsdel        :       IN      std_logic;
          dqso          :       OUT     std_logic;
          ddrclkpol     :       OUT     std_logic;
          dqsc          :       OUT     std_logic;
          prmbdet       :       OUT     std_logic;
          dqsxfer       :       OUT     std_logic;
          datavalid       :       OUT     std_logic
        );

ATTRIBUTE vital_level0 OF dqsbufc : ENTITY IS TRUE;
END dqsbufc;

-- architecture body --

architecture V of DQSBUFC is
  ATTRIBUTE vital_level0 OF v : ARCHITECTURE IS TRUE;
---
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
---
  SIGNAL dqsi_ipd                 : std_logic := '0';
  SIGNAL clk_ipd                  : std_logic := '0';
  SIGNAL xclk_ipd                  : std_logic := '0';
  SIGNAL read_ipd                 : std_logic := '0';
  SIGNAL dqsdel_ipd               : std_logic := '0';
  SIGNAL quarter_period           : time := 0 ns;
  SIGNAL quarter_period_xclk           : time := 0 ns;
  SIGNAL clk_last_rising_edge     : time := 0 ns;
  SIGNAL xclk_last_rising_edge     : time := 0 ns;
  SIGNAL A, C                     : std_logic := '0';
  SIGNAL B, D, E                  : std_logic := '0';
  SIGNAL A_inv, C_inv                     : std_logic := '0';
  SIGNAL B_inv, D_inv, E_inv                  : std_logic := '0';
  SIGNAL DDRCLKPOL_int            : std_logic := '0';
  SIGNAL DQSXFER_int            : std_logic := '0';
  SIGNAL CLKP                     : std_logic := '0';
  SIGNAL DQSO_int                 : std_logic := '0';
  SIGNAL DQSC_int                 : std_logic := '0';
  SIGNAL DQSO_int1                : std_logic := '0';
  SIGNAL PRMBDET_int              : std_logic := '0';
  SIGNAL DQSO_int0                : std_logic := '0';
  SIGNAL DQSO_int2                : std_logic := '0';
  SIGNAL clk_rising_edge_count    : integer := 0;
  SIGNAL xclk_rising_edge_count    : integer := 0;
  SIGNAL DATAVALID_int                : std_logic := '0';
  SIGNAL data_valid_neg                : std_logic := '0';
  SIGNAL data_valid_pos                : std_logic := '0';
  SIGNAL prmbdet_clean                : std_logic := '0';
  SIGNAL reset_data_valid_regs        : std_logic := '0';
  SIGNAL prmbdet_raw                  : std_logic := '0';
  SIGNAL reset_prmbdet_clean        : std_logic := '0';
  SIGNAL data_valid                   : std_logic := '0';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(dqsi_ipd, dqsi, tipd_dqsi);
   VitalWireDelay(clk_ipd, clk, tipd_clk);
   VitalWireDelay(xclk_ipd, xclk, tipd_xclk);
   VitalWireDelay(read_ipd, read, tipd_read);
   VitalWireDelay(dqsdel_ipd, dqsdel, tipd_dqsdel);
   END BLOCK;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   inst10: or2 PORT MAP (a=>read_ipd, b=>A, z=>C_inv);
   inst11: inv PORT MAP (a=>C_inv, z=>C);
   inst12: or2 PORT MAP (a=>C, b=>D, z=>A_inv);
   inst13: inv PORT MAP (a=>A_inv, z=>A);
   inst14: or2 PORT MAP (a=>D, b=>E, z=>B_inv);
   inst15: inv PORT MAP (a=>B_inv, z=>B);
   inst16: or2 PORT MAP (a=>C, b=>PRMBDET_int, z=>E_inv);
   inst17: inv PORT MAP (a=>E_inv, z=>E);
   inst18: or3 PORT MAP (a=>B, b=>read_ipd, c=>PRMBDET_int, z=>D_inv);
   inst19: inv PORT MAP (a=>D_inv, z=>D);

   P1 : PROCESS (dqsi_ipd)
   BEGIN
      IF (dqsi_ipd = 'X') THEN
         PRMBDET_int <= '1';
      ELSE
         PRMBDET_int <= dqsi_ipd;
      END IF;
   END PROCESS;

   P2 : PROCESS (D)
   BEGIN
      IF (D'event and D = '0') THEN
         DDRCLKPOL_int <= clk_ipd;
      END IF;
   END PROCESS;

   P3 : PROCESS (clk_ipd, DDRCLKPOL_int)
   BEGIN
      IF (DDRCLKPOL_int = '0') THEN
         CLKP <= clk_ipd;
      ELSIF (DDRCLKPOL_int = '1') THEN
         CLKP <= not clk_ipd;
      END IF;
   END PROCESS;

   P4 : PROCESS (clk_ipd)
   BEGIN
      IF (clk_ipd'event and clk_ipd = '1') THEN
         clk_rising_edge_count <= clk_rising_edge_count + 1;
         clk_last_rising_edge <= NOW;
      END IF;
   END PROCESS;

   P5 : PROCESS (clk_ipd)
   BEGIN
      IF (clk_ipd'event and clk_ipd = '0') THEN
         IF (clk_rising_edge_count >= 1) THEN
            quarter_period <= (NOW - clk_last_rising_edge) / 2;
         END IF;
      END IF;
   END PROCESS;

   P6 : PROCESS (dqsi_ipd, dqsdel_ipd)
   BEGIN
      IF (dqsdel_ipd = '1') THEN
         IF (quarter_period > 0 ps) THEN
            DQSO_int <= transport dqsi_ipd after (quarter_period - 0.8 ns);
            DQSC_int <= dqsi_ipd;
         END IF;
      ELSE
         DQSO_int <= '0';
         DQSC_int <= '0';
      END IF;
   END PROCESS;

   P7 : PROCESS (DQSO_int, CLKP)
   BEGIN
      IF (CLKP = '1') THEN
         DQSO_int1 <= '0';
      ELSIF (DQSO_int'event and DQSO_int'last_value = '0') THEN
         DQSO_int1 <= '1';
      END IF;
   END PROCESS;

   DQSO_int0 <= DQSO_int;

   DQSO_int2 <= transport (DQSO_int1 or DQSO_int0) after 0.8 ns;
   ddrclkpol <= DDRCLKPOL_int;
   prmbdet <= PRMBDET_int;
   dqso <= DQSO_int2;
   dqsc <= DQSC_int;

   P8 : PROCESS (xclk_ipd)
   BEGIN
      IF (xclk_ipd'event and xclk_ipd = '1') THEN
         xclk_rising_edge_count <= xclk_rising_edge_count + 1;
         xclk_last_rising_edge <= NOW;
      END IF;
   END PROCESS;

   P9 : PROCESS (xclk_ipd)
   BEGIN
      IF (xclk_ipd'event and xclk_ipd = '0') THEN
         IF (xclk_rising_edge_count >= 1) THEN
            quarter_period_xclk <= (NOW - xclk_last_rising_edge) / 2;
         END IF;
      END IF;
   END PROCESS;

   P10 : PROCESS (xclk_ipd)
   BEGIN
      IF (quarter_period > 0 ps) THEN
         DQSXFER_int <= transport xclk_ipd after quarter_period_xclk;
      END IF;
   END PROCESS;

   dqsxfer <= DQSXFER_int;

   P11 : PROCESS (PRMBDET_int, read_ipd)
   BEGIN
      IF (read_ipd = '1') THEN
         prmbdet_raw <= '0';
      ELSIF (PRMBDET_int'event and PRMBDET_int = '1') THEN
         prmbdet_raw <= '1';
      END IF;
   END PROCESS;

   reset_prmbdet_clean <= not (prmbdet_raw or read_ipd);

   P13 : PROCESS (dqsi_ipd, reset_prmbdet_clean)
   BEGIN
      IF (reset_prmbdet_clean = '1') THEN
         prmbdet_clean <= '0';
      ELSIF (dqsi_ipd'event and dqsi_ipd = '0') THEN
         prmbdet_clean <= prmbdet_raw;
      END IF;
   END PROCESS;

   reset_data_valid_regs <= (not prmbdet_clean) and dqsi_ipd;

   P15 : PROCESS (clk_ipd, reset_data_valid_regs)
   BEGIN
      IF (reset_data_valid_regs = '1') THEN
         data_valid_pos <= '0';
      ELSIF (clk_ipd'event and clk_ipd = '1') THEN
         data_valid_pos <= prmbdet_clean;
      END IF;
   END PROCESS;

   P16 : PROCESS (clk_ipd, reset_data_valid_regs)
   BEGIN
      IF (reset_data_valid_regs = '1') THEN
         data_valid_neg <= '0';
      ELSIF (clk_ipd'event and clk_ipd = '0') THEN
         data_valid_neg <= prmbdet_clean;
      END IF;
   END PROCESS;

   P17 : PROCESS (data_valid_pos, data_valid_neg, DDRCLKPOL_int)
   BEGIN
      data_valid <= vitalmux
                 (data => (data_valid_neg, data_valid_pos),
                  dselect => (0 => DDRCLKPOL_int));
   END PROCESS;

   P18 : PROCESS (clk_ipd)
   BEGIN
      IF (clk_ipd'event and clk_ipd = '1') THEN
         DATAVALID_int <= data_valid;
      END IF;
   END PROCESS;

   datavalid <= DATAVALID_int;

END v;

CONFIGURATION dqsbufcc OF dqsbufc IS
  FOR v
    FOR ALL: or2 USE ENTITY work.or2(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
  END FOR;
END dqsbufcc;


--*********************************************************************
------CELL DQSDLL------
--*********************************************************************
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity DQSDLL is
    generic(LOCK_CYC         : integer := 2;
            DEL_ADJ          : string  := "PLUS";
            DEL_VAL          : string  := "0";
            LOCK_SENSITIVITY : string  := "LOW");
    port(
          CLK           :       in      STD_ULOGIC;
          RST           :       in      STD_ULOGIC;
          UDDCNTL       :       in      STD_ULOGIC;
          LOCK          :       out     STD_ULOGIC;
          DQSDEL        :       out     STD_ULOGIC
        );

attribute VITAL_LEVEL0 of DQSDLL : entity is FALSE;
end DQSDLL;

-- architecture body --

architecture V of DQSDLL is
  attribute VITAL_LEVEL0 of V : architecture is FALSE;

  signal RST_int      :  std_logic;
  signal UDDCNTL_int  : std_logic;
  signal LOCK_int     : std_logic;
  signal DQSDEL_int   : std_logic;
  signal clkin_in     : std_logic;
  signal clk_rising_edge_count : integer := 0;

begin

  clkin_in <= VitalBUF(CLK);
  RST_int  <= VitalBUF(RST);
  UDDCNTL_int <= VitalINV(UDDCNTL);

  LOCK  <= VitalBUF(LOCK_int);
  DQSDEL <= VitalBUF(DQSDEL_int);
 
  process(clkin_in, RST_int)
  begin
    if (RST_int = '1') then
        clk_rising_edge_count <= 0;
    elsif (clkin_in'event and clkin_in = '1') then
        clk_rising_edge_count <= clk_rising_edge_count + 1;
    end if;
  end process;

  process(clk_rising_edge_count, RST_int)
  begin
    if (RST_int = '1') then
        LOCK_int <= '0';
    elsif (clk_rising_edge_count > LOCK_CYC) then
        LOCK_int <= '1';
    end if;
  end process;

  process(LOCK_int, UDDCNTL_int, RST_int)
  begin
    if (RST_int = '1') then
        DQSDEL_int <= '0';
    elsif (UDDCNTL_int = '1') then
        DQSDEL_int <= LOCK_int;
    else
        DQSDEL_int <= DQSDEL_int;
    end if;
  end process;

end V;


--
----- cell delayb -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY delayb IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "delayb";
      tipd_del0     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_del1     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_del2     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_del3     : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a             : IN std_logic;
      del0          : IN std_logic;
      del1          : IN std_logic;
      del2          : IN std_logic;
      del3          : IN std_logic;
      z             : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF delayb : ENTITY IS TRUE;

END delayb;

-- architecture body --
ARCHITECTURE v OF delayb IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd  : std_logic := '0';
   SIGNAL del_ipd        : std_logic_vector(3 downto 0) := "0000";
   SIGNAL delta          : time  := 0.05 ns;
   SIGNAL cntl_delay     : time  := 0 ns;
   SIGNAL cntl_reg_int   : integer  := 0;
   SIGNAL a_delay        : std_logic := '0';
   SIGNAL a_man_del      : std_logic := '0';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (del_ipd(0), del0, tipd_del0);
   VitalWireDelay (del_ipd(1), del1, tipd_del1);
   VitalWireDelay (del_ipd(2), del2, tipd_del2);
   VitalWireDelay (del_ipd(3), del3, tipd_del3);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   cntl_reg_int <= conv_integer(del_ipd);

   cntl_delay <= (cntl_reg_int * delta);

   a_delay <= transport a_ipd after cntl_delay;

   VitalBehavior : PROCESS (a_delay)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= a_delay;

   END PROCESS;

END v;


--
---
library ieee, std;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--use work.components.all;


-- ************************************************************************
-- Entity definition
-- ************************************************************************

entity CCU2B is

   generic (
      inject1_0 : string := "YES";
      inject1_1 : string := "YES";
      init0: string := "0x0000";
      init1: string := "0x0000"
   );

   port (
      A0,A1 : in std_ulogic;
      B0,B1 : in std_ulogic;
      C0,C1 : in std_ulogic;
      D0,D1 : in std_ulogic;
      CIN : in std_ulogic;
      S0,S1 : out std_ulogic;
      COUT : out std_ulogic

   );
      ATTRIBUTE Vital_Level0 OF CCU2B : ENTITY IS TRUE;

end CCU2B;

architecture bev of CCU2B is
    ATTRIBUTE Vital_Level0 OF bev : ARCHITECTURE IS TRUE;
   ------------------------------------------------------------------
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

   -----------------------------------------------------
   --signal init_vec0 : std_logic_vector( 15 downto 0 )
   --       := To_StdLogicVector(init0);
   --signal init_vec1 : std_logic_vector( 15 downto 0 )
   --       := To_StdLogicVector(init1);

   signal init_vec0 : std_logic_vector( 15 downto 0);
   signal init_vec1 : std_logic_vector( 15 downto 0);

   signal lut2_init0 : std_logic_vector (3 downto 0);
   signal lut2_init1 : std_logic_vector (3 downto 0);

   signal lut2_sel0, lut2_sel1, lut4_sel0, lut4_sel1 : integer :=0;
   signal lut2_out0, lut2_out1 : std_ulogic;
   signal prop0, prop1, gen0, gen1, cout_sig0, cout_sig1 : std_ulogic;
   signal pass_cin0, pass_cin1 : std_ulogic;
   -----------------------------------------------------

begin

   init_vec0 <= hex2bin(init0);
   init_vec1 <= hex2bin(init1);

   lut2_init0 <= init_vec0( 3 downto 0 ); --ecp2
   lut2_init1 <= init_vec1( 3 downto 0 ); --ecp2

   lut2_sel0 <= conv_integer (B0 & A0);
   lut2_sel1 <= conv_integer (B1 & A1);
   lut4_sel0 <= conv_integer (D0 & C0 & B0 & A0);
   lut4_sel1 <= conv_integer (D1 & C1 & B1 & A1);

   prop0 <= init_vec0(lut4_sel0) ;
   prop1 <= init_vec1(lut4_sel1);

   lut2_out0 <= lut2_init0(lut2_sel0);
   lut2_out1 <= lut2_init1(lut2_sel1);

   gen0 <= '0' when (inject1_0 = "YES") else
           '0' when (inject1_0 = "yes") else
           lut2_out0 ; --ecp2
   gen1 <= '0' when (inject1_1 = "YES") else
           '0' when (inject1_0 = "yes") else
           lut2_out1 ; --ecp2

   pass_cin0 <= '0' when (inject1_0 = "YES") else
           '0' when (inject1_0 = "yes") else
           '1' ; --ecp2
   pass_cin1 <= '0' when (inject1_1 = "YES") else
           '0' when (inject1_0 = "yes") else
           '1' ; --ecp2

   cout_sig0 <= (not(prop0) and gen0 ) or (prop0 and CIN);
   cout_sig1 <= (not(prop1) and gen1 ) or (prop1 and cout_sig0);

   --ecp2 COUT0 <= cout_sig0;
   COUT <= cout_sig1;

   S0 <=  prop0 xor (pass_cin0 and CIN);
   S1 <=  prop1 xor (pass_cin1 and cout_sig0);

end bev;


--
----- cell CLKDIVB -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;


-- entity declaration --
ENTITY CLKDIVB IS
   GENERIC(
      gsr                  : String := "DISABLED";
      TimingChecksOn       : boolean := FALSE;
      XOn                  : boolean := FALSE;
      MsgOn                : boolean := FALSE;
      InstancePath         : string := "CLKDIVB";
      tipd_clki            : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_release         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_rst             : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      clki, rst, release             :   IN   std_logic;
      cdiv1, cdiv2, cdiv4, cdiv8     :   OUT  std_logic);

    ATTRIBUTE Vital_Level0 OF CLKDIVB : ENTITY IS TRUE;

END CLKDIVB;

-- architecture body --
ARCHITECTURE v OF CLKDIVB IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL clki_ipd      : std_logic := 'X';
   SIGNAL rst_ipd      : std_logic := 'X';
   SIGNAL release_ipd      : std_logic := 'X';
   SIGNAL cdiv_sig0      : std_logic := '0';
   SIGNAL cdiv_sig1      : std_logic := '0';
   SIGNAL clki_buf       : std_logic := '0';
   SIGNAL cdiv_sig3      : std_logic := '0';
   SIGNAL cdiv_sig4      : std_logic := '0';
   SIGNAL cdiv_sig5      : std_logic := '0';
   SIGNAL g_reset      : std_logic := '1';
   SIGNAL rst_sig      : std_logic := '0';
   SIGNAL count_dn      : std_logic_vector(2 downto 0) := "000";

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (clki_ipd, clki, tipd_clki);
   VitalWireDelay (rst_ipd, rst, tipd_rst);
   VitalWireDelay (release_ipd, release, tipd_release);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------

   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (GSR =  "DISABLED") THEN
         g_reset <= purnet;
      ELSE
         g_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

   rst_sig <= rst_ipd or (not g_reset);

  P1 : PROCESS(clki_ipd)
  BEGIN
     IF (clki_ipd'event and clki_ipd = '1') THEN
        cdiv_sig0 <= not rst_sig;
     END IF;
  END PROCESS;

  clki_buf <= clki_ipd;

  P2 : PROCESS(cdiv_sig0, clki_buf)
  BEGIN
     IF (cdiv_sig0 = '1') THEN
        cdiv_sig3 <= clki_buf;
     ELSE
        cdiv_sig3 <= '0';
     END IF;
  END PROCESS;

  P4 : PROCESS(clki_ipd)
  BEGIN
     IF (clki_ipd'event and clki_ipd = '1') THEN
        cdiv_sig1 <= cdiv_sig0;
     END IF;
  END PROCESS;
 
  cdiv_sig4 <= cdiv_sig3 and cdiv_sig1;

  P5 : PROCESS(clki_ipd, rst_sig)
  BEGIN
     IF (rst_sig = '1') THEN
        cdiv_sig5 <= '0';
     ELSIF (clki_ipd'event and clki_ipd = '1') THEN
        cdiv_sig5 <= '1';
     END IF;
  END PROCESS;

  P3 : PROCESS(clki_ipd, cdiv_sig5, release_ipd)
  BEGIN
     IF (cdiv_sig5 = '0' or release_ipd = '0') THEN
        count_dn <= "000";
     ELSIF (clki_ipd'event and clki_ipd = '1') THEN
        IF (release_ipd = '1') THEN
           count_dn <= count_dn - '1';
        END IF;
     END IF;
  END PROCESS;

  cdiv1 <= cdiv_sig4;
  cdiv2 <= count_dn(0);
  cdiv4 <= count_dn(1);
  cdiv8 <= count_dn(2);
 
END v;


--
----- cell ehxplle -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;


-- entity declaration --
ENTITY ehxplle IS
   GENERIC (
      FIN                : string  := "100.0";
      CLKI_DIV           : Integer   := 1;
      CLKFB_DIV          : Integer   := 1;
      CLKOP_DIV          : Integer   := 8;
      CLKOK_DIV          : Integer   := 2;
      PHASEADJ           : String    := "0.0";
      DUTY               : Integer   := 8;
      PHASE_CNTL         : String    := "STATIC";
      CLKOP_BYPASS       : String    := "DISABLED";
      CLKOS_BYPASS       : String    := "DISABLED";
      CLKOK_BYPASS       : String    := "DISABLED";
      CLKOP_TRIM_POL     : String    := "FALLING";
      CLKOP_TRIM_DELAY   : Integer   := 6;
      CLKOS_TRIM_POL     : String    := "RISING";
      CLKOS_TRIM_DELAY   : Integer   := 0;
      LOCK_DELAY         : Integer   := 100;
      TimingChecksOn     : Boolean   := TRUE;
      XOn                : Boolean   := FALSE;
      MsgOn              : Boolean   := TRUE;
      InstancePath       : String    := "ehxplle";
      tipd_clki             : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rst              : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rstk             : VitalDelayType01 := (0 ns, 0 ns);
      tipd_wrdel            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai3           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai2           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai1           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai0           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai3           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai2           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai1           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai0           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_clkfb            : VitalDelayType01 := (0 ns, 0 ns));

   PORT(
      clki                  : in std_logic;
      clkfb                 : in std_logic;
      rst                   : in std_logic;
      rstk                  : in std_logic;
      wrdel                 : in std_logic;
      drpai3                : in std_logic;
      drpai2                : in std_logic;
      drpai1                : in std_logic;
      drpai0                : in std_logic;
      dfpai3                : in std_logic;
      dfpai2                : in std_logic;
      dfpai1                : in std_logic;
      dfpai0                : in std_logic;
      clkos                 : out std_logic;
      clkop                 : out std_logic;
      clkok                 : out std_logic;
      clkok2                : out std_logic;
      lock                  : out std_logic;
      clkintfb              : out std_logic);

    ATTRIBUTE Vital_Level0 OF ehxplle : ENTITY IS TRUE;

END ehxplle ;

-- ARCHITECTURE body --
ARCHITECTURE V OF ehxplle IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clki_ipd          : std_logic := '0';
    SIGNAL clkfb_ipd         : std_logic := '0';
    SIGNAL rst_ipd           : std_logic := '0';
    SIGNAL rstk_ipd          : std_logic := '0';
    SIGNAL wrdel_ipd         : std_logic := '0';
    SIGNAL drpai_ipd         : std_logic_vector(3 downto 0) := "0000";
    SIGNAL dfpai_ipd         : std_logic_vector(3 downto 0) := "0000";
    SIGNAL false_clk          : std_logic := '0';
    SIGNAL ext_divider        : Real := 1.0 ;
    SIGNAL net_divide         : Real := 1.0 ;
    SIGNAL duty_i             : Integer := 0 ;
    SIGNAL phase_shift_value         : Integer := 0 ;
    SIGNAL phase_shift_value_static  : Integer := 0 ;
    SIGNAL pll_dly_value      : Time  := 0 ps;
    SIGNAL t_in_clk           : time := 0 ns;
    SIGNAL t_vco              : time := 0 ns;
    SIGNAL ha_vco1            : time := 0 ns;
    SIGNAL ha_vco             : time := 0 ns;
    SIGNAL duty_vco1          : time := 0 ns;
    SIGNAL duty_vco           : time := 0 ns;
    SIGNAL ha_vco_r1          : real := 0.0;
    SIGNAL round_err          : real := 0.0;
    SIGNAL t_in_clk1          : time := 0 ns;
    SIGNAL t_in_clk2          : time := 0 ns;
    SIGNAL t_in_clk3          : time := 0 ns;
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL clock_invalid      : std_logic := '0';
    SIGNAL out_clk_valid      : std_logic := '0';
    SIGNAL clkop_first_time   : std_logic := '1';
    SIGNAL total_fb_delay     : time := 0 ps;
    SIGNAL false_t1_int       : time := 5 ns;
    SIGNAL false_t_int        : time := 0 ns;
    SIGNAL ratio1             : Integer   := 0;
    SIGNAL t_fb_clk           : time := 0 ns;
    SIGNAL virtual_delay1     : time := 0 ps;
    SIGNAL real_delay1        : time := 0 ps;
    SIGNAL intfb_out          : std_logic := '0';
    SIGNAL lock_all           : std_logic := '0';
    SIGNAL first_time7        : std_logic := '1';
    SIGNAL real_delay2        : time := 0 ps;
	 SIGNAL phase_delay        : time := 0 ps;
    SIGNAL vir_pclk          : std_logic := '0';
    SIGNAL vir_intfb         : std_logic := '0';
    SIGNAL vir_lock           : std_logic := '0';
    SIGNAL vir_kclk           : std_logic := '0';
	 SIGNAL vir_k2clk          : std_logic := '0';
    SIGNAL vir_sclk           : std_logic := '0';
    SIGNAL final_sclk         : std_logic := '0';
    SIGNAL lock_delay_reg     : time := 1 ns;
    SIGNAL lock1              : std_logic := '0';
    SIGNAL d_lock             : std_logic := '1';
    SIGNAL d1_lock            : std_logic := '1';
    SIGNAL d2_lock            : std_logic := '1';
    SIGNAL d3_lock            : std_logic := '1';
    SIGNAL d4_lock            : std_logic := '1';
    SIGNAL dly_change         : std_logic := '0';
    SIGNAL phase_change       : std_logic := '0';
	 SIGNAL clkop_reg1         : std_logic := '0';
    SIGNAL clkok_reg1         : std_logic := '0';
    SIGNAL duty_set           : Integer := 0 ;
    SIGNAL phase_set          : Integer := 0 ;


BEGIN
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(rst_ipd, rst, tipd_rst);
   VitalWireDelay(rstk_ipd, rstk, tipd_rstk);
   VitalWireDelay(clki_ipd, clki, tipd_clki);
   VitalWireDelay(clkfb_ipd, clkfb, tipd_clkfb);
   VitalWireDelay(wrdel_ipd, wrdel, tipd_wrdel);
   VitalWireDelay(drpai_ipd(3), drpai3, tipd_drpai3);
   VitalWireDelay(drpai_ipd(2), drpai2, tipd_drpai2);
   VitalWireDelay(drpai_ipd(1), drpai1, tipd_drpai1);
   VitalWireDelay(drpai_ipd(0), drpai0, tipd_drpai0);
   VitalWireDelay(dfpai_ipd(3), dfpai3, tipd_dfpai3);
   VitalWireDelay(dfpai_ipd(2), dfpai2, tipd_dfpai2);
   VitalWireDelay(dfpai_ipd(1), dfpai1, tipd_dfpai1);
   VitalWireDelay(dfpai_ipd(0), dfpai0, tipd_dfpai0);
   END BLOCK;

--------------------------------------------------------------------
-- Generate False Clocks
--------------------------------------------------------------------

   false_clk <= not false_clk after 5 ns;
--------------------------------------------------------------------

   P1 : PROCESS (wrdel_ipd)
	BEGIN
	   IF (wrdel_ipd = '1') THEN
	      pll_dly_value <= 70 ps;
		ELSE
		   pll_dly_value <= 0 ps;
		END IF;
      dly_change <= not dly_change;
	END PROCESS;


   P151 : PROCESS (clki_ipd)
   BEGIN
      IF (PHASEADJ = "22.5") THEN
         phase_shift_value_static <= 1;
      ELSIF (PHASEADJ = "45.0") THEN
         phase_shift_value_static <= 2;
      ELSIF (PHASEADJ = "67.5") THEN
         phase_shift_value_static <= 3;
      ELSIF (PHASEADJ = "90.0") THEN
         phase_shift_value_static <= 4;
      ELSIF (PHASEADJ = "112.5") THEN
         phase_shift_value_static <= 5;
      ELSIF (PHASEADJ = "135.0") THEN
         phase_shift_value_static <= 6;
      ELSIF (PHASEADJ = "157.5") THEN
         phase_shift_value_static <= 7;
      ELSIF (PHASEADJ = "180.0") THEN
         phase_shift_value_static <= 8;
      ELSIF (PHASEADJ = "202.5") THEN
         phase_shift_value_static <= 9;
      ELSIF (PHASEADJ = "225.0") THEN
         phase_shift_value_static <= 10;
      ELSIF (PHASEADJ = "247.5") THEN
         phase_shift_value_static <= 11;
      ELSIF (PHASEADJ = "270.0") THEN
         phase_shift_value_static <= 12;
      ELSIF (PHASEADJ = "292.5") THEN
         phase_shift_value_static <= 13;
      ELSIF (PHASEADJ = "315.0") THEN
         phase_shift_value_static <= 14;
      ELSIF (PHASEADJ = "337.5") THEN
         phase_shift_value_static <= 15;
      ELSE 
         phase_shift_value_static <= 0;
      END IF;
   END PROCESS;

   duty_set <= conv_integer(dfpai_ipd);
   phase_set <= conv_integer(drpai_ipd);

   P152 : PROCESS (duty_set, phase_set, phase_shift_value_static)
   BEGIN
      IF (PHASE_CNTL = "DYNAMIC") THEN
         phase_shift_value <= phase_set;
         IF (duty_set > phase_set) THEN
            duty_i <= (duty_set - phase_set);
         ELSIF (duty_set < phase_set) THEN
            duty_i <= 16 + duty_set - phase_set;
         ELSE
            duty_i <= 8;
         END IF;
         phase_change <= not phase_change;
      ELSE
         phase_shift_value <= phase_shift_value_static;
         duty_i <= DUTY;
      END IF;
   END PROCESS;



   P51 : PROCESS (clki_ipd, dly_change, phase_change, rst_ipd)
   BEGIN
      IF (dly_change'event or phase_change'event or (rst_ipd = '1')) THEN
         d_lock <= '0';
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         IF (d_lock = '0') THEN
            d_lock <= '1';
         END IF;
      END IF;
   END PROCESS;

   P52 : PROCESS (clki_ipd)
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
         d1_lock <= d_lock;
      END IF;
   END PROCESS;

   P53 : PROCESS (clki_ipd)
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
         d3_lock <= d1_lock;
      END IF;
   END PROCESS;

   d2_lock <= d_lock and d1_lock;
   d4_lock <= d_lock and d1_lock and d3_lock;

   CLKIN_PERIOD : PROCESS (clki_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF ((t_in_clk = t_in_clk1) and (t_in_clk = t_in_clk2) and (t_in_clk = t_in_clk3)) THEN
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

------------------------------------------------
-- measure the feedback delay value
------------------------------------------------
   P100 : PROCESS (clkfb_ipd)
   VARIABLE fb_count : Integer := 0;
   BEGIN
      IF (clkfb_ipd'event and clkfb_ipd = '1') THEN
         fb_count := fb_count + 1;
         IF (fb_count = 3) THEN
            clkop_first_time <= '0';
         END IF;
      END IF;
   END PROCESS;

   GENERATE_FIRST_FB_EDGE : PROCESS (false_clk, clkfb_ipd)
   VARIABLE false_clk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_int_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   BEGIN
      if (false_clk'event and false_clk'last_value = '0' and false_clk = '1') then
         if (false_clk_first_time) then
            first_int_edge := NOW;
            false_clk_first_time := false;
         end if;
      end if;
      if (clkfb_ipd'event and clkfb_ipd'last_value = '0' and clkfb_ipd = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;
         total_fb_delay <= first_fb_edge - first_int_edge ;
   END PROCESS;

   FB_PERIOD : PROCESS (clkfb_ipd)
   VARIABLE last_clock_edge : time := 0 ps;
   VARIABLE next_clock_edge : time := 0 ps;
   VARIABLE first_time      : Boolean := true;
   BEGIN
      IF (clkfb_ipd'event and clkfb_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
             IF (first_time) THEN
                t_fb_clk <= next_clock_edge - last_clock_edge;
                first_time := false;
             END IF;
           END IF;
      END IF;
   END PROCESS;

   false_t_int <= 2 * false_t1_int;

   INT_FB : PROCESS (t_fb_clk)
   BEGIN
      IF (t_fb_clk > 0 ps) THEN
         ext_divider <= (real(time'pos(t_fb_clk)) / real(time'pos(false_t_int)) );
      END IF;
   END PROCESS;

   DELAY1 : PROCESS (total_fb_delay, t_in_clk, ratio1, virtual_delay1, clki_ipd)
   BEGIN
      IF ((total_fb_delay > 0 ps) and (t_in_clk > 0 ps)) THEN
          ratio1 <= total_fb_delay / t_in_clk;
          virtual_delay1 <= total_fb_delay - (t_in_clk * ratio1);
          real_delay1 <= t_in_clk - virtual_delay1 ;
      END IF;
   END PROCESS;

   net_divide <= (real(CLKFB_DIV) * ext_divider);

   P6 : PROCESS (t_in_clk, net_divide)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_vco <= ((t_in_clk * CLKI_DIV) / net_divide);  -- vco oscillating cycle
         ha_vco_r1 <= ((real(time'pos(t_in_clk)) * real(CLKI_DIV)) / net_divide) / 2.0;
      END IF;
   END PROCESS;

   ha_vco1 <= (t_vco / 2.0);  -- vco oscillating half-cycle
   duty_vco1 <= ((t_vco * duty_i) / 16);  -- duty_cycle

   P106 : PROCESS (ha_vco1)
   BEGIN
      IF (ha_vco1 > 0 ps) THEN
         round_err <= (real(time'pos(t_in_clk)) - ((real(time'pos(ha_vco1)) * 2.0 * net_divide) / real(CLKI_DIV))) / 2.0;
      END IF;
   END PROCESS;

   process (ha_vco1)
	begin
		IF (PHASE_CNTL = "STATIC") THEN
		   ha_vco <= ha_vco1;
		ELSE
			IF (CLKOP_TRIM_POL = "RISING") THEN
				ha_vco <= ha_vco1 - (50 ps * CLKOP_TRIM_DELAY);
			ELSE
				ha_vco <= ha_vco1 + (50 ps * CLKOP_TRIM_DELAY);
			END IF;
		END IF;
	end process;

   process (duty_vco1)
	begin
		IF (PHASE_CNTL = "STATIC") THEN
		   duty_vco <= duty_vco1;
		ELSE
			IF (CLKOS_TRIM_POL = "RISING") THEN
				duty_vco <= duty_vco1 - (50 ps * CLKOS_TRIM_DELAY);
			ELSE
				duty_vco <= duty_vco1 + (50 ps * CLKOS_TRIM_DELAY);
			END IF;
		END IF;
	end process;

   P101 : PROCESS (duty_vco)
   BEGIN
	  IF clock_valid = '1' THEN
      IF (duty_vco < 1 ns) THEN
         assert FALSE
         report "Pulse width of CLKOS is less than 1 ns, which is illegal!"
         severity WARNING;
      ELSIF ((t_vco - duty_vco) < 1 ns) THEN
         assert FALSE
         report "Pulse width of CLKOS is less than 1 ns, which is illegal!"
         severity WARNING;
      END IF;
	  END IF;
   END PROCESS;

   P7 : PROCESS (clki_ipd, rst_ipd, d_lock)
   BEGIN
      IF ((rst_ipd = '1') or (d_lock = '0')) THEN
         out_clk_valid <= '0';
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         out_clk_valid <= clock_valid;
      END IF;
   END PROCESS;

   P8 : PROCESS (out_clk_valid, intfb_out)
      VARIABLE index : real := 0.0;
   BEGIN
      IF (out_clk_valid  = '0') THEN
         intfb_out <= '0';
         first_time7 <= '1';
         index := 0.0;
      ELSE
         IF (first_time7 = '1') THEN
            intfb_out <= '1';
            first_time7 <= '0';
            index := 0.0;
         ELSE
            index := index + 1.0;
            IF (index = net_divide) THEN
--               intfb_out <= not intfb_out after time'val(integer(ha_vco_r1 + round_err));
               intfb_out <= not intfb_out after (ha_vco1 + time'val(integer(round_err)));
               index := 0.0;
            ELSE
               intfb_out <= not intfb_out after ha_vco1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   phase_delay <= ((t_vco * phase_shift_value) / 16);
   real_delay2 <= phase_delay + pll_dly_value;

   PROCESS (intfb_out, d2_lock)
   BEGIN
	  IF (d2_lock = '0') THEN
	     vir_intfb <= '0';
	  ELSE
        vir_intfb <= transport intfb_out after real_delay1;
	  END IF;
	END PROCESS;

   P9 : PROCESS (vir_intfb, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         vir_pclk <= '0';
      ELSE
         IF (vir_intfb'event and vir_intfb = '1') THEN
            vir_pclk <= '1', '0' after ha_vco;
         END IF;
      END IF;
   END PROCESS;

   P108 : PROCESS (intfb_out)
   BEGIN
      IF (out_clk_valid  = '0') THEN
         vir_lock <= '0';
      ELSE
         vir_lock <= '1';
      END IF;
   END PROCESS;

   P91 : PROCESS (vir_pclk, d2_lock)
   VARIABLE index1 : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (d2_lock = '0') THEN
         vir_kclk <= '0';
         first_time := true;
      ELSE
         IF (vir_pclk'event) THEN
            IF (first_time) THEN
               IF (vir_pclk = '1') THEN
                  vir_kclk <= '1';
                  IF (out_clk_valid = '0') THEN
                     first_time := true;
                  ELSE
                     first_time := false;
                  END IF;
                  index1 := 0;
               END IF;
            ELSE
               index1 := index1 + 1;
               IF (index1 = CLKOK_DIV) THEN
                  vir_kclk <= NOT vir_kclk;
                  index1 := 0;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

-------------------------------------------------------
-- Generate LOCK signal
-------------------------------------------------------
   LOCK_IT : PROCESS (rst_ipd, vir_lock, out_clk_valid, clock_invalid)
   BEGIN
      IF (rst_ipd = '1') THEN
         lock_all <= '0';
      ELSE
        IF clock_invalid = '1' THEN
           lock_all <= '0';
        ELSIF out_clk_valid = '1' THEN
           lock_all <= transport vir_lock after (LOCK_DELAY * lock_delay_reg);
        END IF;
      END IF;
   END PROCESS;

   P10 : PROCESS (vir_intfb, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         vir_sclk <= '0';
      ELSE
         IF (vir_intfb'event and vir_intfb = '1') THEN
            vir_sclk <= '1', '0' after duty_vco;
         END IF;
      END IF;
   END PROCESS;

   P54 : PROCESS (vir_sclk, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         final_sclk <= '0';
      ELSE
         final_sclk <= transport vir_sclk after real_delay2;
      END IF;
   END PROCESS;


   -- CLKOK2 = CLKOP / 3

   PROCESS (clkop_reg1, d2_lock)
      VARIABLE index2 : Integer := 0;
      VARIABLE first_time : boolean := true;
   BEGIN
      IF (d2_lock = '0') THEN
         vir_k2clk <= '0';
         first_time := true;
      ELSE
         IF (clkop_reg1'event) THEN
            IF (first_time) THEN
               IF (clkop_reg1 = '1') THEN
                  vir_k2clk <= '1';
                  IF (out_clk_valid = '0') THEN
                     first_time := true;
                  ELSE
                     first_time := false;
                  END IF;
                  index2 := 0;
               END IF;
            ELSE
               index2 := index2 + 1;
               IF (index2 = 3) THEN
                  vir_k2clk <= NOT vir_k2clk;
                  index2 := 0;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

	clkop <= clkop_reg1;

   P12 : PROCESS (clki_ipd, out_clk_valid, vir_pclk, vir_intfb, lock_all, vir_kclk, vir_k2clk,
                  final_sclk, false_clk, rst_ipd, clkop_first_time)
   BEGIN
      IF (CLKOP_BYPASS = "ENABLED") THEN
         clkop_reg1 <= clki_ipd;
      ELSIF (clkop_first_time = '1') THEN
         clkop_reg1 <= false_clk;
      ELSIF (rst_ipd = '1') THEN
         clkop_reg1 <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkop_reg1 <= vir_pclk;
      END IF;

      IF (rst_ipd = '1') THEN
         clkok2 <= '0';
      ELSE
         clkok2 <= vir_k2clk;
      END IF;

      IF (CLKOS_BYPASS = "ENABLED") THEN
         clkos <= clki_ipd;
      ELSIF (clkop_first_time = '1') THEN
         clkos <= false_clk;
      ELSIF (rst_ipd = '1') THEN
         clkos <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkos <= final_sclk;
      END IF;

      IF (CLKOK_BYPASS = "ENABLED") THEN
         clkok_reg1 <= clki_ipd;
      ELSIF (clkop_first_time = '1') THEN
         clkok_reg1 <= false_clk;
      ELSIF (rst_ipd = '1') THEN
         clkok_reg1 <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkok_reg1 <= vir_kclk;
      END IF;

      IF (clkop_first_time = '1') THEN
         clkintfb <= false_clk;
         lock1 <= '0';
      ELSIF (rst_ipd = '1') THEN
         clkintfb <= '0';
         lock1 <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkintfb <= vir_intfb;
         lock1 <= lock_all;
      END IF;
   END PROCESS;

   P15 : PROCESS (clkok_reg1, rstk_ipd)
   BEGIN
      IF (CLKOK_BYPASS = "ENABLED") THEN
         clkok <= clkok_reg1;
      ELSE 
         IF (clkop_first_time = '1') THEN
            clkok <= clkok_reg1;
         ELSIF (rstk_ipd = '1') THEN
            clkok <= '0';
         ELSIF (clkok_reg1'event) THEN
            clkok <= clkok_reg1;
         END IF; 
      END IF;
   END PROCESS;

   lock <= lock1 and d4_lock;
END V;


--
----- cell eplld -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;


-- entity declaration --
ENTITY eplld IS
   GENERIC (
      FIN                : string  := "100.0";
      CLKI_DIV           : Integer   := 1;
      CLKFB_DIV          : Integer   := 1;
      CLKOP_DIV          : Integer   := 8;
      CLKOK_DIV          : Integer   := 2;
      PHASEADJ           : String    := "0.0";
      DUTY               : Integer   := 8;
      PLLCAP             : String    := "DISABLED";
      PHASE_CNTL         : String    := "STATIC";
      CLKOP_BYPASS       : String    := "DISABLED";
      CLKOS_BYPASS       : String    := "DISABLED";
      CLKOK_BYPASS       : String    := "DISABLED";
      PLLTYPE            : String    := "AUTO";
      LOCK_DELAY         : Integer   := 100;
--      LOCK_CYC           : Integer   := 2;
      TimingChecksOn     : Boolean   := TRUE;
      XOn                : Boolean   := FALSE;
      MsgOn              : Boolean   := TRUE;
      InstancePath       : String    := "eplld";
      tipd_clki             : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rst              : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rstk             : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dpamode          : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai3           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai2           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai1           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai0           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai3           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai2           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai1           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai0           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_clkfb            : VitalDelayType01 := (0 ns, 0 ns));

   PORT(
      clki                  : in std_logic;
      clkfb                 : in std_logic;
      rst                   : in std_logic;
      rstk                  : in std_logic;
      dpamode               : in std_logic;
      drpai3                : in std_logic;
      drpai2                : in std_logic;
      drpai1                : in std_logic;
      drpai0                : in std_logic;
      dfpai3                : in std_logic;
      dfpai2                : in std_logic;
      dfpai1                : in std_logic;
      dfpai0                : in std_logic;
      clkos                 : out std_logic;
      clkop                 : out std_logic;
      clkok                 : out std_logic;
      lock                  : out std_logic;
      clkintfb              : out std_logic);

    ATTRIBUTE Vital_Level0 OF eplld : ENTITY IS TRUE;

END eplld ;

-- ARCHITECTURE body --
ARCHITECTURE V OF eplld IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clki_ipd          : std_logic := '0';
    SIGNAL clkfb_ipd         : std_logic := '0';
    SIGNAL rst_ipd           : std_logic := '0';
    SIGNAL rstk_ipd           : std_logic := '0';
    SIGNAL dpamode_ipd           : std_logic := '0';
    SIGNAL drpai_ipd           : std_logic_vector(3 downto 0) := "0000";
    SIGNAL dfpai_ipd           : std_logic_vector(3 downto 0) := "0000";
    SIGNAL false_clk          : std_logic := '0';
    SIGNAL ext_divider        : Real := 1.0 ;
    SIGNAL net_divide         : Real := 1.0 ;
    SIGNAL pll_dly_step         : Integer := 0 ;
    SIGNAL duty_i               : Integer := 0 ;
    SIGNAL phase_shift_value               : Integer := 0 ;
    SIGNAL phase_shift_value_static               : Integer := 0 ;
    SIGNAL t_in_clk           : time := 0 ns;
    SIGNAL t_vco              : time := 0 ns;
    SIGNAL ha_vco              : time := 0 ns;
    SIGNAL duty_vco              : time := 0 ns;
    SIGNAL ha_vco_r           : real := 0.0;
    SIGNAL round_err          : real := 0.0;
    SIGNAL t_in_clk1          : time := 0 ns;
    SIGNAL t_in_clk2          : time := 0 ns;
    SIGNAL t_in_clk3          : time := 0 ns;
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL clock_invalid      : std_logic := '0';
    SIGNAL out_clk_valid      : std_logic := '0';
    SIGNAL clkop_first_time   : std_logic := '1';
    SIGNAL total_fb_delay     : time := 0 ps;
    SIGNAL false_t1_int       : time := 5 ns;
    SIGNAL false_t_int        : time := 0 ns;
    SIGNAL ratio1             : Integer   := 0;
    SIGNAL t_fb_clk           : time := 0 ns;
    SIGNAL virtual_delay1     : time := 0 ps;
    SIGNAL real_delay1        : time := 0 ps;
    SIGNAL intfb_out          : std_logic := '0';
    SIGNAL lock_all           : std_logic := '0';
    SIGNAL first_time7        : std_logic := '1';
    SIGNAL real_delay2        : time := 0 ps;
    SIGNAL real_delay         : time := 0 ps;
    SIGNAL vir_intfb          : std_logic := '0';
    SIGNAL vir_intfb1          : std_logic := '0';
    SIGNAL vir_lock           : std_logic := '0';
    SIGNAL vir_kclk           : std_logic := '0';
    SIGNAL vir_sclk           : std_logic := '0';
    SIGNAL final_sclk           : std_logic := '0';
    SIGNAL lock_delay_reg     : time := 1 ns;
    SIGNAL lock1              : std_logic := '0';
    SIGNAL d_lock             : std_logic := '1';
    SIGNAL d1_lock            : std_logic := '1';
    SIGNAL d2_lock            : std_logic := '1';
    SIGNAL d3_lock            : std_logic := '1';
    SIGNAL d4_lock            : std_logic := '1';
    SIGNAL phase_change         : std_logic := '0';
    SIGNAL clkok_reg1         : std_logic := '0';
    SIGNAL duty_set           : Integer := 0 ;
    SIGNAL phase_set          : Integer := 0 ;
    SIGNAL next_clkin_dly     : std_logic := '0';
    SIGNAL new1_clkin_dly     : std_logic := '0';
    SIGNAL new2_clkin_dly     : std_logic := '0';
    SIGNAL new_lock           : std_logic := '0';
    SIGNAL new_lock1          : std_logic := '0';
    SIGNAL new_lock2          : std_logic := '0';
    SIGNAL lock2_count        : Integer := 0;
    SIGNAL lock_all2          : std_logic := '0';
    SIGNAL rstkb1             : std_logic := '0';
    SIGNAL rstkb_rel          : std_logic := '0';


BEGIN
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(rst_ipd, rst, tipd_rst);
   VitalWireDelay(rstk_ipd, rstk, tipd_rstk);
   VitalWireDelay(clki_ipd, clki, tipd_clki);
   VitalWireDelay(clkfb_ipd, clkfb, tipd_clkfb);
   VitalWireDelay(dpamode_ipd, dpamode, tipd_dpamode);
   VitalWireDelay(drpai_ipd(3), drpai3, tipd_drpai3);
   VitalWireDelay(drpai_ipd(2), drpai2, tipd_drpai2);
   VitalWireDelay(drpai_ipd(1), drpai1, tipd_drpai1);
   VitalWireDelay(drpai_ipd(0), drpai0, tipd_drpai0);
   VitalWireDelay(dfpai_ipd(3), dfpai3, tipd_dfpai3);
   VitalWireDelay(dfpai_ipd(2), dfpai2, tipd_dfpai2);
   VitalWireDelay(dfpai_ipd(1), dfpai1, tipd_dfpai1);
   VitalWireDelay(dfpai_ipd(0), dfpai0, tipd_dfpai0);
   END BLOCK;

--------------------------------------------------------------------
-- Generate False Clocks
--------------------------------------------------------------------

   false_clk <= not false_clk after 5 ns;
--------------------------------------------------------------------

   P151 : PROCESS (clki_ipd)
   BEGIN
      IF (PHASEADJ = "22.5") THEN
         phase_shift_value_static <= 1;
      ELSIF (PHASEADJ = "45.0") THEN
         phase_shift_value_static <= 2;
      ELSIF (PHASEADJ = "67.5") THEN
         phase_shift_value_static <= 3;
      ELSIF (PHASEADJ = "90.0") THEN
         phase_shift_value_static <= 4;
      ELSIF (PHASEADJ = "112.5") THEN
         phase_shift_value_static <= 5;
      ELSIF (PHASEADJ = "135.0") THEN
         phase_shift_value_static <= 6;
      ELSIF (PHASEADJ = "157.5") THEN
         phase_shift_value_static <= 7;
      ELSIF (PHASEADJ = "180.0") THEN
         phase_shift_value_static <= 8;
      ELSIF (PHASEADJ = "202.5") THEN
         phase_shift_value_static <= 9;
      ELSIF (PHASEADJ = "225.0") THEN
         phase_shift_value_static <= 10;
      ELSIF (PHASEADJ = "247.5") THEN
         phase_shift_value_static <= 11;
      ELSIF (PHASEADJ = "270.0") THEN
         phase_shift_value_static <= 12;
      ELSIF (PHASEADJ = "292.5") THEN
         phase_shift_value_static <= 13;
      ELSIF (PHASEADJ = "315.0") THEN
         phase_shift_value_static <= 14;
      ELSIF (PHASEADJ = "337.5") THEN
         phase_shift_value_static <= 15;
      ELSE 
         phase_shift_value_static <= 0;
      END IF;
   END PROCESS;

   duty_set <= conv_integer(dfpai_ipd);
   phase_set <= conv_integer(drpai_ipd);

   P152 : PROCESS (dpamode_ipd, duty_set, phase_set, phase_shift_value_static)
   BEGIN
      IF (PHASE_CNTL = "DYNAMIC") THEN
         IF (dpamode_ipd = '1') THEN
            phase_shift_value <= phase_set;
            IF (duty_set > phase_set) THEN
               duty_i <= (duty_set - phase_set);
            ELSIF (duty_set < phase_set) THEN
               duty_i <= 16 + duty_set - phase_set;
            ELSE
               duty_i <= 8;
            END IF;
            phase_change <= not phase_change;
         ELSE
            phase_shift_value <= phase_shift_value_static;
            duty_i <= DUTY;
         END IF;
      ELSE
         phase_shift_value <= phase_shift_value_static;
         duty_i <= DUTY;
      END IF;
   END PROCESS;



   P51 : PROCESS (clki_ipd, rst_ipd)
   BEGIN
      IF (rst_ipd = '1') THEN
         d_lock <= '0';
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         IF (d_lock = '0') THEN
            d_lock <= '1';
         END IF;
      END IF;
   END PROCESS;

   P52 : PROCESS (clki_ipd)
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
         d1_lock <= d_lock;
      END IF;
   END PROCESS;

   P53 : PROCESS (clki_ipd)
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
         d3_lock <= d1_lock;
      END IF;
   END PROCESS;

   d2_lock <= d_lock and d1_lock;
   d4_lock <= d_lock and d1_lock and d3_lock;

   next_clkin_dly <= transport (not clki_ipd) after (t_in_clk);
   new1_clkin_dly <= clki_ipd;
   new2_clkin_dly <= new1_clkin_dly;

   P71 : PROCESS (next_clkin_dly)
   BEGIN
      new_lock <= not(next_clkin_dly xor new2_clkin_dly);
   END PROCESS;

   new_lock1 <= transport new_lock after (t_in_clk3);
   new_lock2 <= new_lock and new_lock1;

   CLKIN_PERIOD : PROCESS (clki_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF ((t_in_clk = t_in_clk1) and (t_in_clk = t_in_clk2) and (t_in_clk = t_in_clk3)) THEN
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

------------------------------------------------
-- measure the feedback delay value
------------------------------------------------
   P100 : PROCESS (clkfb_ipd)
   VARIABLE fb_count : Integer := 0;
   BEGIN
      IF (clkfb_ipd'event and clkfb_ipd = '1') THEN
         fb_count := fb_count + 1;
         IF (fb_count = 3) THEN
            clkop_first_time <= '0';
         END IF;
      END IF;
   END PROCESS;

   GENERATE_FIRST_FB_EDGE : PROCESS (false_clk, clkfb_ipd)
   VARIABLE false_clk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_int_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   BEGIN
      if (false_clk'event and false_clk'last_value = '0' and false_clk = '1') then
         if (false_clk_first_time) then
            first_int_edge := NOW;
            false_clk_first_time := false;
         end if;
      end if;
      if (clkfb_ipd'event and clkfb_ipd'last_value = '0' and clkfb_ipd = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;
         total_fb_delay <= first_fb_edge - first_int_edge ;
   END PROCESS;

   FB_PERIOD : PROCESS (clkfb_ipd)
   VARIABLE last_clock_edge : time := 0 ps;
   VARIABLE next_clock_edge : time := 0 ps;
   VARIABLE first_time      : Boolean := true;
   BEGIN
      IF (clkfb_ipd'event and clkfb_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
             IF (first_time) THEN
                t_fb_clk <= next_clock_edge - last_clock_edge;
                first_time := false;
             END IF;
           END IF;
      END IF;
   END PROCESS;

   false_t_int <= 2 * false_t1_int;

   INT_FB : PROCESS (t_fb_clk)
   BEGIN
      IF (t_fb_clk > 0 ps) THEN
         ext_divider <= (real(time'pos(t_fb_clk)) / real(time'pos(false_t_int)) );
      END IF;
   END PROCESS;

   DELAY1 : PROCESS (total_fb_delay, t_in_clk, ratio1, virtual_delay1, clki_ipd)
   BEGIN
      IF ((total_fb_delay > 0 ps) and (t_in_clk > 0 ps)) THEN
          ratio1 <= total_fb_delay / t_in_clk;
          virtual_delay1 <= total_fb_delay - (t_in_clk * ratio1);
          real_delay1 <= t_in_clk - virtual_delay1 ;
      END IF;
   END PROCESS;

   net_divide <= (real(CLKFB_DIV) * ext_divider);

   P6 : PROCESS (t_in_clk, net_divide)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_vco <= ((t_in_clk * CLKI_DIV) / net_divide);  -- vco oscillating cycle
         ha_vco_r <= ((real(time'pos(t_in_clk)) * real(CLKI_DIV)) / net_divide) / 2.0;
      END IF;
   END PROCESS;

   ha_vco <= (t_vco / 2.0);  -- vco oscillating half-cycle
   duty_vco <= ((t_vco * duty_i) / 16);  -- duty_cycle

   P106 : PROCESS (ha_vco)
   BEGIN
      IF (ha_vco > 0 ps) THEN
         round_err <= (real(time'pos(t_in_clk)) - ((real(time'pos(ha_vco)) * 2.0 * net_divide) / real(CLKI_DIV))) / 2.0;
      END IF;
   END PROCESS;

   P101 : PROCESS (duty_vco)
   BEGIN
	  IF clock_valid = '1' THEN
      IF (duty_vco < 1 ns) THEN
         assert FALSE
         report "Pulse width of CLKOS is less than 1 ns, which is illegal!"
         severity WARNING;
      ELSIF ((t_vco - duty_vco) < 1 ns) THEN
         assert FALSE
         report "Pulse width of CLKOS is less than 1 ns, which is illegal!"
         severity WARNING;
      END IF;
	  END IF;
   END PROCESS;

   P7 : PROCESS (clki_ipd, rst_ipd, d_lock)
   BEGIN
      IF ((rst_ipd = '1') or (d_lock = '0')) THEN
         out_clk_valid <= '0';
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         out_clk_valid <= clock_valid;
      END IF;
   END PROCESS;

   P8 : PROCESS (out_clk_valid, intfb_out)
      VARIABLE index : real := 0.0;
   BEGIN
      IF (out_clk_valid  = '0') THEN
         intfb_out <= '0';
         first_time7 <= '1';
         index := 0.0;
      ELSE
         IF (first_time7 = '1') THEN
            intfb_out <= '1';
            first_time7 <= '0';
            index := 0.0;
         ELSE
            index := index + 1.0;
            IF (index = net_divide) THEN
--               intfb_out <= not intfb_out after time'val(integer(ha_vco_r + round_err));
               intfb_out <= not intfb_out after (ha_vco + time'val(integer(round_err)));
               index := 0.0;
            ELSE
               intfb_out <= not intfb_out after ha_vco;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   real_delay2 <= ((t_vco * phase_shift_value) / 16);

   real_delay <= (real_delay1 + real_delay2);

   vir_intfb1 <= transport intfb_out after real_delay1;

   P9 : PROCESS (vir_intfb1, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         vir_intfb <= '0';
      ELSE
         vir_intfb <= vir_intfb1;
      END IF;
   END PROCESS;

   P108 : PROCESS (intfb_out)
   BEGIN
      IF (out_clk_valid  = '0') THEN
         vir_lock <= '0';
      ELSE
         vir_lock <= '1';
      END IF;
   END PROCESS;

   P110 : PROCESS (vir_intfb, rstk_ipd)
   BEGIN
      IF (rstk_ipd = '1') THEN
         rstkb_rel <= rstk_ipd;
      ELSIF (vir_intfb'event and vir_intfb = '0') THEN
         rstkb_rel <= rstkb1;
      END IF;
   END PROCESS;

   P111 : PROCESS (vir_intfb)
   VARIABLE index_k : Integer := 0;
   BEGIN
      IF (vir_intfb'event and vir_intfb = '1') THEN
         IF (rstk_ipd = '1') THEN
            rstkb1 <= rstk_ipd;
            index_k := 0;
         ELSE
            index_k := index_k + 1;
            IF (index_k = CLKOK_DIV/2) THEN
               rstkb1 <= rstk_ipd;
               index_k := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P91 : PROCESS (vir_intfb, d2_lock, rstkb_rel)
   VARIABLE index1 : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (d2_lock = '0') THEN
         vir_kclk <= '0';
         first_time := true;
      ELSE
         IF (first_time and rstkb_rel = '0') THEN
            IF (vir_intfb'event and vir_intfb = '1') THEN
               vir_kclk <= '1';
               IF (out_clk_valid = '0') THEN
                  first_time := true;
               ELSE
                  first_time := false;
               END IF;
               index1 := 0;
            END IF;
         ELSIF (rstkb_rel = '1') THEN
            vir_kclk <= '0';
            index1 := 0;
            first_time := true;
         ELSIF (vir_intfb'event and vir_intfb = '1') THEN
            index1 := index1 + 1;
            IF (index1 = CLKOK_DIV/2) THEN
               vir_kclk <= NOT vir_kclk;
               index1 := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

-------------------------------------------------------
-- Generate LOCK signal
-------------------------------------------------------
   LOCK_IT : PROCESS (rst_ipd, vir_lock, out_clk_valid, clock_invalid)
   BEGIN
      IF (rst_ipd = '1') THEN
         lock_all <= '0';
      ELSE
        IF clock_invalid = '1' THEN
           lock_all <= '0';
        ELSIF out_clk_valid = '1' THEN
           lock_all <= transport vir_lock after (LOCK_DELAY * lock_delay_reg);
        END IF;
      END IF;
   END PROCESS;

   P81 : PROCESS (new_lock2)
   BEGIN
      IF (new_lock2'event and new_lock2 = '1') THEN
         lock2_count <= lock2_count + 1;
      END IF;
   END PROCESS;

   P72 : PROCESS (lock_all, new_lock2)
   BEGIN
      IF (new_lock2 = '1') THEN
         lock_all2 <= lock_all and new_lock2;
      ELSIF (new_lock2 = '0') THEN
         IF (lock2_count >= 1) THEN
            lock_all2 <= 'X';
         END IF;
      END IF;
   END PROCESS;

   P10 : PROCESS (vir_intfb, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         vir_sclk <= '0';
      ELSIF (vir_intfb'event and vir_intfb = '1') THEN
         vir_sclk <= '1', '0' after duty_vco;
      END IF;
   END PROCESS;

   P54 : PROCESS (vir_sclk, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         final_sclk <= '0';
      ELSE
         final_sclk <= transport vir_sclk after real_delay2;
      END IF;
   END PROCESS;

   P12 : PROCESS (clki_ipd, out_clk_valid, vir_intfb, lock_all2, vir_kclk, final_sclk, false_clk, rst_ipd, clkop_first_time, new_lock2)
   BEGIN
      IF (CLKOP_BYPASS = "ENABLED") THEN
         clkop <= clki_ipd;
      ELSIF (clkop_first_time = '1') THEN
         clkop <= false_clk;
      ELSIF (rst_ipd = '1') THEN
         clkop <= '0';
      ELSIF (new_lock2 = '0') THEN
         clkop <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkop <= vir_intfb;
      END IF;
 
      IF (CLKOS_BYPASS = "ENABLED") THEN
         clkos <= clki_ipd;
      ELSIF (clkop_first_time = '1') THEN
         clkos <= false_clk;
      ELSIF (rst_ipd = '1') THEN
         clkos <= '0';
      ELSIF (new_lock2 = '0') THEN
         clkos <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkos <= final_sclk;
      END IF;

      IF (CLKOK_BYPASS = "ENABLED") THEN
         clkok_reg1 <= clki_ipd;
      ELSIF (clkop_first_time = '1') THEN
         clkok_reg1 <= false_clk;
      ELSIF (rst_ipd = '1') THEN
         clkok_reg1 <= '0';
      ELSIF (new_lock2 = '0') THEN
         clkok_reg1 <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkok_reg1 <= vir_kclk;
      END IF;

      IF (clkop_first_time = '1') THEN
         clkintfb <= false_clk;
         lock1 <= '0';
      ELSIF (rst_ipd = '1') THEN
         clkintfb <= '0';
         lock1 <= '0';
      ELSIF (new_lock2 = '0') THEN
         clkintfb <= '0';
         lock1 <= lock_all2;
      ELSIF (out_clk_valid = '1') THEN
         clkintfb <= vir_intfb;
         lock1 <= lock_all2;
      END IF;
   END PROCESS;

   P15 : PROCESS (clkok_reg1, rstk_ipd)
   BEGIN
      IF (CLKOK_BYPASS = "ENABLED") THEN
         clkok <= clkok_reg1;
      ELSE 
         IF (clkop_first_time = '1') THEN
            clkok <= clkok_reg1;
         ELSIF (rstk_ipd = '1') THEN
            clkok <= '0';
         ELSIF (clkok_reg1'event) THEN
            clkok <= clkok_reg1;
         END IF; 
      END IF;
   END PROCESS;

   lock <= lock1 and d4_lock;
END V;


--
----- cell ehxplle1 -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;


-- entity declaration --
ENTITY ehxplle1 IS
   GENERIC (
      FIN                : string  := "100.0";
      CLKI_DIV           : Integer   := 1;
      CLKFB_DIV          : Integer   := 1;
      CLKOP_DIV          : Integer   := 8;
      CLKOK_DIV          : Integer   := 2;
      PHASEADJ           : String    := "0.0";
      DUTY               : Integer   := 8;
      PHASE_CNTL         : String    := "STATIC";
      CLKOP_BYPASS       : String    := "DISABLED";
      CLKOS_BYPASS       : String    := "DISABLED";
      CLKOK_BYPASS       : String    := "DISABLED";
      CLKOP_TRIM_POL     : String    := "FALLING";
      CLKOP_TRIM_DELAY   : Integer   := 6;
      CLKOS_TRIM_POL     : String    := "RISING";
      CLKOS_TRIM_DELAY   : Integer   := 0;
      LOCK_DELAY         : Integer   := 100;
      TimingChecksOn     : Boolean   := TRUE;
      XOn                : Boolean   := FALSE;
      MsgOn              : Boolean   := TRUE;
      InstancePath       : String    := "ehxplle1";
      tipd_clki             : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rst              : VitalDelayType01 := (0 ns, 0 ns);
      tipd_pwd              : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rstk             : VitalDelayType01 := (0 ns, 0 ns);
      tipd_wrdel            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai3           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai2           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai1           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai0           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai3           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai2           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai1           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai0           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_clkfb            : VitalDelayType01 := (0 ns, 0 ns));

   PORT(
      clki                  : in std_logic;
      clkfb                 : in std_logic;
      rst                   : in std_logic;
      pwd                   : in std_logic;
      rstk                  : in std_logic;
      wrdel                 : in std_logic;
      drpai3                : in std_logic;
      drpai2                : in std_logic;
      drpai1                : in std_logic;
      drpai0                : in std_logic;
      dfpai3                : in std_logic;
      dfpai2                : in std_logic;
      dfpai1                : in std_logic;
      dfpai0                : in std_logic;
      clkos                 : out std_logic;
      clkop                 : out std_logic;
      clkok                 : out std_logic;
      clkok2                : out std_logic;
      lock                  : out std_logic;
      clkintfb              : out std_logic);

    ATTRIBUTE Vital_Level0 OF ehxplle1 : ENTITY IS TRUE;

END ehxplle1 ;

-- ARCHITECTURE body --
ARCHITECTURE V OF ehxplle1 IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clki_ipd          : std_logic := '0';
    SIGNAL clkfb_ipd         : std_logic := '0';
    SIGNAL rst_ipd           : std_logic := '0';
    SIGNAL rstb_ipd           : std_logic := '0';
    SIGNAL pwd_ipd           : std_logic := '0';
    SIGNAL rstk_ipd          : std_logic := '0';
    SIGNAL wrdel_ipd         : std_logic := '0';
    SIGNAL drpai_ipd         : std_logic_vector(3 downto 0) := "0000";
    SIGNAL dfpai_ipd         : std_logic_vector(3 downto 0) := "0000";
    SIGNAL false_clk          : std_logic := '0';
    SIGNAL ext_divider        : Real := 1.0 ;
    SIGNAL net_divide         : Real := 1.0 ;
    SIGNAL duty_i             : Integer := 0 ;
    SIGNAL phase_shift_value         : Integer := 0 ;
    SIGNAL phase_shift_value_static  : Integer := 0 ;
    SIGNAL pll_dly_value      : Time  := 0 ps;
    SIGNAL t_in_clk           : time := 0 ns;
    SIGNAL t_vco              : time := 0 ns;
    SIGNAL ha_vco1            : time := 0 ns;
    SIGNAL ha_vco             : time := 0 ns;
    SIGNAL duty_vco1          : time := 0 ns;
    SIGNAL duty_vco           : time := 0 ns;
    SIGNAL ha_vco_r1          : real := 0.0;
    SIGNAL round_err          : real := 0.0;
    SIGNAL t_in_clk1          : time := 0 ns;
    SIGNAL t_in_clk2          : time := 0 ns;
    SIGNAL t_in_clk3          : time := 0 ns;
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL clock_invalid      : std_logic := '0';
    SIGNAL out_clk_valid      : std_logic := '0';
    SIGNAL clkop_first_time   : std_logic := '1';
    SIGNAL total_fb_delay     : time := 0 ps;
    SIGNAL false_t1_int       : time := 5 ns;
    SIGNAL false_t_int        : time := 0 ns;
    SIGNAL ratio1             : Integer   := 0;
    SIGNAL t_fb_clk           : time := 0 ns;
    SIGNAL virtual_delay1     : time := 0 ps;
    SIGNAL real_delay1        : time := 0 ps;
    SIGNAL intfb_out          : std_logic := '0';
    SIGNAL lock_all           : std_logic := '0';
    SIGNAL first_time7        : std_logic := '1';
    SIGNAL real_delay2        : time := 0 ps;
	 SIGNAL phase_delay        : time := 0 ps;
    SIGNAL vir_pclk          : std_logic := '0';
    SIGNAL vir_intfb         : std_logic := '0';
    SIGNAL vir_lock           : std_logic := '0';
    SIGNAL vir_kclk           : std_logic := '0';
	 SIGNAL vir_k2clk          : std_logic := '0';
    SIGNAL vir_sclk           : std_logic := '0';
    SIGNAL final_sclk         : std_logic := '0';
    SIGNAL lock_delay_reg     : time := 1 ns;
    SIGNAL lock1              : std_logic := '0';
    SIGNAL d_lock             : std_logic := '1';
    SIGNAL d1_lock            : std_logic := '1';
    SIGNAL d2_lock            : std_logic := '1';
    SIGNAL d3_lock            : std_logic := '1';
    SIGNAL d4_lock            : std_logic := '1';
    SIGNAL dly_change         : std_logic := '0';
    SIGNAL phase_change       : std_logic := '0';
	 SIGNAL clkop_reg1         : std_logic := '0';
    SIGNAL clkok_reg1         : std_logic := '0';
    SIGNAL duty_set           : Integer := 0 ;
    SIGNAL phase_set          : Integer := 0 ;


BEGIN
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(rstb_ipd, rst, tipd_rst);
   VitalWireDelay(pwd_ipd, pwd, tipd_pwd);
   VitalWireDelay(rstk_ipd, rstk, tipd_rstk);
   VitalWireDelay(clki_ipd, clki, tipd_clki);
   VitalWireDelay(clkfb_ipd, clkfb, tipd_clkfb);
   VitalWireDelay(wrdel_ipd, wrdel, tipd_wrdel);
   VitalWireDelay(drpai_ipd(3), drpai3, tipd_drpai3);
   VitalWireDelay(drpai_ipd(2), drpai2, tipd_drpai2);
   VitalWireDelay(drpai_ipd(1), drpai1, tipd_drpai1);
   VitalWireDelay(drpai_ipd(0), drpai0, tipd_drpai0);
   VitalWireDelay(dfpai_ipd(3), dfpai3, tipd_dfpai3);
   VitalWireDelay(dfpai_ipd(2), dfpai2, tipd_dfpai2);
   VitalWireDelay(dfpai_ipd(1), dfpai1, tipd_dfpai1);
   VitalWireDelay(dfpai_ipd(0), dfpai0, tipd_dfpai0);
   END BLOCK;

--------------------------------------------------------------------
-- Generate False Clocks
--------------------------------------------------------------------

   false_clk <= not false_clk after 5 ns;
--------------------------------------------------------------------
   rst_ipd <= rstb_ipd or pwd_ipd;

   P1 : PROCESS (wrdel_ipd)
	BEGIN
	   IF (wrdel_ipd = '1') THEN
	      pll_dly_value <= 70 ps;
		ELSE
		   pll_dly_value <= 0 ps;
		END IF;
      dly_change <= not dly_change;
	END PROCESS;


   P151 : PROCESS (clki_ipd)
   BEGIN
      IF (PHASEADJ = "22.5") THEN
         phase_shift_value_static <= 1;
      ELSIF (PHASEADJ = "45.0") THEN
         phase_shift_value_static <= 2;
      ELSIF (PHASEADJ = "67.5") THEN
         phase_shift_value_static <= 3;
      ELSIF (PHASEADJ = "90.0") THEN
         phase_shift_value_static <= 4;
      ELSIF (PHASEADJ = "112.5") THEN
         phase_shift_value_static <= 5;
      ELSIF (PHASEADJ = "135.0") THEN
         phase_shift_value_static <= 6;
      ELSIF (PHASEADJ = "157.5") THEN
         phase_shift_value_static <= 7;
      ELSIF (PHASEADJ = "180.0") THEN
         phase_shift_value_static <= 8;
      ELSIF (PHASEADJ = "202.5") THEN
         phase_shift_value_static <= 9;
      ELSIF (PHASEADJ = "225.0") THEN
         phase_shift_value_static <= 10;
      ELSIF (PHASEADJ = "247.5") THEN
         phase_shift_value_static <= 11;
      ELSIF (PHASEADJ = "270.0") THEN
         phase_shift_value_static <= 12;
      ELSIF (PHASEADJ = "292.5") THEN
         phase_shift_value_static <= 13;
      ELSIF (PHASEADJ = "315.0") THEN
         phase_shift_value_static <= 14;
      ELSIF (PHASEADJ = "337.5") THEN
         phase_shift_value_static <= 15;
      ELSE 
         phase_shift_value_static <= 0;
      END IF;
   END PROCESS;

   duty_set <= conv_integer(dfpai_ipd);
   phase_set <= conv_integer(drpai_ipd);

   P152 : PROCESS (duty_set, phase_set, phase_shift_value_static)
   BEGIN
      IF (PHASE_CNTL = "DYNAMIC") THEN
         phase_shift_value <= phase_set;
         IF (duty_set > phase_set) THEN
            duty_i <= (duty_set - phase_set);
         ELSIF (duty_set < phase_set) THEN
            duty_i <= 16 + duty_set - phase_set;
         ELSE
            duty_i <= 8;
         END IF;
         phase_change <= not phase_change;
      ELSE
         phase_shift_value <= phase_shift_value_static;
         duty_i <= DUTY;
      END IF;
   END PROCESS;



   P51 : PROCESS (clki_ipd, dly_change, phase_change, rst_ipd)
   BEGIN
      IF (dly_change'event or phase_change'event or (rst_ipd = '1')) THEN
         d_lock <= '0';
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         IF (d_lock = '0') THEN
            d_lock <= '1';
         END IF;
      END IF;
   END PROCESS;

   P52 : PROCESS (clki_ipd)
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
         d1_lock <= d_lock;
      END IF;
   END PROCESS;

   P53 : PROCESS (clki_ipd)
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
         d3_lock <= d1_lock;
      END IF;
   END PROCESS;

   d2_lock <= d_lock and d1_lock;
   d4_lock <= d_lock and d1_lock and d3_lock;

   CLKIN_PERIOD : PROCESS (clki_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF ((t_in_clk = t_in_clk1) and (t_in_clk = t_in_clk2) and (t_in_clk = t_in_clk3)) THEN
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

------------------------------------------------
-- measure the feedback delay value
------------------------------------------------
   P100 : PROCESS (clkfb_ipd)
   VARIABLE fb_count : Integer := 0;
   BEGIN
      IF (clkfb_ipd'event and clkfb_ipd = '1') THEN
         fb_count := fb_count + 1;
         IF (fb_count = 3) THEN
            clkop_first_time <= '0';
         END IF;
      END IF;
   END PROCESS;

   GENERATE_FIRST_FB_EDGE : PROCESS (false_clk, clkfb_ipd)
   VARIABLE false_clk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_int_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   BEGIN
      if (false_clk'event and false_clk'last_value = '0' and false_clk = '1') then
         if (false_clk_first_time) then
            first_int_edge := NOW;
            false_clk_first_time := false;
         end if;
      end if;
      if (clkfb_ipd'event and clkfb_ipd'last_value = '0' and clkfb_ipd = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;
         total_fb_delay <= first_fb_edge - first_int_edge ;
   END PROCESS;

   FB_PERIOD : PROCESS (clkfb_ipd)
   VARIABLE last_clock_edge : time := 0 ps;
   VARIABLE next_clock_edge : time := 0 ps;
   VARIABLE first_time      : Boolean := true;
   BEGIN
      IF (clkfb_ipd'event and clkfb_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
             IF (first_time) THEN
                t_fb_clk <= next_clock_edge - last_clock_edge;
                first_time := false;
             END IF;
           END IF;
      END IF;
   END PROCESS;

   false_t_int <= 2 * false_t1_int;

   INT_FB : PROCESS (t_fb_clk)
   BEGIN
      IF (t_fb_clk > 0 ps) THEN
         ext_divider <= (real(time'pos(t_fb_clk)) / real(time'pos(false_t_int)) );
      END IF;
   END PROCESS;

   DELAY1 : PROCESS (total_fb_delay, t_in_clk, ratio1, virtual_delay1, clki_ipd)
   BEGIN
      IF ((total_fb_delay > 0 ps) and (t_in_clk > 0 ps)) THEN
          ratio1 <= total_fb_delay / t_in_clk;
          virtual_delay1 <= total_fb_delay - (t_in_clk * ratio1);
          real_delay1 <= t_in_clk - virtual_delay1 ;
      END IF;
   END PROCESS;

   net_divide <= (real(CLKFB_DIV) * ext_divider);

   P6 : PROCESS (t_in_clk, net_divide)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_vco <= ((t_in_clk * CLKI_DIV) / net_divide);  -- vco oscillating cycle
         ha_vco_r1 <= ((real(time'pos(t_in_clk)) * real(CLKI_DIV)) / net_divide) / 2.0;
      END IF;
   END PROCESS;

   ha_vco1 <= (t_vco / 2.0);  -- vco oscillating half-cycle
   duty_vco1 <= ((t_vco * duty_i) / 16);  -- duty_cycle

   P106 : PROCESS (ha_vco1)
   BEGIN
      IF (ha_vco1 > 0 ps) THEN
         round_err <= (real(time'pos(t_in_clk)) - ((real(time'pos(ha_vco1)) * 2.0 * net_divide) / real(CLKI_DIV))) / 2.0;
      END IF;
   END PROCESS;

   process (ha_vco1)
	begin
		IF (PHASE_CNTL = "STATIC") THEN
		   ha_vco <= ha_vco1;
		ELSE
			IF (CLKOP_TRIM_POL = "RISING") THEN
				ha_vco <= ha_vco1 - (50 ps * CLKOP_TRIM_DELAY);
			ELSE
				ha_vco <= ha_vco1 + (50 ps * CLKOP_TRIM_DELAY);
			END IF;
		END IF;
	end process;

   process (duty_vco1)
	begin
		IF (PHASE_CNTL = "STATIC") THEN
		   duty_vco <= duty_vco1;
		ELSE
			IF (CLKOS_TRIM_POL = "RISING") THEN
				duty_vco <= duty_vco1 - (50 ps * CLKOS_TRIM_DELAY);
			ELSE
				duty_vco <= duty_vco1 + (50 ps * CLKOS_TRIM_DELAY);
			END IF;
		END IF;
	end process;

   P101 : PROCESS (duty_vco)
   BEGIN
	  IF clock_valid = '1' THEN
      IF (duty_vco < 1 ns) THEN
         assert FALSE
         report "Pulse width of CLKOS is less than 1 ns, which is illegal!"
         severity WARNING;
      ELSIF ((t_vco - duty_vco) < 1 ns) THEN
         assert FALSE
         report "Pulse width of CLKOS is less than 1 ns, which is illegal!"
         severity WARNING;
      END IF;
	  END IF;
   END PROCESS;

   P7 : PROCESS (clki_ipd, rst_ipd, d_lock)
   BEGIN
      IF ((rst_ipd = '1') or (d_lock = '0')) THEN
         out_clk_valid <= '0';
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         out_clk_valid <= clock_valid;
      END IF;
   END PROCESS;

   P8 : PROCESS (out_clk_valid, intfb_out)
      VARIABLE index : real := 0.0;
   BEGIN
      IF (out_clk_valid  = '0') THEN
         intfb_out <= '0';
         first_time7 <= '1';
         index := 0.0;
      ELSE
         IF (first_time7 = '1') THEN
            intfb_out <= '1';
            first_time7 <= '0';
            index := 0.0;
         ELSE
            index := index + 1.0;
            IF (index = net_divide) THEN
--               intfb_out <= not intfb_out after time'val(integer(ha_vco_r1 + round_err));
               intfb_out <= not intfb_out after (ha_vco1 + time'val(integer(round_err)));
               index := 0.0;
            ELSE
               intfb_out <= not intfb_out after ha_vco1;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   phase_delay <= ((t_vco * phase_shift_value) / 16);
   real_delay2 <= phase_delay + pll_dly_value;

   PROCESS (intfb_out, d2_lock)
   BEGIN
	  IF (d2_lock = '0') THEN
	     vir_intfb <= '0';
	  ELSE
        vir_intfb <= transport intfb_out after real_delay1;
	  END IF;
	END PROCESS;

   P9 : PROCESS (vir_intfb, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         vir_pclk <= '0';
      ELSE
         IF (vir_intfb'event and vir_intfb = '1') THEN
            vir_pclk <= '1', '0' after ha_vco;
         END IF;
      END IF;
   END PROCESS;

   P108 : PROCESS (intfb_out)
   BEGIN
      IF (out_clk_valid  = '0') THEN
         vir_lock <= '0';
      ELSE
         vir_lock <= '1';
      END IF;
   END PROCESS;

   P91 : PROCESS (vir_pclk, d2_lock)
   VARIABLE index1 : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (d2_lock = '0') THEN
         vir_kclk <= '0';
         first_time := true;
      ELSE
         IF (vir_pclk'event) THEN
            IF (first_time) THEN
               IF (vir_pclk = '1') THEN
                  vir_kclk <= '1';
                  IF (out_clk_valid = '0') THEN
                     first_time := true;
                  ELSE
                     first_time := false;
                  END IF;
                  index1 := 0;
               END IF;
            ELSE
               index1 := index1 + 1;
               IF (index1 = CLKOK_DIV) THEN
                  vir_kclk <= NOT vir_kclk;
                  index1 := 0;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

-------------------------------------------------------
-- Generate LOCK signal
-------------------------------------------------------
   LOCK_IT : PROCESS (rst_ipd, vir_lock, out_clk_valid, clock_invalid)
   BEGIN
      IF (rst_ipd = '1') THEN
         lock_all <= '0';
      ELSE
        IF clock_invalid = '1' THEN
           lock_all <= '0';
        ELSIF out_clk_valid = '1' THEN
           lock_all <= transport vir_lock after (LOCK_DELAY * lock_delay_reg);
        END IF;
      END IF;
   END PROCESS;

   P10 : PROCESS (vir_intfb, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         vir_sclk <= '0';
      ELSE
         IF (vir_intfb'event and vir_intfb = '1') THEN
            vir_sclk <= '1', '0' after duty_vco;
         END IF;
      END IF;
   END PROCESS;

   P54 : PROCESS (vir_sclk, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         final_sclk <= '0';
      ELSE
         final_sclk <= transport vir_sclk after real_delay2;
      END IF;
   END PROCESS;


   -- CLKOK2 = CLKOP / 3

   PROCESS (clkop_reg1, d2_lock)
      VARIABLE index2 : Integer := 0;
      VARIABLE first_time : boolean := true;
   BEGIN
      IF (d2_lock = '0') THEN
         vir_k2clk <= '0';
         first_time := true;
      ELSE
         IF (clkop_reg1'event) THEN
            IF (first_time) THEN
               IF (clkop_reg1 = '1') THEN
                  vir_k2clk <= '1';
                  IF (out_clk_valid = '0') THEN
                     first_time := true;
                  ELSE
                     first_time := false;
                  END IF;
                  index2 := 0;
               END IF;
            ELSE
               index2 := index2 + 1;
               IF (index2 = 3) THEN
                  vir_k2clk <= NOT vir_k2clk;
                  index2 := 0;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

	clkop <= clkop_reg1;

   P12 : PROCESS (clki_ipd, out_clk_valid, vir_pclk, vir_intfb, lock_all, vir_kclk, vir_k2clk,
                  final_sclk, false_clk, rst_ipd, clkop_first_time)
   BEGIN
      IF (CLKOP_BYPASS = "ENABLED") THEN
         clkop_reg1 <= clki_ipd;
      ELSIF (clkop_first_time = '1') THEN
         clkop_reg1 <= false_clk;
      ELSIF (rst_ipd = '1') THEN
         clkop_reg1 <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkop_reg1 <= vir_pclk;
      END IF;

      IF (rst_ipd = '1') THEN
         clkok2 <= '0';
      ELSE
         clkok2 <= vir_k2clk;
      END IF;

      IF (CLKOS_BYPASS = "ENABLED") THEN
         clkos <= clki_ipd;
      ELSIF (clkop_first_time = '1') THEN
         clkos <= false_clk;
      ELSIF (rst_ipd = '1') THEN
         clkos <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkos <= final_sclk;
      END IF;

      IF (CLKOK_BYPASS = "ENABLED") THEN
         clkok_reg1 <= clki_ipd;
      ELSIF (clkop_first_time = '1') THEN
         clkok_reg1 <= false_clk;
      ELSIF (rst_ipd = '1') THEN
         clkok_reg1 <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkok_reg1 <= vir_kclk;
      END IF;

      IF (clkop_first_time = '1') THEN
         clkintfb <= false_clk;
         lock1 <= '0';
      ELSIF (rst_ipd = '1') THEN
         clkintfb <= '0';
         lock1 <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkintfb <= vir_intfb;
         lock1 <= lock_all;
      END IF;
   END PROCESS;

   P15 : PROCESS (clkok_reg1, rstk_ipd)
   BEGIN
      IF (CLKOK_BYPASS = "ENABLED") THEN
         clkok <= clkok_reg1;
      ELSE 
         IF (clkop_first_time = '1') THEN
            clkok <= clkok_reg1;
         ELSIF (rstk_ipd = '1') THEN
            clkok <= '0';
         ELSIF (clkok_reg1'event) THEN
            clkok <= clkok_reg1;
         END IF; 
      END IF;
   END PROCESS;

   lock <= lock1 and d4_lock;
END V;


--
----- cell eplld1 -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;


-- entity declaration --
ENTITY eplld1 IS
   GENERIC (
      FIN                : string  := "100.0";
      CLKI_DIV           : Integer   := 1;
      CLKFB_DIV          : Integer   := 1;
      CLKOP_DIV          : Integer   := 8;
      CLKOK_DIV          : Integer   := 2;
      PHASEADJ           : String    := "0.0";
      DUTY               : Integer   := 8;
      PLLCAP             : String    := "DISABLED";
      PHASE_CNTL         : String    := "STATIC";
      CLKOP_BYPASS       : String    := "DISABLED";
      CLKOS_BYPASS       : String    := "DISABLED";
      CLKOK_BYPASS       : String    := "DISABLED";
      PLLTYPE            : String    := "AUTO";
      LOCK_DELAY         : Integer   := 100;
--      LOCK_CYC           : Integer   := 2;
      TimingChecksOn     : Boolean   := TRUE;
      XOn                : Boolean   := FALSE;
      MsgOn              : Boolean   := TRUE;
      InstancePath       : String    := "eplld1";
      tipd_clki             : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rst              : VitalDelayType01 := (0 ns, 0 ns);
      tipd_pwd              : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rstk             : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dpamode          : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai3           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai2           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai1           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_drpai0           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai3           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai2           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai1           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_dfpai0           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_clkfb            : VitalDelayType01 := (0 ns, 0 ns));

   PORT(
      clki                  : in std_logic;
      clkfb                 : in std_logic;
      rst                   : in std_logic;
      pwd                   : in std_logic;
      rstk                  : in std_logic;
      dpamode               : in std_logic;
      drpai3                : in std_logic;
      drpai2                : in std_logic;
      drpai1                : in std_logic;
      drpai0                : in std_logic;
      dfpai3                : in std_logic;
      dfpai2                : in std_logic;
      dfpai1                : in std_logic;
      dfpai0                : in std_logic;
      clkos                 : out std_logic;
      clkop                 : out std_logic;
      clkok                 : out std_logic;
      lock                  : out std_logic;
      clkintfb              : out std_logic);

    ATTRIBUTE Vital_Level0 OF eplld1 : ENTITY IS TRUE;

END eplld1 ;

-- ARCHITECTURE body --
ARCHITECTURE V OF eplld1 IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL clki_ipd          : std_logic := '0';
    SIGNAL clkfb_ipd         : std_logic := '0';
    SIGNAL rst_ipd           : std_logic := '0';
    SIGNAL rstb_ipd           : std_logic := '0';
    SIGNAL pwd_ipd           : std_logic := '0';
    SIGNAL rstk_ipd           : std_logic := '0';
    SIGNAL dpamode_ipd           : std_logic := '0';
    SIGNAL drpai_ipd           : std_logic_vector(3 downto 0) := "0000";
    SIGNAL dfpai_ipd           : std_logic_vector(3 downto 0) := "0000";
    SIGNAL false_clk          : std_logic := '0';
    SIGNAL ext_divider        : Real := 1.0 ;
    SIGNAL net_divide         : Real := 1.0 ;
    SIGNAL pll_dly_step         : Integer := 0 ;
    SIGNAL duty_i               : Integer := 0 ;
    SIGNAL phase_shift_value               : Integer := 0 ;
    SIGNAL phase_shift_value_static               : Integer := 0 ;
    SIGNAL t_in_clk           : time := 0 ns;
    SIGNAL t_vco              : time := 0 ns;
    SIGNAL ha_vco              : time := 0 ns;
    SIGNAL duty_vco              : time := 0 ns;
    SIGNAL ha_vco_r           : real := 0.0;
    SIGNAL round_err          : real := 0.0;
    SIGNAL t_in_clk1          : time := 0 ns;
    SIGNAL t_in_clk2          : time := 0 ns;
    SIGNAL t_in_clk3          : time := 0 ns;
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL clock_invalid      : std_logic := '0';
    SIGNAL out_clk_valid      : std_logic := '0';
    SIGNAL clkop_first_time   : std_logic := '1';
    SIGNAL total_fb_delay     : time := 0 ps;
    SIGNAL false_t1_int       : time := 5 ns;
    SIGNAL false_t_int        : time := 0 ns;
    SIGNAL ratio1             : Integer   := 0;
    SIGNAL t_fb_clk           : time := 0 ns;
    SIGNAL virtual_delay1     : time := 0 ps;
    SIGNAL real_delay1        : time := 0 ps;
    SIGNAL intfb_out          : std_logic := '0';
    SIGNAL lock_all           : std_logic := '0';
    SIGNAL first_time7        : std_logic := '1';
    SIGNAL real_delay2        : time := 0 ps;
    SIGNAL real_delay         : time := 0 ps;
    SIGNAL vir_intfb          : std_logic := '0';
    SIGNAL vir_intfb1          : std_logic := '0';
    SIGNAL vir_lock           : std_logic := '0';
    SIGNAL vir_kclk           : std_logic := '0';
    SIGNAL vir_sclk           : std_logic := '0';
    SIGNAL final_sclk           : std_logic := '0';
    SIGNAL lock_delay_reg     : time := 1 ns;
    SIGNAL lock1              : std_logic := '0';
    SIGNAL d_lock             : std_logic := '1';
    SIGNAL d1_lock            : std_logic := '1';
    SIGNAL d2_lock            : std_logic := '1';
    SIGNAL d3_lock            : std_logic := '1';
    SIGNAL d4_lock            : std_logic := '1';
    SIGNAL phase_change         : std_logic := '0';
    SIGNAL clkok_reg1         : std_logic := '0';
    SIGNAL duty_set           : Integer := 0 ;
    SIGNAL phase_set          : Integer := 0 ;
    SIGNAL next_clkin_dly     : std_logic := '0';
    SIGNAL new1_clkin_dly     : std_logic := '0';
    SIGNAL new2_clkin_dly     : std_logic := '0';
    SIGNAL new_lock           : std_logic := '0';
    SIGNAL new_lock1          : std_logic := '0';
    SIGNAL new_lock2          : std_logic := '0';
    SIGNAL lock2_count        : Integer := 0;
    SIGNAL lock_all2          : std_logic := '0';
    SIGNAL rstkb1             : std_logic := '0';
    SIGNAL rstkb_rel          : std_logic := '0';


BEGIN
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(rstb_ipd, rst, tipd_rst);
   VitalWireDelay(pwd_ipd, pwd, tipd_pwd);
   VitalWireDelay(rstk_ipd, rstk, tipd_rstk);
   VitalWireDelay(clki_ipd, clki, tipd_clki);
   VitalWireDelay(clkfb_ipd, clkfb, tipd_clkfb);
   VitalWireDelay(dpamode_ipd, dpamode, tipd_dpamode);
   VitalWireDelay(drpai_ipd(3), drpai3, tipd_drpai3);
   VitalWireDelay(drpai_ipd(2), drpai2, tipd_drpai2);
   VitalWireDelay(drpai_ipd(1), drpai1, tipd_drpai1);
   VitalWireDelay(drpai_ipd(0), drpai0, tipd_drpai0);
   VitalWireDelay(dfpai_ipd(3), dfpai3, tipd_dfpai3);
   VitalWireDelay(dfpai_ipd(2), dfpai2, tipd_dfpai2);
   VitalWireDelay(dfpai_ipd(1), dfpai1, tipd_dfpai1);
   VitalWireDelay(dfpai_ipd(0), dfpai0, tipd_dfpai0);
   END BLOCK;

--------------------------------------------------------------------
-- Generate False Clocks
--------------------------------------------------------------------

   false_clk <= not false_clk after 5 ns;
--------------------------------------------------------------------
   rst_ipd <= rstb_ipd or pwd_ipd;

   P151 : PROCESS (clki_ipd)
   BEGIN
      IF (PHASEADJ = "22.5") THEN
         phase_shift_value_static <= 1;
      ELSIF (PHASEADJ = "45.0") THEN
         phase_shift_value_static <= 2;
      ELSIF (PHASEADJ = "67.5") THEN
         phase_shift_value_static <= 3;
      ELSIF (PHASEADJ = "90.0") THEN
         phase_shift_value_static <= 4;
      ELSIF (PHASEADJ = "112.5") THEN
         phase_shift_value_static <= 5;
      ELSIF (PHASEADJ = "135.0") THEN
         phase_shift_value_static <= 6;
      ELSIF (PHASEADJ = "157.5") THEN
         phase_shift_value_static <= 7;
      ELSIF (PHASEADJ = "180.0") THEN
         phase_shift_value_static <= 8;
      ELSIF (PHASEADJ = "202.5") THEN
         phase_shift_value_static <= 9;
      ELSIF (PHASEADJ = "225.0") THEN
         phase_shift_value_static <= 10;
      ELSIF (PHASEADJ = "247.5") THEN
         phase_shift_value_static <= 11;
      ELSIF (PHASEADJ = "270.0") THEN
         phase_shift_value_static <= 12;
      ELSIF (PHASEADJ = "292.5") THEN
         phase_shift_value_static <= 13;
      ELSIF (PHASEADJ = "315.0") THEN
         phase_shift_value_static <= 14;
      ELSIF (PHASEADJ = "337.5") THEN
         phase_shift_value_static <= 15;
      ELSE 
         phase_shift_value_static <= 0;
      END IF;
   END PROCESS;

   duty_set <= conv_integer(dfpai_ipd);
   phase_set <= conv_integer(drpai_ipd);

   P152 : PROCESS (dpamode_ipd, duty_set, phase_set, phase_shift_value_static)
   BEGIN
      IF (PHASE_CNTL = "DYNAMIC") THEN
         IF (dpamode_ipd = '1') THEN
            phase_shift_value <= phase_set;
            IF (duty_set > phase_set) THEN
               duty_i <= (duty_set - phase_set);
            ELSIF (duty_set < phase_set) THEN
               duty_i <= 16 + duty_set - phase_set;
            ELSE
               duty_i <= 8;
            END IF;
            phase_change <= not phase_change;
         ELSE
            phase_shift_value <= phase_shift_value_static;
            duty_i <= DUTY;
         END IF;
      ELSE
         phase_shift_value <= phase_shift_value_static;
         duty_i <= DUTY;
      END IF;
   END PROCESS;



   P51 : PROCESS (clki_ipd, rst_ipd)
   BEGIN
      IF (rst_ipd = '1') THEN
         d_lock <= '0';
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         IF (d_lock = '0') THEN
            d_lock <= '1';
         END IF;
      END IF;
   END PROCESS;

   P52 : PROCESS (clki_ipd)
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
         d1_lock <= d_lock;
      END IF;
   END PROCESS;

   P53 : PROCESS (clki_ipd)
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
         d3_lock <= d1_lock;
      END IF;
   END PROCESS;

   d2_lock <= d_lock and d1_lock;
   d4_lock <= d_lock and d1_lock and d3_lock;

   next_clkin_dly <= transport (not clki_ipd) after (t_in_clk);
   new1_clkin_dly <= clki_ipd;
   new2_clkin_dly <= new1_clkin_dly;

   P71 : PROCESS (next_clkin_dly)
   BEGIN
      new_lock <= not(next_clkin_dly xor new2_clkin_dly);
   END PROCESS;

   new_lock1 <= transport new_lock after (t_in_clk3);
   new_lock2 <= new_lock and new_lock1;

   CLKIN_PERIOD : PROCESS (clki_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
             IF ((t_in_clk = t_in_clk1) and (t_in_clk = t_in_clk2) and (t_in_clk = t_in_clk3)) THEN
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

------------------------------------------------
-- measure the feedback delay value
------------------------------------------------
   P100 : PROCESS (clkfb_ipd)
   VARIABLE fb_count : Integer := 0;
   BEGIN
      IF (clkfb_ipd'event and clkfb_ipd = '1') THEN
         fb_count := fb_count + 1;
         IF (fb_count = 3) THEN
            clkop_first_time <= '0';
         END IF;
      END IF;
   END PROCESS;

   GENERATE_FIRST_FB_EDGE : PROCESS (false_clk, clkfb_ipd)
   VARIABLE false_clk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_int_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   BEGIN
      if (false_clk'event and false_clk'last_value = '0' and false_clk = '1') then
         if (false_clk_first_time) then
            first_int_edge := NOW;
            false_clk_first_time := false;
         end if;
      end if;
      if (clkfb_ipd'event and clkfb_ipd'last_value = '0' and clkfb_ipd = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;
         total_fb_delay <= first_fb_edge - first_int_edge ;
   END PROCESS;

   FB_PERIOD : PROCESS (clkfb_ipd)
   VARIABLE last_clock_edge : time := 0 ps;
   VARIABLE next_clock_edge : time := 0 ps;
   VARIABLE first_time      : Boolean := true;
   BEGIN
      IF (clkfb_ipd'event and clkfb_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
             IF (first_time) THEN
                t_fb_clk <= next_clock_edge - last_clock_edge;
                first_time := false;
             END IF;
           END IF;
      END IF;
   END PROCESS;

   false_t_int <= 2 * false_t1_int;

   INT_FB : PROCESS (t_fb_clk)
   BEGIN
      IF (t_fb_clk > 0 ps) THEN
         ext_divider <= (real(time'pos(t_fb_clk)) / real(time'pos(false_t_int)) );
      END IF;
   END PROCESS;

   DELAY1 : PROCESS (total_fb_delay, t_in_clk, ratio1, virtual_delay1, clki_ipd)
   BEGIN
      IF ((total_fb_delay > 0 ps) and (t_in_clk > 0 ps)) THEN
          ratio1 <= total_fb_delay / t_in_clk;
          virtual_delay1 <= total_fb_delay - (t_in_clk * ratio1);
          real_delay1 <= t_in_clk - virtual_delay1 ;
      END IF;
   END PROCESS;

   net_divide <= (real(CLKFB_DIV) * ext_divider);

   P6 : PROCESS (t_in_clk, net_divide)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_vco <= ((t_in_clk * CLKI_DIV) / net_divide);  -- vco oscillating cycle
         ha_vco_r <= ((real(time'pos(t_in_clk)) * real(CLKI_DIV)) / net_divide) / 2.0;
      END IF;
   END PROCESS;

   ha_vco <= (t_vco / 2.0);  -- vco oscillating half-cycle
   duty_vco <= ((t_vco * duty_i) / 16);  -- duty_cycle

   P106 : PROCESS (ha_vco)
   BEGIN
      IF (ha_vco > 0 ps) THEN
         round_err <= (real(time'pos(t_in_clk)) - ((real(time'pos(ha_vco)) * 2.0 * net_divide) / real(CLKI_DIV))) / 2.0;
      END IF;
   END PROCESS;

   P101 : PROCESS (duty_vco)
   BEGIN
	  IF clock_valid = '1' THEN
      IF (duty_vco < 1 ns) THEN
         assert FALSE
         report "Pulse width of CLKOS is less than 1 ns, which is illegal!"
         severity WARNING;
      ELSIF ((t_vco - duty_vco) < 1 ns) THEN
         assert FALSE
         report "Pulse width of CLKOS is less than 1 ns, which is illegal!"
         severity WARNING;
      END IF;
	  END IF;
   END PROCESS;

   P7 : PROCESS (clki_ipd, rst_ipd, d_lock)
   BEGIN
      IF ((rst_ipd = '1') or (d_lock = '0')) THEN
         out_clk_valid <= '0';
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         out_clk_valid <= clock_valid;
      END IF;
   END PROCESS;

   P8 : PROCESS (out_clk_valid, intfb_out)
      VARIABLE index : real := 0.0;
   BEGIN
      IF (out_clk_valid  = '0') THEN
         intfb_out <= '0';
         first_time7 <= '1';
         index := 0.0;
      ELSE
         IF (first_time7 = '1') THEN
            intfb_out <= '1';
            first_time7 <= '0';
            index := 0.0;
         ELSE
            index := index + 1.0;
            IF (index = net_divide) THEN
--               intfb_out <= not intfb_out after time'val(integer(ha_vco_r + round_err));
               intfb_out <= not intfb_out after (ha_vco + time'val(integer(round_err)));
               index := 0.0;
            ELSE
               intfb_out <= not intfb_out after ha_vco;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   real_delay2 <= ((t_vco * phase_shift_value) / 16);

   real_delay <= (real_delay1 + real_delay2);

   vir_intfb1 <= transport intfb_out after real_delay1;

   P9 : PROCESS (vir_intfb1, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         vir_intfb <= '0';
      ELSE
         vir_intfb <= vir_intfb1;
      END IF;
   END PROCESS;

   P108 : PROCESS (intfb_out)
   BEGIN
      IF (out_clk_valid  = '0') THEN
         vir_lock <= '0';
      ELSE
         vir_lock <= '1';
      END IF;
   END PROCESS;

   P110 : PROCESS (vir_intfb, rstk_ipd)
   BEGIN
      IF (rstk_ipd = '1') THEN
         rstkb_rel <= rstk_ipd;
      ELSIF (vir_intfb'event and vir_intfb = '0') THEN
         rstkb_rel <= rstkb1;
      END IF;
   END PROCESS;

   P111 : PROCESS (vir_intfb)
   VARIABLE index_k : Integer := 0;
   BEGIN
      IF (vir_intfb'event and vir_intfb = '1') THEN
         IF (rstk_ipd = '1') THEN
            rstkb1 <= rstk_ipd;
            index_k := 0;
         ELSE
            index_k := index_k + 1;
            IF (index_k = CLKOK_DIV/2) THEN
               rstkb1 <= rstk_ipd;
               index_k := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   P91 : PROCESS (vir_intfb, d2_lock, rstkb_rel)
   VARIABLE index1 : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (d2_lock = '0') THEN
         vir_kclk <= '0';
         first_time := true;
      ELSE
         IF (first_time and rstkb_rel = '0') THEN
            IF (vir_intfb'event and vir_intfb = '1') THEN
               vir_kclk <= '1';
               IF (out_clk_valid = '0') THEN
                  first_time := true;
               ELSE
                  first_time := false;
               END IF;
               index1 := 0;
            END IF;
         ELSIF (rstkb_rel = '1') THEN
            vir_kclk <= '0';
            index1 := 0;
            first_time := true;
         ELSIF (vir_intfb'event and vir_intfb = '1') THEN
            index1 := index1 + 1;
            IF (index1 = CLKOK_DIV/2) THEN
               vir_kclk <= NOT vir_kclk;
               index1 := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

-------------------------------------------------------
-- Generate LOCK signal
-------------------------------------------------------
   LOCK_IT : PROCESS (rst_ipd, vir_lock, out_clk_valid, clock_invalid)
   BEGIN
      IF (rst_ipd = '1') THEN
         lock_all <= '0';
      ELSE
        IF clock_invalid = '1' THEN
           lock_all <= '0';
        ELSIF out_clk_valid = '1' THEN
           lock_all <= transport vir_lock after (LOCK_DELAY * lock_delay_reg);
        END IF;
      END IF;
   END PROCESS;

   P81 : PROCESS (new_lock2)
   BEGIN
      IF (new_lock2'event and new_lock2 = '1') THEN
         lock2_count <= lock2_count + 1;
      END IF;
   END PROCESS;

   P72 : PROCESS (lock_all, new_lock2)
   BEGIN
      IF (new_lock2 = '1') THEN
         lock_all2 <= lock_all and new_lock2;
      ELSIF (new_lock2 = '0') THEN
         IF (lock2_count >= 1) THEN
            lock_all2 <= 'X';
         END IF;
      END IF;
   END PROCESS;

   P10 : PROCESS (vir_intfb, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         vir_sclk <= '0';
      ELSIF (vir_intfb'event and vir_intfb = '1') THEN
         vir_sclk <= '1', '0' after duty_vco;
      END IF;
   END PROCESS;

   P54 : PROCESS (vir_sclk, d2_lock)
   BEGIN
      IF (d2_lock = '0') THEN
         final_sclk <= '0';
      ELSE
         final_sclk <= transport vir_sclk after real_delay2;
      END IF;
   END PROCESS;

   P12 : PROCESS (clki_ipd, out_clk_valid, vir_intfb, lock_all2, vir_kclk, final_sclk, false_clk, rst_ipd, clkop_first_time, new_lock2)
   BEGIN
      IF (CLKOP_BYPASS = "ENABLED") THEN
         clkop <= clki_ipd;
      ELSIF (clkop_first_time = '1') THEN
         clkop <= false_clk;
      ELSIF (rst_ipd = '1') THEN
         clkop <= '0';
      ELSIF (new_lock2 = '0') THEN
         clkop <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkop <= vir_intfb;
      END IF;
 
      IF (CLKOS_BYPASS = "ENABLED") THEN
         clkos <= clki_ipd;
      ELSIF (clkop_first_time = '1') THEN
         clkos <= false_clk;
      ELSIF (rst_ipd = '1') THEN
         clkos <= '0';
      ELSIF (new_lock2 = '0') THEN
         clkos <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkos <= final_sclk;
      END IF;

      IF (CLKOK_BYPASS = "ENABLED") THEN
         clkok_reg1 <= clki_ipd;
      ELSIF (clkop_first_time = '1') THEN
         clkok_reg1 <= false_clk;
      ELSIF (rst_ipd = '1') THEN
         clkok_reg1 <= '0';
      ELSIF (new_lock2 = '0') THEN
         clkok_reg1 <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkok_reg1 <= vir_kclk;
      END IF;

      IF (clkop_first_time = '1') THEN
         clkintfb <= false_clk;
         lock1 <= '0';
      ELSIF (rst_ipd = '1') THEN
         clkintfb <= '0';
         lock1 <= '0';
      ELSIF (new_lock2 = '0') THEN
         clkintfb <= '0';
         lock1 <= lock_all2;
      ELSIF (out_clk_valid = '1') THEN
         clkintfb <= vir_intfb;
         lock1 <= lock_all2;
      END IF;
   END PROCESS;

   P15 : PROCESS (clkok_reg1, rstk_ipd)
   BEGIN
      IF (CLKOK_BYPASS = "ENABLED") THEN
         clkok <= clkok_reg1;
      ELSE 
         IF (clkop_first_time = '1') THEN
            clkok <= clkok_reg1;
         ELSIF (rstk_ipd = '1') THEN
            clkok <= '0';
         ELSIF (clkok_reg1'event) THEN
            clkok <= clkok_reg1;
         END IF; 
      END IF;
   END PROCESS;

   lock <= lock1 and d4_lock;
END V;
