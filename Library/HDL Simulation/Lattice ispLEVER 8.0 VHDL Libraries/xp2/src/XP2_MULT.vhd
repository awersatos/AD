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

----- CELL MULT9X9B -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use work.components.all;
use work.global.gsrnet;
use work.global.purnet;

-- entity declaration --
entity MULT9X9B is
  generic(
	 REG_INPUTA_CLK       : string     := "NONE";
	 REG_INPUTA_CE        : string     := "CE0";
	 REG_INPUTA_RST       : string     := "RST0";
	 REG_INPUTB_CLK       : string     := "NONE";
	 REG_INPUTB_CE        : string     := "CE0";
	 REG_INPUTB_RST       : string     := "RST0";
	 REG_PIPELINE_CLK     : string     := "NONE";
	 REG_PIPELINE_CE      : string     := "CE0";
	 REG_PIPELINE_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDA_CLK   : string     := "NONE";
	 REG_SIGNEDA_CE    : string     := "CE0";
	 REG_SIGNEDA_RST   : string     := "RST0";
         REG_SIGNEDB_CLK   : string     := "NONE";
         REG_SIGNEDB_CE    : string     := "CE0";
         REG_SIGNEDB_RST   : string     := "RST0";
	 GSR                  : string     := "ENABLED");
  port (
        A0 : in STD_ULOGIC;
        A1 : in STD_ULOGIC;
        A2 : in STD_ULOGIC;
        A3 : in STD_ULOGIC;
        A4 : in STD_ULOGIC;
        A5 : in STD_ULOGIC;
        A6 : in STD_ULOGIC;
        A7 : in STD_ULOGIC;
        A8 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;

        B0 : in STD_ULOGIC;
        B1 : in STD_ULOGIC;
        B2 : in STD_ULOGIC;
        B3 : in STD_ULOGIC;
        B4 : in STD_ULOGIC;
        B5 : in STD_ULOGIC;
        B6 : in STD_ULOGIC;
        B7 : in STD_ULOGIC;
        B8 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        SOURCEA : in STD_ULOGIC;
        SOURCEB : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;

        P0 : out STD_ULOGIC;
        P1 : out STD_ULOGIC;
        P2 : out STD_ULOGIC;
        P3 : out STD_ULOGIC;
        P4 : out STD_ULOGIC;
        P5 : out STD_ULOGIC;
        P6 : out STD_ULOGIC;
        P7 : out STD_ULOGIC;
        P8 : out STD_ULOGIC;
        P9 : out STD_ULOGIC;
        P10 : out STD_ULOGIC;
        P11 : out STD_ULOGIC;
        P12 : out STD_ULOGIC;
        P13 : out STD_ULOGIC;
        P14 : out STD_ULOGIC;
        P15 : out STD_ULOGIC;
        P16 : out STD_ULOGIC;
        P17 : out STD_ULOGIC
       ); 

attribute VITAL_LEVEL0 of MULT9X9B : entity is TRUE;

end MULT9X9B;

--- Architecture 

library IEEE;
use IEEE.VITAL_Primitives.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
architecture V of MULT9X9B is

  attribute VITAL_LEVEL0 of V : architecture is TRUE;

  -- Local signals used to propagate input wire delay

  signal A_ipd, A_ipd1       : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SRIA_ipd, SRIA_ipd1 : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROA_reg  : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B_ipd, B_ipd1       : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SRIB_ipd, SRIB_ipd1 : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROB_reg  : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal P_ipd  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SIGNEDA_ipd, SIGNEDA_ipd1 : std_logic := 'X';
  signal SIGNEDB_ipd, SIGNEDB_ipd1 : std_logic := 'X';
  signal SOURCEA_ipd, SOURCEA_ipd1 : std_logic := 'X';
  signal SOURCEB_ipd, SOURCEB_ipd1 : std_logic := 'X';
  signal CE0_ipd : std_logic := 'X';
  signal CE1_ipd : std_logic := 'X';
  signal CE2_ipd : std_logic := 'X';
  signal CE3_ipd : std_logic := 'X';
  signal CLK0_ipd : std_logic := 'X';
  signal CLK1_ipd : std_logic := 'X';
  signal CLK2_ipd : std_logic := 'X';
  signal CLK3_ipd : std_logic := 'X';
  signal RST0_ipd : std_logic := 'X';
  signal RST1_ipd : std_logic := 'X';
  signal RST2_ipd : std_logic := 'X';
  signal RST3_ipd : std_logic := 'X';

  signal A_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal P_i      : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P_o      : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P_ps     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P_o1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";

  signal input_a_clk : std_logic := 'X';
  signal input_a_ce  : std_logic := 'X';
  signal input_a_rst  : std_logic := 'X';
  signal input_b_clk : std_logic := 'X';
  signal input_b_ce  : std_logic := 'X';
  signal input_b_rst  : std_logic := 'X';
  signal pipeline_clk : std_logic := 'X';
  signal pipeline_ce  : std_logic := 'X';
  signal pipeline_rst  : std_logic := 'X';
  signal output_clk : std_logic := 'X';
  signal output_ce  : std_logic := 'X';
  signal output_rst  : std_logic := 'X';
  signal signeda_clk : std_logic := 'X';
  signal signeda_ce  : std_logic := 'X';
  signal signeda_rst  : std_logic := 'X';
  signal signeda_reg  : std_logic := 'X';
  signal signeda_p1  : std_logic := 'X';
  signal signedb_clk : std_logic := 'X';
  signal signedb_ce  : std_logic := 'X';
  signal signedb_rst  : std_logic := 'X';
  signal signedb_reg  : std_logic := 'X';
  signal signedb_p1  : std_logic := 'X';

  signal SRN          : std_logic;
  signal input_a_rst_ogsr  : std_logic := 'X';
  signal input_b_rst_ogsr  : std_logic := 'X';
  signal pipeline_rst_ogsr  : std_logic := 'X';
  signal output_rst_ogsr  : std_logic := 'X';
  signal signeda_rst_ogsr  : std_logic := 'X';
  signal signedb_rst_ogsr  : std_logic := 'X';

begin 

    global_reset : process (purnet, gsrnet)
      begin
        if (GSR =  "DISABLED") then
           SRN <= purnet;
        else
           SRN <= purnet AND gsrnet;
        end if;
      end process;

    input_a_rst_ogsr <= input_a_rst or not SRN;
    input_b_rst_ogsr <= input_b_rst or not SRN;
    pipeline_rst_ogsr <= pipeline_rst or not SRN;
    output_rst_ogsr <= output_rst or not SRN;
    signeda_rst_ogsr <= signeda_rst or not SRN;
    signedb_rst_ogsr <= signedb_rst or not SRN;

    A_ipd1 <= (A8 & A7 & A6 & A5 & A4 & A3 & A2 & A1 & A0);
    B_ipd1 <= (B8 & B7 & B6 & B5 & B4 & B3 & B2 & B1 & B0);
    SRIA_ipd1 <= (SRIA8 & SRIA7 & SRIA6 & SRIA5 & SRIA4 & SRIA3 & SRIA2 & SRIA1 & SRIA0);
    SRIB_ipd1 <= (SRIB8 & SRIB7 & SRIB6 & SRIB5 & SRIB4 & SRIB3 & SRIB2 & SRIB1 & SRIB0);
    SIGNEDA_ipd1 <= SIGNEDA;
    SIGNEDB_ipd1 <= SIGNEDB;
    SOURCEA_ipd1 <= SOURCEA;
    SOURCEB_ipd1 <= SOURCEB;

    A_ipd <= A_ipd1;
    B_ipd <= B_ipd1;
    SRIA_ipd <= SRIA_ipd1;
    SRIB_ipd <= SRIB_ipd1;
    SIGNEDA_ipd <= SIGNEDA_ipd1;
    SIGNEDB_ipd <= SIGNEDB_ipd1;
    SOURCEA_ipd <= SOURCEA_ipd1;
    SOURCEB_ipd <= SOURCEB_ipd1;

    CE0_ipd <= CE0;
    CE1_ipd <= CE1;
    CE2_ipd <= CE2;
    CE3_ipd <= CE3;
    CLK0_ipd <= CLK0;
    CLK1_ipd <= CLK1;
    CLK2_ipd <= CLK2;
    CLK3_ipd <= CLK3;
    RST0_ipd <= RST0;
    RST1_ipd <= RST1;
    RST2_ipd <= RST2;
    RST3_ipd <= RST3;

    SROA0 <= SROA_reg(0);
    SROA1 <= SROA_reg(1);
    SROA2 <= SROA_reg(2);
    SROA3 <= SROA_reg(3);
    SROA4 <= SROA_reg(4);
    SROA5 <= SROA_reg(5);
    SROA6 <= SROA_reg(6);
    SROA7 <= SROA_reg(7);
    SROA8 <= SROA_reg(8);

    SROB0 <= SROB_reg(0);
    SROB1 <= SROB_reg(1);
    SROB2 <= SROB_reg(2);
    SROB3 <= SROB_reg(3);
    SROB4 <= SROB_reg(4);
    SROB5 <= SROB_reg(5);
    SROB6 <= SROB_reg(6);
    SROB7 <= SROB_reg(7);
    SROB8 <= SROB_reg(8);

    P0 <= P_ipd(0);
    P1 <= P_ipd(1);
    P2 <= P_ipd(2);
    P3 <= P_ipd(3);
    P4 <= P_ipd(4);
    P5 <= P_ipd(5);
    P6 <= P_ipd(6);
    P7 <= P_ipd(7);
    P8 <= P_ipd(8);
    P9 <= P_ipd(9);
    P10 <= P_ipd(10);
    P11 <= P_ipd(11);
    P12 <= P_ipd(12);
    P13 <= P_ipd(13);
    P14 <= P_ipd(14);
    P15 <= P_ipd(15);
    P16 <= P_ipd(16);
    P17 <= P_ipd(17);


  Input_A_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA_CLK = "CLK0") then
       input_a_clk <= CLK0_ipd;
     elsif (REG_INPUTA_CLK = "CLK1") then
       input_a_clk <= CLK1_ipd;
     elsif (REG_INPUTA_CLK = "CLK2") then
       input_a_clk <= CLK2_ipd;
     elsif (REG_INPUTA_CLK = "CLK3") then
       input_a_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA_CE = "CE0") then
       input_a_ce <= CE0_ipd;
     elsif (REG_INPUTA_CE = "CE1") then
       input_a_ce <= CE1_ipd;
     elsif (REG_INPUTA_CE = "CE2") then
       input_a_ce <= CE2_ipd;
     elsif (REG_INPUTA_CE = "CE3") then
       input_a_ce <= CE3_ipd;
     end if;
  end process;

  Input_A_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA_RST = "RST0") then
       input_a_rst <= RST0_ipd;
     elsif (REG_INPUTA_RST = "RST1") then
       input_a_rst <= RST1_ipd;
     elsif (REG_INPUTA_RST = "RST2") then
       input_a_rst <= RST2_ipd;
     elsif (REG_INPUTA_RST = "RST3") then
       input_a_rst <= RST3_ipd;
     end if;
  end process;
      
  Register_A_Input : process(input_a_clk, input_a_rst_ogsr, input_a_ce)
  begin
     if (input_a_rst_ogsr = '1') then
       A_reg <= (others => '0');
     elsif (rising_edge(input_a_clk)) then
       if (input_a_ce = '1') then
         A_reg <= A_p;
       end if;
     end if;
  end process;

  Select_A_OR_A_reg : process (A_p, A_reg)
  begin
     if (REG_INPUTA_CLK = "NONE") then
       A_gen <= A_p;
     else
       A_gen <= A_reg;
     end if;
  end process;

  SROA_reg <= A_gen;

  Select_A_ipd_OR_SRIA_ipd : process(A_ipd, SRIA_ipd, SOURCEA_ipd)
  begin
     if (SOURCEA_ipd = '1') then
       A_p <= SRIA_ipd;
     elsif (SOURCEA_ipd = '0') then 
       A_p <= A_ipd;
     end if;
  end process;    

  Input_B_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB_CLK = "CLK0") then
       input_b_clk <= CLK0_ipd;
     elsif (REG_INPUTB_CLK = "CLK1") then
       input_b_clk <= CLK1_ipd;
     elsif (REG_INPUTB_CLK = "CLK2") then
       input_b_clk <= CLK2_ipd;
     elsif (REG_INPUTB_CLK = "CLK3") then
       input_b_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB_CE = "CE0") then
       input_b_ce <= CE0_ipd;
     elsif (REG_INPUTB_CE = "CE1") then
       input_b_ce <= CE1_ipd;
     elsif (REG_INPUTB_CE = "CE2") then
       input_b_ce <= CE2_ipd;
     elsif (REG_INPUTB_CE = "CE3") then
       input_b_ce <= CE3_ipd;
     end if;
  end process;

  Input_B_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB_RST = "RST0") then
       input_b_rst <= RST0_ipd;
     elsif (REG_INPUTB_RST = "RST1") then
       input_b_rst <= RST1_ipd;
     elsif (REG_INPUTB_RST = "RST2") then
       input_b_rst <= RST2_ipd;
     elsif (REG_INPUTB_RST = "RST3") then
       input_b_rst <= RST3_ipd;
     end if;
  end process;

  Register_B_Input : process(input_b_clk, input_b_rst_ogsr, input_b_ce)
  begin
     if (input_b_rst_ogsr = '1') then
       B_reg <= (others => '0');
     elsif (rising_edge(input_b_clk)) then
       if (input_b_ce = '1') then
         B_reg <= B_p;
       end if;
     end if;
  end process;

  Select_B_OR_B_reg : process (B_p, B_reg)
  begin
     if (REG_INPUTB_CLK = "NONE") then
       B_gen <= B_p;
     else
       B_gen <= B_reg;
     end if;
  end process;    

  SROB_reg <= B_gen;
    
  Select_B_ipd_OR_SRIB_ipd : process(B_ipd, SRIB_ipd, SOURCEB_ipd)
  begin
     if (SOURCEB_ipd = '1') then
       B_p <= SRIB_ipd;
     elsif (SOURCEB_ipd = '0') then 
       B_p <= B_ipd;
     end if;
  end process;   

  SIGNEDAB_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_CLK = "CLK0") then
       signeda_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_CLK = "CLK1") then
       signeda_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_CLK = "CLK2") then
       signeda_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_CLK = "CLK3") then
       signeda_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_CLK = "CLK0") then
       signedb_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_CLK = "CLK1") then
       signedb_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_CLK = "CLK2") then
       signedb_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_CLK = "CLK3") then
       signedb_clk <= CLK3_ipd;
     end if;

  end process;

  SIGNEDAB_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_CE = "CE0") then
       signeda_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_CE = "CE1") then
       signeda_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_CE = "CE2") then
       signeda_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_CE = "CE3") then
       signeda_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_CE = "CE0") then
       signedb_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_CE = "CE1") then
       signedb_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_CE = "CE2") then
       signedb_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_CE = "CE3") then
       signedb_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_RST = "RST0") then
       signeda_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_RST = "RST1") then
       signeda_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_RST = "RST2") then
       signeda_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_RST = "RST3") then
       signeda_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_RST = "RST0") then
       signedb_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_RST = "RST1") then
       signedb_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_RST = "RST2") then
       signedb_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_RST = "RST3") then
       signedb_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_SIGNEDA : process(signeda_clk, signeda_rst_ogsr, signeda_ce, SIGNEDA_ipd)
  begin
     if (signeda_rst_ogsr = '1') then
       SIGNEDA_reg <= '0';
     elsif (rising_edge(signeda_clk)) then
       if (signeda_ce = '1') then
         SIGNEDA_reg <= SIGNEDA_ipd;
       end if;
     end if;
  end process;

  Register_0_SIGNEDB : process(signedb_clk, signedb_rst_ogsr, signedb_ce, SIGNEDB_ipd)
  begin
     if (signedb_rst_ogsr = '1') then
       SIGNEDB_reg <= '0';
     elsif (rising_edge(signedb_clk)) then
       if (signedb_ce = '1') then
         SIGNEDB_reg <= SIGNEDB_ipd;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_0_reg : process (SIGNEDA_ipd, SIGNEDA_reg)
  begin
     if (REG_SIGNEDA_CLK = "NONE") then
       SIGNEDA_p1 <= SIGNEDA_ipd;
     else
       SIGNEDA_p1 <= SIGNEDA_reg;
     end if;
  end process; 

  Select_SIGNEDB_ipd_OR_SIGNEDB_0_reg : process (SIGNEDB_ipd, SIGNEDB_reg)
  begin
     if (REG_SIGNEDB_CLK = "NONE") then
       SIGNEDB_p1 <= SIGNEDB_ipd;
     else
       SIGNEDB_p1 <= SIGNEDB_reg;
     end if;
  end process;

  VITALMultBehavior : process(A_gen, B_gen, SIGNEDA_p1, SIGNEDB_p1)

    variable O_zd : std_logic_vector( 17 downto 0);
    variable IA, IB  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(8 downto 0);
    variable B_i : std_logic_vector(8 downto 0);

  begin -- process

    if ((A_gen = "000000000") or (B_gen = "000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A_gen) or IS_X(B_gen) ) then
            O_zd := (others => 'X');
    else
      if ((SIGNEDA_p1 = '1') and (A_gen(8) = '1' )) then 
	  A_i :=  TSCOMP(A_gen);
      else 
	  A_i := A_gen;
      end if;

      if ((SIGNEDB_p1 = '1') and (B_gen(8)  = '1')) then
	  B_i := TSCOMP(B_gen);
      else
	  B_i := B_gen;
      end if;

          IA := VEC2INT(A_i);
          IB := VEC2INT(B_i);

         O_zd := INT2VEC((IA * IB), 18);

         sign := (SIGNEDA_p1 and A_gen(8)) xor (SIGNEDB_p1 and B_gen(8));
         if (sign = '1' ) then
                O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p_i <= O_ZD; 

  end process;


  PipeLine_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE_CLK = "CLK0") then
       pipeline_clk <= CLK0_ipd;
     elsif (REG_PIPELINE_CLK = "CLK1") then
       pipeline_clk <= CLK1_ipd;
     elsif (REG_PIPELINE_CLK = "CLK2") then
       pipeline_clk <= CLK2_ipd;
     elsif (REG_PIPELINE_CLK = "CLK3") then
       pipeline_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE_CE = "CE0") then
       pipeline_ce <= CE0_ipd;
     elsif (REG_PIPELINE_CE = "CE1") then
       pipeline_ce <= CE1_ipd;
     elsif (REG_PIPELINE_CE = "CE2") then
       pipeline_ce <= CE2_ipd;
     elsif (REG_PIPELINE_CE = "CE3") then
       pipeline_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE_RST = "RST0") then
       pipeline_rst <= RST0_ipd;
     elsif (REG_PIPELINE_RST = "RST1") then
       pipeline_rst <= RST1_ipd;
     elsif (REG_PIPELINE_RST = "RST2") then
       pipeline_rst <= RST2_ipd;
     elsif (REG_PIPELINE_RST = "RST3") then
       pipeline_rst <= RST3_ipd;
     end if;
  end process;

  Pipeline_p_i : process(pipeline_clk, pipeline_rst_ogsr, pipeline_ce, p_i)
  begin
     if (pipeline_rst_ogsr = '1') then
       p_o <= (others => '0');
     elsif (rising_edge(pipeline_clk)) then
       if (pipeline_ce = '1') then
         p_o <= p_i;
       end if;
     end if;
  end process;

  Select_NOPIPELINE_OR_PIPELINE : process (p_i, p_o)
  begin
     if (REG_PIPELINE_CLK = "NONE") then
       p_ps <= p_i;
     else
       p_ps <= p_o;
     end if;
  end process;

  Output_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_OUTPUT_CLK = "CLK0") then
       output_clk <= CLK0_ipd;
     elsif (REG_OUTPUT_CLK = "CLK1") then
       output_clk <= CLK1_ipd;
     elsif (REG_OUTPUT_CLK = "CLK2") then
       output_clk <= CLK2_ipd;
     elsif (REG_OUTPUT_CLK = "CLK3") then
       output_clk <= CLK3_ipd;
     end if;
  end process;

  Output_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_OUTPUT_CE = "CE0") then
       output_ce <= CE0_ipd;
     elsif (REG_OUTPUT_CE = "CE1") then
       output_ce <= CE1_ipd;
     elsif (REG_OUTPUT_CE = "CE2") then
       output_ce <= CE2_ipd;
     elsif (REG_OUTPUT_CE = "CE3") then
       output_ce <= CE3_ipd;
     end if;
  end process;

  Output_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_OUTPUT_RST = "RST0") then
       output_rst <= RST0_ipd;
     elsif (REG_OUTPUT_RST = "RST1") then
       output_rst <= RST1_ipd;
     elsif (REG_OUTPUT_RST = "RST2") then
       output_rst <= RST2_ipd;
     elsif (REG_OUTPUT_RST = "RST3") then
       output_rst <= RST3_ipd;
     end if;
  end process;

  Output_Register : process(output_clk, output_rst_ogsr, output_ce, p_ps)
  begin
     if (output_rst_ogsr = '1') then
       p_o1 <= (others => '0');
     elsif (rising_edge(output_clk)) then
       if (output_ce = '1') then
         p_o1 <= p_ps;
       end if;
     end if;
  end process;

  Select_OUTREG_OR_NOREG : process (p_ps, p_o1)
  begin
     if (REG_OUTPUT_CLK = "NONE") then
       P_ipd <= p_ps;
     else
       P_ipd <= p_o1;
     end if;
  end process;

end V;

configuration CFG_MULT9X9B_V of MULT9X9B is
   for V
   end for;
end CFG_MULT9X9B_V;
----- CELL MULT9X9ADDSUBB -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use work.components.all;
use work.global.gsrnet;
use work.global.purnet;

-- entity declaration --
entity MULT9X9ADDSUBB is
  generic(
	 REG_INPUTA0_CLK       : string     := "NONE";
	 REG_INPUTA0_CE        : string     := "CE0";
	 REG_INPUTA0_RST       : string     := "RST0";
	 REG_INPUTA1_CLK       : string     := "NONE";
	 REG_INPUTA1_CE        : string     := "CE0";
	 REG_INPUTA1_RST       : string     := "RST0";
	 REG_INPUTB0_CLK       : string     := "NONE";
	 REG_INPUTB0_CE        : string     := "CE0";
	 REG_INPUTB0_RST       : string     := "RST0";
	 REG_INPUTB1_CLK       : string     := "NONE";
	 REG_INPUTB1_CE        : string     := "CE0";
	 REG_INPUTB1_RST       : string     := "RST0";
	 REG_PIPELINE0_CLK     : string     := "NONE";
	 REG_PIPELINE0_CE      : string     := "CE0";
	 REG_PIPELINE0_RST     : string     := "RST0";
	 REG_PIPELINE1_CLK     : string     := "NONE";
	 REG_PIPELINE1_CE      : string     := "CE0";
	 REG_PIPELINE1_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDA_0_CLK   : string     := "NONE";
	 REG_SIGNEDA_0_CE    : string     := "CE0";
	 REG_SIGNEDA_0_RST   : string     := "RST0";
	 REG_SIGNEDA_1_CLK   : string     := "NONE";
	 REG_SIGNEDA_1_CE    : string     := "CE0";
	 REG_SIGNEDA_1_RST   : string     := "RST0";
         REG_SIGNEDB_0_CLK   : string     := "NONE";
         REG_SIGNEDB_0_CE    : string     := "CE0";
         REG_SIGNEDB_0_RST   : string     := "RST0";
         REG_SIGNEDB_1_CLK   : string     := "NONE";
         REG_SIGNEDB_1_CE    : string     := "CE0";
         REG_SIGNEDB_1_RST   : string     := "RST0";
	 REG_ADDNSUB_0_CLK    : string     := "NONE";
	 REG_ADDNSUB_0_CE     : string     := "CE0";
	 REG_ADDNSUB_0_RST    : string     := "RST0";
	 REG_ADDNSUB_1_CLK    : string     := "NONE";
	 REG_ADDNSUB_1_CE     : string     := "CE0";
	 REG_ADDNSUB_1_RST    : string     := "RST0";
	 GSR                  : string     := "ENABLED");
  port (
        A00 : in STD_ULOGIC;
        A01 : in STD_ULOGIC;
        A02 : in STD_ULOGIC;
        A03 : in STD_ULOGIC;
        A04 : in STD_ULOGIC;
        A05 : in STD_ULOGIC;
        A06 : in STD_ULOGIC;
        A07 : in STD_ULOGIC;
        A08 : in STD_ULOGIC;

        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;
        A18 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;

        B00 : in STD_ULOGIC;
        B01 : in STD_ULOGIC;
        B02 : in STD_ULOGIC;
        B03 : in STD_ULOGIC;
        B04 : in STD_ULOGIC;
        B05 : in STD_ULOGIC;
        B06 : in STD_ULOGIC;
        B07 : in STD_ULOGIC;
        B08 : in STD_ULOGIC;

        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;
        B18 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        SOURCEA0 : in STD_ULOGIC;
        SOURCEA1 : in STD_ULOGIC;
        SOURCEB0 : in STD_ULOGIC;
        SOURCEB1 : in STD_ULOGIC;
        ADDNSUB  : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;

        SUM0 : out STD_ULOGIC;
        SUM1 : out STD_ULOGIC;
        SUM2 : out STD_ULOGIC;
        SUM3 : out STD_ULOGIC;
        SUM4 : out STD_ULOGIC;
        SUM5 : out STD_ULOGIC;
        SUM6 : out STD_ULOGIC;
        SUM7 : out STD_ULOGIC;
        SUM8 : out STD_ULOGIC;
        SUM9 : out STD_ULOGIC;
        SUM10 : out STD_ULOGIC;
        SUM11 : out STD_ULOGIC;
        SUM12 : out STD_ULOGIC;
        SUM13 : out STD_ULOGIC;
        SUM14 : out STD_ULOGIC;
        SUM15 : out STD_ULOGIC;
        SUM16 : out STD_ULOGIC;
        SUM17 : out STD_ULOGIC;
        SUM18 : out STD_ULOGIC
       ); 

attribute VITAL_LEVEL0 of MULT9X9ADDSUBB : entity is TRUE;

end MULT9X9ADDSUBB;

--- Architecture 

library IEEE;
use IEEE.VITAL_Primitives.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
architecture V of MULT9X9ADDSUBB is

  attribute VITAL_LEVEL0 of V : architecture is TRUE;

  -- Local signals used to propagate input wire delay

  signal A0_ipd, A0_ipd1     : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A1_ipd, A1_ipd1     : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SRIA_ipd, SRIA_ipd1 : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROA_reg   : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROA_reg1  : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B0_ipd, B0_ipd1     : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B1_ipd, B1_ipd1     : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SRIB_ipd, SRIB_ipd1 : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROB_reg   : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROB_reg1  : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SUM_ipd    : std_logic_vector(18 downto 0) := "XXXXXXXXXXXXXXXXXXX";
  signal SIGNEDA_ipd, SIGNEDA_ipd1 : std_logic := 'X';
  signal SIGNEDB_ipd, SIGNEDB_ipd1 : std_logic := 'X';
  signal SOURCEA0_ipd, SOURCEA0_ipd1 : std_logic := 'X';
  signal SOURCEA1_ipd, SOURCEA1_ipd1 : std_logic := 'X';
  signal SOURCEB0_ipd, SOURCEB0_ipd1 : std_logic := 'X';
  signal SOURCEB1_ipd, SOURCEB1_ipd1 : std_logic := 'X';
  signal ADDNSUB_ipd, ADDNSUB_ipd1 : std_logic := 'X';
  signal CE0_ipd  : std_logic := 'X';
  signal CE1_ipd  : std_logic := 'X';
  signal CE2_ipd  : std_logic := 'X';
  signal CE3_ipd  : std_logic := 'X';
  signal CLK0_ipd : std_logic := 'X';
  signal CLK1_ipd : std_logic := 'X';
  signal CLK2_ipd : std_logic := 'X';
  signal CLK3_ipd : std_logic := 'X';
  signal RST0_ipd : std_logic := 'X';
  signal RST1_ipd : std_logic := 'X';
  signal RST2_ipd : std_logic := 'X';
  signal RST3_ipd : std_logic := 'X';

  signal A0_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A1_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B0_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B1_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A0_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A1_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B0_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B1_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A0_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A1_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B0_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B1_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal P0_i      : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P1_i      : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P0_i_e    : std_logic_vector(18 downto 0) := "XXXXXXXXXXXXXXXXXXX";
  signal P1_i_e    : std_logic_vector(18 downto 0) := "XXXXXXXXXXXXXXXXXXX";
  signal p0_i_e_reg   : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal p1_i_e_reg   : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal p0_i_e_reg1  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal p1_i_e_reg1  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal sum_i     : std_logic_vector(18 downto 0) := "XXXXXXXXXXXXXXXXXXX";
  signal sum_reg  : std_logic_vector(18 downto 0) := "XXXXXXXXXXXXXXXXXXX";

  signal input_a0_clk : std_logic := 'X';
  signal input_a0_ce  : std_logic := 'X';
  signal input_a0_rst  : std_logic := 'X';
  signal input_a1_clk : std_logic := 'X';
  signal input_a1_ce  : std_logic := 'X';
  signal input_a1_rst  : std_logic := 'X';
  signal input_b0_clk : std_logic := 'X';
  signal input_b0_ce  : std_logic := 'X';
  signal input_b0_rst  : std_logic := 'X';
  signal input_b1_clk : std_logic := 'X';
  signal input_b1_ce  : std_logic := 'X';
  signal input_b1_rst  : std_logic := 'X';
  signal pipeline0_clk : std_logic := 'X';
  signal pipeline0_ce  : std_logic := 'X';
  signal pipeline0_rst : std_logic := 'X';
  signal pipeline1_clk : std_logic := 'X';
  signal pipeline1_ce  : std_logic := 'X';
  signal pipeline1_rst : std_logic := 'X';
  signal output_clk : std_logic := 'X';
  signal output_ce  : std_logic := 'X';
  signal output_rst  : std_logic := 'X';
  signal signeda_0_clk : std_logic := 'X';
  signal signeda_0_ce  : std_logic := 'X';
  signal signeda_0_rst  : std_logic := 'X';
  signal signeda_1_clk : std_logic := 'X';
  signal signeda_1_ce  : std_logic := 'X';
  signal signeda_1_rst  : std_logic := 'X';
  signal signeda_0_reg  : std_logic := 'X';
  signal signeda_1_reg  : std_logic := 'X';
  signal signeda_p1  : std_logic := 'X';
  signal signeda_p2  : std_logic := 'X';
  signal signedb_0_clk : std_logic := 'X';
  signal signedb_0_ce  : std_logic := 'X';
  signal signedb_0_rst  : std_logic := 'X';
  signal signedb_1_clk : std_logic := 'X';
  signal signedb_1_ce  : std_logic := 'X';
  signal signedb_1_rst  : std_logic := 'X';
  signal signedb_0_reg  : std_logic := 'X';
  signal signedb_1_reg  : std_logic := 'X';
  signal signedb_p1  : std_logic := 'X';
  signal signedb_p2  : std_logic := 'X';

  signal addnsub_0_clk : std_logic := 'X';
  signal addnsub_0_ce  : std_logic := 'X';
  signal addnsub_0_rst  : std_logic := 'X';
  signal addnsub_1_clk : std_logic := 'X';
  signal addnsub_1_ce  : std_logic := 'X';
  signal addnsub_1_rst  : std_logic := 'X';
  signal addnsub_0_reg  : std_logic := 'X';
  signal addnsub_1_reg  : std_logic := 'X';
  signal addnsub_p1  : std_logic := 'X';
  signal addnsub_p2  : std_logic := 'X';

  signal SRN          : std_logic;
  signal input_a0_rst_ogsr  : std_logic := 'X';
  signal input_a1_rst_ogsr  : std_logic := 'X';
  signal input_b0_rst_ogsr  : std_logic := 'X';
  signal input_b1_rst_ogsr  : std_logic := 'X';
  signal pipeline0_rst_ogsr  : std_logic := 'X';
  signal pipeline1_rst_ogsr  : std_logic := 'X';
  signal output_rst_ogsr  : std_logic := 'X';
  signal signeda_0_rst_ogsr  : std_logic := 'X';
  signal signeda_1_rst_ogsr  : std_logic := 'X';
  signal signedb_0_rst_ogsr  : std_logic := 'X';
  signal signedb_1_rst_ogsr  : std_logic := 'X';
  signal accumsload_0_rst_ogsr  : std_logic := 'X';
  signal accumsload_1_rst_ogsr  : std_logic := 'X';
  signal addnsub_0_rst_ogsr  : std_logic := 'X';
  signal addnsub_1_rst_ogsr  : std_logic := 'X';

begin 

    global_reset : process (purnet, gsrnet)
      begin
        if (GSR =  "DISABLED") then
           SRN <= purnet;
        else
           SRN <= purnet AND gsrnet;
        end if;
      end process;

    input_a0_rst_ogsr <= input_a0_rst or not SRN;
    input_a1_rst_ogsr <= input_a1_rst or not SRN;
    input_b0_rst_ogsr <= input_b0_rst or not SRN;
    input_b1_rst_ogsr <= input_b1_rst or not SRN;
    pipeline0_rst_ogsr <= pipeline0_rst or not SRN;
    pipeline1_rst_ogsr <= pipeline1_rst or not SRN;
    output_rst_ogsr <= output_rst or not SRN;
    signeda_0_rst_ogsr <= signeda_0_rst or not SRN;
    signeda_1_rst_ogsr <= signeda_1_rst or not SRN;
    signedb_0_rst_ogsr <= signedb_0_rst or not SRN;
    signedb_1_rst_ogsr <= signedb_1_rst or not SRN;
    addnsub_0_rst_ogsr <= addnsub_0_rst or not SRN;
    addnsub_1_rst_ogsr <= addnsub_1_rst or not SRN;

    A0_ipd1 <= (A08 & A07 & A06 & A05 & A04 & A03 & A02 & A01 & A00);
    A1_ipd1 <= (A18 & A17 & A16 & A15 & A14 & A13 & A12 & A11 & A10);
    B0_ipd1 <= (B08 & B07 & B06 & B05 & B04 & B03 & B02 & B01 & B00);
    B1_ipd1 <= (B18 & B17 & B16 & B15 & B14 & B13 & B12 & B11 & B10);
    SRIA_ipd1 <= (SRIA8 & SRIA7 & SRIA6 & SRIA5 & SRIA4 & SRIA3 & SRIA2 & SRIA1 & SRIA0);
    SRIB_ipd1 <= (SRIB8 & SRIB7 & SRIB6 & SRIB5 & SRIB4 & SRIB3 & SRIB2 & SRIB1 & SRIB0);
    SIGNEDA_ipd1 <= SIGNEDA;
    SIGNEDB_ipd1 <= SIGNEDB;
    SOURCEA0_ipd1 <= SOURCEA0;
    SOURCEA1_ipd1 <= SOURCEA1;
    SOURCEB0_ipd1 <= SOURCEB0;
    SOURCEB1_ipd1 <= SOURCEB1;
    ADDNSUB_ipd1 <= ADDNSUB;

    A0_ipd <= A0_ipd1;
    A1_ipd <= A1_ipd1;
    B0_ipd <= B0_ipd1;
    B1_ipd <= B1_ipd1;
    SRIA_ipd <= SRIA_ipd1;
    SRIB_ipd <= SRIB_ipd1;
    SIGNEDA_ipd <= SIGNEDA_ipd1;
    SIGNEDB_ipd <= SIGNEDB_ipd1;
    SOURCEA0_ipd <= SOURCEA0_ipd1;
    SOURCEA1_ipd <= SOURCEA1_ipd1;
    SOURCEB0_ipd <= SOURCEB0_ipd1;
    SOURCEB1_ipd <= SOURCEB1_ipd1;
    ADDNSUB_ipd <= ADDNSUB_ipd1;

    CE0_ipd <= CE0;
    CE1_ipd <= CE1;
    CE2_ipd <= CE2;
    CE3_ipd <= CE3;
    CLK0_ipd <= CLK0;
    CLK1_ipd <= CLK1;
    CLK2_ipd <= CLK2;
    CLK3_ipd <= CLK3;
    RST0_ipd <= RST0;
    RST1_ipd <= RST1;
    RST2_ipd <= RST2;
    RST3_ipd <= RST3;

    SROA0 <= SROA_reg1(0);
    SROA1 <= SROA_reg1(1);
    SROA2 <= SROA_reg1(2);
    SROA3 <= SROA_reg1(3);
    SROA4 <= SROA_reg1(4);
    SROA5 <= SROA_reg1(5);
    SROA6 <= SROA_reg1(6);
    SROA7 <= SROA_reg1(7);
    SROA8 <= SROA_reg1(8);

    SROB0 <= SROB_reg1(0);
    SROB1 <= SROB_reg1(1);
    SROB2 <= SROB_reg1(2);
    SROB3 <= SROB_reg1(3);
    SROB4 <= SROB_reg1(4);
    SROB5 <= SROB_reg1(5);
    SROB6 <= SROB_reg1(6);
    SROB7 <= SROB_reg1(7);
    SROB8 <= SROB_reg1(8);

    SUM0 <= SUM_ipd(0);
    SUM1 <= SUM_ipd(1);
    SUM2 <= SUM_ipd(2);
    SUM3 <= SUM_ipd(3);
    SUM4 <= SUM_ipd(4);
    SUM5 <= SUM_ipd(5);
    SUM6 <= SUM_ipd(6);
    SUM7 <= SUM_ipd(7);
    SUM8 <= SUM_ipd(8);
    SUM9 <= SUM_ipd(9);
    SUM10 <= SUM_ipd(10);
    SUM11 <= SUM_ipd(11);
    SUM12 <= SUM_ipd(12);
    SUM13 <= SUM_ipd(13);
    SUM14 <= SUM_ipd(14);
    SUM15 <= SUM_ipd(15);
    SUM16 <= SUM_ipd(16);
    SUM17 <= SUM_ipd(17);
    SUM18 <= SUM_ipd(18);


  Input_A0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA0_CLK = "CLK0") then
       input_a0_clk <= CLK0_ipd;
     elsif (REG_INPUTA0_CLK = "CLK1") then
       input_a0_clk <= CLK1_ipd;
     elsif (REG_INPUTA0_CLK = "CLK2") then
       input_a0_clk <= CLK2_ipd;
     elsif (REG_INPUTA0_CLK = "CLK3") then
       input_a0_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA1_CLK = "CLK0") then
       input_a1_clk <= CLK0_ipd;
     elsif (REG_INPUTA1_CLK = "CLK1") then
       input_a1_clk <= CLK1_ipd;
     elsif (REG_INPUTA1_CLK = "CLK2") then
       input_a1_clk <= CLK2_ipd;
     elsif (REG_INPUTA1_CLK = "CLK3") then
       input_a1_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA0_CE = "CE0") then
       input_a0_ce <= CE0_ipd;
     elsif (REG_INPUTA0_CE = "CE1") then
       input_a0_ce <= CE1_ipd;
     elsif (REG_INPUTA0_CE = "CE2") then
       input_a0_ce <= CE2_ipd;
     elsif (REG_INPUTA0_CE = "CE3") then
       input_a0_ce <= CE3_ipd;
     end if;
  end process;

  Input_A1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA1_CE = "CE0") then
       input_a1_ce <= CE0_ipd;
     elsif (REG_INPUTA1_CE = "CE1") then
       input_a1_ce <= CE1_ipd;
     elsif (REG_INPUTA1_CE = "CE2") then
       input_a1_ce <= CE2_ipd;
     elsif (REG_INPUTA1_CE = "CE3") then
       input_a1_ce <= CE3_ipd;
     end if;
  end process;

  Input_A0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA0_RST = "RST0") then
       input_a0_rst <= RST0_ipd;
     elsif (REG_INPUTA0_RST = "RST1") then
       input_a0_rst <= RST1_ipd;
     elsif (REG_INPUTA0_RST = "RST2") then
       input_a0_rst <= RST2_ipd;
     elsif (REG_INPUTA0_RST = "RST3") then
       input_a0_rst <= RST3_ipd;
     end if;
  end process;

  Input_A1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA1_RST = "RST0") then
       input_a1_rst <= RST0_ipd;
     elsif (REG_INPUTA1_RST = "RST1") then
       input_a1_rst <= RST1_ipd;
     elsif (REG_INPUTA1_RST = "RST2") then
       input_a1_rst <= RST2_ipd;
     elsif (REG_INPUTA1_RST = "RST3") then
       input_a1_rst <= RST3_ipd;
     end if;
  end process;
      
  Register_A0_Input : process(input_a0_clk, input_a0_rst_ogsr, input_a0_ce, A0_p)
  begin
     if (input_a0_rst_ogsr = '1') then
       A0_reg <= (others => '0');
     elsif (rising_edge(input_a0_clk)) then
       if (input_a0_ce = '1') then
         A0_reg <= A0_p;
       end if;
     end if;
  end process;

  Register_A1_Input : process(input_a1_clk, input_a1_rst_ogsr, input_a1_ce, A1_p)
  begin
     if (input_a1_rst_ogsr = '1') then
       A1_reg <= (others => '0');
     elsif (rising_edge(input_a1_clk)) then
       if (input_a1_ce = '1') then
         A1_reg <= A1_p;
       end if;
     end if;
  end process;

  Select_A0_OR_A0_reg : process (A0_p, A0_reg)
  begin
     if (REG_INPUTA0_CLK = "NONE") then
       A0_gen <= A0_p;
     else
       A0_gen <= A0_reg;
     end if;
  end process;

  Select_A1_OR_A1_reg : process (A1_p, A1_reg)
  begin
     if (REG_INPUTA1_CLK = "NONE") then
       A1_gen <= A1_p;
     else
       A1_gen <= A1_reg;
     end if;
  end process;

  SROA_reg1 <= A1_gen;

  Select_A0_p_OR_SRIA_ipd : process(A0_ipd, SRIA_ipd, SOURCEA0_ipd)
  begin
     if (SOURCEA0_ipd = '1') then
       A0_p <= SRIA_ipd;
     elsif (SOURCEA0_ipd = '0') then 
       A0_p <= A0_ipd;
     end if;
  end process;    

  Select_A1_p_OR_SROA_reg : process(A1_ipd, A0_gen, SOURCEA1_ipd)
  begin
     if (SOURCEA1_ipd = '1') then
       A1_p <= A0_gen;
     elsif (SOURCEA1_ipd = '0') then 
       A1_p <= A1_ipd;
     end if;
  end process;    

  Input_B0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB0_CLK = "CLK0") then
       input_b0_clk <= CLK0_ipd;
     elsif (REG_INPUTB0_CLK = "CLK1") then
       input_b0_clk <= CLK1_ipd;
     elsif (REG_INPUTB0_CLK = "CLK2") then
       input_b0_clk <= CLK2_ipd;
     elsif (REG_INPUTB0_CLK = "CLK3") then
       input_b0_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB1_CLK = "CLK0") then
       input_b1_clk <= CLK0_ipd;
     elsif (REG_INPUTB1_CLK = "CLK1") then
       input_b1_clk <= CLK1_ipd;
     elsif (REG_INPUTB1_CLK = "CLK2") then
       input_b1_clk <= CLK2_ipd;
     elsif (REG_INPUTB1_CLK = "CLK3") then
       input_b1_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB0_CE = "CE0") then
       input_b0_ce <= CE0_ipd;
     elsif (REG_INPUTB0_CE = "CE1") then
       input_b0_ce <= CE1_ipd;
     elsif (REG_INPUTB0_CE = "CE2") then
       input_b0_ce <= CE2_ipd;
     elsif (REG_INPUTB0_CE = "CE3") then
       input_b0_ce <= CE3_ipd;
     end if;
  end process;

  Input_B1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB1_CE = "CE0") then
       input_b1_ce <= CE0_ipd;
     elsif (REG_INPUTB1_CE = "CE1") then
       input_b1_ce <= CE1_ipd;
     elsif (REG_INPUTB1_CE = "CE2") then
       input_b1_ce <= CE2_ipd;
     elsif (REG_INPUTB1_CE = "CE3") then
       input_b1_ce <= CE3_ipd;
     end if;
  end process;

  Input_B0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB0_RST = "RST0") then
       input_b0_rst <= RST0_ipd;
     elsif (REG_INPUTB0_RST = "RST1") then
       input_b0_rst <= RST1_ipd;
     elsif (REG_INPUTB0_RST = "RST2") then
       input_b0_rst <= RST2_ipd;
     elsif (REG_INPUTB0_RST = "RST3") then
       input_b0_rst <= RST3_ipd;
     end if;
  end process;

  Input_B1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB1_RST = "RST0") then
       input_b1_rst <= RST0_ipd;
     elsif (REG_INPUTB1_RST = "RST1") then
       input_b1_rst <= RST1_ipd;
     elsif (REG_INPUTB1_RST = "RST2") then
       input_b1_rst <= RST2_ipd;
     elsif (REG_INPUTB1_RST = "RST3") then
       input_b1_rst <= RST3_ipd;
     end if;
  end process;

  Register_B0_Input : process(input_b0_clk, input_b0_rst_ogsr, input_b0_ce, B0_p)
  begin
     if (input_b0_rst_ogsr = '1') then
       B0_reg <= (others => '0');
     elsif (rising_edge(input_b0_clk)) then
       if (input_b0_ce = '1') then
         B0_reg <= B0_p;
       end if;
     end if;
  end process;

  Register_B1_Input : process(input_b1_clk, input_b1_rst_ogsr, input_b1_ce, B1_p)
  begin
     if (input_b1_rst_ogsr = '1') then
       B1_reg <= (others => '0');
     elsif (rising_edge(input_b1_clk)) then
       if (input_b1_ce = '1') then
         B1_reg <= B1_p;
       end if;
     end if;
  end process;

  Select_B0_OR_B0_reg : process (B0_p, B0_reg)
  begin
     if (REG_INPUTB0_CLK = "NONE") then
       B0_gen <= B0_p;
     else
       B0_gen <= B0_reg;
     end if;
  end process;    

  Select_B1_OR_B1_reg : process (B1_p, B1_reg)
  begin
     if (REG_INPUTB1_CLK = "NONE") then
       B1_gen <= B1_p;
     else
       B1_gen <= B1_reg;
     end if;
  end process;    

  SROB_reg1 <= B1_gen;
    
  Select_B0_p_OR_SRIB_ipd : process(B0_ipd, SRIB_ipd, SOURCEB0_ipd)
  begin
     if (SOURCEB0_ipd = '1') then
       B0_p <= SRIB_ipd;
     elsif (SOURCEB0_ipd = '0') then 
       B0_p <= B0_ipd;
     end if;
  end process;  

  Select_B1_p_OR_SROB_reg : process(B1_ipd, B0_gen, SOURCEB0_ipd)
  begin
     if (SOURCEB1_ipd = '1') then
       B1_p <= B0_gen;
     elsif (SOURCEB1_ipd = '0') then 
       B1_p <= B1_ipd;
     end if;
  end process;  

  SIGNEDAB_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDB_0_CLK = "CLK0") then
       signedb_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK1") then
       signedb_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK2") then
       signedb_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK3") then
       signedb_0_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDA_0_CLK = "CLK0") then
       signeda_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK1") then
       signeda_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK2") then
       signeda_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK3") then
       signeda_0_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_0_CE = "CE0") then
       signeda_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE1") then
       signeda_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE2") then
       signeda_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE3") then
       signeda_0_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_0_CE = "CE0") then
       signedb_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE1") then
       signedb_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE2") then
       signedb_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE3") then
       signedb_0_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_0_RST = "RST0") then
       signeda_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST1") then
       signeda_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST2") then
       signeda_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST3") then
       signeda_0_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_0_RST = "RST0") then
       signedb_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST1") then
       signedb_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST2") then
       signedb_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST3") then
       signedb_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_SIGNEDA : process(signeda_0_clk, signeda_0_rst_ogsr, signeda_0_ce, SIGNEDA_ipd)
  begin
     if (signeda_0_rst_ogsr = '1') then
       SIGNEDA_0_reg <= '0';
     elsif (rising_edge(signeda_0_clk)) then
       if (signeda_0_ce = '1') then
         SIGNEDA_0_reg <= SIGNEDA_ipd;
       end if;
     end if;
  end process;

  Register_0_SIGNEDB : process(signedb_0_clk, signedb_0_rst_ogsr, signedb_0_ce, SIGNEDB_ipd)
  begin
     if (signedb_0_rst_ogsr = '1') then
       SIGNEDB_0_reg <= '0';
     elsif (rising_edge(signedb_0_clk)) then
       if (signedb_0_ce = '1') then
         SIGNEDB_0_reg <= SIGNEDB_ipd;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_0_reg : process (SIGNEDA_ipd, SIGNEDA_0_reg)
  begin
     if (REG_SIGNEDA_0_CLK = "NONE") then
       SIGNEDA_p1 <= SIGNEDA_ipd;
     else
       SIGNEDA_p1 <= SIGNEDA_0_reg;
     end if;
  end process; 

  Select_SIGNEDB_ipd_OR_SIGNEDB_0_reg : process (SIGNEDB_ipd, SIGNEDB_0_reg)
  begin
     if (REG_SIGNEDB_0_CLK = "NONE") then
       SIGNEDB_p1 <= SIGNEDB_ipd;
     else
       SIGNEDB_p1 <= SIGNEDB_0_reg;
     end if;
  end process;

  SIGNEDAB_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_1_CLK = "CLK0") then
       signeda_1_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK1") then
       signeda_1_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK2") then
       signeda_1_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK3") then
       signeda_1_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_1_CLK = "CLK0") then
       signedb_1_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK1") then
       signedb_1_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK2") then
       signedb_1_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK3") then
       signedb_1_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_1_CE = "CE0") then
       signeda_1_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE1") then
       signeda_1_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE2") then
       signeda_1_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE3") then
       signeda_1_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_1_CE = "CE0") then
       signedb_1_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE1") then
       signedb_1_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE2") then
       signedb_1_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE3") then
       signedb_1_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_1_RST = "RST0") then
       signeda_1_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_1_RST = "RST1") then
       signeda_1_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST2") then
       signeda_1_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_1_RST = "RST3") then
       signeda_1_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_1_RST = "RST0") then
       signedb_1_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_1_RST = "RST1") then
       signedb_1_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST2") then
       signedb_1_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_1_RST = "RST3") then
       signedb_1_rst <= RST3_ipd;
     end if;
  end process;

  Register_1_SIGNEDA : process(signeda_1_clk, signeda_1_rst_ogsr, signeda_1_ce, SIGNEDA_p1)
  begin
     if (signeda_0_rst_ogsr = '1') then
       SIGNEDA_1_reg <= '0';
     elsif (rising_edge(signeda_1_clk)) then
       if (signeda_1_ce = '1') then
         SIGNEDA_1_reg <= SIGNEDA_p1;
       end if;
     end if;
  end process;

  Register_1_SIGNEDB : process(signedb_1_clk, signedb_1_rst_ogsr, signedb_1_ce, SIGNEDB_p1)
  begin
     if (signedb_0_rst_ogsr = '1') then
       SIGNEDB_1_reg <= '0';
     elsif (rising_edge(signedb_1_clk)) then
       if (signedb_1_ce = '1') then
         SIGNEDB_1_reg <= SIGNEDB_p1;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_1_reg : process (SIGNEDA_p1, SIGNEDA_1_reg)
  begin
     if (REG_SIGNEDA_1_CLK = "NONE") then
       SIGNEDA_p2 <= SIGNEDA_p1;
     else
       SIGNEDA_p2 <= SIGNEDA_1_reg;
     end if;
  end process; 

  Select_SIGNEDB_ipd_OR_SIGNEDB_1_reg : process (SIGNEDB_p1, SIGNEDB_1_reg)
  begin
     if (REG_SIGNEDB_1_CLK = "NONE") then
       SIGNEDB_p2 <= SIGNEDB_p1;
     else
       SIGNEDB_p2 <= SIGNEDB_1_reg;
     end if;
  end process;

  addnsub_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB_0_CLK = "CLK0") then
       addnsub_0_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB_0_CLK = "CLK1") then
       addnsub_0_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB_0_CLK = "CLK2") then
       addnsub_0_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB_0_CLK = "CLK3") then
       addnsub_0_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB_0_CE = "CE0") then
       addnsub_0_ce <= CE0_ipd;
     elsif (REG_ADDNSUB_0_CE = "CE1") then
       addnsub_0_ce <= CE1_ipd;
     elsif (REG_ADDNSUB_0_CE = "CE2") then
       addnsub_0_ce <= CE2_ipd;
     elsif (REG_ADDNSUB_0_CE = "CE3") then
       addnsub_0_ce <= CE3_ipd;
     end if;
  end process;

  addnsub_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB_0_RST = "RST0") then
       addnsub_0_rst <= RST0_ipd;
     elsif (REG_ADDNSUB_0_RST = "RST1") then
       addnsub_0_rst <= RST1_ipd;
     elsif (REG_ADDNSUB_0_RST = "RST2") then
       addnsub_0_rst <= RST2_ipd;
     elsif (REG_ADDNSUB_0_RST = "RST3") then
       addnsub_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_addnsub : process(addnsub_0_clk, addnsub_0_rst_ogsr, addnsub_0_ce, addnsub_ipd)
  begin
     if (addnsub_0_rst_ogsr = '1') then
       addnsub_0_reg <= '0';
     elsif (rising_edge(addnsub_0_clk)) then
       if (addnsub_0_ce = '1') then
         addnsub_0_reg <= addnsub_ipd;
       end if;
     end if;
  end process;

  Select_addnsub_ipd_OR_addnsub_0_reg : process (addnsub_ipd, addnsub_0_reg)
  begin
     if (REG_ADDNSUB_0_CLK = "NONE") then
       addnsub_p1 <= addnsub_ipd;
     else
       addnsub_p1 <= addnsub_0_reg;
     end if;
  end process; 

  addnsub_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB_1_CLK = "CLK0") then
       addnsub_1_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB_1_CLK = "CLK1") then
       addnsub_1_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB_1_CLK = "CLK2") then
       addnsub_1_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB_1_CLK = "CLK3") then
       addnsub_1_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB_1_CE = "CE0") then
       addnsub_1_ce <= CE0_ipd;
     elsif (REG_ADDNSUB_1_CE = "CE1") then
       addnsub_1_ce <= CE1_ipd;
     elsif (REG_ADDNSUB_1_CE = "CE2") then
       addnsub_1_ce <= CE2_ipd;
     elsif (REG_ADDNSUB_1_CE = "CE3") then
       addnsub_1_ce <= CE3_ipd;
     end if;
  end process;

  addnsub_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB_1_RST = "RST0") then
       addnsub_1_rst <= RST0_ipd;
     elsif (REG_ADDNSUB_1_RST = "RST1") then
       addnsub_1_rst <= RST1_ipd;
     elsif (REG_ADDNSUB_0_RST = "RST2") then
       addnsub_1_rst <= RST2_ipd;
     elsif (REG_ADDNSUB_1_RST = "RST3") then
       addnsub_1_rst <= RST3_ipd;
     end if;
  end process;

  Register_1_addnsub : process(addnsub_1_clk, addnsub_1_rst_ogsr, addnsub_1_ce, addnsub_p1)
  begin
     if (addnsub_0_rst_ogsr = '1') then
       addnsub_1_reg <= '0';
     elsif (rising_edge(addnsub_1_clk)) then
       if (addnsub_1_ce = '1') then
         addnsub_1_reg <= addnsub_p1;
       end if;
     end if;
  end process;

  Select_addnsub_ipd_OR_addnsub_1_reg : process (addnsub_p1, addnsub_1_reg)
  begin
     if (REG_ADDNSUB_1_CLK = "NONE") then
       addnsub_p2 <= addnsub_p1;
     else
       addnsub_p2 <= addnsub_1_reg;
     end if;
  end process; 

  VITALMultBehavior_p0_i : process(A0_gen, B0_gen, SIGNEDA_p1, SIGNEDB_p1)

    variable O_zd : std_logic_vector( 17 downto 0);
    variable IA, IB  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(8 downto 0);
    variable B_i : std_logic_vector(8 downto 0);

  begin -- process

    if ((A0_gen = "000000000") or (B0_gen = "000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A0_gen) or IS_X(B0_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A0_gen(8) = '1' ) then
           A_i :=  TSCOMP(A0_gen);
         else
           A_i := A0_gen;
         end if;
      else 
         A_i := A0_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B0_gen(8)  = '1') then
           B_i := TSCOMP(B0_gen);
         else
           B_i := B0_gen;
         end if;
      else
         B_i := B0_gen;
      end if;

          IA := VEC2INT(A_i);
          IB := VEC2INT(B_i);

         O_zd := INT2VEC((IA * IB), 18);

         sign := (SIGNEDA_p1 and A0_gen(8)) xor (SIGNEDB_p1 and B0_gen(8));
         if (sign = '1' ) then
                O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p0_i <= O_ZD; 

  end process;

  VITALMultBehavior_p1_i : process(A1_gen, B1_gen, SIGNEDA_p1, SIGNEDB_p1)

    variable O_zd : std_logic_vector( 17 downto 0);
    variable IA, IB  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(8 downto 0);
    variable B_i : std_logic_vector(8 downto 0);

  begin -- process

    if ((A1_gen = "000000000") or (B1_gen = "000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A1_gen) or IS_X(B1_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A1_gen(8) = '1' ) then
           A_i :=  TSCOMP(A1_gen);
         else
           A_i := A1_gen;
         end if;
      else 
         A_i := A1_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B1_gen(8)  = '1') then
           B_i := TSCOMP(B1_gen);
         else
           B_i := B1_gen;
         end if;
      else
         B_i := B1_gen;
      end if;

          IA := VEC2INT(A_i);
          IB := VEC2INT(B_i);

         O_zd := INT2VEC((IA * IB), 18);

         sign := (SIGNEDA_p1 and A1_gen(8)) xor (SIGNEDB_p1 and B1_gen(8));
         if (sign = '1' ) then
                O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p1_i <= O_ZD; 

  end process;

  P0_i_e_process : process(p0_i_e_reg1, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       p0_i_e(17 downto 0 ) <= p0_i_e_reg1;
       p0_i_e(18)           <= p0_i_e_reg1(17);
    else
       p0_i_e(17 downto 0 ) <= p0_i_e_reg1;
       p0_i_e(18)           <= '0';
    end if;
  end process;

  P1_i_e_process : process(p1_i_e_reg1, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       p1_i_e(17 downto 0 ) <= p1_i_e_reg1;
       p1_i_e(18)           <= p1_i_e_reg1(17);
    else
       p1_i_e(17 downto 0 ) <= p1_i_e_reg1;
       p1_i_e(18)           <= '0';
    end if;
  end process;

  PipeLine0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE0_CLK = "CLK0") then
       pipeline0_clk <= CLK0_ipd;
     elsif (REG_PIPELINE0_CLK = "CLK1") then
       pipeline0_clk <= CLK1_ipd;
     elsif (REG_PIPELINE0_CLK = "CLK2") then
       pipeline0_clk <= CLK2_ipd;
     elsif (REG_PIPELINE0_CLK = "CLK3") then
       pipeline0_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE1_CLK = "CLK0") then
       pipeline1_clk <= CLK0_ipd;
     elsif (REG_PIPELINE1_CLK = "CLK1") then
       pipeline1_clk <= CLK1_ipd;
     elsif (REG_PIPELINE1_CLK = "CLK2") then
       pipeline1_clk <= CLK2_ipd;
     elsif (REG_PIPELINE1_CLK = "CLK3") then
       pipeline1_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE0_CE = "CE0") then
       pipeline0_ce <= CE0_ipd;
     elsif (REG_PIPELINE0_CE = "CE1") then
       pipeline0_ce <= CE1_ipd;
     elsif (REG_PIPELINE0_CE = "CE2") then
       pipeline0_ce <= CE2_ipd;
     elsif (REG_PIPELINE0_CE = "CE3") then
       pipeline0_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE1_CE = "CE0") then
       pipeline1_ce <= CE0_ipd;
     elsif (REG_PIPELINE1_CE = "CE1") then
       pipeline1_ce <= CE1_ipd;
     elsif (REG_PIPELINE1_CE = "CE2") then
       pipeline1_ce <= CE2_ipd;
     elsif (REG_PIPELINE1_CE = "CE3") then
       pipeline1_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE0_RST = "RST0") then
       pipeline0_rst <= RST0_ipd;
     elsif (REG_PIPELINE0_RST = "RST1") then
       pipeline0_rst <= RST1_ipd;
     elsif (REG_PIPELINE0_RST = "RST2") then
       pipeline0_rst <= RST2_ipd;
     elsif (REG_PIPELINE0_RST = "RST3") then
       pipeline0_rst <= RST3_ipd;
     end if;
  end process;

  PipeLine1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE1_RST = "RST0") then
       pipeline1_rst <= RST0_ipd;
     elsif (REG_PIPELINE1_RST = "RST1") then
       pipeline1_rst <= RST1_ipd;
     elsif (REG_PIPELINE1_RST = "RST2") then
       pipeline1_rst <= RST2_ipd;
     elsif (REG_PIPELINE1_RST = "RST3") then
       pipeline1_rst <= RST3_ipd;
     end if;
  end process;

  Pipeline_p0_i_e : process(pipeline0_clk, pipeline0_rst_ogsr, pipeline0_ce, p0_i)
  begin
     if (pipeline0_rst_ogsr = '1') then
       p0_i_e_reg <= (others => '0');
     elsif (rising_edge(pipeline0_clk)) then
       if (pipeline0_ce = '1') then
         p0_i_e_reg <= p0_i;
       end if;
     end if;
  end process;

  Select_p0_i_e_OR_p0_i_e_reg : process (p0_i, p0_i_e_reg)
  begin
     if (REG_PIPELINE0_CLK = "NONE") then
       p0_i_e_reg1 <= p0_i;
     else
       p0_i_e_reg1 <= p0_i_e_reg;
     end if;
  end process;

  Pipeline_p1_i_e : process(pipeline1_clk, pipeline1_rst_ogsr, pipeline1_ce, p1_i)
  begin
     if (pipeline1_rst_ogsr = '1') then
       p1_i_e_reg <= (others => '0');
     elsif (rising_edge(pipeline1_clk)) then
       if (pipeline1_ce = '1') then
         p1_i_e_reg <= p1_i;
       end if;
     end if;
  end process;

  Select_p1_i_e_OR_p1_i_e_reg : process (p1_i, p1_i_e_reg)
  begin
     if (REG_PIPELINE1_CLK = "NONE") then
       p1_i_e_reg1 <= p1_i;
     else
       p1_i_e_reg1 <= p1_i_e_reg;
     end if;
  end process;

  AddSub_process : process(p0_i_e, p1_i_e, addnsub_p2)
  begin
    if (addnsub_p2 = '1') then
      sum_i <= ADDVECT(p0_i_e, p1_i_e);
    else
      sum_i <= SUBVECT(p0_i_e, p1_i_e);
    end if;
  end process;

  Output_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_OUTPUT_CLK = "CLK0") then
       output_clk <= CLK0_ipd;
     elsif (REG_OUTPUT_CLK = "CLK1") then
       output_clk <= CLK1_ipd;
     elsif (REG_OUTPUT_CLK = "CLK2") then
       output_clk <= CLK2_ipd;
     elsif (REG_OUTPUT_CLK = "CLK3") then
       output_clk <= CLK3_ipd;
     end if;
  end process;

  Output_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_OUTPUT_CE = "CE0") then
       output_ce <= CE0_ipd;
     elsif (REG_OUTPUT_CE = "CE1") then
       output_ce <= CE1_ipd;
     elsif (REG_OUTPUT_CE = "CE2") then
       output_ce <= CE2_ipd;
     elsif (REG_OUTPUT_CE = "CE3") then
       output_ce <= CE3_ipd;
     end if;
  end process;

  Output_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_OUTPUT_RST = "RST0") then
       output_rst <= RST0_ipd;
     elsif (REG_OUTPUT_RST = "RST1") then
       output_rst <= RST1_ipd;
     elsif (REG_OUTPUT_RST = "RST2") then
       output_rst <= RST2_ipd;
     elsif (REG_OUTPUT_RST = "RST3") then
       output_rst <= RST3_ipd;
     end if;
  end process;

  Output_Register : process(output_clk, output_rst_ogsr, output_ce, sum_i)
  begin
     if (output_rst_ogsr = '1') then
       sum_reg <= (others => '0');
     elsif (rising_edge(output_clk)) then
       if (output_ce = '1') then
         sum_reg <= sum_i;
       end if;
     end if;
  end process;

  Select_OUTREG_OR_NOREG : process (sum_i, sum_reg)
  begin
     if (REG_OUTPUT_CLK = "NONE") then
       SUM_ipd <= sum_i;
     else
       SUM_ipd <= sum_reg;
     end if;
  end process;

end V;

configuration CFG_MULT9X9ADDSUBB_V of MULT9X9ADDSUBB is
   for V
   end for;
end CFG_MULT9X9ADDSUBB_V;
----- CELL MULT9X9ADDSUBSUMB -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use work.components.all;
use work.global.gsrnet;
use work.global.purnet;

-- entity declaration --
entity MULT9X9ADDSUBSUMB is
  generic(
	 REG_INPUTA0_CLK       : string     := "NONE";
	 REG_INPUTA0_CE        : string     := "CE0";
	 REG_INPUTA0_RST       : string     := "RST0";
	 REG_INPUTA1_CLK       : string     := "NONE";
	 REG_INPUTA1_CE        : string     := "CE0";
	 REG_INPUTA1_RST       : string     := "RST0";
	 REG_INPUTA2_CLK       : string     := "NONE";
	 REG_INPUTA2_CE        : string     := "CE0";
	 REG_INPUTA2_RST       : string     := "RST0";
	 REG_INPUTA3_CLK       : string     := "NONE";
	 REG_INPUTA3_CE        : string     := "CE0";
	 REG_INPUTA3_RST       : string     := "RST0";
	 REG_INPUTB0_CLK       : string     := "NONE";
	 REG_INPUTB0_CE        : string     := "CE0";
	 REG_INPUTB0_RST       : string     := "RST0";
	 REG_INPUTB1_CLK       : string     := "NONE";
	 REG_INPUTB1_CE        : string     := "CE0";
	 REG_INPUTB1_RST       : string     := "RST0";
	 REG_INPUTB2_CLK       : string     := "NONE";
	 REG_INPUTB2_CE        : string     := "CE0";
	 REG_INPUTB2_RST       : string     := "RST0";
	 REG_INPUTB3_CLK       : string     := "NONE";
	 REG_INPUTB3_CE        : string     := "CE0";
	 REG_INPUTB3_RST       : string     := "RST0";
	 REG_PIPELINE0_CLK     : string     := "NONE";
	 REG_PIPELINE0_CE      : string     := "CE0";
	 REG_PIPELINE0_RST     : string     := "RST0";
	 REG_PIPELINE1_CLK     : string     := "NONE";
	 REG_PIPELINE1_CE      : string     := "CE0";
	 REG_PIPELINE1_RST     : string     := "RST0";
	 REG_PIPELINE2_CLK     : string     := "NONE";
	 REG_PIPELINE2_CE      : string     := "CE0";
	 REG_PIPELINE2_RST     : string     := "RST0";
	 REG_PIPELINE3_CLK     : string     := "NONE";
	 REG_PIPELINE3_CE      : string     := "CE0";
	 REG_PIPELINE3_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDA_0_CLK   : string     := "NONE";
	 REG_SIGNEDA_0_CE    : string     := "CE0";
	 REG_SIGNEDA_0_RST   : string     := "RST0";
	 REG_SIGNEDA_1_CLK   : string     := "NONE";
	 REG_SIGNEDA_1_CE    : string     := "CE0";
	 REG_SIGNEDA_1_RST   : string     := "RST0";
         REG_SIGNEDB_0_CLK   : string     := "NONE";
         REG_SIGNEDB_0_CE    : string     := "CE0";
         REG_SIGNEDB_0_RST   : string     := "RST0";
         REG_SIGNEDB_1_CLK   : string     := "NONE";
         REG_SIGNEDB_1_CE    : string     := "CE0";
         REG_SIGNEDB_1_RST   : string     := "RST0";
	 REG_ADDNSUB1_0_CLK    : string     := "NONE";
	 REG_ADDNSUB1_0_CE     : string     := "CE0";
	 REG_ADDNSUB1_0_RST    : string     := "RST0";
	 REG_ADDNSUB1_1_CLK    : string     := "NONE";
	 REG_ADDNSUB1_1_CE     : string     := "CE0";
	 REG_ADDNSUB1_1_RST    : string     := "RST0";
	 REG_ADDNSUB3_0_CLK    : string     := "NONE";
	 REG_ADDNSUB3_0_CE     : string     := "CE0";
	 REG_ADDNSUB3_0_RST    : string     := "RST0";
	 REG_ADDNSUB3_1_CLK    : string     := "NONE";
	 REG_ADDNSUB3_1_CE     : string     := "CE0";
	 REG_ADDNSUB3_1_RST    : string     := "RST0";
	 GSR                  : string     := "ENABLED");
  port (
        A00 : in STD_ULOGIC;
        A01 : in STD_ULOGIC;
        A02 : in STD_ULOGIC;
        A03 : in STD_ULOGIC;
        A04 : in STD_ULOGIC;
        A05 : in STD_ULOGIC;
        A06 : in STD_ULOGIC;
        A07 : in STD_ULOGIC;
        A08 : in STD_ULOGIC;

        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;
        A18 : in STD_ULOGIC;

        A20 : in STD_ULOGIC;
        A21 : in STD_ULOGIC;
        A22 : in STD_ULOGIC;
        A23 : in STD_ULOGIC;
        A24 : in STD_ULOGIC;
        A25 : in STD_ULOGIC;
        A26 : in STD_ULOGIC;
        A27 : in STD_ULOGIC;
        A28 : in STD_ULOGIC;

        A30 : in STD_ULOGIC;
        A31 : in STD_ULOGIC;
        A32 : in STD_ULOGIC;
        A33 : in STD_ULOGIC;
        A34 : in STD_ULOGIC;
        A35 : in STD_ULOGIC;
        A36 : in STD_ULOGIC;
        A37 : in STD_ULOGIC;
        A38 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;

        B00 : in STD_ULOGIC;
        B01 : in STD_ULOGIC;
        B02 : in STD_ULOGIC;
        B03 : in STD_ULOGIC;
        B04 : in STD_ULOGIC;
        B05 : in STD_ULOGIC;
        B06 : in STD_ULOGIC;
        B07 : in STD_ULOGIC;
        B08 : in STD_ULOGIC;

        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;
        B18 : in STD_ULOGIC;

        B20 : in STD_ULOGIC;
        B21 : in STD_ULOGIC;
        B22 : in STD_ULOGIC;
        B23 : in STD_ULOGIC;
        B24 : in STD_ULOGIC;
        B25 : in STD_ULOGIC;
        B26 : in STD_ULOGIC;
        B27 : in STD_ULOGIC;
        B28 : in STD_ULOGIC;

        B30 : in STD_ULOGIC;
        B31 : in STD_ULOGIC;
        B32 : in STD_ULOGIC;
        B33 : in STD_ULOGIC;
        B34 : in STD_ULOGIC;
        B35 : in STD_ULOGIC;
        B36 : in STD_ULOGIC;
        B37 : in STD_ULOGIC;
        B38 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        SOURCEA0 : in STD_ULOGIC;
        SOURCEA1 : in STD_ULOGIC;
        SOURCEA2 : in STD_ULOGIC;
        SOURCEA3 : in STD_ULOGIC;
        SOURCEB0 : in STD_ULOGIC;
        SOURCEB1 : in STD_ULOGIC;
        SOURCEB2 : in STD_ULOGIC;
        SOURCEB3 : in STD_ULOGIC;
        ADDNSUB1  : in STD_ULOGIC;
        ADDNSUB3  : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;

        SUM0 : out STD_ULOGIC;
        SUM1 : out STD_ULOGIC;
        SUM2 : out STD_ULOGIC;
        SUM3 : out STD_ULOGIC;
        SUM4 : out STD_ULOGIC;
        SUM5 : out STD_ULOGIC;
        SUM6 : out STD_ULOGIC;
        SUM7 : out STD_ULOGIC;
        SUM8 : out STD_ULOGIC;
        SUM9 : out STD_ULOGIC;
        SUM10 : out STD_ULOGIC;
        SUM11 : out STD_ULOGIC;
        SUM12 : out STD_ULOGIC;
        SUM13 : out STD_ULOGIC;
        SUM14 : out STD_ULOGIC;
        SUM15 : out STD_ULOGIC;
        SUM16 : out STD_ULOGIC;
        SUM17 : out STD_ULOGIC;
        SUM18 : out STD_ULOGIC;
        SUM19 : out STD_ULOGIC
       ); 

attribute VITAL_LEVEL0 of MULT9X9ADDSUBSUMB : entity is TRUE;

end MULT9X9ADDSUBSUMB;

--- Architecture 

library IEEE;
use IEEE.VITAL_Primitives.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
architecture V of MULT9X9ADDSUBSUMB is

  attribute VITAL_LEVEL0 of V : architecture is TRUE;

  -- Local signals used to propagate input wire delay

  signal A0_ipd, A0_ipd1     : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A1_ipd, A1_ipd1     : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A2_ipd, A2_ipd1     : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A3_ipd, A3_ipd1     : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SRIA_ipd, SRIA_ipd1 : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROA_reg   : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROA_reg1  : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROA_reg2  : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROA_reg3  : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B0_ipd, B0_ipd1     : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B1_ipd, B1_ipd1     : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B2_ipd, B2_ipd1     : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B3_ipd, B3_ipd1     : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SRIB_ipd, SRIB_ipd1 : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROB_reg   : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROB_reg1  : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROB_reg2  : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SROB_reg3  : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal SUM_ipd    : std_logic_vector(19 downto 0) := "XXXXXXXXXXXXXXXXXXXX";
  signal SIGNEDA_ipd, SIGNEDA_ipd1 : std_logic := 'X';
  signal SIGNEDB_ipd, SIGNEDB_ipd1 : std_logic := 'X';
  signal SOURCEA0_ipd, SOURCEA0_ipd1 : std_logic := 'X';
  signal SOURCEA1_ipd, SOURCEA1_ipd1 : std_logic := 'X';
  signal SOURCEA2_ipd, SOURCEA2_ipd1 : std_logic := 'X';
  signal SOURCEA3_ipd, SOURCEA3_ipd1 : std_logic := 'X';
  signal SOURCEB0_ipd, SOURCEB0_ipd1 : std_logic := 'X';
  signal SOURCEB1_ipd, SOURCEB1_ipd1 : std_logic := 'X';
  signal SOURCEB2_ipd, SOURCEB2_ipd1 : std_logic := 'X';
  signal SOURCEB3_ipd, SOURCEB3_ipd1 : std_logic := 'X';
  signal ADDNSUB1_ipd, ADDNSUB1_ipd1 : std_logic := 'X';
  signal ADDNSUB3_ipd, ADDNSUB3_ipd1 : std_logic := 'X';
  signal CE0_ipd  : std_logic := 'X';
  signal CE1_ipd  : std_logic := 'X';
  signal CE2_ipd  : std_logic := 'X';
  signal CE3_ipd  : std_logic := 'X';
  signal CLK0_ipd : std_logic := 'X';
  signal CLK1_ipd : std_logic := 'X';
  signal CLK2_ipd : std_logic := 'X';
  signal CLK3_ipd : std_logic := 'X';
  signal RST0_ipd : std_logic := 'X';
  signal RST1_ipd : std_logic := 'X';
  signal RST2_ipd : std_logic := 'X';
  signal RST3_ipd : std_logic := 'X';

  signal A0_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A1_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A2_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A3_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B0_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B1_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B2_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B3_reg    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A0_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A1_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A2_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A3_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B0_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B1_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B2_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B3_p      : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A0_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A1_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A2_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal A3_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B0_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B1_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B2_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal B3_gen    : std_logic_vector(8 downto 0) := "XXXXXXXXX";
  signal P0_i      : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P1_i      : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P2_i      : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P3_i      : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P0_i_e    : std_logic_vector(18 downto 0) := "XXXXXXXXXXXXXXXXXXX";
  signal P1_i_e    : std_logic_vector(18 downto 0) := "XXXXXXXXXXXXXXXXXXX";
  signal P2_i_e    : std_logic_vector(18 downto 0) := "XXXXXXXXXXXXXXXXXXX";
  signal P3_i_e    : std_logic_vector(18 downto 0) := "XXXXXXXXXXXXXXXXXXX";
  signal p0_i_e_reg    : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal p1_i_e_reg    : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal p2_i_e_reg    : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal p3_i_e_reg    : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal p0_i_e_reg1   : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal p1_i_e_reg1   : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal p2_i_e_reg1   : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal p3_i_e_reg1   : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal sum0_i     : std_logic_vector(18 downto 0) := "XXXXXXXXXXXXXXXXXXX";
  signal sum1_i     : std_logic_vector(18 downto 0) := "XXXXXXXXXXXXXXXXXXX";
  signal sum0_i_e     : std_logic_vector(19 downto 0) := "XXXXXXXXXXXXXXXXXXXX";
  signal sum1_i_e     : std_logic_vector(19 downto 0) := "XXXXXXXXXXXXXXXXXXXX";
  signal sumt_sig  : std_logic_vector(19 downto 0) := "XXXXXXXXXXXXXXXXXXXX";
  signal sumt_reg  : std_logic_vector(19 downto 0) := "XXXXXXXXXXXXXXXXXXXX";

  signal input_a0_clk : std_logic := 'X';
  signal input_a0_ce  : std_logic := 'X';
  signal input_a0_rst  : std_logic := 'X';
  signal input_a1_clk : std_logic := 'X';
  signal input_a1_ce  : std_logic := 'X';
  signal input_a1_rst  : std_logic := 'X';
  signal input_a2_clk : std_logic := 'X';
  signal input_a2_ce  : std_logic := 'X';
  signal input_a2_rst  : std_logic := 'X';
  signal input_a3_clk : std_logic := 'X';
  signal input_a3_ce  : std_logic := 'X';
  signal input_a3_rst  : std_logic := 'X';
  signal input_b0_clk : std_logic := 'X';
  signal input_b0_ce  : std_logic := 'X';
  signal input_b0_rst  : std_logic := 'X';
  signal input_b1_clk : std_logic := 'X';
  signal input_b1_ce  : std_logic := 'X';
  signal input_b1_rst  : std_logic := 'X';
  signal input_b2_clk : std_logic := 'X';
  signal input_b2_ce  : std_logic := 'X';
  signal input_b2_rst  : std_logic := 'X';
  signal input_b3_clk : std_logic := 'X';
  signal input_b3_ce  : std_logic := 'X';
  signal input_b3_rst  : std_logic := 'X';
  signal pipeline0_clk : std_logic := 'X';
  signal pipeline0_ce  : std_logic := 'X';
  signal pipeline0_rst  : std_logic := 'X';
  signal pipeline1_clk : std_logic := 'X';
  signal pipeline1_ce  : std_logic := 'X';
  signal pipeline1_rst  : std_logic := 'X';
  signal pipeline2_clk : std_logic := 'X';
  signal pipeline2_ce  : std_logic := 'X';
  signal pipeline2_rst  : std_logic := 'X';
  signal pipeline3_clk : std_logic := 'X';
  signal pipeline3_ce  : std_logic := 'X';
  signal pipeline3_rst  : std_logic := 'X';
  signal output_clk : std_logic := 'X';
  signal output_ce  : std_logic := 'X';
  signal output_rst  : std_logic := 'X';
  signal signeda_0_clk : std_logic := 'X';
  signal signeda_0_ce  : std_logic := 'X';
  signal signeda_0_rst  : std_logic := 'X';
  signal signeda_1_clk : std_logic := 'X';
  signal signeda_1_ce  : std_logic := 'X';
  signal signeda_1_rst  : std_logic := 'X';
  signal signeda_0_reg  : std_logic := 'X';
  signal signeda_1_reg  : std_logic := 'X';
  signal signeda_p1  : std_logic := 'X';
  signal signeda_p2  : std_logic := 'X';
  signal signedb_0_clk : std_logic := 'X';
  signal signedb_0_ce  : std_logic := 'X';
  signal signedb_0_rst  : std_logic := 'X';
  signal signedb_1_clk : std_logic := 'X';
  signal signedb_1_ce  : std_logic := 'X';
  signal signedb_1_rst  : std_logic := 'X';
  signal signedb_0_reg  : std_logic := 'X';
  signal signedb_1_reg  : std_logic := 'X';
  signal signedb_p1  : std_logic := 'X';
  signal signedb_p2  : std_logic := 'X';

  signal addnsub1_0_clk : std_logic := 'X';
  signal addnsub1_0_ce  : std_logic := 'X';
  signal addnsub1_0_rst  : std_logic := 'X';
  signal addnsub1_1_clk : std_logic := 'X';
  signal addnsub1_1_ce  : std_logic := 'X';
  signal addnsub1_1_rst  : std_logic := 'X';
  signal addnsub1_0_reg  : std_logic := 'X';
  signal addnsub1_1_reg  : std_logic := 'X';
  signal addnsub1_p1  : std_logic := 'X';
  signal addnsub1_p2  : std_logic := 'X';

  signal addnsub3_0_clk : std_logic := 'X';
  signal addnsub3_0_ce  : std_logic := 'X';
  signal addnsub3_0_rst  : std_logic := 'X';
  signal addnsub3_1_clk : std_logic := 'X';
  signal addnsub3_1_ce  : std_logic := 'X';
  signal addnsub3_1_rst  : std_logic := 'X';
  signal addnsub3_0_reg  : std_logic := 'X';
  signal addnsub3_1_reg  : std_logic := 'X';
  signal addnsub3_p1  : std_logic := 'X';
  signal addnsub3_p2  : std_logic := 'X';

  signal SRN          : std_logic;
  signal input_a0_rst_ogsr  : std_logic := 'X';
  signal input_a1_rst_ogsr  : std_logic := 'X';
  signal input_a2_rst_ogsr  : std_logic := 'X';
  signal input_a3_rst_ogsr  : std_logic := 'X';
  signal input_b0_rst_ogsr  : std_logic := 'X';
  signal input_b1_rst_ogsr  : std_logic := 'X';
  signal input_b2_rst_ogsr  : std_logic := 'X';
  signal input_b3_rst_ogsr  : std_logic := 'X';
  signal pipeline0_rst_ogsr  : std_logic := 'X';
  signal pipeline1_rst_ogsr  : std_logic := 'X';
  signal pipeline2_rst_ogsr  : std_logic := 'X';
  signal pipeline3_rst_ogsr  : std_logic := 'X';
  signal output_rst_ogsr  : std_logic := 'X';
  signal signeda_0_rst_ogsr  : std_logic := 'X';
  signal signeda_1_rst_ogsr  : std_logic := 'X';
  signal signedb_0_rst_ogsr  : std_logic := 'X';
  signal signedb_1_rst_ogsr  : std_logic := 'X';
  signal addnsub1_0_rst_ogsr  : std_logic := 'X';
  signal addnsub1_1_rst_ogsr  : std_logic := 'X';
  signal addnsub3_0_rst_ogsr  : std_logic := 'X';
  signal addnsub3_1_rst_ogsr  : std_logic := 'X';

begin 

    global_reset : process (purnet, gsrnet)
      begin
        if (GSR =  "DISABLED") then
           SRN <= purnet;
        else
           SRN <= purnet AND gsrnet;
        end if;
      end process;

    input_a0_rst_ogsr <= input_a0_rst or not SRN;
    input_a1_rst_ogsr <= input_a1_rst or not SRN;
    input_a2_rst_ogsr <= input_a2_rst or not SRN;
    input_a3_rst_ogsr <= input_a3_rst or not SRN;
    input_b0_rst_ogsr <= input_b0_rst or not SRN;
    input_b1_rst_ogsr <= input_b1_rst or not SRN;
    input_b2_rst_ogsr <= input_b2_rst or not SRN;
    input_b3_rst_ogsr <= input_b3_rst or not SRN;
    pipeline0_rst_ogsr <= pipeline0_rst or not SRN;
    pipeline1_rst_ogsr <= pipeline1_rst or not SRN;
    pipeline2_rst_ogsr <= pipeline2_rst or not SRN;
    pipeline3_rst_ogsr <= pipeline3_rst or not SRN;
    output_rst_ogsr <= output_rst or not SRN;
    signeda_0_rst_ogsr <= signeda_0_rst or not SRN;
    signeda_1_rst_ogsr <= signeda_1_rst or not SRN;
    signedb_0_rst_ogsr <= signedb_0_rst or not SRN;
    signedb_1_rst_ogsr <= signedb_1_rst or not SRN;
    addnsub1_0_rst_ogsr <= addnsub1_0_rst or not SRN;
    addnsub1_1_rst_ogsr <= addnsub1_1_rst or not SRN;
    addnsub3_0_rst_ogsr <= addnsub3_0_rst or not SRN;
    addnsub3_1_rst_ogsr <= addnsub3_1_rst or not SRN;

    A0_ipd1 <= (A08 & A07 & A06 & A05 & A04 & A03 & A02 & A01 & A00);
    A1_ipd1 <= (A18 & A17 & A16 & A15 & A14 & A13 & A12 & A11 & A10);
    A2_ipd1 <= (A28 & A27 & A26 & A25 & A24 & A23 & A22 & A21 & A20);
    A3_ipd1 <= (A38 & A37 & A36 & A35 & A34 & A33 & A32 & A31 & A30);
    B0_ipd1 <= (B08 & B07 & B06 & B05 & B04 & B03 & B02 & B01 & B00);
    B1_ipd1 <= (B18 & B17 & B16 & B15 & B14 & B13 & B12 & B11 & B10);
    B2_ipd1 <= (B28 & B27 & B26 & B25 & B24 & B23 & B22 & B21 & B20);
    B3_ipd1 <= (B38 & B37 & B36 & B35 & B34 & B33 & B32 & B31 & B30);
    SRIA_ipd1 <= (SRIA8 & SRIA7 & SRIA6 & SRIA5 & SRIA4 & SRIA3 & SRIA2 & SRIA1 & SRIA0);
    SRIB_ipd1 <= (SRIB8 & SRIB7 & SRIB6 & SRIB5 & SRIB4 & SRIB3 & SRIB2 & SRIB1 & SRIB0);
    SIGNEDA_ipd1 <= SIGNEDA;
    SIGNEDB_ipd1 <= SIGNEDB;
    SOURCEA0_ipd1 <= SOURCEA0;
    SOURCEA1_ipd1 <= SOURCEA1;
    SOURCEA2_ipd1 <= SOURCEA2;
    SOURCEA3_ipd1 <= SOURCEA3;
    SOURCEB0_ipd1 <= SOURCEB0;
    SOURCEB1_ipd1 <= SOURCEB1;
    SOURCEB2_ipd1 <= SOURCEB2;
    SOURCEB3_ipd1 <= SOURCEB3;
    ADDNSUB1_ipd1 <= ADDNSUB1;
    ADDNSUB3_ipd1 <= ADDNSUB3;

    A0_ipd <= A0_ipd1;
    A1_ipd <= A1_ipd1;
    A2_ipd <= A2_ipd1;
    A3_ipd <= A3_ipd1;
    B0_ipd <= B0_ipd1;
    B1_ipd <= B1_ipd1;
    B2_ipd <= B2_ipd1;
    B3_ipd <= B3_ipd1;
    SRIA_ipd <= SRIA_ipd1;
    SRIB_ipd <= SRIB_ipd1;
    SIGNEDA_ipd <= SIGNEDA_ipd1;
    SIGNEDB_ipd <= SIGNEDB_ipd1;
    SOURCEA0_ipd <= SOURCEA0_ipd1;
    SOURCEA1_ipd <= SOURCEA1_ipd1;
    SOURCEA2_ipd <= SOURCEA2_ipd1;
    SOURCEA3_ipd <= SOURCEA3_ipd1;
    SOURCEB0_ipd <= SOURCEB0_ipd1;
    SOURCEB1_ipd <= SOURCEB1_ipd1;
    SOURCEB2_ipd <= SOURCEB2_ipd1;
    SOURCEB3_ipd <= SOURCEB3_ipd1;
    ADDNSUB1_ipd <= ADDNSUB1_ipd1;
    ADDNSUB3_ipd <= ADDNSUB3_ipd1;

    CE0_ipd <= CE0;
    CE1_ipd <= CE1;
    CE2_ipd <= CE2;
    CE3_ipd <= CE3;
    CLK0_ipd <= CLK0;
    CLK1_ipd <= CLK1;
    CLK2_ipd <= CLK2;
    CLK3_ipd <= CLK3;
    RST0_ipd <= RST0;
    RST1_ipd <= RST1;
    RST2_ipd <= RST2;
    RST3_ipd <= RST3;

    SROA0 <= SROA_reg3(0);
    SROA1 <= SROA_reg3(1);
    SROA2 <= SROA_reg3(2);
    SROA3 <= SROA_reg3(3);
    SROA4 <= SROA_reg3(4);
    SROA5 <= SROA_reg3(5);
    SROA6 <= SROA_reg3(6);
    SROA7 <= SROA_reg3(7);
    SROA8 <= SROA_reg3(8);

    SROB0 <= SROB_reg3(0);
    SROB1 <= SROB_reg3(1);
    SROB2 <= SROB_reg3(2);
    SROB3 <= SROB_reg3(3);
    SROB4 <= SROB_reg3(4);
    SROB5 <= SROB_reg3(5);
    SROB6 <= SROB_reg3(6);
    SROB7 <= SROB_reg3(7);
    SROB8 <= SROB_reg3(8);

    SUM0 <= SUM_ipd(0);
    SUM1 <= SUM_ipd(1);
    SUM2 <= SUM_ipd(2);
    SUM3 <= SUM_ipd(3);
    SUM4 <= SUM_ipd(4);
    SUM5 <= SUM_ipd(5);
    SUM6 <= SUM_ipd(6);
    SUM7 <= SUM_ipd(7);
    SUM8 <= SUM_ipd(8);
    SUM9 <= SUM_ipd(9);
    SUM10 <= SUM_ipd(10);
    SUM11 <= SUM_ipd(11);
    SUM12 <= SUM_ipd(12);
    SUM13 <= SUM_ipd(13);
    SUM14 <= SUM_ipd(14);
    SUM15 <= SUM_ipd(15);
    SUM16 <= SUM_ipd(16);
    SUM17 <= SUM_ipd(17);
    SUM18 <= SUM_ipd(18);
    SUM19 <= SUM_ipd(19);

  Input_A0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA0_CLK = "CLK0") then
       input_a0_clk <= CLK0_ipd;
     elsif (REG_INPUTA0_CLK = "CLK1") then
       input_a0_clk <= CLK1_ipd;
     elsif (REG_INPUTA0_CLK = "CLK2") then
       input_a0_clk <= CLK2_ipd;
     elsif (REG_INPUTA0_CLK = "CLK3") then
       input_a0_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA1_CLK = "CLK0") then
       input_a1_clk <= CLK0_ipd;
     elsif (REG_INPUTA1_CLK = "CLK1") then
       input_a1_clk <= CLK1_ipd;
     elsif (REG_INPUTA1_CLK = "CLK2") then
       input_a1_clk <= CLK2_ipd;
     elsif (REG_INPUTA1_CLK = "CLK3") then
       input_a1_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A2_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA2_CLK = "CLK0") then
       input_a2_clk <= CLK0_ipd;
     elsif (REG_INPUTA2_CLK = "CLK1") then
       input_a2_clk <= CLK1_ipd;
     elsif (REG_INPUTA2_CLK = "CLK2") then
       input_a2_clk <= CLK2_ipd;
     elsif (REG_INPUTA2_CLK = "CLK3") then
       input_a2_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A3_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA3_CLK = "CLK0") then
       input_a3_clk <= CLK0_ipd;
     elsif (REG_INPUTA3_CLK = "CLK1") then
       input_a3_clk <= CLK1_ipd;
     elsif (REG_INPUTA3_CLK = "CLK2") then
       input_a3_clk <= CLK2_ipd;
     elsif (REG_INPUTA3_CLK = "CLK3") then
       input_a3_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA0_CE = "CE0") then
       input_a0_ce <= CE0_ipd;
     elsif (REG_INPUTA0_CE = "CE1") then
       input_a0_ce <= CE1_ipd;
     elsif (REG_INPUTA0_CE = "CE2") then
       input_a0_ce <= CE2_ipd;
     elsif (REG_INPUTA0_CE = "CE3") then
       input_a0_ce <= CE3_ipd;
     end if;
  end process;

  Input_A1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA1_CE = "CE0") then
       input_a1_ce <= CE0_ipd;
     elsif (REG_INPUTA1_CE = "CE1") then
       input_a1_ce <= CE1_ipd;
     elsif (REG_INPUTA1_CE = "CE2") then
       input_a1_ce <= CE2_ipd;
     elsif (REG_INPUTA1_CE = "CE3") then
       input_a1_ce <= CE3_ipd;
     end if;
  end process;

  Input_A2_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA2_CE = "CE0") then
       input_a2_ce <= CE0_ipd;
     elsif (REG_INPUTA2_CE = "CE1") then
       input_a2_ce <= CE1_ipd;
     elsif (REG_INPUTA2_CE = "CE2") then
       input_a2_ce <= CE2_ipd;
     elsif (REG_INPUTA2_CE = "CE3") then
       input_a2_ce <= CE3_ipd;
     end if;
  end process;

  Input_A3_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA3_CE = "CE0") then
       input_a3_ce <= CE0_ipd;
     elsif (REG_INPUTA3_CE = "CE1") then
       input_a3_ce <= CE1_ipd;
     elsif (REG_INPUTA3_CE = "CE2") then
       input_a3_ce <= CE2_ipd;
     elsif (REG_INPUTA3_CE = "CE3") then
       input_a3_ce <= CE3_ipd;
     end if;
  end process;

  Input_A0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA0_RST = "RST0") then
       input_a0_rst <= RST0_ipd;
     elsif (REG_INPUTA0_RST = "RST1") then
       input_a0_rst <= RST1_ipd;
     elsif (REG_INPUTA0_RST = "RST2") then
       input_a0_rst <= RST2_ipd;
     elsif (REG_INPUTA0_RST = "RST3") then
       input_a0_rst <= RST3_ipd;
     end if;
  end process;

  Input_A1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA1_RST = "RST0") then
       input_a1_rst <= RST0_ipd;
     elsif (REG_INPUTA1_RST = "RST1") then
       input_a1_rst <= RST1_ipd;
     elsif (REG_INPUTA1_RST = "RST2") then
       input_a1_rst <= RST2_ipd;
     elsif (REG_INPUTA1_RST = "RST3") then
       input_a1_rst <= RST3_ipd;
     end if;
  end process;
      
  Input_A2_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA2_RST = "RST0") then
       input_a2_rst <= RST0_ipd;
     elsif (REG_INPUTA2_RST = "RST1") then
       input_a2_rst <= RST1_ipd;
     elsif (REG_INPUTA2_RST = "RST2") then
       input_a2_rst <= RST2_ipd;
     elsif (REG_INPUTA2_RST = "RST3") then
       input_a2_rst <= RST3_ipd;
     end if;
  end process;
      
  Input_A3_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA3_RST = "RST0") then
       input_a3_rst <= RST0_ipd;
     elsif (REG_INPUTA3_RST = "RST1") then
       input_a3_rst <= RST1_ipd;
     elsif (REG_INPUTA3_RST = "RST2") then
       input_a3_rst <= RST2_ipd;
     elsif (REG_INPUTA3_RST = "RST3") then
       input_a3_rst <= RST3_ipd;
     end if;
  end process;
      
  Register_A0_Input : process(input_a0_clk, input_a0_rst_ogsr, input_a0_ce, A0_p)
  begin
     if (input_a0_rst_ogsr = '1') then
       A0_reg <= (others => '0');
     elsif (rising_edge(input_a0_clk)) then
       if (input_a0_ce = '1') then
         A0_reg <= A0_p;
       end if;
     end if;
  end process;

  Register_A1_Input : process(input_a1_clk, input_a1_rst_ogsr, input_a1_ce, A1_p)
  begin
     if (input_a1_rst_ogsr = '1') then
       A1_reg <= (others => '0');
     elsif (rising_edge(input_a1_clk)) then
       if (input_a1_ce = '1') then
         A1_reg <= A1_p;
       end if;
     end if;
  end process;

  Register_A2_Input : process(input_a2_clk, input_a2_rst_ogsr, input_a2_ce, A2_p)
  begin
     if (input_a2_rst_ogsr = '1') then
       A2_reg <= (others => '0');
     elsif (rising_edge(input_a2_clk)) then
       if (input_a2_ce = '1') then
         A2_reg <= A2_p;
       end if;
     end if;
  end process;

  Register_A3_Input : process(input_a3_clk, input_a3_rst_ogsr, input_a3_ce, A3_p)
  begin
     if (input_a3_rst_ogsr = '1') then
       A3_reg <= (others => '0');
     elsif (rising_edge(input_a3_clk)) then
       if (input_a3_ce = '1') then
         A3_reg <= A3_p;
       end if;
     end if;
  end process;

  Select_A0_OR_A0_reg : process (A0_p, A0_reg)
  begin
     if (REG_INPUTA0_CLK = "NONE") then
       A0_gen <= A0_p;
     else
       A0_gen <= A0_reg;
     end if;
  end process;

  Select_A1_OR_A1_reg : process (A1_p, A1_reg)
  begin
     if (REG_INPUTA1_CLK = "NONE") then
       A1_gen <= A1_p;
     else
       A1_gen <= A1_reg;
     end if;
  end process;

  Select_A2_OR_A2_reg : process (A2_p, A2_reg)
  begin
     if (REG_INPUTA2_CLK = "NONE") then
       A2_gen <= A2_p;
     else
       A2_gen <= A2_reg;
     end if;
  end process;

  Select_A3_OR_A3_reg : process (A3_p, A3_reg)
  begin
     if (REG_INPUTA3_CLK = "NONE") then
       A3_gen <= A3_p;
     else
       A3_gen <= A3_reg;
     end if;
  end process;

  SROA_reg3 <= A3_gen;

  Select_A0_p_OR_SRIA_ipd : process(A0_ipd, SRIA_ipd, SOURCEA0_ipd)
  begin
     if (SOURCEA0_ipd = '1') then
       A0_p <= SRIA_ipd;
     elsif (SOURCEA0_ipd = '0') then 
       A0_p <= A0_ipd;
     end if;
  end process;    

  Select_A1_p_OR_SROA_reg : process(A1_ipd, A0_gen, SOURCEA1_ipd)
  begin
     if (SOURCEA1_ipd = '1') then
       A1_p <= A0_gen;
     elsif (SOURCEA1_ipd = '0') then 
       A1_p <= A1_ipd;
     end if;
  end process;    

  Select_A2_p_OR_SROA_reg : process(A2_ipd, A1_gen, SOURCEA2_ipd)
  begin
     if (SOURCEA2_ipd = '1') then
       A2_p <= A1_gen;
     elsif (SOURCEA2_ipd = '0') then 
       A2_p <= A2_ipd;
     end if;
  end process;    

  Select_A3_p_OR_SROA_reg : process(A3_ipd, A2_gen, SOURCEA3_ipd)
  begin
     if (SOURCEA3_ipd = '1') then
       A3_p <= A2_gen;
     elsif (SOURCEA3_ipd = '0') then 
       A3_p <= A3_ipd;
     end if;
  end process;    

  Input_B0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB0_CLK = "CLK0") then
       input_b0_clk <= CLK0_ipd;
     elsif (REG_INPUTB0_CLK = "CLK1") then
       input_b0_clk <= CLK1_ipd;
     elsif (REG_INPUTB0_CLK = "CLK2") then
       input_b0_clk <= CLK2_ipd;
     elsif (REG_INPUTB0_CLK = "CLK3") then
       input_b0_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB1_CLK = "CLK0") then
       input_b1_clk <= CLK0_ipd;
     elsif (REG_INPUTB1_CLK = "CLK1") then
       input_b1_clk <= CLK1_ipd;
     elsif (REG_INPUTB1_CLK = "CLK2") then
       input_b1_clk <= CLK2_ipd;
     elsif (REG_INPUTB1_CLK = "CLK3") then
       input_b1_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B2_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB2_CLK = "CLK0") then
       input_b2_clk <= CLK0_ipd;
     elsif (REG_INPUTB2_CLK = "CLK1") then
       input_b2_clk <= CLK1_ipd;
     elsif (REG_INPUTB2_CLK = "CLK2") then
       input_b2_clk <= CLK2_ipd;
     elsif (REG_INPUTB2_CLK = "CLK3") then
       input_b2_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B3_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB3_CLK = "CLK0") then
       input_b3_clk <= CLK0_ipd;
     elsif (REG_INPUTB3_CLK = "CLK1") then
       input_b3_clk <= CLK1_ipd;
     elsif (REG_INPUTB3_CLK = "CLK2") then
       input_b3_clk <= CLK2_ipd;
     elsif (REG_INPUTB3_CLK = "CLK3") then
       input_b3_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB0_CE = "CE0") then
       input_b0_ce <= CE0_ipd;
     elsif (REG_INPUTB0_CE = "CE1") then
       input_b0_ce <= CE1_ipd;
     elsif (REG_INPUTB0_CE = "CE2") then
       input_b0_ce <= CE2_ipd;
     elsif (REG_INPUTB0_CE = "CE3") then
       input_b0_ce <= CE3_ipd;
     end if;
  end process;

  Input_B1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB1_CE = "CE0") then
       input_b1_ce <= CE0_ipd;
     elsif (REG_INPUTB1_CE = "CE1") then
       input_b1_ce <= CE1_ipd;
     elsif (REG_INPUTB1_CE = "CE2") then
       input_b1_ce <= CE2_ipd;
     elsif (REG_INPUTB1_CE = "CE3") then
       input_b1_ce <= CE3_ipd;
     end if;
  end process;

  Input_B2_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB2_CE = "CE0") then
       input_b2_ce <= CE0_ipd;
     elsif (REG_INPUTB2_CE = "CE1") then
       input_b2_ce <= CE1_ipd;
     elsif (REG_INPUTB2_CE = "CE2") then
       input_b2_ce <= CE2_ipd;
     elsif (REG_INPUTB2_CE = "CE3") then
       input_b2_ce <= CE3_ipd;
     end if;
  end process;

  Input_B3_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB3_CE = "CE0") then
       input_b3_ce <= CE0_ipd;
     elsif (REG_INPUTB3_CE = "CE1") then
       input_b3_ce <= CE1_ipd;
     elsif (REG_INPUTB3_CE = "CE2") then
       input_b3_ce <= CE2_ipd;
     elsif (REG_INPUTB3_CE = "CE3") then
       input_b3_ce <= CE3_ipd;
     end if;
  end process;

  Input_B0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB0_RST = "RST0") then
       input_b0_rst <= RST0_ipd;
     elsif (REG_INPUTB0_RST = "RST1") then
       input_b0_rst <= RST1_ipd;
     elsif (REG_INPUTB0_RST = "RST2") then
       input_b0_rst <= RST2_ipd;
     elsif (REG_INPUTB0_RST = "RST3") then
       input_b0_rst <= RST3_ipd;
     end if;
  end process;

  Input_B1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB1_RST = "RST0") then
       input_b1_rst <= RST0_ipd;
     elsif (REG_INPUTB1_RST = "RST1") then
       input_b1_rst <= RST1_ipd;
     elsif (REG_INPUTB1_RST = "RST2") then
       input_b1_rst <= RST2_ipd;
     elsif (REG_INPUTB1_RST = "RST3") then
       input_b1_rst <= RST3_ipd;
     end if;
  end process;

  Input_B2_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB2_RST = "RST0") then
       input_b2_rst <= RST0_ipd;
     elsif (REG_INPUTB2_RST = "RST1") then
       input_b2_rst <= RST1_ipd;
     elsif (REG_INPUTB2_RST = "RST2") then
       input_b2_rst <= RST2_ipd;
     elsif (REG_INPUTB2_RST = "RST3") then
       input_b2_rst <= RST3_ipd;
     end if;
  end process;

  Input_B3_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB3_RST = "RST0") then
       input_b3_rst <= RST0_ipd;
     elsif (REG_INPUTB3_RST = "RST1") then
       input_b3_rst <= RST1_ipd;
     elsif (REG_INPUTB3_RST = "RST2") then
       input_b3_rst <= RST2_ipd;
     elsif (REG_INPUTB3_RST = "RST3") then
       input_b3_rst <= RST3_ipd;
     end if;
  end process;

  Register_B0_Input : process(input_b0_clk, input_b0_rst_ogsr, input_b0_ce, B0_p)
  begin
     if (input_b0_rst_ogsr = '1') then
       B0_reg <= (others => '0');
     elsif (rising_edge(input_b0_clk)) then
       if (input_b0_ce = '1') then
         B0_reg <= B0_p;
       end if;
     end if;
  end process;

  Register_B1_Input : process(input_b1_clk, input_b1_rst_ogsr, input_b1_ce, B1_p)
  begin
     if (input_b1_rst_ogsr = '1') then
       B1_reg <= (others => '0');
     elsif (rising_edge(input_b1_clk)) then
       if (input_b1_ce = '1') then
         B1_reg <= B1_p;
       end if;
     end if;
  end process;

  Register_B2_Input : process(input_b2_clk, input_b2_rst_ogsr, input_b2_ce, B2_p)
  begin
     if (input_b2_rst_ogsr = '1') then
       B2_reg <= (others => '0');
     elsif (rising_edge(input_b2_clk)) then
       if (input_b2_ce = '1') then
         B2_reg <= B2_p;
       end if;
     end if;
  end process;

  Register_B3_Input : process(input_b3_clk, input_b3_rst_ogsr, input_b3_ce, B3_p)
  begin
     if (input_b3_rst_ogsr = '1') then
       B3_reg <= (others => '0');
     elsif (rising_edge(input_b3_clk)) then
       if (input_b3_ce = '1') then
         B3_reg <= B3_p;
       end if;
     end if;
  end process;

  Select_B0_OR_B0_reg : process (B0_p, B0_reg)
  begin
     if (REG_INPUTB0_CLK = "NONE") then
       B0_gen <= B0_p;
     else
       B0_gen <= B0_reg;
     end if;
  end process;    

  Select_B1_OR_B1_reg : process (B1_p, B1_reg)
  begin
     if (REG_INPUTB1_CLK = "NONE") then
       B1_gen <= B1_p;
     else
       B1_gen <= B1_reg;
     end if;
  end process;    
    
  Select_B2_OR_B2_reg : process (B2_p, B2_reg)
  begin
     if (REG_INPUTB2_CLK = "NONE") then
       B2_gen <= B2_p;
     else
       B2_gen <= B2_reg;
     end if;
  end process;    
    
  Select_B3_OR_B3_reg : process (B3_p, B3_reg)
  begin
     if (REG_INPUTB3_CLK = "NONE") then
       B3_gen <= B3_p;
     else
       B3_gen <= B3_reg;
     end if;
  end process;    

  SROB_reg3 <= B3_gen;
    
  Select_B0_p_OR_SRIB_ipd : process(B0_ipd, SRIB_ipd, SOURCEB0_ipd)
  begin
     if (SOURCEB0_ipd = '1') then
       B0_p <= SRIB_ipd;
     elsif (SOURCEB0_ipd = '0') then 
       B0_p <= B0_ipd;
     end if;
  end process;  

  Select_B1_p_OR_SROB_reg : process(B1_ipd, B0_gen, SOURCEB1_ipd)
  begin
     if (SOURCEB1_ipd = '1') then
       B1_p <= B0_gen;
     elsif (SOURCEB1_ipd = '0') then 
       B1_p <= B1_ipd;
     end if;
  end process;  

  Select_B2_p_OR_SROB_reg1 : process(B2_ipd, B1_gen, SOURCEB2_ipd)
  begin
     if (SOURCEB2_ipd = '1') then
       B2_p <= B1_gen;
     elsif (SOURCEB2_ipd = '0') then 
       B2_p <= B2_ipd;
     end if;
  end process;  

  Select_B3_p_OR_SROB_reg2 : process(B3_ipd, B2_gen, SOURCEB3_ipd)
  begin
     if (SOURCEB3_ipd = '1') then
       B3_p <= B2_gen;
     elsif (SOURCEB3_ipd = '0') then 
       B3_p <= B3_ipd;
     end if;
  end process;  

  SIGNEDAB_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_0_CLK = "CLK0") then
       signeda_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK1") then
       signeda_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK2") then
       signeda_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK3") then
       signeda_0_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_0_CLK = "CLK0") then
       signedb_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK1") then
       signedb_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK2") then
       signedb_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK3") then
       signedb_0_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_0_CE = "CE0") then
       signeda_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE1") then
       signeda_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE2") then
       signeda_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE3") then
       signeda_0_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_0_CE = "CE0") then
       signedb_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE1") then
       signedb_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE2") then
       signedb_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE3") then
       signedb_0_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_0_RST = "RST0") then
       signedb_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST1") then
       signedb_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST2") then
       signedb_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST3") then
       signedb_0_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_0_RST = "RST0") then
       signedb_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST1") then
       signedb_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST2") then
       signedb_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST3") then
       signedb_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_SIGNEDA : process(signeda_0_clk, signeda_0_rst_ogsr, signeda_0_ce, SIGNEDA_ipd)
  begin
     if (signeda_0_rst_ogsr = '1') then
       SIGNEDA_0_reg <= '0';
     elsif (rising_edge(signeda_0_clk)) then
       if (signeda_0_ce = '1') then
         SIGNEDA_0_reg <= SIGNEDA_ipd;
       end if;
     end if;
  end process;

  Register_0_SIGNEDB : process(signedb_0_clk, signedb_0_rst_ogsr, signedb_0_ce, SIGNEDB_ipd)
  begin
     if (signedb_0_rst_ogsr = '1') then
       SIGNEDB_0_reg <= '0';
     elsif (rising_edge(signedb_0_clk)) then
       if (signedb_0_ce = '1') then
         SIGNEDB_0_reg <= SIGNEDB_ipd;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_0_reg : process (SIGNEDA_ipd, SIGNEDA_0_reg)
  begin
     if (REG_SIGNEDA_0_CLK = "NONE") then
       SIGNEDA_p1 <= SIGNEDA_ipd;
     else
       SIGNEDA_p1 <= SIGNEDA_0_reg;
     end if;
  end process; 

  Select_SIGNEDB_ipd_OR_SIGNEDB_0_reg : process (SIGNEDB_ipd, SIGNEDB_0_reg)
  begin
     if (REG_SIGNEDB_0_CLK = "NONE") then
       SIGNEDB_p1 <= SIGNEDB_ipd;
     else
       SIGNEDB_p1 <= SIGNEDB_0_reg;
     end if;
  end process;

  SIGNEDAB_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_1_CLK = "CLK0") then
       signeda_1_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK1") then
       signeda_1_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK2") then
       signeda_1_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK3") then
       signeda_1_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_1_CLK = "CLK0") then
       signedb_1_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK1") then
       signedb_1_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK2") then
       signedb_1_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK3") then
       signedb_1_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_1_CE = "CE0") then
       signeda_1_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE1") then
       signeda_1_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE2") then
       signeda_1_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE3") then
       signeda_1_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_1_CE = "CE0") then
       signedb_1_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE1") then
       signedb_1_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE2") then
       signedb_1_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE3") then
       signedb_1_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_1_RST = "RST0") then
       signeda_1_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_1_RST = "RST1") then
       signeda_1_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST2") then
       signeda_1_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_1_RST = "RST3") then
       signeda_1_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_1_RST = "RST0") then
       signedb_1_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_1_RST = "RST1") then
       signedb_1_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST2") then
       signedb_1_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_1_RST = "RST3") then
       signedb_1_rst <= RST3_ipd;
     end if;
  end process;

  Register_1_SIGNEDA : process(signeda_1_clk, signeda_1_rst_ogsr, signeda_1_ce, SIGNEDA_p1)
  begin
     if (signeda_0_rst_ogsr = '1') then
       SIGNEDA_1_reg <= '0';
     elsif (rising_edge(signeda_1_clk)) then
       if (signeda_1_ce = '1') then
         SIGNEDA_1_reg <= SIGNEDA_p1;
       end if;
     end if;
  end process;

  Register_1_SIGNEDB : process(signedb_1_clk, signedb_1_rst_ogsr, signedb_1_ce, SIGNEDB_p1)
  begin
     if (signedb_0_rst_ogsr = '1') then
       SIGNEDB_1_reg <= '0';
     elsif (rising_edge(signedb_1_clk)) then
       if (signedb_1_ce = '1') then
         SIGNEDB_1_reg <= SIGNEDB_p1;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_1_reg : process (SIGNEDA_p1, SIGNEDA_1_reg)
  begin
     if (REG_SIGNEDA_1_CLK = "NONE") then
       SIGNEDA_p2 <= SIGNEDA_p1;
     else
       SIGNEDA_p2 <= SIGNEDA_1_reg;
     end if;
  end process; 

  Select_SIGNEDB_ipd_OR_SIGNEDB_1_reg : process (SIGNEDB_p1, SIGNEDB_1_reg)
  begin
     if (REG_SIGNEDB_1_CLK = "NONE") then
       SIGNEDB_p2 <= SIGNEDB_p1;
     else
       SIGNEDB_p2 <= SIGNEDB_1_reg;
     end if;
  end process;

  addnsub1_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB1_0_CLK = "CLK0") then
       addnsub1_0_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB1_0_CLK = "CLK1") then
       addnsub1_0_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB1_0_CLK = "CLK2") then
       addnsub1_0_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB1_0_CLK = "CLK3") then
       addnsub1_0_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub3_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB3_0_CLK = "CLK0") then
       addnsub3_0_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB3_0_CLK = "CLK1") then
       addnsub3_0_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB3_0_CLK = "CLK2") then
       addnsub3_0_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB3_0_CLK = "CLK3") then
       addnsub3_0_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub1_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB1_0_CE = "CE0") then
       addnsub1_0_ce <= CE0_ipd;
     elsif (REG_ADDNSUB1_0_CE = "CE1") then
       addnsub1_0_ce <= CE1_ipd;
     elsif (REG_ADDNSUB1_0_CE = "CE2") then
       addnsub1_0_ce <= CE2_ipd;
     elsif (REG_ADDNSUB1_0_CE = "CE3") then
       addnsub1_0_ce <= CE3_ipd;
     end if;
  end process;

  addnsub3_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB3_0_CE = "CE0") then
       addnsub3_0_ce <= CE0_ipd;
     elsif (REG_ADDNSUB3_0_CE = "CE1") then
       addnsub3_0_ce <= CE1_ipd;
     elsif (REG_ADDNSUB3_0_CE = "CE2") then
       addnsub3_0_ce <= CE2_ipd;
     elsif (REG_ADDNSUB3_0_CE = "CE3") then
       addnsub3_0_ce <= CE3_ipd;
     end if;
  end process;

  addnsub1_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB1_0_RST = "RST0") then
       addnsub1_0_rst <= RST0_ipd;
     elsif (REG_ADDNSUB1_0_RST = "RST1") then
       addnsub1_0_rst <= RST1_ipd;
     elsif (REG_ADDNSUB1_0_RST = "RST2") then
       addnsub1_0_rst <= RST2_ipd;
     elsif (REG_ADDNSUB1_0_RST = "RST3") then
       addnsub1_0_rst <= RST3_ipd;
     end if;
  end process;

  addnsub3_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB3_0_RST = "RST0") then
       addnsub3_0_rst <= RST0_ipd;
     elsif (REG_ADDNSUB3_0_RST = "RST1") then
       addnsub3_0_rst <= RST1_ipd;
     elsif (REG_ADDNSUB3_0_RST = "RST2") then
       addnsub3_0_rst <= RST2_ipd;
     elsif (REG_ADDNSUB3_0_RST = "RST3") then
       addnsub3_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_addnsub1 : process(addnsub1_0_clk, addnsub1_0_rst_ogsr, addnsub1_0_ce, addnsub1_ipd)
  begin
     if (addnsub1_0_rst_ogsr = '1') then
       addnsub1_0_reg <= '0';
     elsif (rising_edge(addnsub1_0_clk)) then
       if (addnsub1_0_ce = '1') then
         addnsub1_0_reg <= addnsub1_ipd;
       end if;
     end if;
  end process;

  Register_0_addnsub3 : process(addnsub3_0_clk, addnsub3_0_rst_ogsr, addnsub3_0_ce, addnsub3_ipd)
  begin
     if (addnsub3_0_rst_ogsr = '1') then
       addnsub3_0_reg <= '0';
     elsif (rising_edge(addnsub3_0_clk)) then
       if (addnsub3_0_ce = '1') then
         addnsub3_0_reg <= addnsub3_ipd;
       end if;
     end if;
  end process;

  Select_addnsub1_ipd_OR_addnsub1_0_reg : process (addnsub1_ipd, addnsub1_0_reg)
  begin
     if (REG_ADDNSUB1_0_CLK = "NONE") then
       addnsub1_p1 <= addnsub1_ipd;
     else
       addnsub1_p1 <= addnsub1_0_reg;
     end if;
  end process; 

  Select_addnsub3_ipd_OR_addnsub3_0_reg : process (addnsub3_ipd, addnsub3_0_reg)
  begin
     if (REG_ADDNSUB3_0_CLK = "NONE") then
       addnsub3_p1 <= addnsub3_ipd;
     else
       addnsub3_p1 <= addnsub3_0_reg;
     end if;
  end process; 

  addnsub1_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB1_1_CLK = "CLK0") then
       addnsub1_1_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB1_1_CLK = "CLK1") then
       addnsub1_1_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB1_1_CLK = "CLK2") then
       addnsub1_1_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB1_1_CLK = "CLK3") then
       addnsub1_1_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub3_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB3_1_CLK = "CLK0") then
       addnsub3_1_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB3_1_CLK = "CLK1") then
       addnsub3_1_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB3_1_CLK = "CLK2") then
       addnsub3_1_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB3_1_CLK = "CLK3") then
       addnsub3_1_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub1_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB1_1_CE = "CE0") then
       addnsub1_1_ce <= CE0_ipd;
     elsif (REG_ADDNSUB1_1_CE = "CE1") then
       addnsub1_1_ce <= CE1_ipd;
     elsif (REG_ADDNSUB1_1_CE = "CE2") then
       addnsub1_1_ce <= CE2_ipd;
     elsif (REG_ADDNSUB1_1_CE = "CE3") then
       addnsub1_1_ce <= CE3_ipd;
     end if;
  end process;

  addnsub3_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB3_1_CE = "CE0") then
       addnsub3_1_ce <= CE0_ipd;
     elsif (REG_ADDNSUB3_1_CE = "CE1") then
       addnsub3_1_ce <= CE1_ipd;
     elsif (REG_ADDNSUB3_1_CE = "CE2") then
       addnsub3_1_ce <= CE2_ipd;
     elsif (REG_ADDNSUB3_1_CE = "CE3") then
       addnsub3_1_ce <= CE3_ipd;
     end if;
  end process;

  addnsub1_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB1_1_RST = "RST0") then
       addnsub1_1_rst <= RST0_ipd;
     elsif (REG_ADDNSUB1_1_RST = "RST1") then
       addnsub1_1_rst <= RST1_ipd;
     elsif (REG_ADDNSUB1_0_RST = "RST2") then
       addnsub1_1_rst <= RST2_ipd;
     elsif (REG_ADDNSUB1_1_RST = "RST3") then
       addnsub1_1_rst <= RST3_ipd;
     end if;
  end process;

  addnsub3_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB3_1_RST = "RST0") then
       addnsub3_1_rst <= RST0_ipd;
     elsif (REG_ADDNSUB3_1_RST = "RST1") then
       addnsub3_1_rst <= RST1_ipd;
     elsif (REG_ADDNSUB3_0_RST = "RST2") then
       addnsub3_1_rst <= RST2_ipd;
     elsif (REG_ADDNSUB3_1_RST = "RST3") then
       addnsub3_1_rst <= RST3_ipd;
     end if;
  end process;

  Register_1_addnsub1 : process(addnsub1_1_clk, addnsub1_1_rst_ogsr, addnsub1_1_ce, addnsub1_p1)
  begin
     if (addnsub1_0_rst_ogsr = '1') then
       addnsub1_1_reg <= '0';
     elsif (rising_edge(addnsub1_1_clk)) then
       if (addnsub1_1_ce = '1') then
         addnsub1_1_reg <= addnsub1_p1;
       end if;
     end if;
  end process;

  Register_1_addnsub3 : process(addnsub3_1_clk, addnsub3_1_rst_ogsr, addnsub3_1_ce, addnsub3_p1)
  begin
     if (addnsub3_0_rst_ogsr = '1') then
       addnsub3_1_reg <= '0';
     elsif (rising_edge(addnsub3_1_clk)) then
       if (addnsub3_1_ce = '1') then
         addnsub3_1_reg <= addnsub3_p1;
       end if;
     end if;
  end process;

  Select_addnsub1_ipd_OR_addnsub1_1_reg : process (addnsub1_p1, addnsub1_1_reg)
  begin
     if (REG_ADDNSUB1_1_CLK = "NONE") then
       addnsub1_p2 <= addnsub1_p1;
     else
       addnsub1_p2 <= addnsub1_1_reg;
     end if;
  end process; 

  Select_addnsub3_ipd_OR_addnsub3_1_reg : process (addnsub3_p1, addnsub3_1_reg)
  begin
     if (REG_ADDNSUB3_1_CLK = "NONE") then
       addnsub3_p2 <= addnsub3_p1;
     else
       addnsub3_p2 <= addnsub3_1_reg;
     end if;
  end process; 

  VITALMultBehavior_p0_i : process(A0_gen, B0_gen, SIGNEDA_p1, SIGNEDB_p1)

    variable O_zd : std_logic_vector( 17 downto 0);
    variable IA, IB  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(8 downto 0);
    variable B_i : std_logic_vector(8 downto 0);

  begin -- process

    if ((A0_gen = "000000000") or (B0_gen = "000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A0_gen) or IS_X(B0_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A0_gen(8) = '1' ) then
           A_i :=  TSCOMP(A0_gen);
         else 
           A_i := A0_gen;
         end if;
      else
         A_i := A0_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B0_gen(8)  = '1') then
           B_i := TSCOMP(B0_gen);
         else
           B_i := B0_gen;
         end if;
      else
         B_i := B0_gen;
      end if;

          IA := VEC2INT(A_i);
          IB := VEC2INT(B_i);

         O_zd := INT2VEC((IA * IB), 18);

         sign := (SIGNEDA_p1 and A0_gen(8)) xor (SIGNEDB_p1 and B0_gen(8));
         if (sign = '1' ) then
                O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p0_i <= O_ZD; 

  end process;

  VITALMultBehavior_p1_i : process(A1_gen, B1_gen, SIGNEDA_p1, SIGNEDB_p1)

    variable O_zd : std_logic_vector( 17 downto 0);
    variable IA, IB  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(8 downto 0);
    variable B_i : std_logic_vector(8 downto 0);

  begin -- process

    if ((A1_gen = "000000000") or (B1_gen = "000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A1_gen) or IS_X(B1_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A1_gen(8) = '1' ) then
           A_i :=  TSCOMP(A1_gen);
         else 
           A_i := A1_gen;
         end if;
      else
         A_i := A1_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B1_gen(8)  = '1') then
           B_i := TSCOMP(B1_gen);
         else
           B_i := B1_gen;
         end if;
      else
         B_i := B1_gen;
      end if;

          IA := VEC2INT(A_i);
          IB := VEC2INT(B_i);

         O_zd := INT2VEC((IA * IB), 18);

         sign := (SIGNEDA_p1 and A1_gen(8)) xor (SIGNEDB_p1 and B1_gen(8));
         if (sign = '1' ) then
                O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p1_i <= O_ZD; 

  end process;

  VITALMultBehavior_p2_i : process(A2_gen, B2_gen, SIGNEDA_p1, SIGNEDB_p1)

    variable O_zd : std_logic_vector( 17 downto 0);
    variable IA, IB  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(8 downto 0);
    variable B_i : std_logic_vector(8 downto 0);

  begin -- process

    if ((A2_gen = "000000000") or (B2_gen = "000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A2_gen) or IS_X(B2_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A2_gen(8) = '1' ) then
           A_i :=  TSCOMP(A2_gen);
         else 
           A_i := A2_gen;
         end if;
      else
         A_i := A2_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B2_gen(8)  = '1') then
           B_i := TSCOMP(B2_gen);
         else
           B_i := B2_gen;
         end if;
      else
         B_i := B2_gen;
      end if;

          IA := VEC2INT(A_i);
          IB := VEC2INT(B_i);

         O_zd := INT2VEC((IA * IB), 18);

         sign := (SIGNEDA_p1 and A2_gen(8)) xor (SIGNEDB_p1 and B2_gen(8));
         if (sign = '1' ) then
                O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p2_i <= O_ZD; 

  end process;

  VITALMultBehavior_p3_i : process(A3_gen, B3_gen, SIGNEDA_p1, SIGNEDB_p1)

    variable O_zd : std_logic_vector( 17 downto 0);
    variable IA, IB  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(8 downto 0);
    variable B_i : std_logic_vector(8 downto 0);

  begin -- process

    if ((A3_gen = "000000000") or (B3_gen = "000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A3_gen) or IS_X(B3_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A3_gen(8) = '1' ) then
           A_i :=  TSCOMP(A3_gen);
         else 
           A_i := A3_gen;
         end if;
      else
         A_i := A3_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B3_gen(8)  = '1') then
           B_i := TSCOMP(B3_gen);
         else
           B_i := B3_gen;
         end if;
      else
         B_i := B3_gen;
      end if;

          IA := VEC2INT(A_i);
          IB := VEC2INT(B_i);

         O_zd := INT2VEC((IA * IB), 18);

         sign := (SIGNEDA_p1 and A3_gen(8)) xor (SIGNEDB_p1 and B3_gen(8));
         if (sign = '1' ) then
                O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p3_i <= O_ZD; 

  end process;

  P0_i_e_process : process(p0_i_e_reg1, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       p0_i_e(17 downto 0 ) <= p0_i_e_reg1;
       p0_i_e(18) <= p0_i_e_reg1(17);
    else
       p0_i_e(17 downto 0 ) <= p0_i_e_reg1;
       p0_i_e(18) <= '0';
    end if;
  end process;

  P1_i_e_process : process(p1_i_e_reg1, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       p1_i_e(17 downto 0 ) <= p1_i_e_reg1;
       p1_i_e(18) <= p1_i_e_reg1(17);
    else
       p1_i_e(17 downto 0 ) <= p1_i_e_reg1;
       p1_i_e(18) <= '0';
    end if;
  end process;

  P2_i_e_process : process(p2_i_e_reg1, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       p2_i_e(17 downto 0 ) <= p2_i_e_reg1;
       p2_i_e(18) <= p2_i_e_reg1(17);
    else
       p2_i_e(17 downto 0 ) <= p2_i_e_reg1;
       p2_i_e(18) <= '0';
    end if;
  end process;

  P3_i_e_process : process(p3_i_e_reg1, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       p3_i_e(17 downto 0 ) <= p3_i_e_reg1;
       p3_i_e(18) <= p3_i_e_reg1(17);
    else
       p3_i_e(17 downto 0 ) <= p3_i_e_reg1;
       p3_i_e(18) <= '0';
    end if;
  end process;

  PipeLine0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE0_CLK = "CLK0") then
       pipeline0_clk <= CLK0_ipd;
     elsif (REG_PIPELINE0_CLK = "CLK1") then
       pipeline0_clk <= CLK1_ipd;
     elsif (REG_PIPELINE0_CLK = "CLK2") then
       pipeline0_clk <= CLK2_ipd;
     elsif (REG_PIPELINE0_CLK = "CLK3") then
       pipeline0_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE1_CLK = "CLK0") then
       pipeline1_clk <= CLK0_ipd;
     elsif (REG_PIPELINE1_CLK = "CLK1") then
       pipeline1_clk <= CLK1_ipd;
     elsif (REG_PIPELINE1_CLK = "CLK2") then
       pipeline1_clk <= CLK2_ipd;
     elsif (REG_PIPELINE1_CLK = "CLK3") then
       pipeline1_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine2_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE2_CLK = "CLK0") then
       pipeline2_clk <= CLK0_ipd;
     elsif (REG_PIPELINE2_CLK = "CLK1") then
       pipeline2_clk <= CLK1_ipd;
     elsif (REG_PIPELINE2_CLK = "CLK2") then
       pipeline2_clk <= CLK2_ipd;
     elsif (REG_PIPELINE2_CLK = "CLK3") then
       pipeline2_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine3_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE3_CLK = "CLK0") then
       pipeline3_clk <= CLK0_ipd;
     elsif (REG_PIPELINE3_CLK = "CLK1") then
       pipeline3_clk <= CLK1_ipd;
     elsif (REG_PIPELINE3_CLK = "CLK2") then
       pipeline3_clk <= CLK2_ipd;
     elsif (REG_PIPELINE3_CLK = "CLK3") then
       pipeline3_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE0_CE = "CE0") then
       pipeline0_ce <= CE0_ipd;
     elsif (REG_PIPELINE0_CE = "CE1") then
       pipeline0_ce <= CE1_ipd;
     elsif (REG_PIPELINE0_CE = "CE2") then
       pipeline0_ce <= CE2_ipd;
     elsif (REG_PIPELINE0_CE = "CE3") then
       pipeline0_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE1_CE = "CE0") then
       pipeline1_ce <= CE0_ipd;
     elsif (REG_PIPELINE1_CE = "CE1") then
       pipeline1_ce <= CE1_ipd;
     elsif (REG_PIPELINE1_CE = "CE2") then
       pipeline1_ce <= CE2_ipd;
     elsif (REG_PIPELINE1_CE = "CE3") then
       pipeline1_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine2_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE2_CE = "CE0") then
       pipeline2_ce <= CE0_ipd;
     elsif (REG_PIPELINE2_CE = "CE1") then
       pipeline2_ce <= CE1_ipd;
     elsif (REG_PIPELINE2_CE = "CE2") then
       pipeline2_ce <= CE2_ipd;
     elsif (REG_PIPELINE2_CE = "CE3") then
       pipeline2_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine3_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE3_CE = "CE0") then
       pipeline3_ce <= CE0_ipd;
     elsif (REG_PIPELINE3_CE = "CE1") then
       pipeline3_ce <= CE1_ipd;
     elsif (REG_PIPELINE3_CE = "CE2") then
       pipeline3_ce <= CE2_ipd;
     elsif (REG_PIPELINE3_CE = "CE3") then
       pipeline3_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE0_RST = "RST0") then
       pipeline0_rst <= RST0_ipd;
     elsif (REG_PIPELINE0_RST = "RST1") then
       pipeline0_rst <= RST1_ipd;
     elsif (REG_PIPELINE0_RST = "RST2") then
       pipeline0_rst <= RST2_ipd;
     elsif (REG_PIPELINE0_RST = "RST3") then
       pipeline0_rst <= RST3_ipd;
     end if;
  end process;

  PipeLine1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE1_RST = "RST0") then
       pipeline1_rst <= RST0_ipd;
     elsif (REG_PIPELINE1_RST = "RST1") then
       pipeline1_rst <= RST1_ipd;
     elsif (REG_PIPELINE1_RST = "RST2") then
       pipeline1_rst <= RST2_ipd;
     elsif (REG_PIPELINE1_RST = "RST3") then
       pipeline1_rst <= RST3_ipd;
     end if;
  end process;

  PipeLine2_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE2_RST = "RST0") then
       pipeline2_rst <= RST0_ipd;
     elsif (REG_PIPELINE2_RST = "RST1") then
       pipeline2_rst <= RST1_ipd;
     elsif (REG_PIPELINE2_RST = "RST2") then
       pipeline2_rst <= RST2_ipd;
     elsif (REG_PIPELINE2_RST = "RST3") then
       pipeline2_rst <= RST3_ipd;
     end if;
  end process;

  PipeLine3_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE3_RST = "RST0") then
       pipeline3_rst <= RST0_ipd;
     elsif (REG_PIPELINE3_RST = "RST1") then
       pipeline3_rst <= RST1_ipd;
     elsif (REG_PIPELINE3_RST = "RST2") then
       pipeline3_rst <= RST2_ipd;
     elsif (REG_PIPELINE3_RST = "RST3") then
       pipeline3_rst <= RST3_ipd;
     end if;
  end process;

  Pipeline_p0_i_e : process(pipeline0_clk, pipeline0_rst_ogsr, pipeline0_ce, p0_i)
  begin
     if (pipeline0_rst_ogsr = '1') then
       p0_i_e_reg <= (others => '0');
     elsif (rising_edge(pipeline0_clk)) then
       if (pipeline0_ce = '1') then
         p0_i_e_reg <= p0_i;
       end if;
     end if;
  end process;

  Select_p0_i_e_OR_p0_i_e_reg : process (p0_i, p0_i_e_reg)
  begin
     if (REG_PIPELINE0_CLK = "NONE") then
       p0_i_e_reg1 <= p0_i;
     else
       p0_i_e_reg1 <= p0_i_e_reg;
     end if;
  end process;

  Pipeline_p1_i_e : process(pipeline1_clk, pipeline1_rst_ogsr, pipeline1_ce, p1_i)
  begin
     if (pipeline1_rst_ogsr = '1') then
       p1_i_e_reg <= (others => '0');
     elsif (rising_edge(pipeline1_clk)) then
       if (pipeline1_ce = '1') then
         p1_i_e_reg <= p1_i;
       end if;
     end if;
  end process;

  Select_p1_i_e_OR_p1_i_e_reg : process (p1_i, p1_i_e_reg)
  begin
     if (REG_PIPELINE1_CLK = "NONE") then
       p1_i_e_reg1 <= p1_i;
     else
       p1_i_e_reg1 <= p1_i_e_reg;
     end if;
  end process;

  Pipeline_p2_i_e : process(pipeline2_clk, pipeline2_rst_ogsr, pipeline2_ce, p2_i)
  begin
     if (pipeline2_rst_ogsr = '1') then
       p2_i_e_reg <= (others => '0');
     elsif (rising_edge(pipeline2_clk)) then
       if (pipeline2_ce = '1') then
         p2_i_e_reg <= p2_i;
       end if;
     end if;
  end process;

  Select_p2_i_e_OR_p2_i_e_reg : process (p2_i, p2_i_e_reg)
  begin
     if (REG_PIPELINE2_CLK = "NONE") then
       p2_i_e_reg1 <= p2_i;
     else
       p2_i_e_reg1 <= p2_i_e_reg;
     end if;
  end process;

  Pipeline_p3_i_e : process(pipeline3_clk, pipeline3_rst_ogsr, pipeline3_ce, p3_i)
  begin
     if (pipeline3_rst_ogsr = '1') then
       p3_i_e_reg <= (others => '0');
     elsif (rising_edge(pipeline3_clk)) then
       if (pipeline3_ce = '1') then
         p3_i_e_reg <= p3_i;
       end if;
     end if;
  end process;

  Select_p3_i_e_OR_p3_i_e_reg : process (p3_i, p3_i_e_reg)
  begin
     if (REG_PIPELINE3_CLK = "NONE") then
       p3_i_e_reg1 <= p3_i;
     else
       p3_i_e_reg1 <= p3_i_e_reg;
     end if;
  end process;

  AddSub_process_sum0_i : process(p0_i_e, p1_i_e, addnsub1_p2)
  begin
    if (addnsub1_p2 = '1') then
      sum0_i <= ADDVECT(p0_i_e, p1_i_e);
    else
      sum0_i <= SUBVECT(p0_i_e, p1_i_e);
    end if;
  end process;

  AddSub_process_sum1_i : process(p2_i_e, p3_i_e, addnsub3_p2)
  begin
    if (addnsub3_p2 = '1') then
      sum1_i <= ADDVECT(p2_i_e, p3_i_e);
    else
      sum1_i <= SUBVECT(p2_i_e, p3_i_e);
    end if;
  end process;

  sum0_i_e_process : process(sum0_i, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       sum0_i_e(18 downto 0 ) <= sum0_i;
       sum0_i_e(19) <= sum0_i(18);
    else
       sum0_i_e(18 downto 0 ) <= sum0_i;
       sum0_i_e(19) <= '0';
    end if;
  end process;

  sum1_i_e_process : process(sum1_i, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       sum1_i_e(18 downto 0 ) <= sum1_i;
       sum1_i_e(19) <= sum1_i(18);
    else
       sum1_i_e(18 downto 0 ) <= sum1_i;
       sum1_i_e(19) <= '0';
    end if;
  end process;

  Sumt_process : process(sum0_i_e, sum1_i_e)
  begin
     sumt_sig <= ADDVECT(sum0_i_e, sum1_i_e);
  end process;

  Output_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_OUTPUT_CLK = "CLK0") then
       output_clk <= CLK0_ipd;
     elsif (REG_OUTPUT_CLK = "CLK1") then
       output_clk <= CLK1_ipd;
     elsif (REG_OUTPUT_CLK = "CLK2") then
       output_clk <= CLK2_ipd;
     elsif (REG_OUTPUT_CLK = "CLK3") then
       output_clk <= CLK3_ipd;
     end if;
  end process;

  Output_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_OUTPUT_CE = "CE0") then
       output_ce <= CE0_ipd;
     elsif (REG_OUTPUT_CE = "CE1") then
       output_ce <= CE1_ipd;
     elsif (REG_OUTPUT_CE = "CE2") then
       output_ce <= CE2_ipd;
     elsif (REG_OUTPUT_CE = "CE3") then
       output_ce <= CE3_ipd;
     end if;
  end process;

  Output_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_OUTPUT_RST = "RST0") then
       output_rst <= RST0_ipd;
     elsif (REG_OUTPUT_RST = "RST1") then
       output_rst <= RST1_ipd;
     elsif (REG_OUTPUT_RST = "RST2") then
       output_rst <= RST2_ipd;
     elsif (REG_OUTPUT_RST = "RST3") then
       output_rst <= RST3_ipd;
     end if;
  end process;

  Output_Register : process(output_clk, output_rst_ogsr, output_ce, sumt_sig)
  begin
     if (output_rst_ogsr = '1') then
       sumt_reg <= (others => '0');
     elsif (rising_edge(output_clk)) then
       if (output_ce = '1') then
         sumt_reg <= sumt_sig;
       end if;
     end if;
  end process;

  Select_OUTREG_OR_NOREG : process (sumt_sig, sumt_reg)
  begin
     if (REG_OUTPUT_CLK = "NONE") then
       SUM_ipd <= sumt_sig;
     else
       SUM_ipd <= sumt_reg;
     end if;
  end process;

end V;

configuration CFG_MULT9X9ADDSUBSUMB_V of MULT9X9ADDSUBSUMB is
   for V
   end for;
end CFG_MULT9X9ADDSUBSUMB_V;
----- CELL MULT18X18B -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use work.components.all;
use work.global.gsrnet;
use work.global.purnet;

-- entity declaration --
entity MULT18X18B is
  generic(
	 REG_INPUTA_CLK       : string     := "NONE";
	 REG_INPUTA_CE        : string     := "CE0";
	 REG_INPUTA_RST       : string     := "RST0";
	 REG_INPUTB_CLK       : string     := "NONE";
	 REG_INPUTB_CE        : string     := "CE0";
	 REG_INPUTB_RST       : string     := "RST0";
	 REG_PIPELINE_CLK     : string     := "NONE";
	 REG_PIPELINE_CE      : string     := "CE0";
	 REG_PIPELINE_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDA_CLK   : string     := "NONE";
	 REG_SIGNEDA_CE    : string     := "CE0";
	 REG_SIGNEDA_RST   : string     := "RST0";
         REG_SIGNEDB_CLK   : string     := "NONE";
         REG_SIGNEDB_CE    : string     := "CE0";
         REG_SIGNEDB_RST   : string     := "RST0";
	 GSR                  : string     := "ENABLED");
  port (
        A0 : in STD_ULOGIC;
        A1 : in STD_ULOGIC;
        A2 : in STD_ULOGIC;
        A3 : in STD_ULOGIC;
        A4 : in STD_ULOGIC;
        A5 : in STD_ULOGIC;
        A6 : in STD_ULOGIC;
        A7 : in STD_ULOGIC;
        A8 : in STD_ULOGIC;
        A9 : in STD_ULOGIC;
        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;
        SRIA9 : in STD_ULOGIC;
        SRIA10 : in STD_ULOGIC;
        SRIA11 : in STD_ULOGIC;
        SRIA12 : in STD_ULOGIC;
        SRIA13 : in STD_ULOGIC;
        SRIA14 : in STD_ULOGIC;
        SRIA15 : in STD_ULOGIC;
        SRIA16 : in STD_ULOGIC;
        SRIA17 : in STD_ULOGIC;

        B0 : in STD_ULOGIC;
        B1 : in STD_ULOGIC;
        B2 : in STD_ULOGIC;
        B3 : in STD_ULOGIC;
        B4 : in STD_ULOGIC;
        B5 : in STD_ULOGIC;
        B6 : in STD_ULOGIC;
        B7 : in STD_ULOGIC;
        B8 : in STD_ULOGIC;
        B9 : in STD_ULOGIC;
        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;
        SRIB9 : in STD_ULOGIC;
        SRIB10 : in STD_ULOGIC;
        SRIB11 : in STD_ULOGIC;
        SRIB12 : in STD_ULOGIC;
        SRIB13 : in STD_ULOGIC;
        SRIB14 : in STD_ULOGIC;
        SRIB15 : in STD_ULOGIC;
        SRIB16 : in STD_ULOGIC;
        SRIB17 : in STD_ULOGIC;

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        SOURCEA : in STD_ULOGIC;
        SOURCEB : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;
        SROA9 : out STD_ULOGIC;
        SROA10 : out STD_ULOGIC;
        SROA11 : out STD_ULOGIC;
        SROA12 : out STD_ULOGIC;
        SROA13 : out STD_ULOGIC;
        SROA14 : out STD_ULOGIC;
        SROA15 : out STD_ULOGIC;
        SROA16 : out STD_ULOGIC;
        SROA17 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;
        SROB9 : out STD_ULOGIC;
        SROB10 : out STD_ULOGIC;
        SROB11 : out STD_ULOGIC;
        SROB12 : out STD_ULOGIC;
        SROB13 : out STD_ULOGIC;
        SROB14 : out STD_ULOGIC;
        SROB15 : out STD_ULOGIC;
        SROB16 : out STD_ULOGIC;
        SROB17 : out STD_ULOGIC;

        P0 : out STD_ULOGIC;
        P1 : out STD_ULOGIC;
        P2 : out STD_ULOGIC;
        P3 : out STD_ULOGIC;
        P4 : out STD_ULOGIC;
        P5 : out STD_ULOGIC;
        P6 : out STD_ULOGIC;
        P7 : out STD_ULOGIC;
        P8 : out STD_ULOGIC;
        P9 : out STD_ULOGIC;
        P10 : out STD_ULOGIC;
        P11 : out STD_ULOGIC;
        P12 : out STD_ULOGIC;
        P13 : out STD_ULOGIC;
        P14 : out STD_ULOGIC;
        P15 : out STD_ULOGIC;
        P16 : out STD_ULOGIC;
        P17 : out STD_ULOGIC;
        P18 : out STD_ULOGIC;
        P19 : out STD_ULOGIC;
        P20 : out STD_ULOGIC;
        P21 : out STD_ULOGIC;
        P22 : out STD_ULOGIC;
        P23 : out STD_ULOGIC;
        P24 : out STD_ULOGIC;
        P25 : out STD_ULOGIC;
        P26 : out STD_ULOGIC;
        P27 : out STD_ULOGIC;
        P28 : out STD_ULOGIC;
        P29 : out STD_ULOGIC;
        P30 : out STD_ULOGIC;
        P31 : out STD_ULOGIC;
        P32 : out STD_ULOGIC;
        P33 : out STD_ULOGIC;
        P34 : out STD_ULOGIC;
        P35 : out STD_ULOGIC
       ); 

attribute VITAL_LEVEL0 of MULT18X18B : entity is TRUE;

end MULT18X18B;

--- Architecture 

library IEEE;
use IEEE.VITAL_Primitives.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
architecture V of MULT18X18B is

  attribute VITAL_LEVEL0 of V : architecture is TRUE;

  -- Local signals used to propagate input wire delay

  signal A_ipd, A_ipd1       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SRIA_ipd, SRIA_ipd1 : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROA_reg  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B_ipd, B_ipd1       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SRIB_ipd, SRIB_ipd1 : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROB_reg  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P_ipd     : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal SIGNEDA_ipd, SIGNEDA_ipd1 : std_logic := 'X';
  signal SIGNEDB_ipd, SIGNEDB_ipd1 : std_logic := 'X';
  signal SOURCEA_ipd, SOURCEA_ipd1 : std_logic := 'X';
  signal SOURCEB_ipd, SOURCEB_ipd1 : std_logic := 'X';
  signal CE0_ipd   : std_logic := 'X';
  signal CE1_ipd   : std_logic := 'X';
  signal CE2_ipd   : std_logic := 'X';
  signal CE3_ipd   : std_logic := 'X';
  signal CLK0_ipd  : std_logic := 'X';
  signal CLK1_ipd  : std_logic := 'X';
  signal CLK2_ipd  : std_logic := 'X';
  signal CLK3_ipd  : std_logic := 'X';
  signal RST0_ipd  : std_logic := 'X';
  signal RST1_ipd  : std_logic := 'X';
  signal RST2_ipd  : std_logic := 'X';
  signal RST3_ipd  : std_logic := 'X';

  signal A_reg     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B_reg     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A_p       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B_p       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A_gen     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B_gen     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P_i       : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_o       : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_ps      : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_o1      : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";

  signal input_a_clk  : std_logic := 'X';
  signal input_a_ce   : std_logic := 'X';
  signal input_a_rst  : std_logic := 'X';
  signal input_b_clk  : std_logic := 'X';
  signal input_b_ce   : std_logic := 'X';
  signal input_b_rst  : std_logic := 'X';
  signal pipeline_clk : std_logic := 'X';
  signal pipeline_ce  : std_logic := 'X';
  signal pipeline_rst : std_logic := 'X';
  signal output_clk   : std_logic := 'X';
  signal output_ce    : std_logic := 'X';
  signal output_rst   : std_logic := 'X';
  signal signeda_0_clk : std_logic := 'X';
  signal signeda_0_ce  : std_logic := 'X';
  signal signeda_0_rst  : std_logic := 'X';
  signal signeda_0_reg  : std_logic := 'X';
  signal signeda_p1  : std_logic := 'X';
  signal signedb_0_clk : std_logic := 'X';
  signal signedb_0_ce  : std_logic := 'X';
  signal signedb_0_rst  : std_logic := 'X';
  signal signedb_0_reg  : std_logic := 'X';
  signal signedb_p1  : std_logic := 'X';

  signal SRN          : std_logic;
  signal input_a_rst_ogsr  : std_logic := 'X';
  signal input_b_rst_ogsr  : std_logic := 'X';
  signal pipeline_rst_ogsr  : std_logic := 'X';
  signal output_rst_ogsr  : std_logic := 'X';
  signal signeda_0_rst_ogsr  : std_logic := 'X';
  signal signedb_0_rst_ogsr  : std_logic := 'X';

begin 

    global_reset : process (purnet, gsrnet)
      begin
        if (GSR =  "DISABLED") then
           SRN <= purnet;
        else
           SRN <= purnet AND gsrnet;
        end if;
      end process;

    input_a_rst_ogsr <= input_a_rst or not SRN;
    input_b_rst_ogsr <= input_b_rst or not SRN;
    pipeline_rst_ogsr <= pipeline_rst or not SRN;
    output_rst_ogsr <= output_rst or not SRN;
    signeda_0_rst_ogsr <= signeda_0_rst or not SRN;
    signedb_0_rst_ogsr <= signedb_0_rst or not SRN;

    A_ipd1 <= (A17 & A16 & A15 & A14 & A13 & A12 & A11 & A10 & A9 & A8 & A7 & A6 & A5 & A4 & A3 & A2 & A1 & A0);
    B_ipd1 <= (B17 & B16 & B15 & B14 & B13 & B12 & B11 & B10 & B9 & B8 & B7 & B6 & B5 & B4 & B3 & B2 & B1 & B0);
    SRIA_ipd1 <= (SRIA17 & SRIA16 & SRIA15 & SRIA14 & SRIA13 & SRIA12 & SRIA11 & SRIA10 & SRIA9 & SRIA8 & SRIA7 & SRIA6 & SRIA5 & SRIA4 & SRIA3 & SRIA2 & SRIA1 & SRIA0);
    SRIB_ipd1 <= (SRIB17 & SRIB16 & SRIB15 & SRIB14 & SRIB13 & SRIB12 & SRIB11 & SRIB10 & SRIB9 & SRIB8 & SRIB7 & SRIB6 & SRIB5 & SRIB4 & SRIB3 & SRIB2 & SRIB1 & SRIB0);
    SIGNEDA_ipd1 <= SIGNEDA;
    SIGNEDB_ipd1 <= SIGNEDB;
    SOURCEA_ipd1 <= SOURCEA;
    SOURCEB_ipd1 <= SOURCEB;

    A_ipd <= A_ipd1;
    B_ipd <= B_ipd1;
    SRIA_ipd <= SRIA_ipd1;
    SRIB_ipd <= SRIB_ipd1;
    SIGNEDA_ipd <= SIGNEDA_ipd1;
    SIGNEDB_ipd <= SIGNEDB_ipd1;
    SOURCEA_ipd <= SOURCEA_ipd1;
    SOURCEB_ipd <= SOURCEB_ipd1;

    CE0_ipd <= CE0;
    CE1_ipd <= CE1;
    CE2_ipd <= CE2;
    CE3_ipd <= CE3;
    CLK0_ipd <= CLK0;
    CLK1_ipd <= CLK1;
    CLK2_ipd <= CLK2;
    CLK3_ipd <= CLK3;
    RST0_ipd <= RST0;
    RST1_ipd <= RST1;
    RST2_ipd <= RST2;
    RST3_ipd <= RST3;

    SROA0 <= SROA_reg(0);
    SROA1 <= SROA_reg(1);
    SROA2 <= SROA_reg(2);
    SROA3 <= SROA_reg(3);
    SROA4 <= SROA_reg(4);
    SROA5 <= SROA_reg(5);
    SROA6 <= SROA_reg(6);
    SROA7 <= SROA_reg(7);
    SROA8 <= SROA_reg(8);
    SROA9 <= SROA_reg(9);
    SROA10 <= SROA_reg(10);
    SROA11 <= SROA_reg(11);
    SROA12 <= SROA_reg(12);
    SROA13 <= SROA_reg(13);
    SROA14 <= SROA_reg(14);
    SROA15 <= SROA_reg(15);
    SROA16 <= SROA_reg(16);
    SROA17 <= SROA_reg(17);

    SROB0 <= SROB_reg(0);
    SROB1 <= SROB_reg(1);
    SROB2 <= SROB_reg(2);
    SROB3 <= SROB_reg(3);
    SROB4 <= SROB_reg(4);
    SROB5 <= SROB_reg(5);
    SROB6 <= SROB_reg(6);
    SROB7 <= SROB_reg(7);
    SROB8 <= SROB_reg(8);
    SROB9 <= SROB_reg(9);
    SROB10 <= SROB_reg(10);
    SROB11 <= SROB_reg(11);
    SROB12 <= SROB_reg(12);
    SROB13 <= SROB_reg(13);
    SROB14 <= SROB_reg(14);
    SROB15 <= SROB_reg(15);
    SROB16 <= SROB_reg(16);
    SROB17 <= SROB_reg(17);

    P0 <= P_ipd(0);
    P1 <= P_ipd(1);
    P2 <= P_ipd(2);
    P3 <= P_ipd(3);
    P4 <= P_ipd(4);
    P5 <= P_ipd(5);
    P6 <= P_ipd(6);
    P7 <= P_ipd(7);
    P8 <= P_ipd(8);
    P9 <= P_ipd(9);
    P10 <= P_ipd(10);
    P11 <= P_ipd(11);
    P12 <= P_ipd(12);
    P13 <= P_ipd(13);
    P14 <= P_ipd(14);
    P15 <= P_ipd(15);
    P16 <= P_ipd(16);
    P17 <= P_ipd(17);
    P18 <= P_ipd(18);
    P19 <= P_ipd(19);
    P20 <= P_ipd(20);
    P21 <= P_ipd(21);
    P22 <= P_ipd(22);
    P23 <= P_ipd(23);
    P24 <= P_ipd(24);
    P25 <= P_ipd(25);
    P26 <= P_ipd(26);
    P27 <= P_ipd(27);
    P28 <= P_ipd(28);
    P29 <= P_ipd(29);
    P30 <= P_ipd(30);
    P31 <= P_ipd(31);
    P32 <= P_ipd(32);
    P33 <= P_ipd(33);
    P34 <= P_ipd(34);
    P35 <= P_ipd(35);


  Input_A_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA_CLK = "CLK0") then
       input_a_clk <= CLK0_ipd;
     elsif (REG_INPUTA_CLK = "CLK1") then
       input_a_clk <= CLK1_ipd;
     elsif (REG_INPUTA_CLK = "CLK2") then
       input_a_clk <= CLK2_ipd;
     elsif (REG_INPUTA_CLK = "CLK3") then
       input_a_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA_CE = "CE0") then
       input_a_ce <= CE0_ipd;
     elsif (REG_INPUTA_CE = "CE1") then
       input_a_ce <= CE1_ipd;
     elsif (REG_INPUTA_CE = "CE2") then
       input_a_ce <= CE2_ipd;
     elsif (REG_INPUTA_CE = "CE3") then
       input_a_ce <= CE3_ipd;
     end if;
  end process;

  Input_A_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA_RST = "RST0") then
       input_a_rst <= RST0_ipd;
     elsif (REG_INPUTA_RST = "RST1") then
       input_a_rst <= RST1_ipd;
     elsif (REG_INPUTA_RST = "RST2") then
       input_a_rst <= RST2_ipd;
     elsif (REG_INPUTA_RST = "RST3") then
       input_a_rst <= RST3_ipd;
     end if;
  end process;
      
  Register_A_Input : process(input_a_clk, input_a_rst_ogsr, input_a_ce)
  begin
     if (input_a_rst_ogsr = '1') then
       A_reg <= (others => '0');
     elsif (rising_edge(input_a_clk)) then
       if (input_a_ce = '1') then
         A_reg <= A_p;
       end if;
     end if;
  end process;

  Select_A_OR_A_reg : process (A_p, A_reg)
  begin
     if (REG_INPUTA_CLK = "NONE") then
       A_gen <= A_p;
     else
       A_gen <= A_reg;
     end if;
  end process;

  SROA_reg <= A_gen;

  Select_A_p_OR_SRIA_ipd : process(A_ipd, SRIA_ipd, SOURCEA_ipd)
  begin
     if (SOURCEA_ipd = '1') then
       A_p <= SRIA_ipd;
     elsif (SOURCEA_ipd = '0') then 
       A_p <= A_ipd;
     end if;
  end process;    

  Input_B_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB_CLK = "CLK0") then
       input_b_clk <= CLK0_ipd;
     elsif (REG_INPUTB_CLK = "CLK1") then
       input_b_clk <= CLK1_ipd;
     elsif (REG_INPUTB_CLK = "CLK2") then
       input_b_clk <= CLK2_ipd;
     elsif (REG_INPUTB_CLK = "CLK3") then
       input_b_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB_CE = "CE0") then
       input_b_ce <= CE0_ipd;
     elsif (REG_INPUTB_CE = "CE1") then
       input_b_ce <= CE1_ipd;
     elsif (REG_INPUTB_CE = "CE2") then
       input_b_ce <= CE2_ipd;
     elsif (REG_INPUTB_CE = "CE3") then
       input_b_ce <= CE3_ipd;
     end if;
  end process;

  Input_B_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB_RST = "RST0") then
       input_b_rst <= RST0_ipd;
     elsif (REG_INPUTB_RST = "RST1") then
       input_b_rst <= RST1_ipd;
     elsif (REG_INPUTB_RST = "RST2") then
       input_b_rst <= RST2_ipd;
     elsif (REG_INPUTB_RST = "RST3") then
       input_b_rst <= RST3_ipd;
     end if;
  end process;

  Register_B_Input : process(input_b_clk, input_b_rst_ogsr, input_b_ce)
  begin
     if (input_b_rst_ogsr = '1') then
       B_reg <= (others => '0');
     elsif (rising_edge(input_b_clk)) then
       if (input_b_ce = '1') then
         B_reg <= B_p;
       end if;
     end if;
  end process;

  Select_B_OR_B_reg : process (B_p, B_reg)
  begin
     if (REG_INPUTB_CLK = "NONE") then
       B_gen <= B_p;
     else
       B_gen <= B_reg;
     end if;
  end process;    

  SROB_reg <= B_gen;
    
  Select_B_p_OR_SRIB_ipd : process(B_ipd, SRIB_ipd, SOURCEB_ipd)
  begin
     if (SOURCEB_ipd = '1') then
       B_p <= SRIB_ipd;
     elsif (SOURCEB_ipd = '0') then 
       B_p <= B_ipd;
     end if;
  end process;   


  SIGNEDAB_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_CLK = "CLK0") then
       signeda_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_CLK = "CLK1") then
       signeda_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_CLK = "CLK2") then
       signeda_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_CLK = "CLK3") then
       signeda_0_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_CLK = "CLK0") then
       signedb_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_CLK = "CLK1") then
       signedb_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_CLK = "CLK2") then
       signedb_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_CLK = "CLK3") then
       signedb_0_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_CE = "CE0") then
       signeda_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_CE = "CE1") then
       signeda_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_CE = "CE2") then
       signeda_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_CE = "CE3") then
       signeda_0_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_CE = "CE0") then
       signedb_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_CE = "CE1") then
       signedb_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_CE = "CE2") then
       signedb_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_CE = "CE3") then
       signedb_0_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_RST = "RST0") then
       signeda_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_RST = "RST1") then
       signeda_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_RST = "RST2") then
       signeda_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_RST = "RST3") then
       signeda_0_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_RST = "RST0") then
       signedb_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_RST = "RST1") then
       signedb_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_RST = "RST2") then
       signedb_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_RST = "RST3") then
       signedb_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_SIGNEDA : process(signeda_0_clk, signeda_0_rst_ogsr, signeda_0_ce, SIGNEDA_ipd)
  begin
     if (signeda_0_rst_ogsr = '1') then
       signeda_0_reg <= '0';
     elsif (rising_edge(signeda_0_clk)) then
       if (signeda_0_ce = '1') then
         signeda_0_reg <= SIGNEDA_ipd;
       end if;
     end if;
  end process;

  Register_0_SIGNEDB : process(signedb_0_clk, signedb_0_rst_ogsr, signedb_0_ce, SIGNEDB_ipd)
  begin
     if (signedb_0_rst_ogsr = '1') then
       signedb_0_reg <= '0';
     elsif (rising_edge(signedb_0_clk)) then
       if (signedb_0_ce = '1') then
         signedb_0_reg <= SIGNEDB_ipd;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_0_reg : process (SIGNEDA_ipd, signeda_0_reg)
  begin
     if (REG_SIGNEDA_CLK = "NONE") then
       signeda_p1 <= SIGNEDA_ipd;
     else
       signeda_p1 <= signeda_0_reg;
     end if;
  end process; 

  Select_SIGNEDB_ipd_OR_SIGNEDB_0_reg : process (SIGNEDB_ipd, signedb_0_reg)
  begin
     if (REG_SIGNEDB_CLK = "NONE") then
       signedb_p1 <= SIGNEDB_ipd;
     else
       signedb_p1 <= signedb_0_reg;
     end if;
  end process;

  VITALMultBehavior : process(A_gen, B_gen, signeda_p1, signedb_p1)

    variable O_zd, OT1_zd, OT2_zd : std_logic_vector( 35 downto 0);
    variable IA,IBL,IBU  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(17 downto 0);
    variable B_i : std_logic_vector(17 downto 0);

  begin -- process

    if ((A_gen = "000000000000000000") or (B_gen = "000000000000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A_gen) or IS_X(B_gen) ) then
            O_zd := (others => 'X');
    else
	if ((signeda_p1 = '1') and (A_gen(17) = '1' )) then
	    A_i :=  TSCOMP(A_gen);
	else 
           A_i := A_gen;
	end if;

	if ((signedb_p1 = '1') and (B_gen(17)  = '1')) then
	    B_i := TSCOMP(B_gen);
	else
	    B_i := B_gen;
	end if;

         IA  := VEC2INT(A_i);
         IBU := VEC2INT(B_i (17 downto 9));
         IBL := VEC2INT(B_i (8 downto 0));

         OT1_zd := INT2VEC((IA * IBU), 36);
         for idex in 0 to 8 loop
             OT1_zd(35 downto 0) := OT1_zd(34 downto 0) & '0';
         end loop;
 
         OT2_zd := INT2VEC((IA * IBL), 36);
         O_zd   := ADDVECT(OT1_zd,OT2_zd);

         sign := (signeda_p1 and A_gen(17)) xor (signedb_p1 and B_gen(17));
         if (sign = '1' ) then
              O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p_i <= O_ZD; 

  end process;


  PipeLine_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE_CLK = "CLK0") then
       pipeline_clk <= CLK0_ipd;
     elsif (REG_PIPELINE_CLK = "CLK1") then
       pipeline_clk <= CLK1_ipd;
     elsif (REG_PIPELINE_CLK = "CLK2") then
       pipeline_clk <= CLK2_ipd;
     elsif (REG_PIPELINE_CLK = "CLK3") then
       pipeline_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE_CE = "CE0") then
       pipeline_ce <= CE0_ipd;
     elsif (REG_PIPELINE_CE = "CE1") then
       pipeline_ce <= CE1_ipd;
     elsif (REG_PIPELINE_CE = "CE2") then
       pipeline_ce <= CE2_ipd;
     elsif (REG_PIPELINE_CE = "CE3") then
       pipeline_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE_RST = "RST0") then
       pipeline_rst <= RST0_ipd;
     elsif (REG_PIPELINE_RST = "RST1") then
       pipeline_rst <= RST1_ipd;
     elsif (REG_PIPELINE_RST = "RST2") then
       pipeline_rst <= RST2_ipd;
     elsif (REG_PIPELINE_RST = "RST3") then
       pipeline_rst <= RST3_ipd;
     end if;
  end process;

  Pipeline_p_i : process(pipeline_clk, pipeline_rst_ogsr, pipeline_ce, p_i)
  begin
     if (pipeline_rst_ogsr = '1') then
       p_o <= (others => '0');
     elsif (rising_edge(pipeline_clk)) then
       if (pipeline_ce = '1') then
         p_o <= p_i;
       end if;
     end if;
  end process;

  Select_NOPIPELINE_OR_PIPELINE : process (p_i, p_o)
  begin
     if (REG_PIPELINE_CLK = "NONE") then
       p_ps <= p_i;
     else
       p_ps <= p_o;
     end if;
  end process;

  Output_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_OUTPUT_CLK = "CLK0") then
       output_clk <= CLK0_ipd;
     elsif (REG_OUTPUT_CLK = "CLK1") then
       output_clk <= CLK1_ipd;
     elsif (REG_OUTPUT_CLK = "CLK2") then
       output_clk <= CLK2_ipd;
     elsif (REG_OUTPUT_CLK = "CLK3") then
       output_clk <= CLK3_ipd;
     end if;
  end process;

  Output_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_OUTPUT_CE = "CE0") then
       output_ce <= CE0_ipd;
     elsif (REG_OUTPUT_CE = "CE1") then
       output_ce <= CE1_ipd;
     elsif (REG_OUTPUT_CE = "CE2") then
       output_ce <= CE2_ipd;
     elsif (REG_OUTPUT_CE = "CE3") then
       output_ce <= CE3_ipd;
     end if;
  end process;

  Output_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_OUTPUT_RST = "RST0") then
       output_rst <= RST0_ipd;
     elsif (REG_OUTPUT_RST = "RST1") then
       output_rst <= RST1_ipd;
     elsif (REG_OUTPUT_RST = "RST2") then
       output_rst <= RST2_ipd;
     elsif (REG_OUTPUT_RST = "RST3") then
       output_rst <= RST3_ipd;
     end if;
  end process;

  Output_Register : process(output_clk, output_rst_ogsr, output_ce, p_ps)
  begin
     if (output_rst_ogsr = '1') then
       p_o1 <= (others => '0');
     elsif (rising_edge(output_clk)) then
       if (output_ce = '1') then
         p_o1 <= p_ps;
       end if;
     end if;
  end process;

  Select_OUTREG_OR_NOREG : process (p_ps, p_o1)
  begin
     if (REG_OUTPUT_CLK = "NONE") then
       P_ipd <= p_ps;
     else
       P_ipd <= p_o1;
     end if;
  end process;

end V;

configuration CFG_MULT18X18B_V of MULT18X18B is
   for V
   end for;
end CFG_MULT18X18B_V;
----- CELL MULT18X18ADDSUBB -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use work.components.all;
use work.global.gsrnet;
use work.global.purnet;

-- entity declaration --
entity MULT18X18ADDSUBB is
  generic(
	 REG_INPUTA0_CLK       : string     := "NONE";
	 REG_INPUTA0_CE        : string     := "CE0";
	 REG_INPUTA0_RST       : string     := "RST0";
	 REG_INPUTA1_CLK       : string     := "NONE";
	 REG_INPUTA1_CE        : string     := "CE0";
	 REG_INPUTA1_RST       : string     := "RST0";
	 REG_INPUTB0_CLK       : string     := "NONE";
	 REG_INPUTB0_CE        : string     := "CE0";
	 REG_INPUTB0_RST       : string     := "RST0";
	 REG_INPUTB1_CLK       : string     := "NONE";
	 REG_INPUTB1_CE        : string     := "CE0";
	 REG_INPUTB1_RST       : string     := "RST0";
	 REG_PIPELINE0_CLK     : string     := "NONE";
	 REG_PIPELINE0_CE      : string     := "CE0";
	 REG_PIPELINE0_RST     : string     := "RST0";
	 REG_PIPELINE1_CLK     : string     := "NONE";
	 REG_PIPELINE1_CE      : string     := "CE0";
	 REG_PIPELINE1_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDA_0_CLK   : string     := "NONE";
	 REG_SIGNEDA_0_CE    : string     := "CE0";
	 REG_SIGNEDA_0_RST   : string     := "RST0";
	 REG_SIGNEDA_1_CLK   : string     := "NONE";
	 REG_SIGNEDA_1_CE    : string     := "CE0";
	 REG_SIGNEDA_1_RST   : string     := "RST0";
         REG_SIGNEDB_0_CLK   : string     := "NONE";
         REG_SIGNEDB_0_CE    : string     := "CE0";
         REG_SIGNEDB_0_RST   : string     := "RST0";
         REG_SIGNEDB_1_CLK   : string     := "NONE";
         REG_SIGNEDB_1_CE    : string     := "CE0";
         REG_SIGNEDB_1_RST   : string     := "RST0";
	 REG_ADDNSUB_0_CLK    : string     := "NONE";
	 REG_ADDNSUB_0_CE     : string     := "CE0";
	 REG_ADDNSUB_0_RST    : string     := "RST0";
	 REG_ADDNSUB_1_CLK    : string     := "NONE";
	 REG_ADDNSUB_1_CE     : string     := "CE0";
	 REG_ADDNSUB_1_RST    : string     := "RST0";
	 GSR                  : string     := "ENABLED");
  port (
        A00 : in STD_ULOGIC;
        A01 : in STD_ULOGIC;
        A02 : in STD_ULOGIC;
        A03 : in STD_ULOGIC;
        A04 : in STD_ULOGIC;
        A05 : in STD_ULOGIC;
        A06 : in STD_ULOGIC;
        A07 : in STD_ULOGIC;
        A08 : in STD_ULOGIC;
        A09 : in STD_ULOGIC;
        A010 : in STD_ULOGIC;
        A011 : in STD_ULOGIC;
        A012 : in STD_ULOGIC;
        A013 : in STD_ULOGIC;
        A014 : in STD_ULOGIC;
        A015 : in STD_ULOGIC;
        A016 : in STD_ULOGIC;
        A017 : in STD_ULOGIC;

        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;
        A18 : in STD_ULOGIC;
        A19 : in STD_ULOGIC;
        A110 : in STD_ULOGIC;
        A111 : in STD_ULOGIC;
        A112 : in STD_ULOGIC;
        A113 : in STD_ULOGIC;
        A114 : in STD_ULOGIC;
        A115 : in STD_ULOGIC;
        A116 : in STD_ULOGIC;
        A117 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;
        SRIA9 : in STD_ULOGIC;
        SRIA10 : in STD_ULOGIC;
        SRIA11 : in STD_ULOGIC;
        SRIA12 : in STD_ULOGIC;
        SRIA13 : in STD_ULOGIC;
        SRIA14 : in STD_ULOGIC;
        SRIA15 : in STD_ULOGIC;
        SRIA16 : in STD_ULOGIC;
        SRIA17 : in STD_ULOGIC;

        B00 : in STD_ULOGIC;
        B01 : in STD_ULOGIC;
        B02 : in STD_ULOGIC;
        B03 : in STD_ULOGIC;
        B04 : in STD_ULOGIC;
        B05 : in STD_ULOGIC;
        B06 : in STD_ULOGIC;
        B07 : in STD_ULOGIC;
        B08 : in STD_ULOGIC;
        B09 : in STD_ULOGIC;
        B010 : in STD_ULOGIC;
        B011 : in STD_ULOGIC;
        B012 : in STD_ULOGIC;
        B013 : in STD_ULOGIC;
        B014 : in STD_ULOGIC;
        B015 : in STD_ULOGIC;
        B016 : in STD_ULOGIC;
        B017 : in STD_ULOGIC;

        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;
        B18 : in STD_ULOGIC;
        B19 : in STD_ULOGIC;
        B110 : in STD_ULOGIC;
        B111 : in STD_ULOGIC;
        B112 : in STD_ULOGIC;
        B113 : in STD_ULOGIC;
        B114 : in STD_ULOGIC;
        B115 : in STD_ULOGIC;
        B116 : in STD_ULOGIC;
        B117 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;
        SRIB9 : in STD_ULOGIC;
        SRIB10 : in STD_ULOGIC;
        SRIB11 : in STD_ULOGIC;
        SRIB12 : in STD_ULOGIC;
        SRIB13 : in STD_ULOGIC;
        SRIB14 : in STD_ULOGIC;
        SRIB15 : in STD_ULOGIC;
        SRIB16 : in STD_ULOGIC;
        SRIB17 : in STD_ULOGIC;

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        SOURCEA0 : in STD_ULOGIC;
        SOURCEA1 : in STD_ULOGIC;
        SOURCEB0 : in STD_ULOGIC;
        SOURCEB1 : in STD_ULOGIC;
        ADDNSUB  : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;
        SROA9 : out STD_ULOGIC;
        SROA10 : out STD_ULOGIC;
        SROA11 : out STD_ULOGIC;
        SROA12 : out STD_ULOGIC;
        SROA13 : out STD_ULOGIC;
        SROA14 : out STD_ULOGIC;
        SROA15 : out STD_ULOGIC;
        SROA16 : out STD_ULOGIC;
        SROA17 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;
        SROB9 : out STD_ULOGIC;
        SROB10 : out STD_ULOGIC;
        SROB11 : out STD_ULOGIC;
        SROB12 : out STD_ULOGIC;
        SROB13 : out STD_ULOGIC;
        SROB14 : out STD_ULOGIC;
        SROB15 : out STD_ULOGIC;
        SROB16 : out STD_ULOGIC;
        SROB17 : out STD_ULOGIC;

        SUM0 : out STD_ULOGIC;
        SUM1 : out STD_ULOGIC;
        SUM2 : out STD_ULOGIC;
        SUM3 : out STD_ULOGIC;
        SUM4 : out STD_ULOGIC;
        SUM5 : out STD_ULOGIC;
        SUM6 : out STD_ULOGIC;
        SUM7 : out STD_ULOGIC;
        SUM8 : out STD_ULOGIC;
        SUM9 : out STD_ULOGIC;
        SUM10 : out STD_ULOGIC;
        SUM11 : out STD_ULOGIC;
        SUM12 : out STD_ULOGIC;
        SUM13 : out STD_ULOGIC;
        SUM14 : out STD_ULOGIC;
        SUM15 : out STD_ULOGIC;
        SUM16 : out STD_ULOGIC;
        SUM17 : out STD_ULOGIC;
        SUM18 : out STD_ULOGIC;
        SUM19 : out STD_ULOGIC;
        SUM20 : out STD_ULOGIC;
        SUM21 : out STD_ULOGIC;
        SUM22 : out STD_ULOGIC;
        SUM23 : out STD_ULOGIC;
        SUM24 : out STD_ULOGIC;
        SUM25 : out STD_ULOGIC;
        SUM26 : out STD_ULOGIC;
        SUM27 : out STD_ULOGIC;
        SUM28 : out STD_ULOGIC;
        SUM29 : out STD_ULOGIC;
        SUM30 : out STD_ULOGIC;
        SUM31 : out STD_ULOGIC;
        SUM32 : out STD_ULOGIC;
        SUM33 : out STD_ULOGIC;
        SUM34 : out STD_ULOGIC;
        SUM35 : out STD_ULOGIC;
        SUM36 : out STD_ULOGIC
       ); 

attribute VITAL_LEVEL0 of MULT18X18ADDSUBB : entity is TRUE;

end MULT18X18ADDSUBB;

--- Architecture 

library IEEE;
use IEEE.VITAL_Primitives.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
architecture V of MULT18X18ADDSUBB is

  attribute VITAL_LEVEL0 of V : architecture is TRUE;

  -- Local signals used to propagate input wire delay

  signal A0_ipd, A0_ipd1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A1_ipd, A1_ipd1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SRIA_ipd, SRIA_ipd1 : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROA_reg  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROA_reg1  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B0_ipd, B0_ipd1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B1_ipd, B1_ipd1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SRIB_ipd, SRIB_ipd1 : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROB_reg  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROB_reg1  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SUM_ipd     : std_logic_vector(36 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal SIGNEDA_ipd, SIGNEDA_ipd1 : std_logic := 'X';
  signal SIGNEDB_ipd, SIGNEDB_ipd1 : std_logic := 'X';
  signal SOURCEA0_ipd, SOURCEA0_ipd1 : std_logic := 'X';
  signal SOURCEA1_ipd, SOURCEA1_ipd1 : std_logic := 'X';
  signal SOURCEB0_ipd, SOURCEB0_ipd1 : std_logic := 'X';
  signal SOURCEB1_ipd, SOURCEB1_ipd1 : std_logic := 'X';
  signal ADDNSUB_ipd, ADDNSUB_ipd1 : std_logic := 'X';
  signal CE0_ipd   : std_logic := 'X';
  signal CE1_ipd   : std_logic := 'X';
  signal CE2_ipd   : std_logic := 'X';
  signal CE3_ipd   : std_logic := 'X';
  signal CLK0_ipd  : std_logic := 'X';
  signal CLK1_ipd  : std_logic := 'X';
  signal CLK2_ipd  : std_logic := 'X';
  signal CLK3_ipd  : std_logic := 'X';
  signal RST0_ipd  : std_logic := 'X';
  signal RST1_ipd  : std_logic := 'X';
  signal RST2_ipd  : std_logic := 'X';
  signal RST3_ipd  : std_logic := 'X';

  signal A0_reg       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A1_reg       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B0_reg       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B1_reg       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A0_p         : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A1_p         : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B0_p         : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B1_p         : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A0_gen       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A1_gen       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B0_gen       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B1_gen       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P0_i         : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P1_i         : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P0_o         : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P1_o         : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P0_i_e       : std_logic_vector(36 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P1_i_e       : std_logic_vector(36 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal p0_i_e_reg   : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal p1_i_e_reg   : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal p0_i_e_reg1  : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal p1_i_e_reg1  : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal sum_i        : std_logic_vector(36 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal sum_reg      : std_logic_vector(36 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";

  signal input_a0_clk : std_logic := 'X';
  signal input_a0_ce  : std_logic := 'X';
  signal input_a0_rst  : std_logic := 'X';
  signal input_a1_clk : std_logic := 'X';
  signal input_a1_ce  : std_logic := 'X';
  signal input_a1_rst  : std_logic := 'X';
  signal input_b0_clk : std_logic := 'X';
  signal input_b0_ce  : std_logic := 'X';
  signal input_b0_rst  : std_logic := 'X';
  signal input_b1_clk : std_logic := 'X';
  signal input_b1_ce  : std_logic := 'X';
  signal input_b1_rst  : std_logic := 'X';
  signal pipeline0_clk : std_logic := 'X';
  signal pipeline0_ce  : std_logic := 'X';
  signal pipeline0_rst : std_logic := 'X';
  signal pipeline1_clk : std_logic := 'X';
  signal pipeline1_ce  : std_logic := 'X';
  signal pipeline1_rst : std_logic := 'X';
  signal output_clk   : std_logic := 'X';
  signal output_ce    : std_logic := 'X';
  signal output_rst   : std_logic := 'X';
  signal signeda_0_clk : std_logic := 'X';
  signal signeda_0_ce  : std_logic := 'X';
  signal signeda_0_rst  : std_logic := 'X';
  signal signeda_1_clk : std_logic := 'X';
  signal signeda_1_ce  : std_logic := 'X';
  signal signeda_1_rst  : std_logic := 'X';
  signal signeda_0_reg  : std_logic := 'X';
  signal signeda_1_reg  : std_logic := 'X';
  signal signeda_p1  : std_logic := 'X';
  signal signeda_p2  : std_logic := 'X';
  signal signedb_0_clk : std_logic := 'X';
  signal signedb_0_ce  : std_logic := 'X';
  signal signedb_0_rst  : std_logic := 'X';
  signal signedb_1_clk : std_logic := 'X';
  signal signedb_1_ce  : std_logic := 'X';
  signal signedb_1_rst  : std_logic := 'X';
  signal signedb_0_reg  : std_logic := 'X';
  signal signedb_1_reg  : std_logic := 'X';
  signal signedb_p1  : std_logic := 'X';
  signal signedb_p2  : std_logic := 'X';

  signal addnsub_0_clk : std_logic := 'X';
  signal addnsub_0_ce  : std_logic := 'X';
  signal addnsub_0_rst  : std_logic := 'X';
  signal addnsub_1_clk : std_logic := 'X';
  signal addnsub_1_ce  : std_logic := 'X';
  signal addnsub_1_rst  : std_logic := 'X';
  signal addnsub_0_reg  : std_logic := 'X';
  signal addnsub_1_reg  : std_logic := 'X';
  signal addnsub_p1  : std_logic := 'X';
  signal addnsub_p2  : std_logic := 'X';

  signal SRN          : std_logic;
  signal input_a0_rst_ogsr  : std_logic := 'X';
  signal input_a1_rst_ogsr  : std_logic := 'X';
  signal input_b0_rst_ogsr  : std_logic := 'X';
  signal input_b1_rst_ogsr  : std_logic := 'X';
  signal pipeline0_rst_ogsr  : std_logic := 'X';
  signal pipeline1_rst_ogsr  : std_logic := 'X';
  signal output_rst_ogsr  : std_logic := 'X';
  signal signeda_0_rst_ogsr  : std_logic := 'X';
  signal signeda_1_rst_ogsr  : std_logic := 'X';
  signal signedb_0_rst_ogsr  : std_logic := 'X';
  signal signedb_1_rst_ogsr  : std_logic := 'X';
  signal accumsload_0_rst_ogsr  : std_logic := 'X';
  signal accumsload_1_rst_ogsr  : std_logic := 'X';
  signal addnsub_0_rst_ogsr  : std_logic := 'X';
  signal addnsub_1_rst_ogsr  : std_logic := 'X';

begin 

    global_reset : process (purnet, gsrnet)
      begin
        if (GSR =  "DISABLED") then
           SRN <= purnet;
        else
           SRN <= purnet AND gsrnet;
        end if;
      end process;

    input_a0_rst_ogsr <= input_a0_rst or not SRN;
    input_a1_rst_ogsr <= input_a1_rst or not SRN;
    input_b0_rst_ogsr <= input_b0_rst or not SRN;
    input_b1_rst_ogsr <= input_b1_rst or not SRN;
    pipeline0_rst_ogsr <= pipeline0_rst or not SRN;
    pipeline1_rst_ogsr <= pipeline1_rst or not SRN;
    output_rst_ogsr <= output_rst or not SRN;
    signeda_0_rst_ogsr <= signeda_0_rst or not SRN;
    signeda_1_rst_ogsr <= signeda_1_rst or not SRN;
    signedb_0_rst_ogsr <= signedb_0_rst or not SRN;
    signedb_1_rst_ogsr <= signedb_1_rst or not SRN;
    addnsub_0_rst_ogsr <= addnsub_0_rst or not SRN;
    addnsub_1_rst_ogsr <= addnsub_1_rst or not SRN;

    A0_ipd1 <= (A017 & A016 & A015 & A014 & A013 & A012 & A011 & A010 & A09 & A08 & A07 & A06 & A05 & A04 & A03 & A02 & A01 & A00);
    A1_ipd1 <= (A117 & A116 & A115 & A114 & A113 & A112 & A111 & A110 & A19 & A18 & A17 & A16 & A15 & A14 & A13 & A12 & A11 & A10);
    B0_ipd1 <= (B017 & B016 & B015 & B014 & B013 & B012 & B011 & B010 & B09 & B08 & B07 & B06 & B05 & B04 & B03 & B02 & B01 & B00);
    B1_ipd1 <= (B117 & B116 & B115 & B114 & B113 & B112 & B111 & B110 & B19 & B18 & B17 & B16 & B15 & B14 & B13 & B12 & B11 & B10);
    SRIA_ipd1 <= (SRIA17 & SRIA16 & SRIA15 & SRIA14 & SRIA13 & SRIA12 & SRIA11 & SRIA10 & SRIA9 & SRIA8 & SRIA7 & SRIA6 & SRIA5 & SRIA4 & SRIA3 & SRIA2 & SRIA1 & SRIA0);
    SRIB_ipd1 <= (SRIB17 & SRIB16 & SRIB15 & SRIB14 & SRIB13 & SRIB12 & SRIB11 & SRIB10 & SRIB9 & SRIB8 & SRIB7 & SRIB6 & SRIB5 & SRIB4 & SRIB3 & SRIB2 & SRIB1 & SRIB0);
    SIGNEDA_ipd1 <= SIGNEDA;
    SIGNEDB_ipd1 <= SIGNEDB;
    SOURCEA0_ipd1 <= SOURCEA0;
    SOURCEA1_ipd1 <= SOURCEA1;
    SOURCEB0_ipd1 <= SOURCEB0;
    SOURCEB1_ipd1 <= SOURCEB1;
    ADDNSUB_ipd1 <= ADDNSUB;

    A0_ipd <= A0_ipd1;
    A1_ipd <= A1_ipd1;
    B0_ipd <= B0_ipd1;
    B1_ipd <= B1_ipd1;
    SRIA_ipd <= SRIA_ipd1;
    SRIB_ipd <= SRIB_ipd1;
    SIGNEDA_ipd <= SIGNEDA_ipd1;
    SIGNEDB_ipd <= SIGNEDB_ipd1;
    SOURCEA0_ipd <= SOURCEA0_ipd1;
    SOURCEA1_ipd <= SOURCEA1_ipd1;
    SOURCEB0_ipd <= SOURCEB0_ipd1;
    SOURCEB1_ipd <= SOURCEB1_ipd1;
    ADDNSUB_ipd <= ADDNSUB_ipd1;

    CE0_ipd <= CE0;
    CE1_ipd <= CE1;
    CE2_ipd <= CE2;
    CE3_ipd <= CE3;
    CLK0_ipd <= CLK0;
    CLK1_ipd <= CLK1;
    CLK2_ipd <= CLK2;
    CLK3_ipd <= CLK3;
    RST0_ipd <= RST0;
    RST1_ipd <= RST1;
    RST2_ipd <= RST2;
    RST3_ipd <= RST3;

    SROA0 <= SROA_reg1(0);
    SROA1 <= SROA_reg1(1);
    SROA2 <= SROA_reg1(2);
    SROA3 <= SROA_reg1(3);
    SROA4 <= SROA_reg1(4);
    SROA5 <= SROA_reg1(5);
    SROA6 <= SROA_reg1(6);
    SROA7 <= SROA_reg1(7);
    SROA8 <= SROA_reg1(8);
    SROA9 <= SROA_reg1(9);
    SROA10 <= SROA_reg1(10);
    SROA11 <= SROA_reg1(11);
    SROA12 <= SROA_reg1(12);
    SROA13 <= SROA_reg1(13);
    SROA14 <= SROA_reg1(14);
    SROA15 <= SROA_reg1(15);
    SROA16 <= SROA_reg1(16);
    SROA17 <= SROA_reg1(17);

    SROB0 <= SROB_reg1(0);
    SROB1 <= SROB_reg1(1);
    SROB2 <= SROB_reg1(2);
    SROB3 <= SROB_reg1(3);
    SROB4 <= SROB_reg1(4);
    SROB5 <= SROB_reg1(5);
    SROB6 <= SROB_reg1(6);
    SROB7 <= SROB_reg1(7);
    SROB8 <= SROB_reg1(8);
    SROB9 <= SROB_reg1(9);
    SROB10 <= SROB_reg1(10);
    SROB11 <= SROB_reg1(11);
    SROB12 <= SROB_reg1(12);
    SROB13 <= SROB_reg1(13);
    SROB14 <= SROB_reg1(14);
    SROB15 <= SROB_reg1(15);
    SROB16 <= SROB_reg1(16);
    SROB17 <= SROB_reg1(17);

    SUM0 <= SUM_ipd(0);
    SUM1 <= SUM_ipd(1);
    SUM2 <= SUM_ipd(2);
    SUM3 <= SUM_ipd(3);
    SUM4 <= SUM_ipd(4);
    SUM5 <= SUM_ipd(5);
    SUM6 <= SUM_ipd(6);
    SUM7 <= SUM_ipd(7);
    SUM8 <= SUM_ipd(8);
    SUM9 <= SUM_ipd(9);
    SUM10 <= SUM_ipd(10);
    SUM11 <= SUM_ipd(11);
    SUM12 <= SUM_ipd(12);
    SUM13 <= SUM_ipd(13);
    SUM14 <= SUM_ipd(14);
    SUM15 <= SUM_ipd(15);
    SUM16 <= SUM_ipd(16);
    SUM17 <= SUM_ipd(17);
    SUM18 <= SUM_ipd(18);
    SUM19 <= SUM_ipd(19);
    SUM20 <= SUM_ipd(20);
    SUM21 <= SUM_ipd(21);
    SUM22 <= SUM_ipd(22);
    SUM23 <= SUM_ipd(23);
    SUM24 <= SUM_ipd(24);
    SUM25 <= SUM_ipd(25);
    SUM26 <= SUM_ipd(26);
    SUM27 <= SUM_ipd(27);
    SUM28 <= SUM_ipd(28);
    SUM29 <= SUM_ipd(29);
    SUM30 <= SUM_ipd(30);
    SUM31 <= SUM_ipd(31);
    SUM32 <= SUM_ipd(32);
    SUM33 <= SUM_ipd(33);
    SUM34 <= SUM_ipd(34);
    SUM35 <= SUM_ipd(35);
    SUM36 <= SUM_ipd(36);


  Input_A0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA0_CLK = "CLK0") then
       input_a0_clk <= CLK0_ipd;
     elsif (REG_INPUTA0_CLK = "CLK1") then
       input_a0_clk <= CLK1_ipd;
     elsif (REG_INPUTA0_CLK = "CLK2") then
       input_a0_clk <= CLK2_ipd;
     elsif (REG_INPUTA0_CLK = "CLK3") then
       input_a0_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA1_CLK = "CLK0") then
       input_a1_clk <= CLK0_ipd;
     elsif (REG_INPUTA1_CLK = "CLK1") then
       input_a1_clk <= CLK1_ipd;
     elsif (REG_INPUTA1_CLK = "CLK2") then
       input_a1_clk <= CLK2_ipd;
     elsif (REG_INPUTA1_CLK = "CLK3") then
       input_a1_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA0_CE = "CE0") then
       input_a0_ce <= CE0_ipd;
     elsif (REG_INPUTA0_CE = "CE1") then
       input_a0_ce <= CE1_ipd;
     elsif (REG_INPUTA0_CE = "CE2") then
       input_a0_ce <= CE2_ipd;
     elsif (REG_INPUTA0_CE = "CE3") then
       input_a0_ce <= CE3_ipd;
     end if;
  end process;

  Input_A1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA1_CE = "CE0") then
       input_a1_ce <= CE0_ipd;
     elsif (REG_INPUTA1_CE = "CE1") then
       input_a1_ce <= CE1_ipd;
     elsif (REG_INPUTA1_CE = "CE2") then
       input_a1_ce <= CE2_ipd;
     elsif (REG_INPUTA1_CE = "CE3") then
       input_a1_ce <= CE3_ipd;
     end if;
  end process;

  Input_A0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA0_RST = "RST0") then
       input_a0_rst <= RST0_ipd;
     elsif (REG_INPUTA0_RST = "RST1") then
       input_a0_rst <= RST1_ipd;
     elsif (REG_INPUTA0_RST = "RST2") then
       input_a0_rst <= RST2_ipd;
     elsif (REG_INPUTA0_RST = "RST3") then
       input_a0_rst <= RST3_ipd;
     end if;
  end process;
      
  Input_A1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA1_RST = "RST0") then
       input_a1_rst <= RST0_ipd;
     elsif (REG_INPUTA1_RST = "RST1") then
       input_a1_rst <= RST1_ipd;
     elsif (REG_INPUTA1_RST = "RST2") then
       input_a1_rst <= RST2_ipd;
     elsif (REG_INPUTA1_RST = "RST3") then
       input_a1_rst <= RST3_ipd;
     end if;
  end process;
      
  Register_A0_Input : process(input_a0_clk, input_a0_rst_ogsr, input_a0_ce)
  begin
     if (input_a0_rst_ogsr = '1') then
       A0_reg <= (others => '0');
     elsif (rising_edge(input_a0_clk)) then
       if (input_a0_ce = '1') then
         A0_reg <= A0_p;
       end if;
     end if;
  end process;

  Register_A1_Input : process(input_a1_clk, input_a1_rst_ogsr, input_a1_ce)
  begin
     if (input_a1_rst_ogsr = '1') then
       A1_reg <= (others => '0');
     elsif (rising_edge(input_a1_clk)) then
       if (input_a1_ce = '1') then
         A1_reg <= A1_p;
       end if;
     end if;
  end process;

  Select_A0_OR_A0_reg : process (A0_p, A0_reg)
  begin
     if (REG_INPUTA0_CLK = "NONE") then
       A0_gen <= A0_p;
     else
       A0_gen <= A0_reg;
     end if;
  end process;

  Select_A1_OR_A1_reg : process (A1_p, A1_reg)
  begin
     if (REG_INPUTA1_CLK = "NONE") then
       A1_gen <= A1_p;
     else
       A1_gen <= A1_reg;
     end if;
  end process;

  SROA_reg1 <= A1_gen;

  Select_A0_p_OR_SRIA_ipd : process(A0_ipd, SRIA_ipd, SOURCEA0_ipd)
  begin
     if (SOURCEA0_ipd = '1') then
       A0_p <= SRIA_ipd;
     elsif (SOURCEA0_ipd = '0') then 
       A0_p <= A0_ipd;
     end if;
  end process;    

  Select_A1_p_OR_SROA_reg : process(A1_ipd, A0_gen, SOURCEA1_ipd)
  begin
     if (SOURCEA1_ipd = '1') then
       A1_p <= A0_gen;
     elsif (SOURCEA1_ipd = '0') then 
       A1_p <= A1_ipd;
     end if;
  end process;    

  Input_B0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB0_CLK = "CLK0") then
       input_b0_clk <= CLK0_ipd;
     elsif (REG_INPUTB0_CLK = "CLK1") then
       input_b0_clk <= CLK1_ipd;
     elsif (REG_INPUTB0_CLK = "CLK2") then
       input_b0_clk <= CLK2_ipd;
     elsif (REG_INPUTB0_CLK = "CLK3") then
       input_b0_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB1_CLK = "CLK0") then
       input_b1_clk <= CLK0_ipd;
     elsif (REG_INPUTB1_CLK = "CLK1") then
       input_b1_clk <= CLK1_ipd;
     elsif (REG_INPUTB1_CLK = "CLK2") then
       input_b1_clk <= CLK2_ipd;
     elsif (REG_INPUTB1_CLK = "CLK3") then
       input_b1_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB0_CE = "CE0") then
       input_b0_ce <= CE0_ipd;
     elsif (REG_INPUTB0_CE = "CE1") then
       input_b0_ce <= CE1_ipd;
     elsif (REG_INPUTB0_CE = "CE2") then
       input_b0_ce <= CE2_ipd;
     elsif (REG_INPUTB0_CE = "CE3") then
       input_b0_ce <= CE3_ipd;
     end if;
  end process;

  Input_B1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB1_CE = "CE0") then
       input_b1_ce <= CE0_ipd;
     elsif (REG_INPUTB1_CE = "CE1") then
       input_b1_ce <= CE1_ipd;
     elsif (REG_INPUTB1_CE = "CE2") then
       input_b1_ce <= CE2_ipd;
     elsif (REG_INPUTB1_CE = "CE3") then
       input_b1_ce <= CE3_ipd;
     end if;
  end process;

  Input_B0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB0_RST = "RST0") then
       input_b0_rst <= RST0_ipd;
     elsif (REG_INPUTB0_RST = "RST1") then
       input_b0_rst <= RST1_ipd;
     elsif (REG_INPUTB0_RST = "RST2") then
       input_b0_rst <= RST2_ipd;
     elsif (REG_INPUTB0_RST = "RST3") then
       input_b0_rst <= RST3_ipd;
     end if;
  end process;

  Input_B1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB1_RST = "RST0") then
       input_b1_rst <= RST0_ipd;
     elsif (REG_INPUTB1_RST = "RST1") then
       input_b1_rst <= RST1_ipd;
     elsif (REG_INPUTB1_RST = "RST2") then
       input_b1_rst <= RST2_ipd;
     elsif (REG_INPUTB1_RST = "RST3") then
       input_b1_rst <= RST3_ipd;
     end if;
  end process;

  Register_B0_Input : process(input_b0_clk, input_b0_rst_ogsr, input_b0_ce)
  begin
     if (input_b0_rst_ogsr = '1') then
       B0_reg <= (others => '0');
     elsif (rising_edge(input_b0_clk)) then
       if (input_b0_ce = '1') then
         B0_reg <= B0_p;
       end if;
     end if;
  end process;

  Register_B1_Input : process(input_b1_clk, input_b1_rst_ogsr, input_b1_ce)
  begin
     if (input_b1_rst_ogsr = '1') then
       B1_reg <= (others => '0');
     elsif (rising_edge(input_b1_clk)) then
       if (input_b1_ce = '1') then
         B1_reg <= B1_p;
       end if;
     end if;
  end process;

  Select_B0_OR_B0_reg : process (B0_p, B0_reg)
  begin
     if (REG_INPUTB0_CLK = "NONE") then
       B0_gen <= B0_p;
     else
       B0_gen <= B0_reg;
     end if;
  end process;    

  Select_B1_OR_B1_reg : process (B1_p, B1_reg)
  begin
     if (REG_INPUTB1_CLK = "NONE") then
       B1_gen <= B1_p;
     else
       B1_gen <= B1_reg;
     end if;
  end process;    

  SROB_reg1 <= B1_gen;
    
  Select_B0_p_OR_SRIB_ipd : process(B0_ipd, SRIB_ipd, SOURCEB0_ipd)
  begin
     if (SOURCEB0_ipd = '1') then
       B0_p <= SRIB_ipd;
     elsif (SOURCEB0_ipd = '0') then 
       B0_p <= B0_ipd;
     end if;
  end process;  

  Select_B1_p_OR_SROB_reg : process(B1_ipd, B0_gen, SOURCEB1_ipd)
  begin
     if (SOURCEB1_ipd = '1') then
       B1_p <= B0_gen;
     elsif (SOURCEB1_ipd = '0') then 
       B1_p <= B1_ipd;
     end if;
  end process; 

  SIGNEDAB_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_0_CLK = "CLK0") then
       signeda_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK1") then
       signeda_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK2") then
       signeda_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK3") then
       signeda_0_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_0_CLK = "CLK0") then
       signedb_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK1") then
       signedb_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK2") then
       signedb_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK3") then
       signedb_0_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_0_CE = "CE0") then
       signeda_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE1") then
       signeda_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE2") then
       signeda_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE3") then
       signeda_0_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_0_CE = "CE0") then
       signedb_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE1") then
       signedb_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE2") then
       signedb_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE3") then
       signedb_0_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_0_RST = "RST0") then
       signeda_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST1") then
       signeda_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST2") then
       signeda_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST3") then
       signeda_0_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_0_RST = "RST0") then
       signedb_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST1") then
       signedb_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST2") then
       signedb_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST3") then
       signedb_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_SIGNEDA : process(signeda_0_clk, signeda_0_rst_ogsr, signeda_0_ce, SIGNEDA_ipd)
  begin
     if (signeda_0_rst_ogsr = '1') then
       SIGNEDA_0_reg <= '0';
     elsif (rising_edge(signeda_0_clk)) then
       if (signeda_0_ce = '1') then
         SIGNEDA_0_reg <= SIGNEDA_ipd;
       end if;
     end if;
  end process;

  Register_0_SIGNEDB : process(signedb_0_clk, signedb_0_rst_ogsr, signedb_0_ce, SIGNEDB_ipd)
  begin
     if (signedb_0_rst_ogsr = '1') then
       SIGNEDB_0_reg <= '0';
     elsif (rising_edge(signedb_0_clk)) then
       if (signedb_0_ce = '1') then
         SIGNEDB_0_reg <= SIGNEDB_ipd;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_0_reg : process (SIGNEDA_ipd, SIGNEDA_0_reg)
  begin
     if (REG_SIGNEDA_0_CLK = "NONE") then
       SIGNEDA_p1 <= SIGNEDA_ipd;
     else
       SIGNEDA_p1 <= SIGNEDA_0_reg;
     end if;
  end process; 

  Select_SIGNEDB_ipd_OR_SIGNEDB_0_reg : process (SIGNEDB_ipd, SIGNEDB_0_reg)
  begin
     if (REG_SIGNEDB_0_CLK = "NONE") then
       SIGNEDB_p1 <= SIGNEDB_ipd;
     else
       SIGNEDB_p1 <= SIGNEDB_0_reg;
     end if;
  end process;

  SIGNEDAB_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_1_CLK = "CLK0") then
       signeda_1_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK1") then
       signeda_1_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK2") then
       signeda_1_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK3") then
       signeda_1_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_1_CLK = "CLK0") then
       signedb_1_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK1") then
       signedb_1_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK2") then
       signedb_1_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK3") then
       signedb_1_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_1_CE = "CE0") then
       signeda_1_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE1") then
       signeda_1_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE2") then
       signeda_1_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE3") then
       signeda_1_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_1_CE = "CE0") then
       signedb_1_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE1") then
       signedb_1_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE2") then
       signedb_1_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE3") then
       signedb_1_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_1_RST = "RST0") then
       signeda_1_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_1_RST = "RST1") then
       signeda_1_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST2") then
       signeda_1_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_1_RST = "RST3") then
       signeda_1_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_1_RST = "RST0") then
       signedb_1_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_1_RST = "RST1") then
       signedb_1_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST2") then
       signedb_1_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_1_RST = "RST3") then
       signedb_1_rst <= RST3_ipd;
     end if;
  end process;

  Register_1_SIGNEDA : process(signeda_1_clk, signeda_1_rst_ogsr, signeda_1_ce, SIGNEDA_p1)
  begin
     if (signeda_0_rst_ogsr = '1') then
       SIGNEDA_1_reg <= '0';
     elsif (rising_edge(signeda_1_clk)) then
       if (signeda_1_ce = '1') then
         SIGNEDA_1_reg <= SIGNEDA_p1;
       end if;
     end if;
  end process;

  Register_1_SIGNEDB : process(signedb_1_clk, signedb_1_rst_ogsr, signedb_1_ce, SIGNEDB_p1)
  begin
     if (signedb_0_rst_ogsr = '1') then
       SIGNEDB_1_reg <= '0';
     elsif (rising_edge(signedb_1_clk)) then
       if (signedb_1_ce = '1') then
         SIGNEDB_1_reg <= SIGNEDB_p1;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_1_reg : process (SIGNEDA_p1, SIGNEDA_1_reg)
  begin
     if (REG_SIGNEDA_1_CLK = "NONE") then
       SIGNEDA_p2 <= SIGNEDA_p1;
     else
       SIGNEDA_p2 <= SIGNEDA_1_reg;
     end if;
  end process;

  Select_SIGNEDB_ipd_OR_SIGNEDB_1_reg : process (SIGNEDB_p1, SIGNEDB_1_reg)
  begin
     if (REG_SIGNEDB_1_CLK = "NONE") then
       SIGNEDB_p2 <= SIGNEDB_p1;
     else
       SIGNEDB_p2 <= SIGNEDB_1_reg;
     end if;
  end process;

  addnsub_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB_0_CLK = "CLK0") then
       addnsub_0_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB_0_CLK = "CLK1") then
       addnsub_0_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB_0_CLK = "CLK2") then
       addnsub_0_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB_0_CLK = "CLK3") then
       addnsub_0_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB_0_CE = "CE0") then
       addnsub_0_ce <= CE0_ipd;
     elsif (REG_ADDNSUB_0_CE = "CE1") then
       addnsub_0_ce <= CE1_ipd;
     elsif (REG_ADDNSUB_0_CE = "CE2") then
       addnsub_0_ce <= CE2_ipd;
     elsif (REG_ADDNSUB_0_CE = "CE3") then
       addnsub_0_ce <= CE3_ipd;
     end if;
  end process;

  addnsub_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB_0_RST = "RST0") then
       addnsub_0_rst <= RST0_ipd;
     elsif (REG_ADDNSUB_0_RST = "RST1") then
       addnsub_0_rst <= RST1_ipd;
     elsif (REG_ADDNSUB_0_RST = "RST2") then
       addnsub_0_rst <= RST2_ipd;
     elsif (REG_ADDNSUB_0_RST = "RST3") then
       addnsub_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_addnsub : process(addnsub_0_clk, addnsub_0_rst_ogsr, addnsub_0_ce, addnsub_ipd)
  begin
     if (addnsub_0_rst_ogsr = '1') then
       addnsub_0_reg <= '0';
     elsif (rising_edge(addnsub_0_clk)) then
       if (addnsub_0_ce = '1') then
         addnsub_0_reg <= addnsub_ipd;
       end if;
     end if;
  end process;

  Select_addnsub_ipd_OR_addnsub_0_reg : process (addnsub_ipd, addnsub_0_reg)
  begin
     if (REG_ADDNSUB_0_CLK = "NONE") then
       addnsub_p1 <= addnsub_ipd;
     else
       addnsub_p1 <= addnsub_0_reg;
     end if;
  end process; 

  addnsub_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB_1_CLK = "CLK0") then
       addnsub_1_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB_1_CLK = "CLK1") then
       addnsub_1_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB_1_CLK = "CLK2") then
       addnsub_1_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB_1_CLK = "CLK3") then
       addnsub_1_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB_1_CE = "CE0") then
       addnsub_1_ce <= CE0_ipd;
     elsif (REG_ADDNSUB_1_CE = "CE1") then
       addnsub_1_ce <= CE1_ipd;
     elsif (REG_ADDNSUB_1_CE = "CE2") then
       addnsub_1_ce <= CE2_ipd;
     elsif (REG_ADDNSUB_1_CE = "CE3") then
       addnsub_1_ce <= CE3_ipd;
     end if;
  end process;

  addnsub_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB_1_RST = "RST0") then
       addnsub_1_rst <= RST0_ipd;
     elsif (REG_ADDNSUB_1_RST = "RST1") then
       addnsub_1_rst <= RST1_ipd;
     elsif (REG_ADDNSUB_0_RST = "RST2") then
       addnsub_1_rst <= RST2_ipd;
     elsif (REG_ADDNSUB_1_RST = "RST3") then
       addnsub_1_rst <= RST3_ipd;
     end if;
  end process;

  Register_1_addnsub : process(addnsub_1_clk, addnsub_1_rst_ogsr, addnsub_1_ce, addnsub_p1)
  begin
     if (addnsub_0_rst_ogsr = '1') then
       addnsub_1_reg <= '0';
     elsif (rising_edge(addnsub_1_clk)) then
       if (addnsub_1_ce = '1') then
         addnsub_1_reg <= addnsub_p1;
       end if;
     end if;
  end process;

  Select_addnsub_ipd_OR_addnsub_1_reg : process (addnsub_p1, addnsub_1_reg)
  begin
     if (REG_ADDNSUB_1_CLK = "NONE") then
       addnsub_p2 <= addnsub_p1;
     else
       addnsub_p2 <= addnsub_1_reg;
     end if;
  end process;     

  VITALMultBehavior_p0_i : process(A0_gen, B0_gen, SIGNEDA_p1, SIGNEDB_p1)
    variable O_zd, OT1_zd, OT2_zd : std_logic_vector( 35 downto 0);
    variable IA,IBL,IBU  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(17 downto 0);
    variable B_i : std_logic_vector(17 downto 0);

  begin -- process

    if ((A0_gen = "000000000000000000") or (B0_gen = "000000000000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A0_gen) or IS_X(B0_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A0_gen(17) = '1' ) then
           A_i :=  TSCOMP(A0_gen);
         else 
           A_i := A0_gen;
         end if;
      else
         A_i := A0_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B0_gen(17)  = '1') then
           B_i := TSCOMP(B0_gen);
         else
           B_i := B0_gen;
         end if;
      else
         B_i := B0_gen;
      end if;

         IA  := VEC2INT(A_i);
         IBU := VEC2INT(B_i (17 downto 9));
         IBL := VEC2INT(B_i (8 downto 0));

         OT1_zd := INT2VEC((IA * IBU), 36);
         for idex in 0 to 8 loop
             OT1_zd(35 downto 0) := OT1_zd(34 downto 0) & '0';
         end loop;
 
         OT2_zd := INT2VEC((IA * IBL), 36);
         O_zd   := ADDVECT(OT1_zd,OT2_zd);

         sign := (SIGNEDA_p1 and A0_gen(17)) xor (SIGNEDB_p1 and B0_gen(17));
         if (sign = '1' ) then
              O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p0_i <= O_zd; 

  end process;

  VITALMultBehavior_p1_i : process(A1_gen, B1_gen, SIGNEDA_p1, SIGNEDB_p1)
    variable O_zd, OT1_zd, OT2_zd : std_logic_vector( 35 downto 0);
    variable IA,IBL,IBU  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(17 downto 0);
    variable B_i : std_logic_vector(17 downto 0);

  begin -- process

    if ((A1_gen = "000000000000000000") or (B1_gen = "000000000000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A1_gen) or IS_X(B1_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A1_gen(17) = '1' ) then
           A_i :=  TSCOMP(A1_gen);
         else 
           A_i := A1_gen;
         end if;
      else
         A_i := A1_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B1_gen(17)  = '1') then
           B_i := TSCOMP(B1_gen);
         else
           B_i := B1_gen;
         end if;
      else
         B_i := B1_gen;
      end if;

         IA  := VEC2INT(A_i);
         IBU := VEC2INT(B_i (17 downto 9));
         IBL := VEC2INT(B_i (8 downto 0));

         OT1_zd := INT2VEC((IA * IBU), 36);
         for idex in 0 to 8 loop
             OT1_zd(35 downto 0) := OT1_zd(34 downto 0) & '0';
         end loop;
 
         OT2_zd := INT2VEC((IA * IBL), 36);
         O_zd   := ADDVECT(OT1_zd,OT2_zd);

         sign := (SIGNEDA_p1 and A1_gen(17)) xor (SIGNEDB_p1 and B1_gen(17));
         if (sign = '1' ) then
              O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p1_i <= O_zd; 

  end process;

  P0_i_e_process : process(p0_i_e_reg1, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       p0_i_e(35 downto 0 ) <= p0_i_e_reg1;
       p0_i_e(36)           <= p0_i_e_reg1(35);
    else
       p0_i_e(35 downto 0 ) <= p0_i_e_reg1;
       p0_i_e(36)           <= '0';
    end if;
  end process;

  P1_i_e_process : process(p1_i_e_reg1, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       p1_i_e(35 downto 0 ) <= p1_i_e_reg1;
       p1_i_e(36)           <= p1_i_e_reg1(35);
    else
       p1_i_e(35 downto 0 ) <= p1_i_e_reg1;
       p1_i_e(36)           <= '0';
    end if;
  end process;

  PipeLine0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE0_CLK = "CLK0") then
       pipeline0_clk <= CLK0_ipd;
     elsif (REG_PIPELINE0_CLK = "CLK1") then
       pipeline0_clk <= CLK1_ipd;
     elsif (REG_PIPELINE0_CLK = "CLK2") then
       pipeline0_clk <= CLK2_ipd;
     elsif (REG_PIPELINE0_CLK = "CLK3") then
       pipeline0_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE1_CLK = "CLK0") then
       pipeline1_clk <= CLK0_ipd;
     elsif (REG_PIPELINE1_CLK = "CLK1") then
       pipeline1_clk <= CLK1_ipd;
     elsif (REG_PIPELINE1_CLK = "CLK2") then
       pipeline1_clk <= CLK2_ipd;
     elsif (REG_PIPELINE1_CLK = "CLK3") then
       pipeline1_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE0_CE = "CE0") then
       pipeline0_ce <= CE0_ipd;
     elsif (REG_PIPELINE0_CE = "CE1") then
       pipeline0_ce <= CE1_ipd;
     elsif (REG_PIPELINE0_CE = "CE2") then
       pipeline0_ce <= CE2_ipd;
     elsif (REG_PIPELINE0_CE = "CE3") then
       pipeline0_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE1_CE = "CE0") then
       pipeline1_ce <= CE0_ipd;
     elsif (REG_PIPELINE1_CE = "CE1") then
       pipeline1_ce <= CE1_ipd;
     elsif (REG_PIPELINE1_CE = "CE2") then
       pipeline1_ce <= CE2_ipd;
     elsif (REG_PIPELINE1_CE = "CE3") then
       pipeline1_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE0_RST = "RST0") then
       pipeline0_rst <= RST0_ipd;
     elsif (REG_PIPELINE0_RST = "RST1") then
       pipeline0_rst <= RST1_ipd;
     elsif (REG_PIPELINE0_RST = "RST2") then
       pipeline0_rst <= RST2_ipd;
     elsif (REG_PIPELINE0_RST = "RST3") then
       pipeline0_rst <= RST3_ipd;
     end if;
  end process;

  PipeLine1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE1_RST = "RST0") then
       pipeline1_rst <= RST0_ipd;
     elsif (REG_PIPELINE1_RST = "RST1") then
       pipeline1_rst <= RST1_ipd;
     elsif (REG_PIPELINE1_RST = "RST2") then
       pipeline1_rst <= RST2_ipd;
     elsif (REG_PIPELINE1_RST = "RST3") then
       pipeline1_rst <= RST3_ipd;
     end if;
  end process;

  Pipeline_p0_i_e : process(pipeline0_clk, pipeline0_rst_ogsr, pipeline0_ce, p0_i)
  begin
     if (pipeline0_rst_ogsr = '1') then
       p0_i_e_reg <= (others => '0');
     elsif (rising_edge(pipeline0_clk)) then
       if (pipeline0_ce = '1') then
         p0_i_e_reg <= p0_i;
       end if;
     end if;
  end process;

  Select_p0_i_e_OR_p0_i_e_reg : process (p0_i, p0_i_e_reg)
  begin
     if (REG_PIPELINE0_CLK = "NONE") then
       p0_i_e_reg1 <= p0_i;
     else
       p0_i_e_reg1 <= p0_i_e_reg;
     end if;
  end process;

  Pipeline_p1_i_e : process(pipeline1_clk, pipeline1_rst_ogsr, pipeline1_ce, p1_i)
  begin
     if (pipeline1_rst_ogsr = '1') then
       p1_i_e_reg <= (others => '0');
     elsif (rising_edge(pipeline1_clk)) then
       if (pipeline1_ce = '1') then
         p1_i_e_reg <= p1_i;
       end if;
     end if;
  end process;

  Select_p1_i_e_OR_p1_i_e_reg : process (p1_i, p1_i_e_reg)
  begin
     if (REG_PIPELINE1_CLK = "NONE") then
       p1_i_e_reg1 <= p1_i;
     else
       p1_i_e_reg1 <= p1_i_e_reg;
     end if;
  end process;

  AddSub_process : process(p0_i_e, p1_i_e, addnsub_p2)
  begin
    if (addnsub_p2 = '1') then
      sum_i <= ADDVECT(p0_i_e, p1_i_e);
    else
      sum_i <= SUBVECT(p0_i_e, p1_i_e);
    end if;
  end process;

  Output_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_OUTPUT_CLK = "CLK0") then
       output_clk <= CLK0_ipd;
     elsif (REG_OUTPUT_CLK = "CLK1") then
       output_clk <= CLK1_ipd;
     elsif (REG_OUTPUT_CLK = "CLK2") then
       output_clk <= CLK2_ipd;
     elsif (REG_OUTPUT_CLK = "CLK3") then
       output_clk <= CLK3_ipd;
     end if;
  end process;

  Output_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_OUTPUT_CE = "CE0") then
       output_ce <= CE0_ipd;
     elsif (REG_OUTPUT_CE = "CE1") then
       output_ce <= CE1_ipd;
     elsif (REG_OUTPUT_CE = "CE2") then
       output_ce <= CE2_ipd;
     elsif (REG_OUTPUT_CE = "CE3") then
       output_ce <= CE3_ipd;
     end if;
  end process;

  Output_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_OUTPUT_RST = "RST0") then
       output_rst <= RST0_ipd;
     elsif (REG_OUTPUT_RST = "RST1") then
       output_rst <= RST1_ipd;
     elsif (REG_OUTPUT_RST = "RST2") then
       output_rst <= RST2_ipd;
     elsif (REG_OUTPUT_RST = "RST3") then
       output_rst <= RST3_ipd;
     end if;
  end process;

  Output_Register : process(output_clk, output_rst_ogsr, output_ce, sum_i)
  begin
     if (output_rst_ogsr = '1') then
       sum_reg <= (others => '0');
     elsif (rising_edge(output_clk)) then
       if (output_ce = '1') then
         sum_reg <= sum_i;
       end if;
     end if;
  end process;

  Select_OUTREG_OR_NOREG : process (sum_i, sum_reg)
  begin
     if (REG_OUTPUT_CLK = "NONE") then
       SUM_ipd <= sum_i;
     else
       SUM_ipd <= sum_reg;
     end if;
  end process;

end V;

configuration CFG_MULT18X18ADDSUBB_V of MULT18X18ADDSUBB is
   for V
   end for;
end CFG_MULT18X18ADDSUBB_V;
----- CELL MULT18X18ADDSUBSUMB -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use work.components.all;
use work.global.gsrnet;
use work.global.purnet;

-- entity declaration --
entity MULT18X18ADDSUBSUMB is
  generic(
	 REG_INPUTA0_CLK       : string     := "NONE";
	 REG_INPUTA0_CE        : string     := "CE0";
	 REG_INPUTA0_RST       : string     := "RST0";
	 REG_INPUTA1_CLK       : string     := "NONE";
	 REG_INPUTA1_CE        : string     := "CE0";
	 REG_INPUTA1_RST       : string     := "RST0";
	 REG_INPUTA2_CLK       : string     := "NONE";
	 REG_INPUTA2_CE        : string     := "CE0";
	 REG_INPUTA2_RST       : string     := "RST0";
	 REG_INPUTA3_CLK       : string     := "NONE";
	 REG_INPUTA3_CE        : string     := "CE0";
	 REG_INPUTA3_RST       : string     := "RST0";
	 REG_INPUTB0_CLK       : string     := "NONE";
	 REG_INPUTB0_CE        : string     := "CE0";
	 REG_INPUTB0_RST       : string     := "RST0";
	 REG_INPUTB1_CLK       : string     := "NONE";
	 REG_INPUTB1_CE        : string     := "CE0";
	 REG_INPUTB1_RST       : string     := "RST0";
	 REG_INPUTB2_CLK       : string     := "NONE";
	 REG_INPUTB2_CE        : string     := "CE0";
	 REG_INPUTB2_RST       : string     := "RST0";
	 REG_INPUTB3_CLK       : string     := "NONE";
	 REG_INPUTB3_CE        : string     := "CE0";
	 REG_INPUTB3_RST       : string     := "RST0";
	 REG_PIPELINE0_CLK     : string     := "NONE";
	 REG_PIPELINE0_CE      : string     := "CE0";
	 REG_PIPELINE0_RST     : string     := "RST0";
	 REG_PIPELINE1_CLK     : string     := "NONE";
	 REG_PIPELINE1_CE      : string     := "CE0";
	 REG_PIPELINE1_RST     : string     := "RST0";
	 REG_PIPELINE2_CLK     : string     := "NONE";
	 REG_PIPELINE2_CE      : string     := "CE0";
	 REG_PIPELINE2_RST     : string     := "RST0";
	 REG_PIPELINE3_CLK     : string     := "NONE";
	 REG_PIPELINE3_CE      : string     := "CE0";
	 REG_PIPELINE3_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDA_0_CLK   : string     := "NONE";
	 REG_SIGNEDA_0_CE    : string     := "CE0";
	 REG_SIGNEDA_0_RST   : string     := "RST0";
	 REG_SIGNEDA_1_CLK   : string     := "NONE";
	 REG_SIGNEDA_1_CE    : string     := "CE0";
	 REG_SIGNEDA_1_RST   : string     := "RST0";
         REG_SIGNEDB_0_CLK   : string     := "NONE";
         REG_SIGNEDB_0_CE    : string     := "CE0";
         REG_SIGNEDB_0_RST   : string     := "RST0";
         REG_SIGNEDB_1_CLK   : string     := "NONE";
         REG_SIGNEDB_1_CE    : string     := "CE0";
         REG_SIGNEDB_1_RST   : string     := "RST0";
	 REG_ADDNSUB1_0_CLK    : string     := "NONE";
	 REG_ADDNSUB1_0_CE     : string     := "CE0";
	 REG_ADDNSUB1_0_RST    : string     := "RST0";
	 REG_ADDNSUB1_1_CLK    : string     := "NONE";
	 REG_ADDNSUB1_1_CE     : string     := "CE0";
	 REG_ADDNSUB1_1_RST    : string     := "RST0";
	 REG_ADDNSUB3_0_CLK    : string     := "NONE";
	 REG_ADDNSUB3_0_CE     : string     := "CE0";
	 REG_ADDNSUB3_0_RST    : string     := "RST0";
	 REG_ADDNSUB3_1_CLK    : string     := "NONE";
	 REG_ADDNSUB3_1_CE     : string     := "CE0";
	 REG_ADDNSUB3_1_RST    : string     := "RST0";
	 GSR                  : string     := "ENABLED");
  port (
        A00 : in STD_ULOGIC;
        A01 : in STD_ULOGIC;
        A02 : in STD_ULOGIC;
        A03 : in STD_ULOGIC;
        A04 : in STD_ULOGIC;
        A05 : in STD_ULOGIC;
        A06 : in STD_ULOGIC;
        A07 : in STD_ULOGIC;
        A08 : in STD_ULOGIC;
        A09 : in STD_ULOGIC;
        A010 : in STD_ULOGIC;
        A011 : in STD_ULOGIC;
        A012 : in STD_ULOGIC;
        A013 : in STD_ULOGIC;
        A014 : in STD_ULOGIC;
        A015 : in STD_ULOGIC;
        A016 : in STD_ULOGIC;
        A017 : in STD_ULOGIC;

        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;
        A18 : in STD_ULOGIC;
        A19 : in STD_ULOGIC;
        A110 : in STD_ULOGIC;
        A111 : in STD_ULOGIC;
        A112 : in STD_ULOGIC;
        A113 : in STD_ULOGIC;
        A114 : in STD_ULOGIC;
        A115 : in STD_ULOGIC;
        A116 : in STD_ULOGIC;
        A117 : in STD_ULOGIC;

        A20 : in STD_ULOGIC;
        A21 : in STD_ULOGIC;
        A22 : in STD_ULOGIC;
        A23 : in STD_ULOGIC;
        A24 : in STD_ULOGIC;
        A25 : in STD_ULOGIC;
        A26 : in STD_ULOGIC;
        A27 : in STD_ULOGIC;
        A28 : in STD_ULOGIC;
        A29 : in STD_ULOGIC;
        A210 : in STD_ULOGIC;
        A211 : in STD_ULOGIC;
        A212 : in STD_ULOGIC;
        A213 : in STD_ULOGIC;
        A214 : in STD_ULOGIC;
        A215 : in STD_ULOGIC;
        A216 : in STD_ULOGIC;
        A217 : in STD_ULOGIC;

        A30 : in STD_ULOGIC;
        A31 : in STD_ULOGIC;
        A32 : in STD_ULOGIC;
        A33 : in STD_ULOGIC;
        A34 : in STD_ULOGIC;
        A35 : in STD_ULOGIC;
        A36 : in STD_ULOGIC;
        A37 : in STD_ULOGIC;
        A38 : in STD_ULOGIC;
        A39 : in STD_ULOGIC;
        A310 : in STD_ULOGIC;
        A311 : in STD_ULOGIC;
        A312 : in STD_ULOGIC;
        A313 : in STD_ULOGIC;
        A314 : in STD_ULOGIC;
        A315 : in STD_ULOGIC;
        A316 : in STD_ULOGIC;
        A317 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;
        SRIA9 : in STD_ULOGIC;
        SRIA10 : in STD_ULOGIC;
        SRIA11 : in STD_ULOGIC;
        SRIA12 : in STD_ULOGIC;
        SRIA13 : in STD_ULOGIC;
        SRIA14 : in STD_ULOGIC;
        SRIA15 : in STD_ULOGIC;
        SRIA16 : in STD_ULOGIC;
        SRIA17 : in STD_ULOGIC;

        B00 : in STD_ULOGIC;
        B01 : in STD_ULOGIC;
        B02 : in STD_ULOGIC;
        B03 : in STD_ULOGIC;
        B04 : in STD_ULOGIC;
        B05 : in STD_ULOGIC;
        B06 : in STD_ULOGIC;
        B07 : in STD_ULOGIC;
        B08 : in STD_ULOGIC;
        B09 : in STD_ULOGIC;
        B010 : in STD_ULOGIC;
        B011 : in STD_ULOGIC;
        B012 : in STD_ULOGIC;
        B013 : in STD_ULOGIC;
        B014 : in STD_ULOGIC;
        B015 : in STD_ULOGIC;
        B016 : in STD_ULOGIC;
        B017 : in STD_ULOGIC;

        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;
        B18 : in STD_ULOGIC;
        B19 : in STD_ULOGIC;
        B110 : in STD_ULOGIC;
        B111 : in STD_ULOGIC;
        B112 : in STD_ULOGIC;
        B113 : in STD_ULOGIC;
        B114 : in STD_ULOGIC;
        B115 : in STD_ULOGIC;
        B116 : in STD_ULOGIC;
        B117 : in STD_ULOGIC;

        B20 : in STD_ULOGIC;
        B21 : in STD_ULOGIC;
        B22 : in STD_ULOGIC;
        B23 : in STD_ULOGIC;
        B24 : in STD_ULOGIC;
        B25 : in STD_ULOGIC;
        B26 : in STD_ULOGIC;
        B27 : in STD_ULOGIC;
        B28 : in STD_ULOGIC;
        B29 : in STD_ULOGIC;
        B210 : in STD_ULOGIC;
        B211 : in STD_ULOGIC;
        B212 : in STD_ULOGIC;
        B213 : in STD_ULOGIC;
        B214 : in STD_ULOGIC;
        B215 : in STD_ULOGIC;
        B216 : in STD_ULOGIC;
        B217 : in STD_ULOGIC;

        B30 : in STD_ULOGIC;
        B31 : in STD_ULOGIC;
        B32 : in STD_ULOGIC;
        B33 : in STD_ULOGIC;
        B34 : in STD_ULOGIC;
        B35 : in STD_ULOGIC;
        B36 : in STD_ULOGIC;
        B37 : in STD_ULOGIC;
        B38 : in STD_ULOGIC;
        B39 : in STD_ULOGIC;
        B310 : in STD_ULOGIC;
        B311 : in STD_ULOGIC;
        B312 : in STD_ULOGIC;
        B313 : in STD_ULOGIC;
        B314 : in STD_ULOGIC;
        B315 : in STD_ULOGIC;
        B316 : in STD_ULOGIC;
        B317 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;
        SRIB9 : in STD_ULOGIC;
        SRIB10 : in STD_ULOGIC;
        SRIB11 : in STD_ULOGIC;
        SRIB12 : in STD_ULOGIC;
        SRIB13 : in STD_ULOGIC;
        SRIB14 : in STD_ULOGIC;
        SRIB15 : in STD_ULOGIC;
        SRIB16 : in STD_ULOGIC;
        SRIB17 : in STD_ULOGIC;

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        SOURCEA0 : in STD_ULOGIC;
        SOURCEA1 : in STD_ULOGIC;
        SOURCEA2 : in STD_ULOGIC;
        SOURCEA3 : in STD_ULOGIC;
        SOURCEB0 : in STD_ULOGIC;
        SOURCEB1 : in STD_ULOGIC;
        SOURCEB2 : in STD_ULOGIC;
        SOURCEB3 : in STD_ULOGIC;
        ADDNSUB1  : in STD_ULOGIC;
        ADDNSUB3  : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;
        SROA9 : out STD_ULOGIC;
        SROA10 : out STD_ULOGIC;
        SROA11 : out STD_ULOGIC;
        SROA12 : out STD_ULOGIC;
        SROA13 : out STD_ULOGIC;
        SROA14 : out STD_ULOGIC;
        SROA15 : out STD_ULOGIC;
        SROA16 : out STD_ULOGIC;
        SROA17 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;
        SROB9 : out STD_ULOGIC;
        SROB10 : out STD_ULOGIC;
        SROB11 : out STD_ULOGIC;
        SROB12 : out STD_ULOGIC;
        SROB13 : out STD_ULOGIC;
        SROB14 : out STD_ULOGIC;
        SROB15 : out STD_ULOGIC;
        SROB16 : out STD_ULOGIC;
        SROB17 : out STD_ULOGIC;

        SUM0 : out STD_ULOGIC;
        SUM1 : out STD_ULOGIC;
        SUM2 : out STD_ULOGIC;
        SUM3 : out STD_ULOGIC;
        SUM4 : out STD_ULOGIC;
        SUM5 : out STD_ULOGIC;
        SUM6 : out STD_ULOGIC;
        SUM7 : out STD_ULOGIC;
        SUM8 : out STD_ULOGIC;
        SUM9 : out STD_ULOGIC;
        SUM10 : out STD_ULOGIC;
        SUM11 : out STD_ULOGIC;
        SUM12 : out STD_ULOGIC;
        SUM13 : out STD_ULOGIC;
        SUM14 : out STD_ULOGIC;
        SUM15 : out STD_ULOGIC;
        SUM16 : out STD_ULOGIC;
        SUM17 : out STD_ULOGIC;
        SUM18 : out STD_ULOGIC;
        SUM19 : out STD_ULOGIC;
        SUM20 : out STD_ULOGIC;
        SUM21 : out STD_ULOGIC;
        SUM22 : out STD_ULOGIC;
        SUM23 : out STD_ULOGIC;
        SUM24 : out STD_ULOGIC;
        SUM25 : out STD_ULOGIC;
        SUM26 : out STD_ULOGIC;
        SUM27 : out STD_ULOGIC;
        SUM28 : out STD_ULOGIC;
        SUM29 : out STD_ULOGIC;
        SUM30 : out STD_ULOGIC;
        SUM31 : out STD_ULOGIC;
        SUM32 : out STD_ULOGIC;
        SUM33 : out STD_ULOGIC;
        SUM34 : out STD_ULOGIC;
        SUM35 : out STD_ULOGIC;
        SUM36 : out STD_ULOGIC;
        SUM37 : out STD_ULOGIC
       ); 

attribute VITAL_LEVEL0 of MULT18X18ADDSUBSUMB : entity is TRUE;

end MULT18X18ADDSUBSUMB;

--- Architecture 

library IEEE;
use IEEE.VITAL_Primitives.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
architecture V of MULT18X18ADDSUBSUMB is

  attribute VITAL_LEVEL0 of V : architecture is TRUE;

  -- Local signals used to propagate input wire delay

  signal A0_ipd, A0_ipd1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A1_ipd, A1_ipd1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A2_ipd, A2_ipd1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A3_ipd, A3_ipd1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SRIA_ipd, SRIA_ipd1 : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROA_reg  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROA_reg1  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROA_reg2  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROA_reg3  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B0_ipd, B0_ipd1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B1_ipd, B1_ipd1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B2_ipd, B2_ipd1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B3_ipd, B3_ipd1     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SRIB_ipd, SRIB_ipd1 : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROB_reg  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROB_reg1  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROB_reg2  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROB_reg3  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SUM_ipd     : std_logic_vector(37 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal SIGNEDA_ipd, SIGNEDA_ipd1 : std_logic := 'X';
  signal SIGNEDB_ipd, SIGNEDB_ipd1 : std_logic := 'X';
  signal SOURCEA0_ipd, SOURCEA0_ipd1 : std_logic := 'X';
  signal SOURCEA1_ipd, SOURCEA1_ipd1 : std_logic := 'X';
  signal SOURCEA2_ipd, SOURCEA2_ipd1 : std_logic := 'X';
  signal SOURCEA3_ipd, SOURCEA3_ipd1 : std_logic := 'X';
  signal SOURCEB0_ipd, SOURCEB0_ipd1 : std_logic := 'X';
  signal SOURCEB1_ipd, SOURCEB1_ipd1 : std_logic := 'X';
  signal SOURCEB2_ipd, SOURCEB2_ipd1 : std_logic := 'X';
  signal SOURCEB3_ipd, SOURCEB3_ipd1 : std_logic := 'X';
  signal ADDNSUB1_ipd, ADDNSUB1_ipd1 : std_logic := 'X';
  signal ADDNSUB3_ipd, ADDNSUB3_ipd1 : std_logic := 'X';
  signal CE0_ipd   : std_logic := 'X';
  signal CE1_ipd   : std_logic := 'X';
  signal CE2_ipd   : std_logic := 'X';
  signal CE3_ipd   : std_logic := 'X';
  signal CLK0_ipd  : std_logic := 'X';
  signal CLK1_ipd  : std_logic := 'X';
  signal CLK2_ipd  : std_logic := 'X';
  signal CLK3_ipd  : std_logic := 'X';
  signal RST0_ipd  : std_logic := 'X';
  signal RST1_ipd  : std_logic := 'X';
  signal RST2_ipd  : std_logic := 'X';
  signal RST3_ipd  : std_logic := 'X';

  signal A0_reg     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A1_reg     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A2_reg     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A3_reg     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B0_reg     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B1_reg     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B2_reg     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B3_reg     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A0_p       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A1_p       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A2_p       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A3_p       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B0_p       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B1_p       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B2_p       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B3_p       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A0_gen     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A1_gen     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A2_gen     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A3_gen     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B0_gen     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B1_gen     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B2_gen     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B3_gen     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P0_i       : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P1_i       : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P2_i       : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P3_i       : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P0_i_e    : std_logic_vector(36 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P1_i_e    : std_logic_vector(36 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P2_i_e    : std_logic_vector(36 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P3_i_e    : std_logic_vector(36 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal p0_i_e_reg    : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal p1_i_e_reg    : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal p2_i_e_reg    : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal p3_i_e_reg    : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal p0_i_e_reg1    : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal p1_i_e_reg1    : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal p2_i_e_reg1    : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal p3_i_e_reg1    : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal sum0_i     : std_logic_vector(36 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal sum1_i     : std_logic_vector(36 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal sum0_i_e   : std_logic_vector(37 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal sum1_i_e   : std_logic_vector(37 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal sumt_sig  : std_logic_vector(37 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal sumt_reg  : std_logic_vector(37 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";

  signal input_a0_clk : std_logic := 'X';
  signal input_a0_ce  : std_logic := 'X';
  signal input_a0_rst  : std_logic := 'X';
  signal input_a1_clk : std_logic := 'X';
  signal input_a1_ce  : std_logic := 'X';
  signal input_a1_rst  : std_logic := 'X';
  signal input_a2_clk : std_logic := 'X';
  signal input_a2_ce  : std_logic := 'X';
  signal input_a2_rst  : std_logic := 'X';
  signal input_a3_clk : std_logic := 'X';
  signal input_a3_ce  : std_logic := 'X';
  signal input_a3_rst  : std_logic := 'X';
  signal input_b0_clk : std_logic := 'X';
  signal input_b0_ce  : std_logic := 'X';
  signal input_b0_rst  : std_logic := 'X';
  signal input_b1_clk : std_logic := 'X';
  signal input_b1_ce  : std_logic := 'X';
  signal input_b1_rst  : std_logic := 'X';
  signal input_b2_clk : std_logic := 'X';
  signal input_b2_ce  : std_logic := 'X';
  signal input_b2_rst  : std_logic := 'X';
  signal input_b3_clk : std_logic := 'X';
  signal input_b3_ce  : std_logic := 'X';
  signal input_b3_rst  : std_logic := 'X';
  signal pipeline0_clk : std_logic := 'X';
  signal pipeline0_ce  : std_logic := 'X';
  signal pipeline0_rst  : std_logic := 'X';
  signal pipeline1_clk : std_logic := 'X';
  signal pipeline1_ce  : std_logic := 'X';
  signal pipeline1_rst  : std_logic := 'X';
  signal pipeline2_clk : std_logic := 'X';
  signal pipeline2_ce  : std_logic := 'X';
  signal pipeline2_rst  : std_logic := 'X';
  signal pipeline3_clk : std_logic := 'X';
  signal pipeline3_ce  : std_logic := 'X';
  signal pipeline3_rst  : std_logic := 'X';
  signal output_clk : std_logic := 'X';
  signal output_ce  : std_logic := 'X';
  signal output_rst  : std_logic := 'X';
  signal signeda_0_clk : std_logic := 'X';
  signal signeda_0_ce  : std_logic := 'X';
  signal signeda_0_rst  : std_logic := 'X';
  signal signeda_1_clk : std_logic := 'X';
  signal signeda_1_ce  : std_logic := 'X';
  signal signeda_1_rst  : std_logic := 'X';
  signal signeda_0_reg  : std_logic := 'X';
  signal signeda_1_reg  : std_logic := 'X';
  signal signeda_p1  : std_logic := 'X';
  signal signeda_p2  : std_logic := 'X';
  signal signedb_0_clk : std_logic := 'X';
  signal signedb_0_ce  : std_logic := 'X';
  signal signedb_0_rst  : std_logic := 'X';
  signal signedb_1_clk : std_logic := 'X';
  signal signedb_1_ce  : std_logic := 'X';
  signal signedb_1_rst  : std_logic := 'X';
  signal signedb_0_reg  : std_logic := 'X';
  signal signedb_1_reg  : std_logic := 'X';
  signal signedb_p1  : std_logic := 'X';
  signal signedb_p2  : std_logic := 'X';

  signal addnsub1_0_clk : std_logic := 'X';
  signal addnsub1_0_ce  : std_logic := 'X';
  signal addnsub1_0_rst  : std_logic := 'X';
  signal addnsub1_1_clk : std_logic := 'X';
  signal addnsub1_1_ce  : std_logic := 'X';
  signal addnsub1_1_rst  : std_logic := 'X';
  signal addnsub1_0_reg  : std_logic := 'X';
  signal addnsub1_1_reg  : std_logic := 'X';
  signal addnsub1_p1  : std_logic := 'X';
  signal addnsub1_p2  : std_logic := 'X';

  signal addnsub3_0_clk : std_logic := 'X';
  signal addnsub3_0_ce  : std_logic := 'X';
  signal addnsub3_0_rst  : std_logic := 'X';
  signal addnsub3_1_clk : std_logic := 'X';
  signal addnsub3_1_ce  : std_logic := 'X';
  signal addnsub3_1_rst  : std_logic := 'X';
  signal addnsub3_0_reg  : std_logic := 'X';
  signal addnsub3_1_reg  : std_logic := 'X';
  signal addnsub3_p1  : std_logic := 'X';
  signal addnsub3_p2  : std_logic := 'X';

  signal SRN          : std_logic;
  signal input_a0_rst_ogsr  : std_logic := 'X';
  signal input_a1_rst_ogsr  : std_logic := 'X';
  signal input_a2_rst_ogsr  : std_logic := 'X';
  signal input_a3_rst_ogsr  : std_logic := 'X';
  signal input_b0_rst_ogsr  : std_logic := 'X';
  signal input_b1_rst_ogsr  : std_logic := 'X';
  signal input_b2_rst_ogsr  : std_logic := 'X';
  signal input_b3_rst_ogsr  : std_logic := 'X';
  signal pipeline0_rst_ogsr  : std_logic := 'X';
  signal pipeline1_rst_ogsr  : std_logic := 'X';
  signal pipeline2_rst_ogsr  : std_logic := 'X';
  signal pipeline3_rst_ogsr  : std_logic := 'X';
  signal output_rst_ogsr  : std_logic := 'X';
  signal signeda_0_rst_ogsr  : std_logic := 'X';
  signal signeda_1_rst_ogsr  : std_logic := 'X';
  signal signeda_2_rst_ogsr  : std_logic := 'X';
  signal signeda_3_rst_ogsr  : std_logic := 'X';
  signal signedb_0_rst_ogsr  : std_logic := 'X';
  signal signedb_1_rst_ogsr  : std_logic := 'X';
  signal signedb_2_rst_ogsr  : std_logic := 'X';
  signal signedb_3_rst_ogsr  : std_logic := 'X';
  signal addnsub1_0_rst_ogsr  : std_logic := 'X';
  signal addnsub1_1_rst_ogsr  : std_logic := 'X';
  signal addnsub3_0_rst_ogsr  : std_logic := 'X';
  signal addnsub3_1_rst_ogsr  : std_logic := 'X';

begin 

    global_reset : process (purnet, gsrnet)
      begin
        if (GSR =  "DISABLED") then
           SRN <= purnet;
        else
           SRN <= purnet AND gsrnet;
        end if;
      end process;

    input_a0_rst_ogsr <= input_a0_rst or not SRN;
    input_a1_rst_ogsr <= input_a1_rst or not SRN;
    input_a2_rst_ogsr <= input_a2_rst or not SRN;
    input_a3_rst_ogsr <= input_a3_rst or not SRN;
    input_b0_rst_ogsr <= input_b0_rst or not SRN;
    input_b1_rst_ogsr <= input_b1_rst or not SRN;
    input_b2_rst_ogsr <= input_b2_rst or not SRN;
    input_b3_rst_ogsr <= input_b3_rst or not SRN;
    pipeline0_rst_ogsr <= pipeline0_rst or not SRN;
    pipeline1_rst_ogsr <= pipeline1_rst or not SRN;
    pipeline2_rst_ogsr <= pipeline2_rst or not SRN;
    pipeline3_rst_ogsr <= pipeline3_rst or not SRN;
    output_rst_ogsr <= output_rst or not SRN;
    signeda_0_rst_ogsr <= signeda_0_rst or not SRN;
    signeda_1_rst_ogsr <= signeda_1_rst or not SRN;
    signedb_0_rst_ogsr <= signedb_0_rst or not SRN;
    signedb_1_rst_ogsr <= signedb_1_rst or not SRN;
    addnsub1_0_rst_ogsr <= addnsub1_0_rst or not SRN;
    addnsub1_1_rst_ogsr <= addnsub1_1_rst or not SRN;
    addnsub3_0_rst_ogsr <= addnsub3_0_rst or not SRN;
    addnsub3_1_rst_ogsr <= addnsub3_1_rst or not SRN;

    A0_ipd1 <= (A017 & A016 & A015 & A014 & A013 & A012 & A011 & A010 & A09 & A08 & A07 & A06 & A05 & A04 & A03 & A02 & A01 & A00);
    A1_ipd1 <= (A117 & A116 & A115 & A114 & A113 & A112 & A111 & A110 & A19 & A18 & A17 & A16 & A15 & A14 & A13 & A12 & A11 & A10);
    A2_ipd1 <= (A217 & A216 & A215 & A214 & A213 & A212 & A211 & A210 & A29 & A28 & A27 & A26 & A25 & A24 & A23 & A22 & A21 & A20);
    A3_ipd1 <= (A317 & A316 & A315 & A314 & A313 & A312 & A311 & A310 & A39 & A38 & A37 & A36 & A35 & A34 & A33 & A32 & A31 & A30);
    B0_ipd1 <= (B017 & B016 & B015 & B014 & B013 & B012 & B011 & B010 & B09 & B08 & B07 & B06 & B05 & B04 & B03 & B02 & B01 & B00);
    B1_ipd1 <= (B117 & B116 & B115 & B114 & B113 & B112 & B111 & B110 & B19 & B18 & B17 & B16 & B15 & B14 & B13 & B12 & B11 & B10);
    B2_ipd1 <= (B217 & B216 & B215 & B214 & B213 & B212 & B211 & B210 & B29 & B28 & B27 & B26 & B25 & B24 & B23 & B22 & B21 & B20);
    B3_ipd1 <= (B317 & B316 & B315 & B314 & B313 & B312 & B311 & B310 & B39 & B38 & B37 & B36 & B35 & B34 & B33 & B32 & B31 & B30);
    SRIA_ipd1 <= (SRIA17 & SRIA16 & SRIA15 & SRIA14 & SRIA13 & SRIA12 & SRIA11 & SRIA10 & SRIA9 & SRIA8 & SRIA7 & SRIA6 & SRIA5 & SRIA4 & SRIA3 & SRIA2 & SRIA1 & SRIA0);
    SRIB_ipd1 <= (SRIB17 & SRIB16 & SRIB15 & SRIB14 & SRIB13 & SRIB12 & SRIB11 & SRIB10 & SRIB9 & SRIB8 & SRIB7 & SRIB6 & SRIB5 & SRIB4 & SRIB3 & SRIB2 & SRIB1 & SRIB0);
    SIGNEDA_ipd1 <= SIGNEDA;
    SIGNEDB_ipd1 <= SIGNEDB;
    SOURCEA0_ipd1 <= SOURCEA0;
    SOURCEA1_ipd1 <= SOURCEA1;
    SOURCEA2_ipd1 <= SOURCEA2;
    SOURCEA3_ipd1 <= SOURCEA3;
    SOURCEB0_ipd1 <= SOURCEB0;
    SOURCEB1_ipd1 <= SOURCEB1;
    SOURCEB2_ipd1 <= SOURCEB2;
    SOURCEB3_ipd1 <= SOURCEB3;
    ADDNSUB1_ipd1 <= ADDNSUB1;
    ADDNSUB3_ipd1 <= ADDNSUB3;

    A0_ipd <= A0_ipd1;
    A1_ipd <= A1_ipd1;
    A2_ipd <= A2_ipd1;
    A3_ipd <= A3_ipd1;
    B0_ipd <= B0_ipd1;
    B1_ipd <= B1_ipd1;
    B2_ipd <= B2_ipd1;
    B3_ipd <= B3_ipd1;
    SRIA_ipd <= SRIA_ipd1;
    SRIB_ipd <= SRIB_ipd1;
    SIGNEDA_ipd <= SIGNEDA_ipd1;
    SIGNEDB_ipd <= SIGNEDB_ipd1;
    SOURCEA0_ipd <= SOURCEA0_ipd1;
    SOURCEA1_ipd <= SOURCEA1_ipd1;
    SOURCEA2_ipd <= SOURCEA2_ipd1;
    SOURCEA3_ipd <= SOURCEA3_ipd1;
    SOURCEB0_ipd <= SOURCEB0_ipd1;
    SOURCEB1_ipd <= SOURCEB1_ipd1;
    SOURCEB2_ipd <= SOURCEB2_ipd1;
    SOURCEB3_ipd <= SOURCEB3_ipd1;
    ADDNSUB1_ipd <= ADDNSUB1_ipd1;
    ADDNSUB3_ipd <= ADDNSUB3_ipd1;

    CE0_ipd <= CE0;
    CE1_ipd <= CE1;
    CE2_ipd <= CE2;
    CE3_ipd <= CE3;
    CLK0_ipd <= CLK0;
    CLK1_ipd <= CLK1;
    CLK2_ipd <= CLK2;
    CLK3_ipd <= CLK3;
    RST0_ipd <= RST0;
    RST1_ipd <= RST1;
    RST2_ipd <= RST2;
    RST3_ipd <= RST3;

    SROA0 <= SROA_reg3(0);
    SROA1 <= SROA_reg3(1);
    SROA2 <= SROA_reg3(2);
    SROA3 <= SROA_reg3(3);
    SROA4 <= SROA_reg3(4);
    SROA5 <= SROA_reg3(5);
    SROA6 <= SROA_reg3(6);
    SROA7 <= SROA_reg3(7);
    SROA8 <= SROA_reg3(8);
    SROA9 <= SROA_reg3(9);
    SROA10 <= SROA_reg3(10);
    SROA11 <= SROA_reg3(11);
    SROA12 <= SROA_reg3(12);
    SROA13 <= SROA_reg3(13);
    SROA14 <= SROA_reg3(14);
    SROA15 <= SROA_reg3(15);
    SROA16 <= SROA_reg3(16);
    SROA17 <= SROA_reg3(17);

    SROB0 <= SROB_reg3(0);
    SROB1 <= SROB_reg3(1);
    SROB2 <= SROB_reg3(2);
    SROB3 <= SROB_reg3(3);
    SROB4 <= SROB_reg3(4);
    SROB5 <= SROB_reg3(5);
    SROB6 <= SROB_reg3(6);
    SROB7 <= SROB_reg3(7);
    SROB8 <= SROB_reg3(8);
    SROB9 <= SROB_reg3(9);
    SROB10 <= SROB_reg3(10);
    SROB11 <= SROB_reg3(11);
    SROB12 <= SROB_reg3(12);
    SROB13 <= SROB_reg3(13);
    SROB14 <= SROB_reg3(14);
    SROB15 <= SROB_reg3(15);
    SROB16 <= SROB_reg3(16);
    SROB17 <= SROB_reg3(17);

    SUM0 <= SUM_ipd(0);
    SUM1 <= SUM_ipd(1);
    SUM2 <= SUM_ipd(2);
    SUM3 <= SUM_ipd(3);
    SUM4 <= SUM_ipd(4);
    SUM5 <= SUM_ipd(5);
    SUM6 <= SUM_ipd(6);
    SUM7 <= SUM_ipd(7);
    SUM8 <= SUM_ipd(8);
    SUM9 <= SUM_ipd(9);
    SUM10 <= SUM_ipd(10);
    SUM11 <= SUM_ipd(11);
    SUM12 <= SUM_ipd(12);
    SUM13 <= SUM_ipd(13);
    SUM14 <= SUM_ipd(14);
    SUM15 <= SUM_ipd(15);
    SUM16 <= SUM_ipd(16);
    SUM17 <= SUM_ipd(17);
    SUM18 <= SUM_ipd(18);
    SUM19 <= SUM_ipd(19);
    SUM20 <= SUM_ipd(20);
    SUM21 <= SUM_ipd(21);
    SUM22 <= SUM_ipd(22);
    SUM23 <= SUM_ipd(23);
    SUM24 <= SUM_ipd(24);
    SUM25 <= SUM_ipd(25);
    SUM26 <= SUM_ipd(26);
    SUM27 <= SUM_ipd(27);
    SUM28 <= SUM_ipd(28);
    SUM29 <= SUM_ipd(29);
    SUM30 <= SUM_ipd(30);
    SUM31 <= SUM_ipd(31);
    SUM32 <= SUM_ipd(32);
    SUM33 <= SUM_ipd(33);
    SUM34 <= SUM_ipd(34);
    SUM35 <= SUM_ipd(35);
    SUM36 <= SUM_ipd(36);
    SUM37 <= SUM_ipd(37);


  Input_A0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA0_CLK = "CLK0") then
       input_a0_clk <= CLK0_ipd;
     elsif (REG_INPUTA0_CLK = "CLK1") then
       input_a0_clk <= CLK1_ipd;
     elsif (REG_INPUTA0_CLK = "CLK2") then
       input_a0_clk <= CLK2_ipd;
     elsif (REG_INPUTA0_CLK = "CLK3") then
       input_a0_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA1_CLK = "CLK0") then
       input_a1_clk <= CLK0_ipd;
     elsif (REG_INPUTA1_CLK = "CLK1") then
       input_a1_clk <= CLK1_ipd;
     elsif (REG_INPUTA1_CLK = "CLK2") then
       input_a1_clk <= CLK2_ipd;
     elsif (REG_INPUTA1_CLK = "CLK3") then
       input_a1_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A2_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA2_CLK = "CLK0") then
       input_a2_clk <= CLK0_ipd;
     elsif (REG_INPUTA2_CLK = "CLK1") then
       input_a2_clk <= CLK1_ipd;
     elsif (REG_INPUTA2_CLK = "CLK2") then
       input_a2_clk <= CLK2_ipd;
     elsif (REG_INPUTA2_CLK = "CLK3") then
       input_a2_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A3_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA3_CLK = "CLK0") then
       input_a3_clk <= CLK0_ipd;
     elsif (REG_INPUTA3_CLK = "CLK1") then
       input_a3_clk <= CLK1_ipd;
     elsif (REG_INPUTA3_CLK = "CLK2") then
       input_a3_clk <= CLK2_ipd;
     elsif (REG_INPUTA3_CLK = "CLK3") then
       input_a3_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA0_CE = "CE0") then
       input_a0_ce <= CE0_ipd;
     elsif (REG_INPUTA0_CE = "CE1") then
       input_a0_ce <= CE1_ipd;
     elsif (REG_INPUTA0_CE = "CE2") then
       input_a0_ce <= CE2_ipd;
     elsif (REG_INPUTA0_CE = "CE3") then
       input_a0_ce <= CE3_ipd;
     end if;
  end process;

  Input_A1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA1_CE = "CE0") then
       input_a1_ce <= CE0_ipd;
     elsif (REG_INPUTA1_CE = "CE1") then
       input_a1_ce <= CE1_ipd;
     elsif (REG_INPUTA1_CE = "CE2") then
       input_a1_ce <= CE2_ipd;
     elsif (REG_INPUTA1_CE = "CE3") then
       input_a1_ce <= CE3_ipd;
     end if;
  end process;

  Input_A2_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA2_CE = "CE0") then
       input_a2_ce <= CE0_ipd;
     elsif (REG_INPUTA2_CE = "CE1") then
       input_a2_ce <= CE1_ipd;
     elsif (REG_INPUTA2_CE = "CE2") then
       input_a2_ce <= CE2_ipd;
     elsif (REG_INPUTA2_CE = "CE3") then
       input_a2_ce <= CE3_ipd;
     end if;
  end process;

  Input_A3_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA3_CE = "CE0") then
       input_a3_ce <= CE0_ipd;
     elsif (REG_INPUTA3_CE = "CE1") then
       input_a3_ce <= CE1_ipd;
     elsif (REG_INPUTA3_CE = "CE2") then
       input_a3_ce <= CE2_ipd;
     elsif (REG_INPUTA3_CE = "CE3") then
       input_a3_ce <= CE3_ipd;
     end if;
  end process;

  Input_A0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA0_RST = "RST0") then
       input_a0_rst <= RST0_ipd;
     elsif (REG_INPUTA0_RST = "RST1") then
       input_a0_rst <= RST1_ipd;
     elsif (REG_INPUTA0_RST = "RST2") then
       input_a0_rst <= RST2_ipd;
     elsif (REG_INPUTA0_RST = "RST3") then
       input_a0_rst <= RST3_ipd;
     end if;
  end process;

  Input_A1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA1_RST = "RST0") then
       input_a1_rst <= RST0_ipd;
     elsif (REG_INPUTA1_RST = "RST1") then
       input_a1_rst <= RST1_ipd;
     elsif (REG_INPUTA1_RST = "RST2") then
       input_a1_rst <= RST2_ipd;
     elsif (REG_INPUTA1_RST = "RST3") then
       input_a1_rst <= RST3_ipd;
     end if;
  end process;
      
  Input_A2_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA2_RST = "RST0") then
       input_a2_rst <= RST0_ipd;
     elsif (REG_INPUTA2_RST = "RST1") then
       input_a2_rst <= RST1_ipd;
     elsif (REG_INPUTA2_RST = "RST2") then
       input_a2_rst <= RST2_ipd;
     elsif (REG_INPUTA2_RST = "RST3") then
       input_a2_rst <= RST3_ipd;
     end if;
  end process;
      
  Input_A3_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA3_RST = "RST0") then
       input_a3_rst <= RST0_ipd;
     elsif (REG_INPUTA3_RST = "RST1") then
       input_a3_rst <= RST1_ipd;
     elsif (REG_INPUTA3_RST = "RST2") then
       input_a3_rst <= RST2_ipd;
     elsif (REG_INPUTA3_RST = "RST3") then
       input_a3_rst <= RST3_ipd;
     end if;
  end process;
      
  Register_A0_Input : process(input_a0_clk, input_a0_rst_ogsr, input_a0_ce, A0_p)
  begin
     if (input_a0_rst_ogsr = '1') then
       A0_reg <= (others => '0');
     elsif (rising_edge(input_a0_clk)) then
       if (input_a0_ce = '1') then
         A0_reg <= A0_p;
       end if;
     end if;
  end process;

  Register_A1_Input : process(input_a1_clk, input_a1_rst_ogsr, input_a1_ce, A1_p)
  begin
     if (input_a1_rst_ogsr = '1') then
       A1_reg <= (others => '0');
     elsif (rising_edge(input_a1_clk)) then
       if (input_a1_ce = '1') then
         A1_reg <= A1_p;
       end if;
     end if;
  end process;

  Register_A2_Input : process(input_a2_clk, input_a2_rst_ogsr, input_a2_ce, A2_p)
  begin
     if (input_a2_rst_ogsr = '1') then
       A2_reg <= (others => '0');
     elsif (rising_edge(input_a2_clk)) then
       if (input_a2_ce = '1') then
         A2_reg <= A2_p;
       end if;
     end if;
  end process;

  Register_A3_Input : process(input_a3_clk, input_a3_rst_ogsr, input_a3_ce, A3_p)
  begin
     if (input_a3_rst_ogsr = '1') then
       A3_reg <= (others => '0');
     elsif (rising_edge(input_a3_clk)) then
       if (input_a3_ce = '1') then
         A3_reg <= A3_p;
       end if;
     end if;
  end process;

  Select_A0_OR_A0_reg : process (A0_p, A0_reg)
  begin
     if (REG_INPUTA0_CLK = "NONE") then
       A0_gen <= A0_p;
     else
       A0_gen <= A0_reg;
     end if;
  end process;

  Select_A1_OR_A1_reg : process (A1_p, A1_reg)
  begin
     if (REG_INPUTA1_CLK = "NONE") then
       A1_gen <= A1_p;
     else
       A1_gen <= A1_reg;
     end if;
  end process;

  Select_A2_OR_A2_reg : process (A2_p, A2_reg)
  begin
     if (REG_INPUTA2_CLK = "NONE") then
       A2_gen <= A2_p;
     else
       A2_gen <= A2_reg;
     end if;
  end process;

  Select_A3_OR_A3_reg : process (A3_p, A3_reg)
  begin
     if (REG_INPUTA3_CLK = "NONE") then
       A3_gen <= A3_p;
     else
       A3_gen <= A3_reg;
     end if;
  end process;

  SROA_reg3 <= A3_gen;

  Select_A0_p_OR_SRIA_ipd : process(A0_ipd, SRIA_ipd, SOURCEA0_ipd)
  begin
     if (SOURCEA0_ipd = '1') then
       A0_p <= SRIA_ipd;
     elsif (SOURCEA0_ipd = '0') then 
       A0_p <= A0_ipd;
     end if;
  end process;    

  Select_A1_p_OR_SROA_reg : process(A1_ipd, A0_gen, SOURCEA1_ipd)
  begin
     if (SOURCEA1_ipd = '1') then
       A1_p <= A0_gen;
     elsif (SOURCEA1_ipd = '0') then 
       A1_p <= A1_ipd;
     end if;
  end process;    

  Select_A2_p_OR_SROA_reg : process(A2_ipd, A1_gen, SOURCEA2_ipd)
  begin
     if (SOURCEA2_ipd = '1') then
       A2_p <= A1_gen;
     elsif (SOURCEA2_ipd = '0') then 
       A2_p <= A2_ipd;
     end if;
  end process;    

  Select_A3_p_OR_SROA_reg : process(A3_ipd, A2_gen, SOURCEA3_ipd)
  begin
     if (SOURCEA3_ipd = '1') then
       A3_p <= A2_gen;
     elsif (SOURCEA3_ipd = '0') then 
       A3_p <= A3_ipd;
     end if;
  end process;    

  Input_B0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB0_CLK = "CLK0") then
       input_b0_clk <= CLK0_ipd;
     elsif (REG_INPUTB0_CLK = "CLK1") then
       input_b0_clk <= CLK1_ipd;
     elsif (REG_INPUTB0_CLK = "CLK2") then
       input_b0_clk <= CLK2_ipd;
     elsif (REG_INPUTB0_CLK = "CLK3") then
       input_b0_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB1_CLK = "CLK0") then
       input_b1_clk <= CLK0_ipd;
     elsif (REG_INPUTB1_CLK = "CLK1") then
       input_b1_clk <= CLK1_ipd;
     elsif (REG_INPUTB1_CLK = "CLK2") then
       input_b1_clk <= CLK2_ipd;
     elsif (REG_INPUTB1_CLK = "CLK3") then
       input_b1_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B2_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB2_CLK = "CLK0") then
       input_b2_clk <= CLK0_ipd;
     elsif (REG_INPUTB2_CLK = "CLK1") then
       input_b2_clk <= CLK1_ipd;
     elsif (REG_INPUTB2_CLK = "CLK2") then
       input_b2_clk <= CLK2_ipd;
     elsif (REG_INPUTB2_CLK = "CLK3") then
       input_b2_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B3_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB3_CLK = "CLK0") then
       input_b3_clk <= CLK0_ipd;
     elsif (REG_INPUTB3_CLK = "CLK1") then
       input_b3_clk <= CLK1_ipd;
     elsif (REG_INPUTB3_CLK = "CLK2") then
       input_b3_clk <= CLK2_ipd;
     elsif (REG_INPUTB3_CLK = "CLK3") then
       input_b3_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB0_CE = "CE0") then
       input_b0_ce <= CE0_ipd;
     elsif (REG_INPUTB0_CE = "CE1") then
       input_b0_ce <= CE1_ipd;
     elsif (REG_INPUTB0_CE = "CE2") then
       input_b0_ce <= CE2_ipd;
     elsif (REG_INPUTB0_CE = "CE3") then
       input_b0_ce <= CE3_ipd;
     end if;
  end process;

  Input_B1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB1_CE = "CE0") then
       input_b1_ce <= CE0_ipd;
     elsif (REG_INPUTB1_CE = "CE1") then
       input_b1_ce <= CE1_ipd;
     elsif (REG_INPUTB1_CE = "CE2") then
       input_b1_ce <= CE2_ipd;
     elsif (REG_INPUTB1_CE = "CE3") then
       input_b1_ce <= CE3_ipd;
     end if;
  end process;

  Input_B2_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB2_CE = "CE0") then
       input_b2_ce <= CE0_ipd;
     elsif (REG_INPUTB2_CE = "CE1") then
       input_b2_ce <= CE1_ipd;
     elsif (REG_INPUTB2_CE = "CE2") then
       input_b2_ce <= CE2_ipd;
     elsif (REG_INPUTB2_CE = "CE3") then
       input_b2_ce <= CE3_ipd;
     end if;
  end process;

  Input_B3_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB3_CE = "CE0") then
       input_b3_ce <= CE0_ipd;
     elsif (REG_INPUTB3_CE = "CE1") then
       input_b3_ce <= CE1_ipd;
     elsif (REG_INPUTB3_CE = "CE2") then
       input_b3_ce <= CE2_ipd;
     elsif (REG_INPUTB3_CE = "CE3") then
       input_b3_ce <= CE3_ipd;
     end if;
  end process;

  Input_B0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB0_RST = "RST0") then
       input_b0_rst <= RST0_ipd;
     elsif (REG_INPUTB0_RST = "RST1") then
       input_b0_rst <= RST1_ipd;
     elsif (REG_INPUTB0_RST = "RST2") then
       input_b0_rst <= RST2_ipd;
     elsif (REG_INPUTB0_RST = "RST3") then
       input_b0_rst <= RST3_ipd;
     end if;
  end process;

  Input_B1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB1_RST = "RST0") then
       input_b1_rst <= RST0_ipd;
     elsif (REG_INPUTB1_RST = "RST1") then
       input_b1_rst <= RST1_ipd;
     elsif (REG_INPUTB1_RST = "RST2") then
       input_b1_rst <= RST2_ipd;
     elsif (REG_INPUTB1_RST = "RST3") then
       input_b1_rst <= RST3_ipd;
     end if;
  end process;

  Input_B2_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB2_RST = "RST0") then
       input_b2_rst <= RST0_ipd;
     elsif (REG_INPUTB2_RST = "RST1") then
       input_b2_rst <= RST1_ipd;
     elsif (REG_INPUTB2_RST = "RST2") then
       input_b2_rst <= RST2_ipd;
     elsif (REG_INPUTB2_RST = "RST3") then
       input_b2_rst <= RST3_ipd;
     end if;
  end process;

  Input_B3_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB3_RST = "RST0") then
       input_b3_rst <= RST0_ipd;
     elsif (REG_INPUTB3_RST = "RST1") then
       input_b3_rst <= RST1_ipd;
     elsif (REG_INPUTB3_RST = "RST2") then
       input_b3_rst <= RST2_ipd;
     elsif (REG_INPUTB3_RST = "RST3") then
       input_b3_rst <= RST3_ipd;
     end if;
  end process;

  Register_B0_Input : process(input_b0_clk, input_b0_rst_ogsr, input_b0_ce, B0_p)
  begin
     if (input_b0_rst_ogsr = '1') then
       B0_reg <= (others => '0');
     elsif (rising_edge(input_b0_clk)) then
       if (input_b0_ce = '1') then
         B0_reg <= B0_p;
       end if;
     end if;
  end process;

  Register_B1_Input : process(input_b1_clk, input_b1_rst_ogsr, input_b1_ce, B1_p)
  begin
     if (input_b1_rst_ogsr = '1') then
       B1_reg <= (others => '0');
     elsif (rising_edge(input_b1_clk)) then
       if (input_b1_ce = '1') then
         B1_reg <= B1_p;
       end if;
     end if;
  end process;

  Register_B2_Input : process(input_b2_clk, input_b2_rst_ogsr, input_b2_ce, B2_p)
  begin
     if (input_b2_rst_ogsr = '1') then
       B2_reg <= (others => '0');
     elsif (rising_edge(input_b2_clk)) then
       if (input_b2_ce = '1') then
         B2_reg <= B2_p;
       end if;
     end if;
  end process;

  Register_B3_Input : process(input_b3_clk, input_b3_rst_ogsr, input_b3_ce, B3_p)
  begin
     if (input_b3_rst_ogsr = '1') then
       B3_reg <= (others => '0');
     elsif (rising_edge(input_b3_clk)) then
       if (input_b3_ce = '1') then
         B3_reg <= B3_p;
       end if;
     end if;
  end process;

  Select_B0_OR_B0_reg : process (B0_p, B0_reg)
  begin
     if (REG_INPUTB0_CLK = "NONE") then
       B0_gen <= B0_p;
     else
       B0_gen <= B0_reg;
     end if;
  end process;    

  Select_B1_OR_B1_reg : process (B1_p, B1_reg)
  begin
     if (REG_INPUTB1_CLK = "NONE") then
       B1_gen <= B1_p;
     else
       B1_gen <= B1_reg;
     end if;
  end process;    
    
  Select_B2_OR_B2_reg : process (B2_p, B2_reg)
  begin
     if (REG_INPUTB2_CLK = "NONE") then
       B2_gen <= B2_p;
     else
       B2_gen <= B2_reg;
     end if;
  end process;    
    
  Select_B3_OR_B3_reg : process (B3_p, B3_reg)
  begin
     if (REG_INPUTB3_CLK = "NONE") then
       B3_gen <= B3_p;
     else
       B3_gen <= B3_reg;
     end if;
  end process;    

  SROB_reg3 <= B3_gen;
    
  Select_B0_p_OR_SRIB_ipd : process(B0_ipd, SRIB_ipd, SOURCEB0_ipd)
  begin
     if (SOURCEB0_ipd = '1') then
       B0_p <= SRIB_ipd;
     elsif (SOURCEB0_ipd = '0') then 
       B0_p <= B0_ipd;
     end if;
  end process;  

  Select_B1_p_OR_SROB_reg : process(B1_ipd, B0_gen, SOURCEB1_ipd)
  begin
     if (SOURCEB1_ipd = '1') then
       B1_p <= B0_gen;
     elsif (SOURCEB1_ipd = '0') then 
       B1_p <= B1_ipd;
     end if;
  end process;  

  Select_B2_p_OR_SROB_reg1 : process(B2_ipd, B1_gen, SOURCEB2_ipd)
  begin
     if (SOURCEB2_ipd = '1') then
       B2_p <= B1_gen;
     elsif (SOURCEB2_ipd = '0') then 
       B2_p <= B2_ipd;
     end if;
  end process;  

  Select_B3_p_OR_SROB_reg2 : process(B3_ipd, B2_gen, SOURCEB3_ipd)
  begin
     if (SOURCEB3_ipd = '1') then
       B3_p <= B2_gen;
     elsif (SOURCEB3_ipd = '0') then 
       B3_p <= B3_ipd;
     end if;
  end process;  

  SIGNEDAB_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_0_CLK = "CLK0") then
       signeda_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK1") then
       signeda_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK2") then
       signeda_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK3") then
       signeda_0_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_0_CLK = "CLK0") then
       signedb_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK1") then
       signedb_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK2") then
       signedb_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK3") then
       signedb_0_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_0_CE = "CE0") then
       signeda_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE1") then
       signeda_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE2") then
       signeda_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE3") then
       signeda_0_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_0_CE = "CE0") then
       signedb_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE1") then
       signedb_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE2") then
       signedb_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE3") then
       signedb_0_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_0_RST = "RST0") then
       signeda_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST1") then
       signeda_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST2") then
       signeda_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST3") then
       signeda_0_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_0_RST = "RST0") then
       signedb_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST1") then
       signedb_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST2") then
       signedb_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST3") then
       signedb_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_SIGNEDA : process(signeda_0_clk, signeda_0_rst_ogsr, signeda_0_ce, SIGNEDA_ipd)
  begin
     if (signeda_0_rst_ogsr = '1') then
       SIGNEDA_0_reg <= '0';
     elsif (rising_edge(signeda_0_clk)) then
       if (signeda_0_ce = '1') then
         SIGNEDA_0_reg <= SIGNEDA_ipd;
       end if;
     end if;
  end process;

  Register_0_SIGNEDB : process(signedb_0_clk, signedb_0_rst_ogsr, signedb_0_ce, SIGNEDB_ipd)
  begin
     if (signedb_0_rst_ogsr = '1') then
       SIGNEDB_0_reg <= '0';
     elsif (rising_edge(signedb_0_clk)) then
       if (signedb_0_ce = '1') then
         SIGNEDB_0_reg <= SIGNEDB_ipd;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_0_reg : process (SIGNEDA_ipd, SIGNEDA_0_reg)
  begin
     if (REG_SIGNEDA_0_CLK = "NONE") then
       SIGNEDA_p1 <= SIGNEDA_ipd;
     else
       SIGNEDA_p1 <= SIGNEDA_0_reg;
     end if;
  end process; 

  Select_SIGNEDB_ipd_OR_SIGNEDB_0_reg : process (SIGNEDB_ipd, SIGNEDB_0_reg)
  begin
     if (REG_SIGNEDB_0_CLK = "NONE") then
       SIGNEDB_p1 <= SIGNEDB_ipd;
     else
       SIGNEDB_p1 <= SIGNEDB_0_reg;
     end if;
  end process;

  SIGNEDAB_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_1_CLK = "CLK0") then
       signeda_1_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK1") then
       signeda_1_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK2") then
       signeda_1_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK3") then
       signeda_1_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_1_CLK = "CLK0") then
       signedb_1_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK1") then
       signedb_1_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK2") then
       signedb_1_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK3") then
       signedb_1_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_1_CE = "CE0") then
       signeda_1_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE1") then
       signeda_1_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE2") then
       signeda_1_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE3") then
       signeda_1_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_1_CE = "CE0") then
       signedb_1_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE1") then
       signedb_1_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE2") then
       signedb_1_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE3") then
       signedb_1_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_1_RST = "RST0") then
       signeda_1_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_1_RST = "RST1") then
       signeda_1_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST2") then
       signeda_1_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_1_RST = "RST3") then
       signeda_1_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_1_RST = "RST0") then
       signedb_1_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_1_RST = "RST1") then
       signedb_1_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST2") then
       signedb_1_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_1_RST = "RST3") then
       signedb_1_rst <= RST3_ipd;
     end if;
  end process;

  Register_1_SIGNEDA : process(signeda_1_clk, signeda_1_rst_ogsr, signeda_1_ce, SIGNEDA_p1)
  begin
     if (signeda_0_rst_ogsr = '1') then
       SIGNEDA_1_reg <= '0';
     elsif (rising_edge(signeda_1_clk)) then
       if (signeda_1_ce = '1') then
         SIGNEDA_1_reg <= SIGNEDA_p1;
       end if;
     end if;
  end process;

  Register_1_SIGNEDB : process(signedb_1_clk, signedb_1_rst_ogsr, signedb_1_ce, SIGNEDB_p1)
  begin
     if (signedb_0_rst_ogsr = '1') then
       SIGNEDB_1_reg <= '0';
     elsif (rising_edge(signedb_1_clk)) then
       if (signedb_1_ce = '1') then
         SIGNEDB_1_reg <= SIGNEDB_p1;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_1_reg : process (SIGNEDA_p1, SIGNEDA_1_reg)
  begin
     if (REG_SIGNEDA_1_CLK = "NONE") then
       SIGNEDA_p2 <= SIGNEDA_p1;
     else
       SIGNEDA_p2 <= SIGNEDA_1_reg;
     end if;
  end process; 

  Select_SIGNEDB_ipd_OR_SIGNEDB_1_reg : process (SIGNEDB_p1, SIGNEDB_1_reg)
  begin
     if (REG_SIGNEDB_1_CLK = "NONE") then
       SIGNEDB_p2 <= SIGNEDB_p1;
     else
       SIGNEDB_p2 <= SIGNEDB_1_reg;
     end if;
  end process;

  addnsub1_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB1_0_CLK = "CLK0") then
       addnsub1_0_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB1_0_CLK = "CLK1") then
       addnsub1_0_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB1_0_CLK = "CLK2") then
       addnsub1_0_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB1_0_CLK = "CLK3") then
       addnsub1_0_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub3_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB3_0_CLK = "CLK0") then
       addnsub3_0_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB3_0_CLK = "CLK1") then
       addnsub3_0_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB3_0_CLK = "CLK2") then
       addnsub3_0_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB3_0_CLK = "CLK3") then
       addnsub3_0_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub1_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB1_0_CE = "CE0") then
       addnsub1_0_ce <= CE0_ipd;
     elsif (REG_ADDNSUB1_0_CE = "CE1") then
       addnsub1_0_ce <= CE1_ipd;
     elsif (REG_ADDNSUB1_0_CE = "CE2") then
       addnsub1_0_ce <= CE2_ipd;
     elsif (REG_ADDNSUB1_0_CE = "CE3") then
       addnsub1_0_ce <= CE3_ipd;
     end if;
  end process;

  addnsub3_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB3_0_CE = "CE0") then
       addnsub3_0_ce <= CE0_ipd;
     elsif (REG_ADDNSUB3_0_CE = "CE1") then
       addnsub3_0_ce <= CE1_ipd;
     elsif (REG_ADDNSUB3_0_CE = "CE2") then
       addnsub3_0_ce <= CE2_ipd;
     elsif (REG_ADDNSUB3_0_CE = "CE3") then
       addnsub3_0_ce <= CE3_ipd;
     end if;
  end process;

  addnsub1_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB1_0_RST = "RST0") then
       addnsub1_0_rst <= RST0_ipd;
     elsif (REG_ADDNSUB1_0_RST = "RST1") then
       addnsub1_0_rst <= RST1_ipd;
     elsif (REG_ADDNSUB1_0_RST = "RST2") then
       addnsub1_0_rst <= RST2_ipd;
     elsif (REG_ADDNSUB1_0_RST = "RST3") then
       addnsub1_0_rst <= RST3_ipd;
     end if;
  end process;

  addnsub3_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB3_0_RST = "RST0") then
       addnsub3_0_rst <= RST0_ipd;
     elsif (REG_ADDNSUB3_0_RST = "RST1") then
       addnsub3_0_rst <= RST1_ipd;
     elsif (REG_ADDNSUB3_0_RST = "RST2") then
       addnsub3_0_rst <= RST2_ipd;
     elsif (REG_ADDNSUB3_0_RST = "RST3") then
       addnsub3_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_addnsub1 : process(addnsub1_0_clk, addnsub1_0_rst_ogsr, addnsub1_0_ce, addnsub1_ipd)
  begin
     if (addnsub1_0_rst_ogsr = '1') then
       addnsub1_0_reg <= '0';
     elsif (rising_edge(addnsub1_0_clk)) then
       if (addnsub1_0_ce = '1') then
         addnsub1_0_reg <= addnsub1_ipd;
       end if;
     end if;
  end process;

  Register_0_addnsub3 : process(addnsub3_0_clk, addnsub3_0_rst_ogsr, addnsub3_0_ce, addnsub3_ipd)
  begin
     if (addnsub3_0_rst_ogsr = '1') then
       addnsub3_0_reg <= '0';
     elsif (rising_edge(addnsub3_0_clk)) then
       if (addnsub3_0_ce = '1') then
         addnsub3_0_reg <= addnsub3_ipd;
       end if;
     end if;
  end process;

  Select_addnsub1_ipd_OR_addnsub1_0_reg : process (addnsub1_ipd, addnsub1_0_reg)
  begin
     if (REG_ADDNSUB1_0_CLK = "NONE") then
       addnsub1_p1 <= addnsub1_ipd;
     else
       addnsub1_p1 <= addnsub1_0_reg;
     end if;
  end process; 

  Select_addnsub3_ipd_OR_addnsub3_0_reg : process (addnsub3_ipd, addnsub3_0_reg)
  begin
     if (REG_ADDNSUB3_0_CLK = "NONE") then
       addnsub3_p1 <= addnsub3_ipd;
     else
       addnsub3_p1 <= addnsub3_0_reg;
     end if;
  end process; 

  addnsub1_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB1_1_CLK = "CLK0") then
       addnsub1_1_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB1_1_CLK = "CLK1") then
       addnsub1_1_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB1_1_CLK = "CLK2") then
       addnsub1_1_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB1_1_CLK = "CLK3") then
       addnsub1_1_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub3_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB3_1_CLK = "CLK0") then
       addnsub3_1_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB3_1_CLK = "CLK1") then
       addnsub3_1_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB3_1_CLK = "CLK2") then
       addnsub3_1_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB3_1_CLK = "CLK3") then
       addnsub3_1_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub1_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB1_1_CE = "CE0") then
       addnsub1_1_ce <= CE0_ipd;
     elsif (REG_ADDNSUB1_1_CE = "CE1") then
       addnsub1_1_ce <= CE1_ipd;
     elsif (REG_ADDNSUB1_1_CE = "CE2") then
       addnsub1_1_ce <= CE2_ipd;
     elsif (REG_ADDNSUB1_1_CE = "CE3") then
       addnsub1_1_ce <= CE3_ipd;
     end if;
  end process;

  addnsub3_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB3_1_CE = "CE0") then
       addnsub3_1_ce <= CE0_ipd;
     elsif (REG_ADDNSUB3_1_CE = "CE1") then
       addnsub3_1_ce <= CE1_ipd;
     elsif (REG_ADDNSUB3_1_CE = "CE2") then
       addnsub3_1_ce <= CE2_ipd;
     elsif (REG_ADDNSUB3_1_CE = "CE3") then
       addnsub3_1_ce <= CE3_ipd;
     end if;
  end process;

  addnsub1_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB1_1_RST = "RST0") then
       addnsub1_1_rst <= RST0_ipd;
     elsif (REG_ADDNSUB1_1_RST = "RST1") then
       addnsub1_1_rst <= RST1_ipd;
     elsif (REG_ADDNSUB1_0_RST = "RST2") then
       addnsub1_1_rst <= RST2_ipd;
     elsif (REG_ADDNSUB1_1_RST = "RST3") then
       addnsub1_1_rst <= RST3_ipd;
     end if;
  end process;

  addnsub3_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB3_1_RST = "RST0") then
       addnsub3_1_rst <= RST0_ipd;
     elsif (REG_ADDNSUB3_1_RST = "RST1") then
       addnsub3_1_rst <= RST1_ipd;
     elsif (REG_ADDNSUB3_0_RST = "RST2") then
       addnsub3_1_rst <= RST2_ipd;
     elsif (REG_ADDNSUB3_1_RST = "RST3") then
       addnsub3_1_rst <= RST3_ipd;
     end if;
  end process;

  Register_1_addnsub1 : process(addnsub1_1_clk, addnsub1_1_rst_ogsr, addnsub1_1_ce, addnsub1_p1)
  begin
     if (addnsub1_0_rst_ogsr = '1') then
       addnsub1_1_reg <= '0';
     elsif (rising_edge(addnsub1_1_clk)) then
       if (addnsub1_1_ce = '1') then
         addnsub1_1_reg <= addnsub1_p1;
       end if;
     end if;
  end process;

  Register_1_addnsub3 : process(addnsub3_1_clk, addnsub3_1_rst_ogsr, addnsub3_1_ce, addnsub3_p1)
  begin
     if (addnsub3_0_rst_ogsr = '1') then
       addnsub3_1_reg <= '0';
     elsif (rising_edge(addnsub3_1_clk)) then
       if (addnsub3_1_ce = '1') then
         addnsub3_1_reg <= addnsub3_p1;
       end if;
     end if;
  end process;

  Select_addnsub1_ipd_OR_addnsub1_1_reg : process (addnsub1_p1, addnsub1_1_reg)
  begin
     if (REG_ADDNSUB1_1_CLK = "NONE") then
       addnsub1_p2 <= addnsub1_p1;
     else
       addnsub1_p2 <= addnsub1_1_reg;
     end if;
  end process; 

  Select_addnsub3_ipd_OR_addnsub3_1_reg : process (addnsub3_p1, addnsub3_1_reg)
  begin
     if (REG_ADDNSUB3_1_CLK = "NONE") then
       addnsub3_p2 <= addnsub3_p1;
     else
       addnsub3_p2 <= addnsub3_1_reg;
     end if;
  end process; 

  VITALMultBehavior_p0_i : process(A0_gen, B0_gen, SIGNEDA_p1, SIGNEDB_p1)
    variable O_zd, OT1_zd, OT2_zd : std_logic_vector( 35 downto 0);
    variable IA,IBL,IBU  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(17 downto 0);
    variable B_i : std_logic_vector(17 downto 0);

  begin -- process

    if ((A0_gen = "000000000000000000") or (B0_gen = "000000000000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A0_gen) or IS_X(B0_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A0_gen(17) = '1' ) then
           A_i :=  TSCOMP(A0_gen);
         else 
           A_i := A0_gen;
         end if;
      else
         A_i := A0_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B0_gen(17)  = '1') then
           B_i := TSCOMP(B0_gen);
         else
           B_i := B0_gen;
         end if;
      else
         B_i := B0_gen;
      end if;

         IA  := VEC2INT(A_i);
         IBU := VEC2INT(B_i (17 downto 9));
         IBL := VEC2INT(B_i (8 downto 0));

         OT1_zd := INT2VEC((IA * IBU), 36);
         for idex in 0 to 8 loop
             OT1_zd(35 downto 0) := OT1_zd(34 downto 0) & '0';
         end loop;
 
         OT2_zd := INT2VEC((IA * IBL), 36);
         O_zd   := ADDVECT(OT1_zd,OT2_zd);

         sign := (SIGNEDA_p1 and A0_gen(17)) xor (SIGNEDB_p1 and B0_gen(17));
         if (sign = '1' ) then
              O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p0_i <= O_zd; 

  end process;

  VITALMultBehavior_p1_i : process(A1_gen, B1_gen, SIGNEDA_p1, SIGNEDB_p1)
    variable O_zd, OT1_zd, OT2_zd : std_logic_vector( 35 downto 0);
    variable IA,IBL,IBU  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(17 downto 0);
    variable B_i : std_logic_vector(17 downto 0);

  begin -- process

    if ((A1_gen = "000000000000000000") or (B1_gen = "000000000000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A1_gen) or IS_X(B1_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A1_gen(17) = '1' ) then
           A_i :=  TSCOMP(A1_gen);
         else 
           A_i := A1_gen;
         end if;
      else
         A_i := A1_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B1_gen(17)  = '1') then
           B_i := TSCOMP(B1_gen);
         else
           B_i := B1_gen;
         end if;
      else
         B_i := B1_gen;
      end if;

         IA  := VEC2INT(A_i);
         IBU := VEC2INT(B_i (17 downto 9));
         IBL := VEC2INT(B_i (8 downto 0));

         OT1_zd := INT2VEC((IA * IBU), 36);
         for idex in 0 to 8 loop
             OT1_zd(35 downto 0) := OT1_zd(34 downto 0) & '0';
         end loop;
 
         OT2_zd := INT2VEC((IA * IBL), 36);
         O_zd   := ADDVECT(OT1_zd,OT2_zd);

         sign := (SIGNEDA_p1 and A1_gen(17)) xor (SIGNEDB_p1 and B1_gen(17));
         if (sign = '1' ) then
              O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p1_i <= O_zd; 

  end process;

  VITALMultBehavior_p2_i : process(A2_gen, B2_gen, SIGNEDA_p1, SIGNEDB_p1)
    variable O_zd, OT1_zd, OT2_zd : std_logic_vector( 35 downto 0);
    variable IA,IBL,IBU  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(17 downto 0);
    variable B_i : std_logic_vector(17 downto 0);

  begin -- process

    if ((A2_gen = "000000000000000000") or (B2_gen = "000000000000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A2_gen) or IS_X(B2_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A2_gen(17) = '1' ) then
           A_i :=  TSCOMP(A2_gen);
         else 
           A_i := A2_gen;
         end if;
      else
         A_i := A2_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B2_gen(17)  = '1') then
           B_i := TSCOMP(B2_gen);
         else
           B_i := B2_gen;
         end if;
      else
         B_i := B2_gen;
      end if;

         IA  := VEC2INT(A_i);
         IBU := VEC2INT(B_i (17 downto 9));
         IBL := VEC2INT(B_i (8 downto 0));

         OT1_zd := INT2VEC((IA * IBU), 36);
         for idex in 0 to 8 loop
             OT1_zd(35 downto 0) := OT1_zd(34 downto 0) & '0';
         end loop;
 
         OT2_zd := INT2VEC((IA * IBL), 36);
         O_zd   := ADDVECT(OT1_zd,OT2_zd);

         sign := (SIGNEDA_p1 and A2_gen(17)) xor (SIGNEDB_p1 and B2_gen(17));
         if (sign = '1' ) then
              O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p2_i <= O_zd; 

  end process;

  VITALMultBehavior_p3_i : process(A3_gen, B3_gen, SIGNEDA_p1, SIGNEDB_p1)
    variable O_zd, OT1_zd, OT2_zd : std_logic_vector( 35 downto 0);
    variable IA,IBL,IBU  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(17 downto 0);
    variable B_i : std_logic_vector(17 downto 0);

  begin -- process

    if ((A3_gen = "000000000000000000") or (B3_gen = "000000000000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A3_gen) or IS_X(B3_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A3_gen(17) = '1' ) then
           A_i :=  TSCOMP(A3_gen);
         else 
           A_i := A3_gen;
         end if;
      else
         A_i := A3_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B3_gen(17)  = '1') then
           B_i := TSCOMP(B3_gen);
         else
           B_i := B3_gen;
         end if;
      else
         B_i := B3_gen;
      end if;

         IA  := VEC2INT(A_i);
         IBU := VEC2INT(B_i (17 downto 9));
         IBL := VEC2INT(B_i (8 downto 0));

         OT1_zd := INT2VEC((IA * IBU), 36);
         for idex in 0 to 8 loop
             OT1_zd(35 downto 0) := OT1_zd(34 downto 0) & '0';
         end loop;
 
         OT2_zd := INT2VEC((IA * IBL), 36);
         O_zd   := ADDVECT(OT1_zd,OT2_zd);

         sign := (SIGNEDA_p1 and A3_gen(17)) xor (SIGNEDB_p1 and B3_gen(17));
         if (sign = '1' ) then
              O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p3_i <= O_zd; 

  end process;

  P0_i_e_process : process(p0_i_e_reg1, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       p0_i_e(35 downto 0 ) <= p0_i_e_reg1;
       p0_i_e(36) <= p0_i_e_reg1(35);
    else
       p0_i_e(35 downto 0 ) <= p0_i_e_reg1;
       p0_i_e(36) <= '0';
    end if;
  end process;

  P1_i_e_process : process(p1_i_e_reg1, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       p1_i_e(35 downto 0 ) <= p1_i_e_reg1;
       p1_i_e(36) <= p1_i_e_reg1(35);
    else
       p1_i_e(35 downto 0 ) <= p1_i_e_reg1;
       p1_i_e(36) <= '0';
    end if;
  end process;

  P2_i_e_process : process(p2_i_e_reg1, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       p2_i_e(35 downto 0 ) <= p2_i_e_reg1;
       p2_i_e(36) <= p2_i_e_reg1(35);
    else
       p2_i_e(35 downto 0 ) <= p2_i_e_reg1;
       p2_i_e(36) <= '0';
    end if;
  end process;

  P3_i_e_process : process(p3_i_e_reg1, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       p3_i_e(35 downto 0 ) <= p3_i_e_reg1;
       p3_i_e(36) <= p3_i_e_reg1(35);
    else
       p3_i_e(35 downto 0 ) <= p3_i_e_reg1;
       p3_i_e(36) <= '0';
    end if;
  end process;

  PipeLine0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE0_CLK = "CLK0") then
       pipeline0_clk <= CLK0_ipd;
     elsif (REG_PIPELINE0_CLK = "CLK1") then
       pipeline0_clk <= CLK1_ipd;
     elsif (REG_PIPELINE0_CLK = "CLK2") then
       pipeline0_clk <= CLK2_ipd;
     elsif (REG_PIPELINE0_CLK = "CLK3") then
       pipeline0_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE1_CLK = "CLK0") then
       pipeline1_clk <= CLK0_ipd;
     elsif (REG_PIPELINE1_CLK = "CLK1") then
       pipeline1_clk <= CLK1_ipd;
     elsif (REG_PIPELINE1_CLK = "CLK2") then
       pipeline1_clk <= CLK2_ipd;
     elsif (REG_PIPELINE1_CLK = "CLK3") then
       pipeline1_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine2_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE2_CLK = "CLK0") then
       pipeline2_clk <= CLK0_ipd;
     elsif (REG_PIPELINE2_CLK = "CLK1") then
       pipeline2_clk <= CLK1_ipd;
     elsif (REG_PIPELINE2_CLK = "CLK2") then
       pipeline2_clk <= CLK2_ipd;
     elsif (REG_PIPELINE2_CLK = "CLK3") then
       pipeline2_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine3_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE3_CLK = "CLK0") then
       pipeline3_clk <= CLK0_ipd;
     elsif (REG_PIPELINE3_CLK = "CLK1") then
       pipeline3_clk <= CLK1_ipd;
     elsif (REG_PIPELINE3_CLK = "CLK2") then
       pipeline3_clk <= CLK2_ipd;
     elsif (REG_PIPELINE3_CLK = "CLK3") then
       pipeline3_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE0_CE = "CE0") then
       pipeline0_ce <= CE0_ipd;
     elsif (REG_PIPELINE0_CE = "CE1") then
       pipeline0_ce <= CE1_ipd;
     elsif (REG_PIPELINE0_CE = "CE2") then
       pipeline0_ce <= CE2_ipd;
     elsif (REG_PIPELINE0_CE = "CE3") then
       pipeline0_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE1_CE = "CE0") then
       pipeline1_ce <= CE0_ipd;
     elsif (REG_PIPELINE1_CE = "CE1") then
       pipeline1_ce <= CE1_ipd;
     elsif (REG_PIPELINE1_CE = "CE2") then
       pipeline1_ce <= CE2_ipd;
     elsif (REG_PIPELINE1_CE = "CE3") then
       pipeline1_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine2_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE2_CE = "CE0") then
       pipeline2_ce <= CE0_ipd;
     elsif (REG_PIPELINE2_CE = "CE1") then
       pipeline2_ce <= CE1_ipd;
     elsif (REG_PIPELINE2_CE = "CE2") then
       pipeline2_ce <= CE2_ipd;
     elsif (REG_PIPELINE2_CE = "CE3") then
       pipeline2_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine3_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE3_CE = "CE0") then
       pipeline3_ce <= CE0_ipd;
     elsif (REG_PIPELINE3_CE = "CE1") then
       pipeline3_ce <= CE1_ipd;
     elsif (REG_PIPELINE3_CE = "CE2") then
       pipeline3_ce <= CE2_ipd;
     elsif (REG_PIPELINE3_CE = "CE3") then
       pipeline3_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE0_RST = "RST0") then
       pipeline0_rst <= RST0_ipd;
     elsif (REG_PIPELINE0_RST = "RST1") then
       pipeline0_rst <= RST1_ipd;
     elsif (REG_PIPELINE0_RST = "RST2") then
       pipeline0_rst <= RST2_ipd;
     elsif (REG_PIPELINE0_RST = "RST3") then
       pipeline0_rst <= RST3_ipd;
     end if;
  end process;

  PipeLine1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE1_RST = "RST0") then
       pipeline1_rst <= RST0_ipd;
     elsif (REG_PIPELINE1_RST = "RST1") then
       pipeline1_rst <= RST1_ipd;
     elsif (REG_PIPELINE1_RST = "RST2") then
       pipeline1_rst <= RST2_ipd;
     elsif (REG_PIPELINE1_RST = "RST3") then
       pipeline1_rst <= RST3_ipd;
     end if;
  end process;

  PipeLine2_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE2_RST = "RST0") then
       pipeline2_rst <= RST0_ipd;
     elsif (REG_PIPELINE2_RST = "RST1") then
       pipeline2_rst <= RST1_ipd;
     elsif (REG_PIPELINE2_RST = "RST2") then
       pipeline2_rst <= RST2_ipd;
     elsif (REG_PIPELINE2_RST = "RST3") then
       pipeline2_rst <= RST3_ipd;
     end if;
  end process;

  PipeLine3_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE3_RST = "RST0") then
       pipeline3_rst <= RST0_ipd;
     elsif (REG_PIPELINE3_RST = "RST1") then
       pipeline3_rst <= RST1_ipd;
     elsif (REG_PIPELINE3_RST = "RST2") then
       pipeline3_rst <= RST2_ipd;
     elsif (REG_PIPELINE3_RST = "RST3") then
       pipeline3_rst <= RST3_ipd;
     end if;
  end process;

  Pipeline_p0_i_e : process(pipeline0_clk, pipeline0_rst_ogsr, pipeline0_ce, p0_i)
  begin
     if (pipeline0_rst_ogsr = '1') then
       p0_i_e_reg <= (others => '0');
     elsif (rising_edge(pipeline0_clk)) then
       if (pipeline0_ce = '1') then
         p0_i_e_reg <= p0_i;
       end if;
     end if;
  end process;

  Select_p0_i_e_OR_p0_i_e_reg : process (p0_i, p0_i_e_reg)
  begin
     if (REG_PIPELINE0_CLK = "NONE") then
       p0_i_e_reg1 <= p0_i;
     else
       p0_i_e_reg1 <= p0_i_e_reg;
     end if;
  end process;

  Pipeline_p1_i_e : process(pipeline1_clk, pipeline1_rst_ogsr, pipeline1_ce, p1_i)
  begin
     if (pipeline1_rst_ogsr = '1') then
       p1_i_e_reg <= (others => '0');
     elsif (rising_edge(pipeline1_clk)) then
       if (pipeline1_ce = '1') then
         p1_i_e_reg <= p1_i;
       end if;
     end if;
  end process;

  Select_p1_i_e_OR_p1_i_e_reg : process (p1_i, p1_i_e_reg)
  begin
     if (REG_PIPELINE1_CLK = "NONE") then
       p1_i_e_reg1 <= p1_i;
     else
       p1_i_e_reg1 <= p1_i_e_reg;
     end if;
  end process;

  Pipeline_p2_i_e : process(pipeline2_clk, pipeline2_rst_ogsr, pipeline2_ce, p2_i)
  begin
     if (pipeline2_rst_ogsr = '1') then
       p2_i_e_reg <= (others => '0');
     elsif (rising_edge(pipeline2_clk)) then
       if (pipeline2_ce = '1') then
         p2_i_e_reg <= p2_i;
       end if;
     end if;
  end process;

  Select_p2_i_e_OR_p2_i_e_reg : process (p2_i, p2_i_e_reg)
  begin
     if (REG_PIPELINE2_CLK = "NONE") then
       p2_i_e_reg1 <= p2_i;
     else
       p2_i_e_reg1 <= p2_i_e_reg;
     end if;
  end process;

  Pipeline_p3_i_e : process(pipeline3_clk, pipeline3_rst_ogsr, pipeline3_ce, p3_i)
  begin
     if (pipeline3_rst_ogsr = '1') then
       p3_i_e_reg <= (others => '0');
     elsif (rising_edge(pipeline3_clk)) then
       if (pipeline3_ce = '1') then
         p3_i_e_reg <= p3_i;
       end if;
     end if;
  end process;

  Select_p3_i_e_OR_p3_i_e_reg : process (p3_i, p3_i_e_reg)
  begin
     if (REG_PIPELINE3_CLK = "NONE") then
       p3_i_e_reg1 <= p3_i;
     else
       p3_i_e_reg1 <= p3_i_e_reg;
     end if;
  end process;

  AddSub_process_sum0_i : process(p0_i_e, p1_i_e, addnsub1_p2)
  begin
    if (addnsub1_p2 = '1') then
      sum0_i <= ADDVECT(p0_i_e, p1_i_e);
    else
      sum0_i <= SUBVECT(p0_i_e, p1_i_e);
    end if;
  end process;

  AddSub_process_sum1_i : process(p2_i_e, p3_i_e, addnsub3_p2)
  begin
    if (addnsub3_p2 = '1') then
      sum1_i <= ADDVECT(p2_i_e, p3_i_e);
    else
      sum1_i <= SUBVECT(p2_i_e, p3_i_e);
    end if;
  end process;

  sum0_i_e_process : process(sum0_i, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       sum0_i_e(36 downto 0 ) <= sum0_i;
       sum0_i_e(37) <= sum0_i(36);
    else
       sum0_i_e(36 downto 0 ) <= sum0_i;
       sum0_i_e(37) <= '0';
    end if;
  end process;

  sum1_i_e_process : process(sum1_i, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
       sum1_i_e(36 downto 0 ) <= sum1_i;
       sum1_i_e(37) <= sum1_i(36);
    else
       sum1_i_e(36 downto 0 ) <= sum1_i;
       sum1_i_e(37) <= '0';
    end if;
  end process;

  Sumt_process : process(sum0_i_e, sum1_i_e)
  begin
     sumt_sig <= ADDVECT(sum0_i_e, sum1_i_e);
  end process;

  Output_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_OUTPUT_CLK = "CLK0") then
       output_clk <= CLK0_ipd;
     elsif (REG_OUTPUT_CLK = "CLK1") then
       output_clk <= CLK1_ipd;
     elsif (REG_OUTPUT_CLK = "CLK2") then
       output_clk <= CLK2_ipd;
     elsif (REG_OUTPUT_CLK = "CLK3") then
       output_clk <= CLK3_ipd;
     end if;
  end process;

  Output_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_OUTPUT_CE = "CE0") then
       output_ce <= CE0_ipd;
     elsif (REG_OUTPUT_CE = "CE1") then
       output_ce <= CE1_ipd;
     elsif (REG_OUTPUT_CE = "CE2") then
       output_ce <= CE2_ipd;
     elsif (REG_OUTPUT_CE = "CE3") then
       output_ce <= CE3_ipd;
     end if;
  end process;

  Output_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_OUTPUT_RST = "RST0") then
       output_rst <= RST0_ipd;
     elsif (REG_OUTPUT_RST = "RST1") then
       output_rst <= RST1_ipd;
     elsif (REG_OUTPUT_RST = "RST2") then
       output_rst <= RST2_ipd;
     elsif (REG_OUTPUT_RST = "RST3") then
       output_rst <= RST3_ipd;
     end if;
  end process;

  Output_Register : process(output_clk, output_rst_ogsr, output_ce, sumt_sig)
  begin
     if (output_rst_ogsr = '1') then
       sumt_reg <= (others => '0');
     elsif (rising_edge(output_clk)) then
       if (output_ce = '1') then
         sumt_reg <= sumt_sig;
       end if;
     end if;
  end process;

  Select_OUTREG_OR_NOREG : process (sumt_sig, sumt_reg)
  begin
     if (REG_OUTPUT_CLK = "NONE") then
       SUM_ipd <= sumt_sig;
     else
       SUM_ipd <= sumt_reg;
     end if;
  end process;

end V;

configuration CFG_MULT18X18ADDSUBSUMB_V of MULT18X18ADDSUBSUMB is
   for V
   end for;
end CFG_MULT18X18ADDSUBSUMB_V;
----- CELL MULT18X18MACB -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use work.components.all;
use work.global.gsrnet;
use work.global.purnet;

-- entity declaration --
entity MULT18X18MACB is
  generic(
	 REG_INPUTA_CLK       : string     := "NONE";
	 REG_INPUTA_CE        : string     := "CE0";
	 REG_INPUTA_RST       : string     := "RST0";
	 REG_INPUTB_CLK       : string     := "NONE";
	 REG_INPUTB_CE        : string     := "CE0";
	 REG_INPUTB_RST       : string     := "RST0";
	 REG_PIPELINE_CLK     : string     := "NONE";
	 REG_PIPELINE_CE      : string     := "CE0";
	 REG_PIPELINE_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDA_0_CLK   : string     := "NONE";
	 REG_SIGNEDA_0_CE    : string     := "CE0";
	 REG_SIGNEDA_0_RST   : string     := "RST0";
	 REG_SIGNEDA_1_CLK   : string     := "NONE";
	 REG_SIGNEDA_1_CE    : string     := "CE0";
	 REG_SIGNEDA_1_RST   : string     := "RST0";
         REG_SIGNEDB_0_CLK   : string     := "NONE";
         REG_SIGNEDB_0_CE    : string     := "CE0";
         REG_SIGNEDB_0_RST   : string     := "RST0";
         REG_SIGNEDB_1_CLK   : string     := "NONE";
         REG_SIGNEDB_1_CE    : string     := "CE0";
         REG_SIGNEDB_1_RST   : string     := "RST0";
	 REG_ACCUMSLOAD_0_CLK : string     := "NONE";
	 REG_ACCUMSLOAD_0_CE  : string     := "CE0";
	 REG_ACCUMSLOAD_0_RST : string     := "RST0";
	 REG_ACCUMSLOAD_1_CLK : string     := "NONE";
	 REG_ACCUMSLOAD_1_CE  : string     := "CE0";
	 REG_ACCUMSLOAD_1_RST : string     := "RST0";
	 REG_ADDNSUB_0_CLK    : string     := "NONE";
	 REG_ADDNSUB_0_CE     : string     := "CE0";
	 REG_ADDNSUB_0_RST    : string     := "RST0";
	 REG_ADDNSUB_1_CLK    : string     := "NONE";
	 REG_ADDNSUB_1_CE     : string     := "CE0";
	 REG_ADDNSUB_1_RST    : string     := "RST0";
	 GSR                  : string     := "ENABLED");
  port (
        A0 : in STD_ULOGIC;
        A1 : in STD_ULOGIC;
        A2 : in STD_ULOGIC;
        A3 : in STD_ULOGIC;
        A4 : in STD_ULOGIC;
        A5 : in STD_ULOGIC;
        A6 : in STD_ULOGIC;
        A7 : in STD_ULOGIC;
        A8 : in STD_ULOGIC;
        A9 : in STD_ULOGIC;
        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;
        SRIA9 : in STD_ULOGIC;
        SRIA10 : in STD_ULOGIC;
        SRIA11 : in STD_ULOGIC;
        SRIA12 : in STD_ULOGIC;
        SRIA13 : in STD_ULOGIC;
        SRIA14 : in STD_ULOGIC;
        SRIA15 : in STD_ULOGIC;
        SRIA16 : in STD_ULOGIC;
        SRIA17 : in STD_ULOGIC;

        B0 : in STD_ULOGIC;
        B1 : in STD_ULOGIC;
        B2 : in STD_ULOGIC;
        B3 : in STD_ULOGIC;
        B4 : in STD_ULOGIC;
        B5 : in STD_ULOGIC;
        B6 : in STD_ULOGIC;
        B7 : in STD_ULOGIC;
        B8 : in STD_ULOGIC;
        B9 : in STD_ULOGIC;
        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;
        SRIB9 : in STD_ULOGIC;
        SRIB10 : in STD_ULOGIC;
        SRIB11 : in STD_ULOGIC;
        SRIB12 : in STD_ULOGIC;
        SRIB13 : in STD_ULOGIC;
        SRIB14 : in STD_ULOGIC;
        SRIB15 : in STD_ULOGIC;
        SRIB16 : in STD_ULOGIC;
        SRIB17 : in STD_ULOGIC;

        LD0    : in STD_ULOGIC;
        LD1    : in STD_ULOGIC;
        LD2    : in STD_ULOGIC;
        LD3    : in STD_ULOGIC;
        LD4    : in STD_ULOGIC;
        LD5    : in STD_ULOGIC;
        LD6    : in STD_ULOGIC;
        LD7    : in STD_ULOGIC;
        LD8    : in STD_ULOGIC;
        LD9    : in STD_ULOGIC;
        LD10    : in STD_ULOGIC;
        LD11    : in STD_ULOGIC;
        LD12    : in STD_ULOGIC;
        LD13    : in STD_ULOGIC;
        LD14    : in STD_ULOGIC;
        LD15    : in STD_ULOGIC;
        LD16    : in STD_ULOGIC;
        LD17    : in STD_ULOGIC;
        LD18    : in STD_ULOGIC;
        LD19    : in STD_ULOGIC;
        LD20    : in STD_ULOGIC;
        LD21    : in STD_ULOGIC;
        LD22    : in STD_ULOGIC;
        LD23    : in STD_ULOGIC;
        LD24    : in STD_ULOGIC;
        LD25    : in STD_ULOGIC;
        LD26    : in STD_ULOGIC;
        LD27    : in STD_ULOGIC;
        LD28    : in STD_ULOGIC;
        LD29    : in STD_ULOGIC;
        LD30    : in STD_ULOGIC;
        LD31    : in STD_ULOGIC;
        LD32    : in STD_ULOGIC;
        LD33    : in STD_ULOGIC;
        LD34    : in STD_ULOGIC;
        LD35    : in STD_ULOGIC;
        LD36    : in STD_ULOGIC;
        LD37    : in STD_ULOGIC;
        LD38    : in STD_ULOGIC;
        LD39    : in STD_ULOGIC;
        LD40    : in STD_ULOGIC;
        LD41    : in STD_ULOGIC;
        LD42    : in STD_ULOGIC;
        LD43    : in STD_ULOGIC;
        LD44    : in STD_ULOGIC;
        LD45    : in STD_ULOGIC;
        LD46    : in STD_ULOGIC;
        LD47    : in STD_ULOGIC;
        LD48    : in STD_ULOGIC;
        LD49    : in STD_ULOGIC;
        LD50    : in STD_ULOGIC;
        LD51    : in STD_ULOGIC;

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        SOURCEA : in STD_ULOGIC;
        SOURCEB : in STD_ULOGIC;
        ACCUMSLOAD : in STD_ULOGIC;
        ADDNSUB : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;
        SROA9 : out STD_ULOGIC;
        SROA10 : out STD_ULOGIC;
        SROA11 : out STD_ULOGIC;
        SROA12 : out STD_ULOGIC;
        SROA13 : out STD_ULOGIC;
        SROA14 : out STD_ULOGIC;
        SROA15 : out STD_ULOGIC;
        SROA16 : out STD_ULOGIC;
        SROA17 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;
        SROB9 : out STD_ULOGIC;
        SROB10 : out STD_ULOGIC;
        SROB11 : out STD_ULOGIC;
        SROB12 : out STD_ULOGIC;
        SROB13 : out STD_ULOGIC;
        SROB14 : out STD_ULOGIC;
        SROB15 : out STD_ULOGIC;
        SROB16 : out STD_ULOGIC;
        SROB17 : out STD_ULOGIC;

        ACCUM0 : out STD_ULOGIC;
        ACCUM1 : out STD_ULOGIC;
        ACCUM2 : out STD_ULOGIC;
        ACCUM3 : out STD_ULOGIC;
        ACCUM4 : out STD_ULOGIC;
        ACCUM5 : out STD_ULOGIC;
        ACCUM6 : out STD_ULOGIC;
        ACCUM7 : out STD_ULOGIC;
        ACCUM8 : out STD_ULOGIC;
        ACCUM9 : out STD_ULOGIC;
        ACCUM10 : out STD_ULOGIC;
        ACCUM11 : out STD_ULOGIC;
        ACCUM12 : out STD_ULOGIC;
        ACCUM13 : out STD_ULOGIC;
        ACCUM14 : out STD_ULOGIC;
        ACCUM15 : out STD_ULOGIC;
        ACCUM16 : out STD_ULOGIC;
        ACCUM17 : out STD_ULOGIC;
        ACCUM18 : out STD_ULOGIC;
        ACCUM19 : out STD_ULOGIC;
        ACCUM20 : out STD_ULOGIC;
        ACCUM21 : out STD_ULOGIC;
        ACCUM22 : out STD_ULOGIC;
        ACCUM23 : out STD_ULOGIC;
        ACCUM24 : out STD_ULOGIC;
        ACCUM25 : out STD_ULOGIC;
        ACCUM26 : out STD_ULOGIC;
        ACCUM27 : out STD_ULOGIC;
        ACCUM28 : out STD_ULOGIC;
        ACCUM29 : out STD_ULOGIC;
        ACCUM30 : out STD_ULOGIC;
        ACCUM31 : out STD_ULOGIC;
        ACCUM32 : out STD_ULOGIC;
        ACCUM33 : out STD_ULOGIC;
        ACCUM34 : out STD_ULOGIC;
        ACCUM35 : out STD_ULOGIC;
        ACCUM36 : out STD_ULOGIC;
        ACCUM37 : out STD_ULOGIC;
        ACCUM38 : out STD_ULOGIC;
        ACCUM39 : out STD_ULOGIC;
        ACCUM40 : out STD_ULOGIC;
        ACCUM41 : out STD_ULOGIC;
        ACCUM42 : out STD_ULOGIC;
        ACCUM43 : out STD_ULOGIC;
        ACCUM44 : out STD_ULOGIC;
        ACCUM45 : out STD_ULOGIC;
        ACCUM46 : out STD_ULOGIC;
        ACCUM47 : out STD_ULOGIC;
        ACCUM48 : out STD_ULOGIC;
        ACCUM49 : out STD_ULOGIC;
        ACCUM50 : out STD_ULOGIC;
        ACCUM51 : out STD_ULOGIC;
        OVERFLOW : out STD_ULOGIC
       ); 

attribute VITAL_LEVEL0 of MULT18X18MACB : entity is TRUE;

end MULT18X18MACB;

--- Architecture 

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
architecture V of MULT18X18MACB is

  attribute VITAL_LEVEL0 of V : architecture is TRUE;

  -- Local signals used to propagate input wire delay

  signal A_ipd, A_ipd1       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SRIA_ipd, SRIA_ipd1 : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROA_reg  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B_ipd, B_ipd1       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SRIB_ipd, SRIB_ipd1 : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SROB_reg  : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal SIGNEDA_ipd, SIGNEDA_ipd1  : std_logic := 'X';
  signal SIGNEDB_ipd, SIGNEDB_ipd1  : std_logic := 'X';
  signal SOURCEA_ipd, SOURCEA_ipd1  : std_logic := 'X';
  signal SOURCEB_ipd, SOURCEB_ipd1  : std_logic := 'X';
  signal ACCUMSLOAD_ipd, ACCUMSLOAD_ipd1  : std_logic := 'X';
  signal ADDNSUB_ipd, ADDNSUB_ipd1  : std_logic := 'X';
  signal CE0_ipd  : std_logic := 'X';
  signal CE1_ipd  : std_logic := 'X';
  signal CE2_ipd  : std_logic := 'X';
  signal CE3_ipd  : std_logic := 'X';

  signal CLK0_ipd  : std_logic := 'X';
  signal CLK1_ipd  : std_logic := 'X';
  signal CLK2_ipd  : std_logic := 'X';
  signal CLK3_ipd  : std_logic := 'X';
  signal RST0_ipd  : std_logic := 'X';
  signal RST1_ipd  : std_logic := 'X';
  signal RST2_ipd  : std_logic := 'X';
  signal RST3_ipd  : std_logic := 'X';
  signal ld_ipd, ld_ipd1 : std_logic_vector(51 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";

  signal A_reg     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B_reg     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A_p       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B_p       : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal A_gen     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal B_gen     : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
  signal P_i       : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_o       : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_ps      : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_ps_accum     : std_logic_vector(52 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_sig_ps_accum     : std_logic_vector(52 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_sig_ps_accum_2     : std_logic_vector(52 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal accum_reg      : std_logic_vector(52 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal accum_sig      : std_logic_vector(52 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal accum_sig_l    : std_logic_vector(52 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal Zerovector    : std_logic_vector(52 downto 0) := "00000000000000000000000000000000000000000000000000000";

  signal overflow_sig_1 : std_logic := 'X';
  signal overflow_sig_2 : std_logic := 'X';
  signal OVERFLOW_ipd  : std_logic := 'X';
  signal input_a_clk  : std_logic := 'X';
  signal input_a_ce   : std_logic := 'X';
  signal input_a_rst  : std_logic := 'X';
  signal input_b_clk  : std_logic := 'X';
  signal input_b_ce   : std_logic := 'X';
  signal input_b_rst  : std_logic := 'X';
  signal pipeline_clk : std_logic := 'X';
  signal pipeline_ce  : std_logic := 'X';
  signal pipeline_rst : std_logic := 'X';
  signal output_clk   : std_logic := 'X';
  signal output_ce    : std_logic := 'X';
  signal output_rst   : std_logic := 'X';
  signal signeda_0_clk : std_logic := 'X';
  signal signeda_0_ce  : std_logic := 'X';
  signal signeda_0_rst  : std_logic := 'X';
  signal signeda_1_clk : std_logic := 'X';
  signal signeda_1_ce  : std_logic := 'X';
  signal signeda_1_rst  : std_logic := 'X';
  signal signeda_0_reg  : std_logic := 'X';
  signal signeda_1_reg  : std_logic := 'X';
  signal signeda_p1  : std_logic := 'X';
  signal signeda_p2  : std_logic := 'X';
  signal signedab_p2  : std_logic := 'X';
  signal signedb_0_clk : std_logic := 'X';
  signal signedb_0_ce  : std_logic := 'X';
  signal signedb_0_rst  : std_logic := 'X';
  signal signedb_1_clk : std_logic := 'X';
  signal signedb_1_ce  : std_logic := 'X';
  signal signedb_1_rst  : std_logic := 'X';
  signal signedb_0_reg  : std_logic := 'X';
  signal signedb_1_reg  : std_logic := 'X';
  signal signedb_p1  : std_logic := 'X';
  signal signedb_p2  : std_logic := 'X';

  signal accumsload_0_clk : std_logic := 'X';
  signal accumsload_0_ce  : std_logic := 'X';
  signal accumsload_0_rst  : std_logic := 'X';
  signal accumsload_1_clk : std_logic := 'X';
  signal accumsload_1_ce  : std_logic := 'X';
  signal accumsload_1_rst  : std_logic := 'X';
  signal accumsload_0_reg  : std_logic := 'X';
  signal accumsload_1_reg  : std_logic := 'X';
  signal accumsload_p1  : std_logic := 'X';
  signal accumsload_p2  : std_logic := 'X';
  signal accumsload_p3  : std_logic := 'X';

  signal addnsub_0_clk : std_logic := 'X';
  signal addnsub_0_ce  : std_logic := 'X';
  signal addnsub_0_rst  : std_logic := 'X';
  signal addnsub_1_clk : std_logic := 'X';
  signal addnsub_1_ce  : std_logic := 'X';
  signal addnsub_1_rst  : std_logic := 'X';
  signal addnsub_0_reg  : std_logic := 'X';
  signal addnsub_1_reg  : std_logic := 'X';
  signal addnsub_p1  : std_logic := 'X';
  signal addnsub_p2  : std_logic := 'X';

  signal SRN          : std_logic;
  signal input_a_rst_ogsr  : std_logic := 'X';
  signal input_b_rst_ogsr  : std_logic := 'X';
  signal pipeline_rst_ogsr  : std_logic := 'X';
  signal output_rst_ogsr  : std_logic := 'X';
  signal signeda_0_rst_ogsr  : std_logic := 'X';
  signal signeda_1_rst_ogsr  : std_logic := 'X';
  signal signedb_0_rst_ogsr  : std_logic := 'X';
  signal signedb_1_rst_ogsr  : std_logic := 'X';
  signal accumsload_0_rst_ogsr  : std_logic := 'X';
  signal accumsload_1_rst_ogsr  : std_logic := 'X';
  signal addnsub_0_rst_ogsr  : std_logic := 'X';
  signal addnsub_1_rst_ogsr  : std_logic := 'X';

begin 

    global_reset : process (purnet, gsrnet)
      begin
        if (GSR =  "DISABLED") then
           SRN <= purnet;
        else
           SRN <= purnet AND gsrnet;
        end if;
      end process;

    input_a_rst_ogsr <= input_a_rst or not SRN;
    input_b_rst_ogsr <= input_b_rst or not SRN;
    pipeline_rst_ogsr <= pipeline_rst or not SRN;
    output_rst_ogsr <= output_rst or not SRN;
    signeda_0_rst_ogsr <= signeda_0_rst or not SRN;
    signeda_1_rst_ogsr <= signeda_1_rst or not SRN;
    signedb_0_rst_ogsr <= signedb_0_rst or not SRN;
    signedb_1_rst_ogsr <= signedb_1_rst or not SRN;
    accumsload_0_rst_ogsr <= accumsload_0_rst or not SRN;
    accumsload_1_rst_ogsr <= accumsload_1_rst or not SRN;
    addnsub_0_rst_ogsr <= addnsub_0_rst or not SRN;
    addnsub_1_rst_ogsr <= addnsub_1_rst or not SRN;

    ld_ipd1 <= (LD51 & LD50 & LD49 & LD48 & LD47 & LD46 & LD45 & LD44 & LD43 & LD42 & LD41 & LD40 & LD39 & LD38 & LD37 & LD36 & LD35 & LD34 & LD33 & LD32 & LD31 & LD30 & LD29 & LD28 & LD27 & LD26 & LD25 & LD24 & LD23 & LD22 & LD21 & LD20 & LD19 & LD18 & LD17 & LD16 & LD15 & LD14 & LD13 & LD12 & LD11 & LD10 & LD9 & LD8 & LD7 & LD6 & LD5 & LD4 & LD3 & LD2 & LD1 & LD0);
    A_ipd1 <= (A17 & A16 & A15 & A14 & A13 & A12 & A11 & A10 & A9 & A8 & A7 & A6 & A5 & A4 & A3 & A2 & A1 & A0);
    B_ipd1 <= (B17 & B16 & B15 & B14 & B13 & B12 & B11 & B10 & B9 & B8 & B7 & B6 & B5 & B4 & B3 & B2 & B1 & B0);
    SRIA_ipd1 <= (SRIA17 & SRIA16 & SRIA15 & SRIA14 & SRIA13 & SRIA12 & SRIA11 & SRIA10 & SRIA9 & SRIA8 & SRIA7 & SRIA6 & SRIA5 & SRIA4 & SRIA3 & SRIA2 & SRIA1 & SRIA0);
    SRIB_ipd1 <= (SRIB17 & SRIB16 & SRIB15 & SRIB14 & SRIB13 & SRIB12 & SRIB11 & SRIB10 & SRIB9 & SRIB8 & SRIB7 & SRIB6 & SRIB5 & SRIB4 & SRIB3 & SRIB2 & SRIB1 & SRIB0);
    SIGNEDA_ipd1 <= SIGNEDA;
    SIGNEDB_ipd1 <= SIGNEDB;
    SOURCEA_ipd1 <= SOURCEA;
    SOURCEB_ipd1 <= SOURCEB;
    ACCUMSLOAD_ipd1 <= ACCUMSLOAD;
    ADDNSUB_ipd1 <= ADDNSUB;

    ld_ipd <= ld_ipd1;
    A_ipd <= A_ipd1;
    B_ipd <= B_ipd1;
    SRIA_ipd <= SRIA_ipd1;
    SRIB_ipd <= SRIB_ipd1;
    SIGNEDA_ipd <= SIGNEDA_ipd1;
    SIGNEDB_ipd <= SIGNEDB_ipd1;
    SOURCEA_ipd <= SOURCEA_ipd1;
    SOURCEB_ipd <= SOURCEB_ipd1;
    ACCUMSLOAD_ipd <= ACCUMSLOAD_ipd1;
    ADDNSUB_ipd <= ADDNSUB_ipd1;

    CE0_ipd <= CE0;
    CE1_ipd <= CE1;
    CE2_ipd <= CE2;
    CE3_ipd <= CE3;
    CLK0_ipd <= CLK0;
    CLK1_ipd <= CLK1;
    CLK2_ipd <= CLK2;
    CLK3_ipd <= CLK3;
    RST0_ipd <= RST0;
    RST1_ipd <= RST1;
    RST2_ipd <= RST2;
    RST3_ipd <= RST3;

    SROA0 <= SROA_reg(0);
    SROA1 <= SROA_reg(1);
    SROA2 <= SROA_reg(2);
    SROA3 <= SROA_reg(3);
    SROA4 <= SROA_reg(4);
    SROA5 <= SROA_reg(5);
    SROA6 <= SROA_reg(6);
    SROA7 <= SROA_reg(7);
    SROA8 <= SROA_reg(8);
    SROA9 <= SROA_reg(9);
    SROA10 <= SROA_reg(10);
    SROA11 <= SROA_reg(11);
    SROA12 <= SROA_reg(12);
    SROA13 <= SROA_reg(13);
    SROA14 <= SROA_reg(14);
    SROA15 <= SROA_reg(15);
    SROA16 <= SROA_reg(16);
    SROA17 <= SROA_reg(17);

    SROB0 <= SROB_reg(0);
    SROB1 <= SROB_reg(1);
    SROB2 <= SROB_reg(2);
    SROB3 <= SROB_reg(3);
    SROB4 <= SROB_reg(4);
    SROB5 <= SROB_reg(5);
    SROB6 <= SROB_reg(6);
    SROB7 <= SROB_reg(7);
    SROB8 <= SROB_reg(8);
    SROB9 <= SROB_reg(9);
    SROB10 <= SROB_reg(10);
    SROB11 <= SROB_reg(11);
    SROB12 <= SROB_reg(12);
    SROB13 <= SROB_reg(13);
    SROB14 <= SROB_reg(14);
    SROB15 <= SROB_reg(15);
    SROB16 <= SROB_reg(16);
    SROB17 <= SROB_reg(17);

    ACCUM0 <= accum_reg(0);
    ACCUM1 <= accum_reg(1);
    ACCUM2 <= accum_reg(2);
    ACCUM3 <= accum_reg(3);
    ACCUM4 <= accum_reg(4);
    ACCUM5 <= accum_reg(5);
    ACCUM6 <= accum_reg(6);
    ACCUM7 <= accum_reg(7);
    ACCUM8 <= accum_reg(8);
    ACCUM9 <= accum_reg(9);
    ACCUM10 <= accum_reg(10);
    ACCUM11 <= accum_reg(11);
    ACCUM12 <= accum_reg(12);
    ACCUM13 <= accum_reg(13);
    ACCUM14 <= accum_reg(14);
    ACCUM15 <= accum_reg(15);
    ACCUM16 <= accum_reg(16);
    ACCUM17 <= accum_reg(17);
    ACCUM18 <= accum_reg(18);
    ACCUM19 <= accum_reg(19);
    ACCUM20 <= accum_reg(20);
    ACCUM21 <= accum_reg(21);
    ACCUM22 <= accum_reg(22);
    ACCUM23 <= accum_reg(23);
    ACCUM24 <= accum_reg(24);
    ACCUM25 <= accum_reg(25);
    ACCUM26 <= accum_reg(26);
    ACCUM27 <= accum_reg(27);
    ACCUM28 <= accum_reg(28);
    ACCUM29 <= accum_reg(29);
    ACCUM30 <= accum_reg(30);
    ACCUM31 <= accum_reg(31);
    ACCUM32 <= accum_reg(32);
    ACCUM33 <= accum_reg(33);
    ACCUM34 <= accum_reg(34);
    ACCUM35 <= accum_reg(35);
    ACCUM36 <= accum_reg(36);
    ACCUM37 <= accum_reg(37);
    ACCUM38 <= accum_reg(38);
    ACCUM39 <= accum_reg(39);
    ACCUM40 <= accum_reg(40);
    ACCUM41 <= accum_reg(41);
    ACCUM42 <= accum_reg(42);
    ACCUM43 <= accum_reg(43);
    ACCUM44 <= accum_reg(44);
    ACCUM45 <= accum_reg(45);
    ACCUM46 <= accum_reg(46);
    ACCUM47 <= accum_reg(47);
    ACCUM48 <= accum_reg(48);
    ACCUM49 <= accum_reg(49);
    ACCUM50 <= accum_reg(50);
    ACCUM51 <= accum_reg(51);

    OVERFLOW <= OVERFLOW_ipd;

  Input_A_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA_CLK = "CLK0") then
       input_a_clk <= CLK0_ipd;
     elsif (REG_INPUTA_CLK = "CLK1") then
       input_a_clk <= CLK1_ipd;
     elsif (REG_INPUTA_CLK = "CLK2") then
       input_a_clk <= CLK2_ipd;
     elsif (REG_INPUTA_CLK = "CLK3") then
       input_a_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA_CE = "CE0") then
       input_a_ce <= CE0_ipd;
     elsif (REG_INPUTA_CE = "CE1") then
       input_a_ce <= CE1_ipd;
     elsif (REG_INPUTA_CE = "CE2") then
       input_a_ce <= CE2_ipd;
     elsif (REG_INPUTA_CE = "CE3") then
       input_a_ce <= CE3_ipd;
     end if;
  end process;

  Input_A_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA_RST = "RST0") then
       input_a_rst <= RST0_ipd;
     elsif (REG_INPUTA_RST = "RST1") then
       input_a_rst <= RST1_ipd;
     elsif (REG_INPUTA_RST = "RST2") then
       input_a_rst <= RST2_ipd;
     elsif (REG_INPUTA_RST = "RST3") then
       input_a_rst <= RST3_ipd;
     end if;
  end process;
      
  Register_A_Input : process(input_a_clk, input_a_rst_ogsr, input_a_ce, A_p)
  begin
     if (input_a_rst_ogsr = '1') then
       A_reg <= (others => '0');
     elsif (rising_edge(input_a_clk)) then
       if (input_a_ce = '1') then
         A_reg <= A_p;
       end if;
     end if;
  end process;

  Select_A_OR_A_reg : process (A_p, A_reg)
  begin
     if (REG_INPUTA_CLK = "NONE") then
       A_gen <= A_p;
     else
       A_gen <= A_reg;
     end if;
  end process;

  SROA_reg <= A_gen;

  Select_A_p_OR_SRIA_ipd : process(A_ipd, SRIA_ipd, SOURCEA_ipd)
  begin
     if (SOURCEA_ipd = '1') then
       A_p <= SRIA_ipd;
     elsif (SOURCEA_ipd = '0') then 
       A_p <= A_ipd;
     end if;
  end process;    

  Input_B_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB_CLK = "CLK0") then
       input_b_clk <= CLK0_ipd;
     elsif (REG_INPUTB_CLK = "CLK1") then
       input_b_clk <= CLK1_ipd;
     elsif (REG_INPUTB_CLK = "CLK2") then
       input_b_clk <= CLK2_ipd;
     elsif (REG_INPUTB_CLK = "CLK3") then
       input_b_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB_CE = "CE0") then
       input_b_ce <= CE0_ipd;
     elsif (REG_INPUTB_CE = "CE1") then
       input_b_ce <= CE1_ipd;
     elsif (REG_INPUTB_CE = "CE2") then
       input_b_ce <= CE2_ipd;
     elsif (REG_INPUTB_CE = "CE3") then
       input_b_ce <= CE3_ipd;
     end if;
  end process;

  Input_B_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB_RST = "RST0") then
       input_b_rst <= RST0_ipd;
     elsif (REG_INPUTB_RST = "RST1") then
       input_b_rst <= RST1_ipd;
     elsif (REG_INPUTB_RST = "RST2") then
       input_b_rst <= RST2_ipd;
     elsif (REG_INPUTB_RST = "RST3") then
       input_b_rst <= RST3_ipd;
     end if;
  end process;

  Register_B_Input : process(input_b_clk, input_b_rst_ogsr, input_b_ce, B_p)
  begin
     if (input_b_rst_ogsr = '1') then
       B_reg <= (others => '0');
     elsif (rising_edge(input_b_clk)) then
       if (input_b_ce = '1') then
         B_reg <= B_p;
       end if;
     end if;
  end process;

  Select_B_OR_B_reg : process (B_p, B_reg)
  begin
     if (REG_INPUTB_CLK = "NONE") then
       B_gen <= B_p;
     else
       B_gen <= B_reg;
     end if;
  end process;    

  SROB_reg <= B_gen;
    
  Select_B_p_OR_SRIB_ipd : process(B_ipd, SRIB_ipd, SOURCEB_ipd)
  begin
     if (SOURCEB_ipd = '1') then
       B_p <= SRIB_ipd;
     elsif (SOURCEB_ipd = '0') then 
       B_p <= B_ipd;
     end if;
  end process;   


  SIGNEDAB_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_0_CLK = "CLK0") then
       signeda_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK1") then
       signeda_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK2") then
       signeda_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK3") then
       signeda_0_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_0_CLK = "CLK0") then
       signedb_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK1") then
       signedb_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK2") then
       signedb_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK3") then
       signedb_0_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_0_CE = "CE0") then
       signeda_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE1") then
       signeda_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE2") then
       signeda_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE3") then
       signeda_0_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_0_CE = "CE0") then
       signedb_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE1") then
       signedb_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE2") then
       signedb_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE3") then
       signedb_0_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_0_RST = "RST0") then
       signeda_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST1") then
       signeda_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST2") then
       signeda_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST3") then
       signeda_0_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_0_RST = "RST0") then
       signedb_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST1") then
       signedb_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST2") then
       signedb_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST3") then
       signedb_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_SIGNEDA : process(signeda_0_clk, signeda_0_rst_ogsr, signeda_0_ce, SIGNEDA_ipd)
  begin
     if (signeda_0_rst_ogsr = '1') then
       SIGNEDA_0_reg <= '0';
     elsif (rising_edge(signeda_0_clk)) then
       if (signeda_0_ce = '1') then
         SIGNEDA_0_reg <= SIGNEDA_ipd;
       end if;
     end if;
  end process;

  Register_0_SIGNEDB : process(signedb_0_clk, signedb_0_rst_ogsr, signedb_0_ce, SIGNEDB_ipd)
  begin
     if (signedb_0_rst_ogsr = '1') then
       SIGNEDB_0_reg <= '0';
     elsif (rising_edge(signedb_0_clk)) then
       if (signedb_0_ce = '1') then
         SIGNEDB_0_reg <= SIGNEDB_ipd;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_0_reg : process (SIGNEDA_ipd, SIGNEDA_0_reg)
  begin
     if (REG_SIGNEDA_0_CLK = "NONE") then
       SIGNEDA_p1 <= SIGNEDA_ipd;
     else
       SIGNEDA_p1 <= SIGNEDA_0_reg;
     end if;
  end process; 

  Select_SIGNEDB_ipd_OR_SIGNEDB_0_reg : process (SIGNEDB_ipd, SIGNEDB_0_reg)
  begin
     if (REG_SIGNEDB_0_CLK = "NONE") then
       SIGNEDB_p1 <= SIGNEDB_ipd;
     else
       SIGNEDB_p1 <= SIGNEDB_0_reg;
     end if;
  end process;

  SIGNEDAB_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_1_CLK = "CLK0") then
       signeda_1_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK1") then
       signeda_1_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK2") then
       signeda_1_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK3") then
       signeda_1_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_1_CLK = "CLK0") then
       signedb_1_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK1") then
       signedb_1_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK2") then
       signedb_1_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK3") then
       signedb_1_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_1_CE = "CE0") then
       signeda_1_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE1") then
       signeda_1_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE2") then
       signeda_1_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE3") then
       signeda_1_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_1_CE = "CE0") then
       signedb_1_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE1") then
       signedb_1_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE2") then
       signedb_1_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE3") then
       signedb_1_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_1_RST = "RST0") then
       signeda_1_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_1_RST = "RST1") then
       signeda_1_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST2") then
       signeda_1_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_1_RST = "RST3") then
       signeda_1_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_1_RST = "RST0") then
       signedb_1_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_1_RST = "RST1") then
       signedb_1_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST2") then
       signedb_1_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_1_RST = "RST3") then
       signedb_1_rst <= RST3_ipd;
     end if;
  end process;

  Register_1_SIGNEDA : process(signeda_1_clk, signeda_1_rst_ogsr, signeda_1_ce, SIGNEDA_p1)
  begin
     if (signeda_0_rst_ogsr = '1') then
       SIGNEDA_1_reg <= '0';
     elsif (rising_edge(signeda_1_clk)) then
       if (signeda_1_ce = '1') then
         SIGNEDA_1_reg <= SIGNEDA_p1;
       end if;
     end if;
  end process;

  Register_1_SIGNEDB : process(signedb_1_clk, signedb_1_rst_ogsr, signedb_1_ce, SIGNEDB_p1)
  begin
     if (signedb_0_rst_ogsr = '1') then
       SIGNEDB_1_reg <= '0';
     elsif (rising_edge(signedb_1_clk)) then
       if (signedb_1_ce = '1') then
         SIGNEDB_1_reg <= SIGNEDB_p1;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_1_reg : process (SIGNEDA_p1, SIGNEDA_1_reg)
  begin
     if (REG_SIGNEDA_1_CLK = "NONE") then
       SIGNEDA_p2 <= SIGNEDA_p1;
     else
       SIGNEDA_p2 <= SIGNEDA_1_reg;
     end if;
  end process;   

  Select_SIGNEDB_ipd_OR_SIGNEDB_1_reg : process (SIGNEDB_p1, SIGNEDB_1_reg)
  begin
     if (REG_SIGNEDB_1_CLK = "NONE") then
       SIGNEDB_p2 <= SIGNEDB_p1;
     else
       SIGNEDB_p2 <= SIGNEDB_1_reg;
     end if;
  end process;

  addnsub_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB_0_CLK = "CLK0") then
       addnsub_0_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB_0_CLK = "CLK1") then
       addnsub_0_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB_0_CLK = "CLK2") then
       addnsub_0_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB_0_CLK = "CLK3") then
       addnsub_0_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB_0_CE = "CE0") then
       addnsub_0_ce <= CE0_ipd;
     elsif (REG_ADDNSUB_0_CE = "CE1") then
       addnsub_0_ce <= CE1_ipd;
     elsif (REG_ADDNSUB_0_CE = "CE2") then
       addnsub_0_ce <= CE2_ipd;
     elsif (REG_ADDNSUB_0_CE = "CE3") then
       addnsub_0_ce <= CE3_ipd;
     end if;
  end process;

  addnsub_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB_0_RST = "RST0") then
       addnsub_0_rst <= RST0_ipd;
     elsif (REG_ADDNSUB_0_RST = "RST1") then
       addnsub_0_rst <= RST1_ipd;
     elsif (REG_ADDNSUB_0_RST = "RST2") then
       addnsub_0_rst <= RST2_ipd;
     elsif (REG_ADDNSUB_0_RST = "RST3") then
       addnsub_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_addnsub : process(addnsub_0_clk, addnsub_0_rst_ogsr, addnsub_0_ce, addnsub_ipd)
  begin
     if (addnsub_0_rst_ogsr = '1') then
       addnsub_0_reg <= '0';
     elsif (rising_edge(addnsub_0_clk)) then
       if (addnsub_0_ce = '1') then
         addnsub_0_reg <= addnsub_ipd;
       end if;
     end if;
  end process;

  Select_addnsub_ipd_OR_addnsub_0_reg : process (addnsub_ipd, addnsub_0_reg)
  begin
     if (REG_ADDNSUB_0_CLK = "NONE") then
       addnsub_p1 <= addnsub_ipd;
     else
       addnsub_p1 <= addnsub_0_reg;
     end if;
  end process; 

  addnsub_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ADDNSUB_1_CLK = "CLK0") then
       addnsub_1_clk <= CLK0_ipd;
     elsif (REG_ADDNSUB_1_CLK = "CLK1") then
       addnsub_1_clk <= CLK1_ipd;
     elsif (REG_ADDNSUB_1_CLK = "CLK2") then
       addnsub_1_clk <= CLK2_ipd;
     elsif (REG_ADDNSUB_1_CLK = "CLK3") then
       addnsub_1_clk <= CLK3_ipd;
     end if;
  end process;

  addnsub_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ADDNSUB_1_CE = "CE0") then
       addnsub_1_ce <= CE0_ipd;
     elsif (REG_ADDNSUB_1_CE = "CE1") then
       addnsub_1_ce <= CE1_ipd;
     elsif (REG_ADDNSUB_1_CE = "CE2") then
       addnsub_1_ce <= CE2_ipd;
     elsif (REG_ADDNSUB_1_CE = "CE3") then
       addnsub_1_ce <= CE3_ipd;
     end if;
  end process;

  addnsub_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ADDNSUB_1_RST = "RST0") then
       addnsub_1_rst <= RST0_ipd;
     elsif (REG_ADDNSUB_1_RST = "RST1") then
       addnsub_1_rst <= RST1_ipd;
     elsif (REG_ADDNSUB_0_RST = "RST2") then
       addnsub_1_rst <= RST2_ipd;
     elsif (REG_ADDNSUB_1_RST = "RST3") then
       addnsub_1_rst <= RST3_ipd;
     end if;
  end process;

  Register_1_addnsub : process(addnsub_1_clk, addnsub_1_rst, addnsub_1_ce, addnsub_p1)
  begin
     if (addnsub_0_rst = '1') then
       addnsub_1_reg <= '0';
     elsif (rising_edge(addnsub_1_clk)) then
       if (addnsub_1_ce = '1') then
         addnsub_1_reg <= addnsub_p1;
       end if;
     end if;
  end process;

  Select_addnsub_ipd_OR_addnsub_1_reg : process (addnsub_p1, addnsub_1_reg)
  begin
     if (REG_ADDNSUB_1_CLK = "NONE") then
       addnsub_p2 <= addnsub_p1;
     else
       addnsub_p2 <= addnsub_1_reg;
     end if;
  end process;        

  VITALMultBehavior : process(A_gen, B_gen, SIGNEDA_p1, SIGNEDB_p1)

    variable O_zd, OT1_zd, OT2_zd : std_logic_vector( 35 downto 0);
    variable IA,IBL,IBU  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(17 downto 0);
    variable B_i : std_logic_vector(17 downto 0);

  begin -- process

    if ((A_gen = "000000000000000000") or (B_gen = "000000000000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A_gen) or IS_X(B_gen) ) then
            O_zd := (others => 'X');
    else
      if (SIGNEDA_p1 = '1') then
         if (A_gen(17) = '1' ) then
           A_i :=  TSCOMP(A_gen);
         else 
           A_i := A_gen;
         end if;
      else
         A_i := A_gen;
      end if;

      if (SIGNEDB_p1 = '1') then
         if (B_gen(17)  = '1') then
           B_i := TSCOMP(B_gen);
         else
           B_i := B_gen;
         end if;
      else
         B_i := B_gen;
      end if;

         IA  := VEC2INT(A_i);
         IBU := VEC2INT(B_i (17 downto 9));
         IBL := VEC2INT(B_i (8 downto 0));

         OT1_zd := INT2VEC((IA * IBU), 36);
         for idex in 0 to 8 loop
             OT1_zd(35 downto 0) := OT1_zd(34 downto 0) & '0';
         end loop;
 
         OT2_zd := INT2VEC((IA * IBL), 36);
         O_zd   := ADDVECT(OT1_zd,OT2_zd);

         sign := (SIGNEDA_p1 and A_gen(17)) xor (SIGNEDB_p1 and B_gen(17));
         if (sign = '1' ) then
              O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p_i <= O_ZD; 

  end process;


  PipeLine_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE_CLK = "CLK0") then
       pipeline_clk <= CLK0_ipd;
     elsif (REG_PIPELINE_CLK = "CLK1") then
       pipeline_clk <= CLK1_ipd;
     elsif (REG_PIPELINE_CLK = "CLK2") then
       pipeline_clk <= CLK2_ipd;
     elsif (REG_PIPELINE_CLK = "CLK3") then
       pipeline_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE_CE = "CE0") then
       pipeline_ce <= CE0_ipd;
     elsif (REG_PIPELINE_CE = "CE1") then
       pipeline_ce <= CE1_ipd;
     elsif (REG_PIPELINE_CE = "CE2") then
       pipeline_ce <= CE2_ipd;
     elsif (REG_PIPELINE_CE = "CE3") then
       pipeline_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE_RST = "RST0") then
       pipeline_rst <= RST0_ipd;
     elsif (REG_PIPELINE_RST = "RST1") then
       pipeline_rst <= RST1_ipd;
     elsif (REG_PIPELINE_RST = "RST2") then
       pipeline_rst <= RST2_ipd;
     elsif (REG_PIPELINE_RST = "RST3") then
       pipeline_rst <= RST3_ipd;
     end if;
  end process;

  Pipeline_p_i : process(pipeline_clk, pipeline_rst_ogsr, pipeline_ce, p_i)
  begin
     if (pipeline_rst_ogsr = '1') then
       p_o <= (others => '0');
     elsif (rising_edge(pipeline_clk)) then
       if (pipeline_ce = '1') then
         p_o <= p_i;
       end if;
     end if;
  end process;

  Select_NOPIPELINE_OR_PIPELINE : process (p_i, p_o)
  begin
     if (REG_PIPELINE_CLK = "NONE") then
       p_ps <= p_i;
     else
       p_ps <= p_o;
     end if;
  end process;

  p_ps_accum_process : process (P_ps, signeda_p2, signedb_p2)
  begin
    if (signeda_p2 = '1' or signedb_p2 = '1') then
      P_ps_accum(35 downto 0) <= P_ps;
      P_ps_accum(52 downto 36) <=(others => P_ps(35));
    else
      P_ps_accum(35 downto 0) <= P_ps;
      P_ps_accum(52 downto 36) <= (others => '0');
    end if;
  end process;

  accum_sig <= ADDVECT(accum_sig_l, P_ps_accum) when (addnsub_p2 = '1') else SUBVECT(accum_sig_l, P_ps_accum) ;

--  P_sig_ps_accum <= ADDVECT(P_ps_accum, Zerovector) when (addnsub_p2 = '1') else SUBVECT(Zerovector, P_ps_accum) ;

  ACCUMSLOAD_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ACCUMSLOAD_0_CLK = "CLK0") then
       accumsload_0_clk <= CLK0_ipd;
     elsif (REG_ACCUMSLOAD_0_CLK = "CLK1") then
       accumsload_0_clk <= CLK1_ipd;
     elsif (REG_ACCUMSLOAD_0_CLK = "CLK2") then
       accumsload_0_clk <= CLK2_ipd;
     elsif (REG_ACCUMSLOAD_0_CLK = "CLK3") then
       accumsload_0_clk <= CLK3_ipd;
     end if;
  end process;

  ACCUMSLOAD_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ACCUMSLOAD_0_CE = "CE0") then
       accumsload_0_ce <= CE0_ipd;
     elsif (REG_ACCUMSLOAD_0_CE = "CE1") then
       accumsload_0_ce <= CE1_ipd;
     elsif (REG_ACCUMSLOAD_0_CE = "CE2") then
       accumsload_0_ce <= CE2_ipd;
     elsif (REG_ACCUMSLOAD_0_CE = "CE3") then
       accumsload_0_ce <= CE3_ipd;
     end if;
  end process;

  ACCUMSLOAD_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ACCUMSLOAD_0_RST = "RST0") then
       accumsload_0_rst <= RST0_ipd;
     elsif (REG_ACCUMSLOAD_0_RST = "RST1") then
       accumsload_0_rst <= RST1_ipd;
     elsif (REG_ACCUMSLOAD_0_RST = "RST2") then
       accumsload_0_rst <= RST2_ipd;
     elsif (REG_ACCUMSLOAD_0_RST = "RST3") then
       accumsload_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_ACCUMSLOAD : process(accumsload_0_clk, accumsload_0_rst_ogsr, accumsload_0_ce, ACCUMSLOAD_ipd)
  begin
     if (accumsload_0_rst_ogsr = '1') then
       accumsload_0_reg <= '0';
     elsif (rising_edge(accumsload_0_clk)) then
       if (accumsload_0_ce = '1') then
         accumsload_0_reg <= ACCUMSLOAD_ipd;
       end if;
     end if;
  end process;

  Select_ACCUMSLOAD_ipd_OR_ACCUMSLOAD_0_reg : process (ACCUMSLOAD_ipd, accumsload_0_reg)
  begin
     if (REG_ACCUMSLOAD_0_CLK = "NONE") then
       accumsload_p1 <= ACCUMSLOAD_ipd;
     else
       accumsload_p1 <= accumsload_0_reg;
     end if;
  end process; 

  ACCUMSLOAD_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_ACCUMSLOAD_1_CLK = "CLK0") then
       accumsload_1_clk <= CLK0_ipd;
     elsif (REG_ACCUMSLOAD_1_CLK = "CLK1") then
       accumsload_1_clk <= CLK1_ipd;
     elsif (REG_ACCUMSLOAD_1_CLK = "CLK2") then
       accumsload_1_clk <= CLK2_ipd;
     elsif (REG_ACCUMSLOAD_1_CLK = "CLK3") then
       accumsload_1_clk <= CLK3_ipd;
     end if;
  end process;

  ACCUMSLOAD_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_ACCUMSLOAD_1_CE = "CE0") then
       accumsload_1_ce <= CE0_ipd;
     elsif (REG_ACCUMSLOAD_1_CE = "CE1") then
       accumsload_1_ce <= CE1_ipd;
     elsif (REG_ACCUMSLOAD_1_CE = "CE2") then
       accumsload_1_ce <= CE2_ipd;
     elsif (REG_ACCUMSLOAD_1_CE = "CE3") then
       accumsload_1_ce <= CE3_ipd;
     end if;
  end process;

  ACCUMSLOAD_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_ACCUMSLOAD_1_RST = "RST0") then
       accumsload_1_rst <= RST0_ipd;
     elsif (REG_ACCUMSLOAD_1_RST = "RST1") then
       accumsload_1_rst <= RST1_ipd;
     elsif (REG_ACCUMSLOAD_0_RST = "RST2") then
       accumsload_1_rst <= RST2_ipd;
     elsif (REG_ACCUMSLOAD_1_RST = "RST3") then
       accumsload_1_rst <= RST3_ipd;
     end if;
  end process;

  Register_1_ACCUMSLOAD : process(accumsload_1_clk, accumsload_1_rst_ogsr, accumsload_1_ce, accumsload_p1)
  begin
     if (accumsload_0_rst_ogsr = '1') then
       accumsload_1_reg <= '0';
     elsif (rising_edge(accumsload_1_clk)) then
       if (accumsload_1_ce = '1') then
         accumsload_1_reg <= accumsload_p1;
       end if;
     end if;
  end process;

  Select_ACCUMSLOAD_ipd_OR_ACCUMSLOAD_1_reg : process (accumsload_p1, accumsload_1_reg)
  begin
     if (REG_ACCUMSLOAD_1_CLK = "NONE") then
       accumsload_p2 <= accumsload_p1;
     else
       accumsload_p2 <= accumsload_1_reg;
     end if;
  end process; 

  Load_OR_not_Load : process (accumsload_p2, accum_reg, ld_ipd)
  begin
    if (accumsload_p2 = '1') then
       accum_sig_l(51 downto 0) <= ld_ipd;
       if (signeda_p2 = '1' or signedb_p2 = '1') then
          accum_sig_l(52) <= ld_ipd(51);
       else
          accum_sig_l(52) <= '0';
       end if;
    else
       accum_sig_l(51 downto 0) <= accum_reg(51 downto 0);
       if (signeda_p2 = '1' or signedb_p2 = '1') then
          accum_sig_l(52) <= accum_reg(51);
       else
          accum_sig_l(52) <= '0';
       end if;
    end if;
  end process;

  Output_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_OUTPUT_CLK = "CLK0") then
       output_clk <= CLK0_ipd;
     elsif (REG_OUTPUT_CLK = "CLK1") then
       output_clk <= CLK1_ipd;
     elsif (REG_OUTPUT_CLK = "CLK2") then
       output_clk <= CLK2_ipd;
     elsif (REG_OUTPUT_CLK = "CLK3") then
       output_clk <= CLK3_ipd;
     end if;
  end process;

  Output_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_OUTPUT_CE = "CE0") then
       output_ce <= CE0_ipd;
     elsif (REG_OUTPUT_CE = "CE1") then
       output_ce <= CE1_ipd;
     elsif (REG_OUTPUT_CE = "CE2") then
       output_ce <= CE2_ipd;
     elsif (REG_OUTPUT_CE = "CE3") then
       output_ce <= CE3_ipd;
     end if;
  end process;

  Output_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_OUTPUT_RST = "RST0") then
       output_rst <= RST0_ipd;
     elsif (REG_OUTPUT_RST = "RST1") then
       output_rst <= RST1_ipd;
     elsif (REG_OUTPUT_RST = "RST2") then
       output_rst <= RST2_ipd;
     elsif (REG_OUTPUT_RST = "RST3") then
       output_rst <= RST3_ipd;
     end if;
  end process;

  Output_Register : process(output_clk, output_rst_ogsr, output_ce, accum_sig)
  begin
     if (output_rst_ogsr = '1') then
       accum_reg <= (others => '0');
     elsif (rising_edge(output_clk)) then
       if (output_ce = '1') then
         accum_reg <= accum_sig;
       end if;
     end if;
  end process;

  Output_Register1 : process(output_clk, output_rst_ogsr, output_ce, accum_reg,
  accumsload_p2, P_ps_accum)
  begin
     if (output_rst_ogsr = '1') then
       overflow_sig_1 <= '0';
       overflow_sig_2 <= '0';
       P_sig_ps_accum_2 <= (others => '0');
       accumsload_p3 <= '0';
     elsif (rising_edge(output_clk)) then
       if (output_ce = '1') then
         overflow_sig_1 <= accum_reg(52);
         overflow_sig_2 <= (not accum_reg(52) and accum_reg(51)) or (accum_reg(52) and not accum_reg(51));
         P_sig_ps_accum_2 <= P_ps_accum;
         accumsload_p3 <= accumsload_p2;
       end if;
     end if;
  end process;

  signedab_p2 <= signeda_p2 or signedb_p2;

  Overflow_process : process(signedab_p2, accum_reg)
  begin
    if (signedab_p2 = '1') then
       OVERFLOW_ipd <= (((not accum_reg(52)) and accum_reg(51)) or (accum_reg(52) and (not accum_reg(51))));
    else
       OVERFLOW_ipd <= accum_reg(52);
    end if;
  end process;

end V;

configuration CFG_MULT18X18MACB_V of MULT18X18MACB is
   for V
   end for;
end CFG_MULT18X18MACB_V;
----- CELL MULT36X36B -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use work.components.all;
use work.global.gsrnet;
use work.global.purnet;

-- entity declaration --
entity MULT36X36B is
  generic(
	 REG_INPUTA_CLK       : string     := "NONE";
	 REG_INPUTA_CE        : string     := "CE0";
	 REG_INPUTA_RST       : string     := "RST0";
	 REG_INPUTB_CLK       : string     := "NONE";
	 REG_INPUTB_CE        : string     := "CE0";
	 REG_INPUTB_RST       : string     := "RST0";
	 REG_PIPELINE_CLK     : string     := "NONE";
	 REG_PIPELINE_CE      : string     := "CE0";
	 REG_PIPELINE_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDA_0_CLK   : string     := "NONE";
	 REG_SIGNEDA_0_CE    : string     := "CE0";
	 REG_SIGNEDA_0_RST   : string     := "RST0";
	 REG_SIGNEDA_1_CLK   : string     := "NONE";
	 REG_SIGNEDA_1_CE    : string     := "CE0";
	 REG_SIGNEDA_1_RST   : string     := "RST0";
         REG_SIGNEDB_0_CLK   : string     := "NONE";
         REG_SIGNEDB_0_CE    : string     := "CE0";
         REG_SIGNEDB_0_RST   : string     := "RST0";
         REG_SIGNEDB_1_CLK   : string     := "NONE";
         REG_SIGNEDB_1_CE    : string     := "CE0";
         REG_SIGNEDB_1_RST   : string     := "RST0";
	 GSR                  : string     := "ENABLED");
  port (
        A0 : in STD_ULOGIC;
        A1 : in STD_ULOGIC;
        A2 : in STD_ULOGIC;
        A3 : in STD_ULOGIC;
        A4 : in STD_ULOGIC;
        A5 : in STD_ULOGIC;
        A6 : in STD_ULOGIC;
        A7 : in STD_ULOGIC;
        A8 : in STD_ULOGIC;
        A9 : in STD_ULOGIC;
        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;
        A18 : in STD_ULOGIC;
        A19 : in STD_ULOGIC;
        A20 : in STD_ULOGIC;
        A21 : in STD_ULOGIC;
        A22 : in STD_ULOGIC;
        A23 : in STD_ULOGIC;
        A24 : in STD_ULOGIC;
        A25 : in STD_ULOGIC;
        A26 : in STD_ULOGIC;
        A27 : in STD_ULOGIC;
        A28 : in STD_ULOGIC;
        A29 : in STD_ULOGIC;
        A30 : in STD_ULOGIC;
        A31 : in STD_ULOGIC;
        A32 : in STD_ULOGIC;
        A33 : in STD_ULOGIC;
        A34 : in STD_ULOGIC;
        A35 : in STD_ULOGIC;

        B0 : in STD_ULOGIC;
        B1 : in STD_ULOGIC;
        B2 : in STD_ULOGIC;
        B3 : in STD_ULOGIC;
        B4 : in STD_ULOGIC;
        B5 : in STD_ULOGIC;
        B6 : in STD_ULOGIC;
        B7 : in STD_ULOGIC;
        B8 : in STD_ULOGIC;
        B9 : in STD_ULOGIC;
        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;
        B18 : in STD_ULOGIC;
        B19 : in STD_ULOGIC;
        B20 : in STD_ULOGIC;
        B21 : in STD_ULOGIC;
        B22 : in STD_ULOGIC;
        B23 : in STD_ULOGIC;
        B24 : in STD_ULOGIC;
        B25 : in STD_ULOGIC;
        B26 : in STD_ULOGIC;
        B27 : in STD_ULOGIC;
        B28 : in STD_ULOGIC;
        B29 : in STD_ULOGIC;
        B30 : in STD_ULOGIC;
        B31 : in STD_ULOGIC;
        B32 : in STD_ULOGIC;
        B33 : in STD_ULOGIC;
        B34 : in STD_ULOGIC;
        B35 : in STD_ULOGIC;

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        P0 : out STD_ULOGIC;
        P1 : out STD_ULOGIC;
        P2 : out STD_ULOGIC;
        P3 : out STD_ULOGIC;
        P4 : out STD_ULOGIC;
        P5 : out STD_ULOGIC;
        P6 : out STD_ULOGIC;
        P7 : out STD_ULOGIC;
        P8 : out STD_ULOGIC;
        P9 : out STD_ULOGIC;
        P10 : out STD_ULOGIC;
        P11 : out STD_ULOGIC;
        P12 : out STD_ULOGIC;
        P13 : out STD_ULOGIC;
        P14 : out STD_ULOGIC;
        P15 : out STD_ULOGIC;
        P16 : out STD_ULOGIC;
        P17 : out STD_ULOGIC;
        P18 : out STD_ULOGIC;
        P19 : out STD_ULOGIC;
        P20 : out STD_ULOGIC;
        P21 : out STD_ULOGIC;
        P22 : out STD_ULOGIC;
        P23 : out STD_ULOGIC;
        P24 : out STD_ULOGIC;
        P25 : out STD_ULOGIC;
        P26 : out STD_ULOGIC;
        P27 : out STD_ULOGIC;
        P28 : out STD_ULOGIC;
        P29 : out STD_ULOGIC;
        P30 : out STD_ULOGIC;
        P31 : out STD_ULOGIC;
        P32 : out STD_ULOGIC;
        P33 : out STD_ULOGIC;
        P34 : out STD_ULOGIC;
        P35 : out STD_ULOGIC;
        P36 : out STD_ULOGIC;
        P37 : out STD_ULOGIC;
        P38 : out STD_ULOGIC;
        P39 : out STD_ULOGIC;
        P40 : out STD_ULOGIC;
        P41 : out STD_ULOGIC;
        P42 : out STD_ULOGIC;
        P43 : out STD_ULOGIC;
        P44 : out STD_ULOGIC;
        P45 : out STD_ULOGIC;
        P46 : out STD_ULOGIC;
        P47 : out STD_ULOGIC;
        P48 : out STD_ULOGIC;
        P49 : out STD_ULOGIC;
        P50 : out STD_ULOGIC;
        P51 : out STD_ULOGIC;
        P52 : out STD_ULOGIC;
        P53 : out STD_ULOGIC;
        P54 : out STD_ULOGIC;
        P55 : out STD_ULOGIC;
        P56 : out STD_ULOGIC;
        P57 : out STD_ULOGIC;
        P58 : out STD_ULOGIC;
        P59 : out STD_ULOGIC;
        P60 : out STD_ULOGIC;
        P61 : out STD_ULOGIC;
        P62 : out STD_ULOGIC;
        P63 : out STD_ULOGIC;
        P64 : out STD_ULOGIC;
        P65 : out STD_ULOGIC;
        P66 : out STD_ULOGIC;
        P67 : out STD_ULOGIC;
        P68 : out STD_ULOGIC;
        P69 : out STD_ULOGIC;
        P70 : out STD_ULOGIC;
        P71 : out STD_ULOGIC
       ); 

attribute VITAL_LEVEL0 of MULT36X36B : entity is TRUE;

end MULT36X36B;

--- Architecture 

library IEEE;
use IEEE.VITAL_Primitives.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
architecture V of MULT36X36B is

  attribute VITAL_LEVEL0 of V : architecture is TRUE;


  -- Local signals used to propagate input wire delay

  signal A_ipd, A_ipd1 : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal B_ipd, B_ipd1 : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_ipd     : std_logic_vector(71 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal SIGNEDA_ipd, SIGNEDA_ipd1 : std_logic := 'X';
  signal SIGNEDB_ipd, SIGNEDB_ipd1 : std_logic := 'X';
  signal CE0_ipd   : std_logic := 'X';
  signal CE1_ipd   : std_logic := 'X';
  signal CE2_ipd   : std_logic := 'X';
  signal CE3_ipd   : std_logic := 'X';
  signal CLK0_ipd  : std_logic := 'X';
  signal CLK1_ipd  : std_logic := 'X';
  signal CLK2_ipd  : std_logic := 'X';
  signal CLK3_ipd  : std_logic := 'X';
  signal RST0_ipd  : std_logic := 'X';
  signal RST1_ipd  : std_logic := 'X';
  signal RST2_ipd  : std_logic := 'X';
  signal RST3_ipd  : std_logic := 'X';

  signal A_reg     : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal B_reg     : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal A_p       : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal B_p       : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_i       : std_logic_vector(71 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_o       : std_logic_vector(71 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_ps      : std_logic_vector(71 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
  signal P_o1      : std_logic_vector(71 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";

  signal input_a_clk  : std_logic := 'X';
  signal input_a_ce   : std_logic := 'X';
  signal input_a_rst  : std_logic := 'X';
  signal input_b_clk  : std_logic := 'X';
  signal input_b_ce   : std_logic := 'X';
  signal input_b_rst  : std_logic := 'X';
  signal pipeline_clk : std_logic := 'X';
  signal pipeline_ce  : std_logic := 'X';
  signal pipeline_rst : std_logic := 'X';
  signal output_clk   : std_logic := 'X';
  signal output_ce    : std_logic := 'X';
  signal output_rst   : std_logic := 'X';
  signal signeda_0_clk : std_logic := 'X';
  signal signeda_0_ce  : std_logic := 'X';
  signal signeda_0_rst  : std_logic := 'X';
  signal signeda_1_clk : std_logic := 'X';
  signal signeda_1_ce  : std_logic := 'X';
  signal signeda_1_rst  : std_logic := 'X';
  signal signeda_0_reg  : std_logic := 'X';
  signal signeda_1_reg  : std_logic := 'X';
  signal signeda_p1  : std_logic := 'X';
  signal signeda_p2  : std_logic := 'X';
  signal signedb_0_clk : std_logic := 'X';
  signal signedb_0_ce  : std_logic := 'X';
  signal signedb_0_rst  : std_logic := 'X';
  signal signedb_1_clk : std_logic := 'X';
  signal signedb_1_ce  : std_logic := 'X';
  signal signedb_1_rst  : std_logic := 'X';
  signal signedb_0_reg  : std_logic := 'X';
  signal signedb_1_reg  : std_logic := 'X';
  signal signedb_p1  : std_logic := 'X';
  signal signedb_p2  : std_logic := 'X';

  signal SRN          : std_logic;
  signal input_a_rst_ogsr  : std_logic := 'X';
  signal input_b_rst_ogsr  : std_logic := 'X';
  signal pipeline_rst_ogsr  : std_logic := 'X';
  signal output_rst_ogsr  : std_logic := 'X';
  signal signeda_0_rst_ogsr  : std_logic := 'X';
  signal signeda_1_rst_ogsr  : std_logic := 'X';
  signal signedb_0_rst_ogsr  : std_logic := 'X';
  signal signedb_1_rst_ogsr  : std_logic := 'X';

begin 

    global_reset : process (purnet, gsrnet)
      begin
        if (GSR =  "DISABLED") then
           SRN <= purnet;
        else
           SRN <= purnet AND gsrnet;
        end if;
      end process;

    input_a_rst_ogsr <= input_a_rst or not SRN;
    input_b_rst_ogsr <= input_b_rst or not SRN;
    pipeline_rst_ogsr <= pipeline_rst or not SRN;
    output_rst_ogsr <= output_rst or not SRN;
    signeda_0_rst_ogsr <= signeda_0_rst or not SRN;
    signeda_1_rst_ogsr <= signeda_1_rst or not SRN;
    signedb_0_rst_ogsr <= signedb_0_rst or not SRN;
    signedb_1_rst_ogsr <= signedb_1_rst or not SRN;

    A_ipd1 <= (A35 & A34 & A33 & A32 & A31 & A30 & A29 & A28 & A27 & A26 & A25 & A24 & A23 & A22 & A21 & A20 & A19 & A18 & A17 & A16 & A15 & A14 & A13 & A12 & A11 & A10 & A9 & A8 & A7 & A6 & A5 & A4 & A3 & A2 & A1 & A0);
    B_ipd1 <= (B35 & B34 & B33 & B32 & B31 & B30 & B29 & B28 & B27 & B26 & B25 & B24 & B23 & B22 & B21 & B20 & B19 & B18 & B17 & B16 & B15 & B14 & B13 & B12 & B11 & B10 & B9 & B8 & B7 & B6 & B5 & B4 & B3 & B2 & B1 & B0);
    SIGNEDA_ipd1 <= SIGNEDA;
    SIGNEDB_ipd1 <= SIGNEDB;

    A_ipd <= A_ipd1;
    B_ipd <= B_ipd1;
    SIGNEDA_ipd <= SIGNEDA_ipd1;
    SIGNEDB_ipd <= SIGNEDB_ipd1;

    CE0_ipd <= CE0;
    CE1_ipd <= CE1;
    CE2_ipd <= CE2;
    CE3_ipd <= CE3;
    CLK0_ipd <= CLK0;
    CLK1_ipd <= CLK1;
    CLK2_ipd <= CLK2;
    CLK3_ipd <= CLK3;
    RST0_ipd <= RST0;
    RST1_ipd <= RST1;
    RST2_ipd <= RST2;
    RST3_ipd <= RST3;

    P0 <= P_ipd(0);
    P1 <= P_ipd(1);
    P2 <= P_ipd(2);
    P3 <= P_ipd(3);
    P4 <= P_ipd(4);
    P5 <= P_ipd(5);
    P6 <= P_ipd(6);
    P7 <= P_ipd(7);
    P8 <= P_ipd(8);
    P9 <= P_ipd(9);
    P10 <= P_ipd(10);
    P11 <= P_ipd(11);
    P12 <= P_ipd(12);
    P13 <= P_ipd(13);
    P14 <= P_ipd(14);
    P15 <= P_ipd(15);
    P16 <= P_ipd(16);
    P17 <= P_ipd(17);
    P18 <= P_ipd(18);
    P19 <= P_ipd(19);
    P20 <= P_ipd(20);
    P21 <= P_ipd(21);
    P22 <= P_ipd(22);
    P23 <= P_ipd(23);
    P24 <= P_ipd(24);
    P25 <= P_ipd(25);
    P26 <= P_ipd(26);
    P27 <= P_ipd(27);
    P28 <= P_ipd(28);
    P29 <= P_ipd(29);
    P30 <= P_ipd(30);
    P31 <= P_ipd(31);
    P32 <= P_ipd(32);
    P33 <= P_ipd(33);
    P34 <= P_ipd(34);
    P35 <= P_ipd(35);
    P36 <= P_ipd(36);
    P37 <= P_ipd(37);
    P38 <= P_ipd(38);
    P39 <= P_ipd(39);
    P40 <= P_ipd(40);
    P41 <= P_ipd(41);
    P42 <= P_ipd(42);
    P43 <= P_ipd(43);
    P44 <= P_ipd(44);
    P45 <= P_ipd(45);
    P46 <= P_ipd(46);
    P47 <= P_ipd(47);
    P48 <= P_ipd(48);
    P49 <= P_ipd(49);
    P50 <= P_ipd(50);
    P51 <= P_ipd(51);
    P52 <= P_ipd(52);
    P53 <= P_ipd(53);
    P54 <= P_ipd(54);
    P55 <= P_ipd(55);
    P56 <= P_ipd(56);
    P57 <= P_ipd(57);
    P58 <= P_ipd(58);
    P59 <= P_ipd(59);
    P60 <= P_ipd(60);
    P61 <= P_ipd(61);
    P62 <= P_ipd(62);
    P63 <= P_ipd(63);
    P64 <= P_ipd(64);
    P65 <= P_ipd(65);
    P66 <= P_ipd(66);
    P67 <= P_ipd(67);
    P68 <= P_ipd(68);
    P69 <= P_ipd(69);
    P70 <= P_ipd(70);
    P71 <= P_ipd(71);

  Input_A_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTA_CLK = "CLK0") then
       input_a_clk <= CLK0_ipd;
     elsif (REG_INPUTA_CLK = "CLK1") then
       input_a_clk <= CLK1_ipd;
     elsif (REG_INPUTA_CLK = "CLK2") then
       input_a_clk <= CLK2_ipd;
     elsif (REG_INPUTA_CLK = "CLK3") then
       input_a_clk <= CLK3_ipd;
     end if;
  end process;

  Input_A_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTA_CE = "CE0") then
       input_a_ce <= CE0_ipd;
     elsif (REG_INPUTA_CE = "CE1") then
       input_a_ce <= CE1_ipd;
     elsif (REG_INPUTA_CE = "CE2") then
       input_a_ce <= CE2_ipd;
     elsif (REG_INPUTA_CE = "CE3") then
       input_a_ce <= CE3_ipd;
     end if;
  end process;

  Input_A_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTA_RST = "RST0") then
       input_a_rst <= RST0_ipd;
     elsif (REG_INPUTA_RST = "RST1") then
       input_a_rst <= RST1_ipd;
     elsif (REG_INPUTA_RST = "RST2") then
       input_a_rst <= RST2_ipd;
     elsif (REG_INPUTA_RST = "RST3") then
       input_a_rst <= RST3_ipd;
     end if;
  end process;
      
  Register_A_Input : process(input_a_clk, input_a_rst_ogsr, input_a_ce, A_ipd)
  begin
     if (input_a_rst_ogsr = '1') then
       A_reg <= (others => '0');
     elsif (rising_edge(input_a_clk)) then
       if (input_a_ce = '1') then
         A_reg <= A_ipd;
       end if;
     end if;
  end process;

  Select_A_OR_A_reg : process (A_ipd, A_reg)
  begin
     if (REG_INPUTA_CLK = "NONE") then
       A_p <= A_ipd;
     else
       A_p <= A_reg;
     end if;
  end process;

  Input_B_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_INPUTB_CLK = "CLK0") then
       input_b_clk <= CLK0_ipd;
     elsif (REG_INPUTB_CLK = "CLK1") then
       input_b_clk <= CLK1_ipd;
     elsif (REG_INPUTB_CLK = "CLK2") then
       input_b_clk <= CLK2_ipd;
     elsif (REG_INPUTB_CLK = "CLK3") then
       input_b_clk <= CLK3_ipd;
     end if;
  end process;

  Input_B_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_INPUTB_CE = "CE0") then
       input_b_ce <= CE0_ipd;
     elsif (REG_INPUTB_CE = "CE1") then
       input_b_ce <= CE1_ipd;
     elsif (REG_INPUTB_CE = "CE2") then
       input_b_ce <= CE2_ipd;
     elsif (REG_INPUTB_CE = "CE3") then
       input_b_ce <= CE3_ipd;
     end if;
  end process;

  Input_B_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_INPUTB_RST = "RST0") then
       input_b_rst <= RST0_ipd;
     elsif (REG_INPUTB_RST = "RST1") then
       input_b_rst <= RST1_ipd;
     elsif (REG_INPUTB_RST = "RST2") then
       input_b_rst <= RST2_ipd;
     elsif (REG_INPUTB_RST = "RST3") then
       input_b_rst <= RST3_ipd;
     end if;
  end process;

  Register_B_Input : process(input_b_clk, input_b_rst_ogsr, input_b_ce, B_ipd)
  begin
     if (input_b_rst_ogsr = '1') then
       B_reg <= (others => '0');
     elsif (rising_edge(input_b_clk)) then
       if (input_b_ce = '1') then
         B_reg <= B_ipd;
       end if;
     end if;
  end process;

  Select_B_OR_B_reg : process (B_ipd, B_reg)
  begin
     if (REG_INPUTB_CLK = "NONE") then
       B_p <= B_ipd;
     else
       B_p <= B_reg;
     end if;
  end process;

  SIGNEDAB_0_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_0_CLK = "CLK0") then
       signeda_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK1") then
       signeda_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK2") then
       signeda_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_0_CLK = "CLK3") then
       signeda_0_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_0_CLK = "CLK0") then
       signedb_0_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK1") then
       signedb_0_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK2") then
       signedb_0_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_0_CLK = "CLK3") then
       signedb_0_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_0_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_0_CE = "CE0") then
       signeda_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE1") then
       signeda_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE2") then
       signeda_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_0_CE = "CE3") then
       signeda_0_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_0_CE = "CE0") then
       signedb_0_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE1") then
       signedb_0_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE2") then
       signedb_0_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_0_CE = "CE3") then
       signedb_0_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_0_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_0_RST = "RST0") then
       signeda_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST1") then
       signeda_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST2") then
       signeda_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST3") then
       signeda_0_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_0_RST = "RST0") then
       signedb_0_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST1") then
       signedb_0_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST2") then
       signedb_0_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST3") then
       signedb_0_rst <= RST3_ipd;
     end if;
  end process;

  Register_0_SIGNEDA : process(signeda_0_clk, signeda_0_rst_ogsr, signeda_0_ce, SIGNEDA_ipd)
  begin
     if (signeda_0_rst_ogsr = '1') then
       signeda_0_reg <= '0';
     elsif (rising_edge(signeda_0_clk)) then
       if (signeda_0_ce = '1') then
         signeda_0_reg <= SIGNEDA_ipd;
       end if;
     end if;
  end process;

  Register_0_SIGNEDB : process(signedb_0_clk, signedb_0_rst_ogsr, signedb_0_ce, SIGNEDB_ipd)
  begin
     if (signedb_0_rst_ogsr = '1') then
       signedb_0_reg <= '0';
     elsif (rising_edge(signedb_0_clk)) then
       if (signedb_0_ce = '1') then
         signedb_0_reg <= SIGNEDB_ipd;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_0_reg : process (SIGNEDA_ipd, signeda_0_reg)
  begin
     if (REG_SIGNEDA_0_CLK = "NONE") then
       signeda_p1 <= SIGNEDA_ipd;
     else
       signeda_p1 <= signeda_0_reg;
     end if;
  end process; 

  Select_SIGNEDB_ipd_OR_SIGNEDB_0_reg : process (SIGNEDB_ipd, signedb_0_reg)
  begin
     if (REG_SIGNEDB_0_CLK = "NONE") then
       signedb_p1 <= SIGNEDB_ipd;
     else
       signedb_p1 <= signedb_0_reg;
     end if;
  end process;

  SIGNEDAB_1_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_SIGNEDA_1_CLK = "CLK0") then
       signedb_1_clk <= CLK0_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK1") then
       signedb_1_clk <= CLK1_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK2") then
       signedb_1_clk <= CLK2_ipd;
     elsif (REG_SIGNEDA_1_CLK = "CLK3") then
       signedb_1_clk <= CLK3_ipd;
     end if;

     if (REG_SIGNEDB_1_CLK = "CLK0") then
       signedb_1_clk <= CLK0_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK1") then
       signedb_1_clk <= CLK1_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK2") then
       signedb_1_clk <= CLK2_ipd;
     elsif (REG_SIGNEDB_1_CLK = "CLK3") then
       signedb_1_clk <= CLK3_ipd;
     end if;
  end process;

  SIGNEDAB_1_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_SIGNEDA_1_CE = "CE0") then
       signeda_1_ce <= CE0_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE1") then
       signeda_1_ce <= CE1_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE2") then
       signeda_1_ce <= CE2_ipd;
     elsif (REG_SIGNEDA_1_CE = "CE3") then
       signeda_1_ce <= CE3_ipd;
     end if;

     if (REG_SIGNEDB_1_CE = "CE0") then
       signedb_1_ce <= CE0_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE1") then
       signedb_1_ce <= CE1_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE2") then
       signedb_1_ce <= CE2_ipd;
     elsif (REG_SIGNEDB_1_CE = "CE3") then
       signedb_1_ce <= CE3_ipd;
     end if;
  end process;

  SIGNEDAB_1_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_SIGNEDA_1_RST = "RST0") then
       signeda_1_rst <= RST0_ipd;
     elsif (REG_SIGNEDA_1_RST = "RST1") then
       signeda_1_rst <= RST1_ipd;
     elsif (REG_SIGNEDA_0_RST = "RST2") then
       signeda_1_rst <= RST2_ipd;
     elsif (REG_SIGNEDA_1_RST = "RST3") then
       signeda_1_rst <= RST3_ipd;
     end if;

     if (REG_SIGNEDB_1_RST = "RST0") then
       signedb_1_rst <= RST0_ipd;
     elsif (REG_SIGNEDB_1_RST = "RST1") then
       signedb_1_rst <= RST1_ipd;
     elsif (REG_SIGNEDB_0_RST = "RST2") then
       signedb_1_rst <= RST2_ipd;
     elsif (REG_SIGNEDB_1_RST = "RST3") then
       signedb_1_rst <= RST3_ipd;
     end if;
  end process;

  Register_1_SIGNEDA : process(signeda_1_clk, signeda_1_rst_ogsr, signeda_1_ce, signeda_p1)
  begin
     if (signeda_0_rst_ogsr = '1') then
       signeda_1_reg <= '0';
     elsif (rising_edge(signeda_1_clk)) then
       if (signeda_1_ce = '1') then
         signeda_1_reg <= signeda_p1;
       end if;
     end if;
  end process;

  Register_1_SIGNEDB : process(signedb_1_clk, signedb_1_rst_ogsr, signedb_1_ce, signedb_p1)
  begin
     if (signedb_0_rst_ogsr = '1') then
       signedb_1_reg <= '0';
     elsif (rising_edge(signedb_1_clk)) then
       if (signedb_1_ce = '1') then
         signedb_1_reg <= signedb_p1;
       end if;
     end if;
  end process;

  Select_SIGNEDA_ipd_OR_SIGNEDA_1_reg : process (signeda_p1, signeda_1_reg)
  begin
     if (REG_SIGNEDA_1_CLK = "NONE") then
       signeda_p2 <= signeda_p1;
     else
       signeda_p2 <= signeda_1_reg;
     end if;
  end process;          

  Select_SIGNEDB_ipd_OR_SIGNEDB_1_reg : process (signedb_p1, signedb_1_reg)
  begin
     if (REG_SIGNEDB_1_CLK = "NONE") then
       signedb_p2 <= signedb_p1;
     else
       signedb_p2 <= signedb_1_reg;
     end if;
  end process;

  VITALMultBehavior : process(A_p, B_p, signeda_p2, signedb_p2)

    variable y0, y1, y2, y3, y4, y5, sum0, sum1, sum2, sum3 : std_logic_vector( 71 downto 0);
    variable O_zd: std_logic_vector( 71 downto 0);
    variable IAL, IAU, IBL, IBM, IBU  : integer ;
    variable sign : std_logic := '0';
    variable A_i : std_logic_vector(35 downto 0);
    variable B_i : std_logic_vector(35 downto 0);
    variable y0_i, y1_i, y2_i, y3_i, y4_i, y5_i  : std_logic_vector(29 downto 0);

  begin -- process

    if ((A_p = "000000000000000000000000000000000000") or (B_p = "000000000000000000000000000000000000")) then
            O_zd := (others => '0');
    elsif (IS_X(A_p) or IS_X(B_p) ) then
            O_zd := (others => 'X');
    else
      if ((signeda_p2 = '1') and (A_p(35) = '1' )) then
	  A_i :=  TSCOMP(A_p);
      else 
	  A_i := A_p;
      end if;

      if ((signedb_p2 = '1') and  (B_p(35)  = '1')) then
         B_i := TSCOMP(B_p);
      else
         B_i := B_p;
      end if;

         IAU := VEC2INT(A_i(35 downto 18));
         IAL := VEC2INT(A_i(17 downto 0));
         IBU := VEC2INT(B_i(35 downto 24));
         IBM := VEC2INT(B_i(23 downto 12));
         IBL := VEC2INT(B_i(11 downto 0));


         y0_i := INT2VEC((IAL * IBL), 30);
         y1_i := INT2VEC((IAL * IBM), 30);
         y2_i := INT2VEC((IAL * IBU), 30);
         y3_i := INT2VEC((IAU * IBL), 30);
         y4_i := INT2VEC((IAU * IBM), 30);
         y5_i := INT2VEC((IAU * IBU), 30);


         y0(29 downto 0)  := y0_i;
         y0(71 downto 30) := (others => '0');

         y1(11 downto 0)  := (others => '0');
         y1(41 downto 12) := y1_i;
         y1(71 downto 42) := (others => '0');

         y2(23 downto 0)  := (others => '0');
         y2(53 downto 24) := y2_i;
         y2(71 downto 54) := (others => '0');

         y3(17 downto 0)  := (others => '0');
         y3(47 downto 18) := y3_i;
         y3(71 downto 48) := (others => '0');

         y4(29 downto 0)  := (others => '0');
         y4(59 downto 30) := y4_i;
         y4(71 downto 60) := (others => '0');

         y5(41 downto 0)  := (others => '0');
         y5(71 downto 42) := y5_i;

         sum0 := ADDVECT(y0, y1);
         sum1 := ADDVECT(y2, y3);

         sum2 := ADDVECT(y4, y5);

         sum3 := ADDVECT(sum0, sum1);
         O_zd := ADDVECT(sum2, sum3);

         sign := (signeda_p2 and A_p(35)) xor (signedb_p2 and B_p(35));
         if (sign = '1' ) then
                O_zd := TSCOMP(O_zd);
         end if;

    end if;

    p_i <= O_ZD; 

  end process;


  PipeLine_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_PIPELINE_CLK = "CLK0") then
       pipeline_clk <= CLK0_ipd;
     elsif (REG_PIPELINE_CLK = "CLK1") then
       pipeline_clk <= CLK1_ipd;
     elsif (REG_PIPELINE_CLK = "CLK2") then
       pipeline_clk <= CLK2_ipd;
     elsif (REG_PIPELINE_CLK = "CLK3") then
       pipeline_clk <= CLK3_ipd;
     end if;
  end process;

  PipeLine_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_PIPELINE_CE = "CE0") then
       pipeline_ce <= CE0_ipd;
     elsif (REG_PIPELINE_CE = "CE1") then
       pipeline_ce <= CE1_ipd;
     elsif (REG_PIPELINE_CE = "CE2") then
       pipeline_ce <= CE2_ipd;
     elsif (REG_PIPELINE_CE = "CE3") then
       pipeline_ce <= CE3_ipd;
     end if;
  end process;

  PipeLine_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_PIPELINE_RST = "RST0") then
       pipeline_rst <= RST0_ipd;
     elsif (REG_PIPELINE_RST = "RST1") then
       pipeline_rst <= RST1_ipd;
     elsif (REG_PIPELINE_RST = "RST2") then
       pipeline_rst <= RST2_ipd;
     elsif (REG_PIPELINE_RST = "RST3") then
       pipeline_rst <= RST3_ipd;
     end if;
  end process;

  Pipeline_p_i : process(pipeline_clk, pipeline_rst, pipeline_ce, p_i)
  begin
     if (pipeline_rst = '1') then
       p_o <= (others => '0');
     elsif (rising_edge(pipeline_clk)) then
       if (pipeline_ce = '1') then
         p_o <= p_i;
       end if;
     end if;
  end process;

  Select_NOPIPELINE_OR_PIPELINE : process (p_i, p_o)
  begin
     if (REG_PIPELINE_CLK = "NONE") then
       p_ps <= p_i;
     else
       p_ps <= p_o;
     end if;
  end process;

  Output_Clock  : process(CLK0_ipd, CLK1_ipd, CLK2_ipd, CLK3_ipd)
  begin
     if (REG_OUTPUT_CLK = "CLK0") then
       output_clk <= CLK0_ipd;
     elsif (REG_OUTPUT_CLK = "CLK1") then
       output_clk <= CLK1_ipd;
     elsif (REG_OUTPUT_CLK = "CLK2") then
       output_clk <= CLK2_ipd;
     elsif (REG_OUTPUT_CLK = "CLK3") then
       output_clk <= CLK3_ipd;
     end if;
  end process;

  Output_ClockEnable  : process(CE0_ipd, CE1_ipd, CE2_ipd, CE3_ipd)
  begin
     if (REG_OUTPUT_CE = "CE0") then
       output_ce <= CE0_ipd;
     elsif (REG_OUTPUT_CE = "CE1") then
       output_ce <= CE1_ipd;
     elsif (REG_OUTPUT_CE = "CE2") then
       output_ce <= CE2_ipd;
     elsif (REG_OUTPUT_CE = "CE3") then
       output_ce <= CE3_ipd;
     end if;
  end process;

  Output_Reset  : process(RST0_ipd, RST1_ipd, RST2_ipd, RST3_ipd)
  begin
     if (REG_OUTPUT_RST = "RST0") then
       output_rst <= RST0_ipd;
     elsif (REG_OUTPUT_RST = "RST1") then
       output_rst <= RST1_ipd;
     elsif (REG_OUTPUT_RST = "RST2") then
       output_rst <= RST2_ipd;
     elsif (REG_OUTPUT_RST = "RST3") then
       output_rst <= RST3_ipd;
     end if;
  end process;

  Output_Register : process(output_clk, output_rst, output_ce, p_ps)
  begin
     if (output_rst = '1') then
       p_o1 <= (others => '0');
     elsif (rising_edge(output_clk)) then
       if (output_ce = '1') then
         p_o1 <= p_ps;
       end if;
     end if;
  end process;

  Select_OUTREG_OR_NOREG : process (p_ps, p_o1)
  begin
     if (REG_OUTPUT_CLK = "NONE") then
       P_ipd <= p_ps;
     else
       P_ipd <= p_o1;
     end if;
  end process;

end V;

configuration CFG_MULT36X36B_V of MULT36X36B is
   for V
   end for;
end CFG_MULT36X36B_V;
