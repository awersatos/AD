---------------------------------------------------------------------------
-- $Id: blkmemdp_v4_0.vhd,v 1.17 2008/09/08 20:06:21 akennedy Exp $
--
---------------------------------------------------------------------------
-- Dual Port Block Memory  - Behavioral Model
---------------------------------------------------------------------------
--                                                                       --
-- This File is owned and controlled by Xilinx and must be used solely   --
-- for design, simulation, implementation and creation of design files   --
-- limited to Xilinx devices or technologies. Use with non-Xilinx        --
-- devices or technologies is expressly prohibited and immediately       --
-- terminates your license.                                              --
--                                                                       --
-- Xilinx products are not intended for use in life support              --
-- appliances, devices, or systems. Use in such applications is          --
-- expressly prohibited.                                                 --
--                                                                       --
--
--        ****************************
--        ** Copyright Xilinx, Inc. **
--        ** All rights reserved.   **
--        ****************************
--
---------------------------------------------------------------------------
-- Filename:    blkmemdp_v4_0.vhd
--
-- Description: The behavioral model for the Dual Port Block Memory
--
---------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Package containing functions used in the Dual Port Block Memory Behavior
-- Model
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all; 


library XilinxCoreLib ;
use XilinxCoreLib.mem_init_file_pack_v4_0.all ;
use XilinxCoreLib.ul_utils.all ;
use XilinxCoreLib.blkmemdp_pkg_v4_0.all ;


entity blkmemdp_v4_0 is

  generic (

       c_addra_width          : integer := 11 ;
       c_addrb_width          : integer := 9  ;
       c_default_data         : string  := "0" ;
       c_depth_a              : integer := 2048 ;
       c_depth_b              : integer :=  512 ;
       c_enable_rlocs         : integer :=  0 ;
       c_has_default_data     : integer := 1 ;
       c_has_dina             : integer := 1 ;
       c_has_dinb             : integer := 1 ;
       c_has_douta            : integer := 1 ;
       c_has_doutb            : integer := 1 ;
       c_has_ena              : integer := 1 ;
       c_has_enb              : integer := 1 ;
       c_has_limit_data_pitch : integer := 1 ;
       c_has_nda              : integer := 1 ;
       c_has_ndb              : integer := 1 ;
       c_has_rdya             : integer := 1 ;
       c_has_rdyb             : integer := 1 ;
       c_has_rfda             : integer := 1 ;
       c_has_rfdb             : integer := 1 ;
       c_has_sinita           : integer := 1;
       c_has_sinitb           : integer := 1;
       c_has_wea              : integer := 1 ;
       c_has_web              : integer := 1 ;
       c_limit_data_pitch     : integer := 16 ;
       c_mem_init_file        : string  := "null.mif" ;
       c_pipe_stages_a        : integer := 0 ;
       c_pipe_stages_b        : integer := 0 ;
       c_reg_inputsa          : integer := 1 ;
       c_reg_inputsb          : integer := 1 ;
       c_sinita_value         : string  := "0000" ;
       c_sinitb_value         : string  := "0000" ;
       c_width_a              : integer := 8 ;
       c_width_b              : integer := 32 ;
       c_write_modea          : integer := 2 ;
       c_write_modeb          : integer := 2 ; 
       ------------------------------------------------------------------------
       -- new generic
       --c_xmem_init_array : MEM_ARRAY := DEFAULT_XMEM_INIT_ARRAY
       ------------------------------------------------------------------------

       ------------------------------------------------------------
       -- New Generics for Primitive Selection and Pin Polarity
       ------------------------------------------------------------
       c_ybottom_addr     : STRING := "1024";
       c_yclka_is_rising   : INTEGER := 1; 
       c_yclkb_is_rising   : INTEGER := 1; 
       c_yena_is_high      : INTEGER := 1;
       c_yenb_is_high      : INTEGER := 1;
       c_yhierarchy       : STRING  := "hierarchy1" ;
       c_ymake_bmm        : INTEGER := 0;
       c_yprimitive_type  : STRING  := "4kx4";
       c_ysinita_is_high   : INTEGER := 1; 
       c_ysinitb_is_high   : INTEGER := 1; 
       c_ytop_addr        : STRING := "0" ;
       c_yuse_single_primitive : INTEGER := 0;
       c_ywea_is_high      : INTEGER := 1;
       c_yweb_is_high      : INTEGER := 1
  );

  port (DINA   : in STD_LOGIC_VECTOR (c_width_a-1 downto 0) := (OTHERS => '0');
        DINB   : in STD_LOGIC_VECTOR (c_width_b-1 downto 0) := (OTHERS => '0');
        ENA    : in STD_LOGIC := '1';
        ENB    : in STD_LOGIC := '1';
        WEA    : in STD_LOGIC := '0';
        WEB    : in STD_LOGIC := '0' ;
        SINITA : in STD_LOGIC := '0';
        SINITB : in STD_LOGIC := '0';
        NDA    : in STD_LOGIC := '0';
        NDB    : in STD_LOGIC := '0';
        CLKA   : in STD_LOGIC;
        CLKB   : in STD_LOGIC;
        ADDRA  : in STD_LOGIC_VECTOR (c_addra_width-1 downto 0);
        ADDRB  : in STD_LOGIC_VECTOR (c_addrb_width-1 downto 0);
        RDYA   : out STD_LOGIC ;
        RDYB   : out STD_LOGIC ;
        RFDA   : out STD_LOGIC ;
        RFDB   : out STD_LOGIC ;
        DOUTA    : out STD_LOGIC_VECTOR (c_width_a-1 downto 0);
        DOUTB    : out STD_LOGIC_VECTOR (c_width_b-1 downto 0)
       ); 

end blkmemdp_v4_0;

-----------------------------------------------------------------------------

architecture behavioral of blkmemdp_v4_0 is

-----------------------------------------------------------------------------
-- Functions definitions
-----------------------------------------------------------------------------
  
  -----------------------------------------------------------------------------
  -- Procedures that outputs warning messages
  -----------------------------------------------------------------------------
  
  procedure warn_out_undef ( outsig: IN STRING;  warning_on: IN BOOLEAN ) is
  begin
    IF (warning_on = TRUE) THEN
      assert false report
      "Setting output " & outsig & " to X"
      severity WARNING;
    END IF;
  end warn_out_undef;

  procedure warn_signout_undef( sig :IN STRING; outsig: IN STRING;  warning_on: IN BOOLEAN ) is
  begin
    IF (warning_on = TRUE) THEN
      assert false report
      "Undefined input "& sig &". Setting output " & outsig & " to X"
      severity WARNING;
    END IF;
  END warn_signout_undef;

  procedure warn_memcontent_undef ( whichport: IN STRING; addr: IN STRING; warning_on: IN BOOLEAN ) is
  begin
    IF (warning_on = TRUE) THEN
      assert false report
      "Setting contents of memory at ADDR"& whichport &"="& addr &
      " to X"
      severity WARNING;
    END IF;
  end warn_memcontent_undef;

  procedure warn_oddclk_trans ( sig: STRING; bef: STRING; aft: STRING; warning_on: IN BOOLEAN) is
  begin
    IF (warning_on = TRUE) THEN
      assert false report
      "Clock signal " & sig & " transitioned from " & bef & " to " & aft &
      ". Memory operation will not be successful."
      severity WARNING;
    END IF;
  end warn_oddclk_trans;
      
  -----------------------------------------------------------------------------
  
   function SLV_TO_STR (
      SLV : in std_logic_vector
   ) return string is
 
       variable j : integer := SLV'length;
       variable STR : string (SLV'length downto 1);
 
 
   begin
           for I in SLV'high downto SLV'low loop
                case SLV(I) is
                     when '0' => STR(J) := '0';
                     when '1' => STR(J) := '1';
                     when 'X' => STR(J) := 'X';
                     when 'U' => STR(J) := 'U';
                when others => STR(J) := 'X';
                end case;
                J := J - 1;
            end loop;
            return STR;
   end SLV_TO_STR;

   procedure SET_MEM_TO_X ( sig: STRING ; ADDRESS : in std_logic_vector;
      MEM : inout std_logic_vector
   ) is
 
   begin
      assert false report
      "Invalid address "& sig &" : "& SLV_TO_STR(ADDRESS) & ". Entire memory contents will be set to 'X'."
      severity warning;
      for I in MEM'high downto MEM'low loop
          MEM(I) := 'X';
      end loop;
   end SET_MEM_TO_X;

   function SLV_TO_INT(SLV: in std_logic_vector
   ) return integer is
 
     variable int : integer;
   begin
        int := 0;
        for i in SLV'high downto SLV'low loop
            int := int * 2;
            if SLV(i) = '1' then
                int := int + 1;
            end if;
        end loop;
        return int;
   end;

   function ADDR_IS_VALID (
      SLV : in std_logic_vector
   ) return boolean is
 
      variable IS_VALID : boolean := TRUE;
 
  begin
      for I in SLV'high downto SLV'low loop
          if (SLV(I) /= '0' AND SLV(I) /= '1') then
              IS_VALID := FALSE;
          end if;
      end loop;
      return IS_VALID;
  end ADDR_IS_VALID;

  FUNCTION hexstr_to_std_logic_vec( arg1 : STRING; size : INTEGER ) RETURN STD_LOGIC_VECTOR IS
     VARIABLE RESULT : STD_LOGIC_VECTOR(size-1 DOWNTO 0):= (OTHERS=> '0');
     VARIABLE BIN : STD_LOGIC_VECTOR(3 DOWNTO 0);
     VARIABLE INDEX : INTEGER := 0;
  BEGIN
     FOR i IN arg1'REVERSE_RANGE LOOP
       CASE arg1(i) IS
         WHEN '0' => BIN := (OTHERS=>'0');
         WHEN '1' => BIN := (0=>'1', OTHERS=>'0');
         WHEN '2' => BIN := (1=>'1', OTHERS=>'0');
         WHEN '3' => BIN := (0=>'1', 1=>'1', OTHERS=>'0');
         WHEN '4' => BIN := (2=>'1', OTHERS=>'0');
         WHEN '5' => BIN := (0=>'1', 2=>'1', OTHERS=>'0');
         WHEN '6' => BIN := (1=>'1', 2=>'1', OTHERS=>'0');
         WHEN '7' => BIN := (3=>'0', OTHERS=>'1');
         WHEN '8' => BIN := (3=>'1', OTHERS=>'0');
         WHEN '9' => BIN := (0=>'1', 3=>'1', OTHERS=>'0');
         WHEN 'A' => BIN := (0=>'0', 2=>'0', OTHERS=>'1');
         WHEN 'a' => BIN := (0=>'0', 2=>'0', OTHERS=>'1');
         WHEN 'B' => BIN := (2=>'0', OTHERS=>'1');
         WHEN 'b' => BIN := (2=>'0', OTHERS=>'1');
         WHEN 'C' => BIN := (0=>'0', 1=>'0', OTHERS=>'1');
         WHEN 'c' => BIN := (0=>'0', 1=>'0', OTHERS=>'1');
         WHEN 'D' => BIN := (1=>'0', OTHERS=>'1');
         WHEN 'd' => BIN := (1=>'0', OTHERS=>'1');
         WHEN 'E' => BIN := (0=>'0', OTHERS=>'1');
         WHEN 'e' => BIN := (0=>'0', OTHERS=>'1');
         WHEN 'F' => BIN := (OTHERS=>'1');
         WHEN 'f' => BIN := (OTHERS=>'1');
         WHEN OTHERS =>
           ASSERT FALSE
             REPORT "NOT A HEX CHARACTER" SEVERITY ERROR;
           FOR j IN 0 TO 3 LOOP
               BIN(j) := 'X';
           END LOOP;
       END CASE;
       FOR j IN 0 TO 3 LOOP
         IF (INDEX*4)+j < size THEN
           RESULT((INDEX*4)+j) := BIN(j);
         END IF;
       END LOOP;
       INDEX := INDEX + 1;
     END LOOP;
     RETURN RESULT;
  END hexstr_to_std_logic_vec;


  procedure ADDR_OVERLAP (
      ADDRESS_A, ADDRESS_B, DAW, DBW : in integer;
      OVERLAP : out boolean;
      OVRLAP_LSB, OVRLAP_MSB, DOA_OV_LSB,
      DOA_OV_MSB, DOB_OV_LSB, DOB_OV_MSB : out integer
  ) is   

  variable A_LSB, A_MSB, B_LSB, B_MSB : integer;

  begin  
      A_LSB := ADDRESS_A * DAW;
      A_MSB := A_LSB + DAW - 1;
      B_LSB := ADDRESS_B * DBW;
      B_MSB := B_LSB + DBW - 1;

      if (A_MSB < B_LSB OR B_MSB < A_LSB) then
          OVERLAP := FALSE;
      else
          OVERLAP := TRUE;
          if (A_LSB >= B_LSB) then
              OVRLAP_LSB := A_LSB;
              DOA_OV_LSB := 0;
              DOB_OV_LSB := A_LSB - B_LSB;
          else 
              OVRLAP_LSB := B_LSB;
              DOA_OV_LSB := B_LSB - A_LSB;
              DOB_OV_LSB := 0;
          end if;
          if (A_MSB >= B_MSB) then
              OVRLAP_MSB := B_MSB;
              DOA_OV_MSB := DAW - (A_MSB - B_MSB) - 1;
              DOB_OV_MSB := DBW - 1;
          else 
              OVRLAP_MSB := A_MSB;
              DOA_OV_MSB := DAW - 1;
              DOB_OV_MSB := DBW - (B_MSB - A_MSB) - 1;
          end if;
      end if;
  end ADDR_OVERLAP;

  procedure COLLISION (
      ADDRESS : in std_logic_vector;
      LSB, MSB : in integer;
      MODE, PORT1, PORT2, InstancePath : in string;
      MEM : inout std_logic_vector
  ) is
 
  begin
      if (MODE = "write") then
          assert false report
          "WRITE COLLISION detected at " & PORT1 & " in instance " & InstancePath &
          ". Contents of address "& SLV_TO_STR(ADDRESS) &
          " will be wholly or partially set to 'X'."
          severity ERROR;
          for I in MSB downto LSB loop
              MEM(I) := 'X';
          end loop;
      elsif (MODE = "read") then
          assert false report
          "Attempting to read some or all of contents of address "& SLV_TO_STR(ADDRESS) &
          " from " & PORT2 & " while writing from " & PORT1 &
          " in instance " & InstancePath
          severity WARNING;
      end if;
  end COLLISION;


  ---------------------------------------------------------------------------
  -- Internal signals and type declarations
  ---------------------------------------------------------------------------

  type pipeline_stages_a is array ( 0 to c_pipe_stages_a) of std_logic_vector(c_width_a-1 downto 0) ;
  type pipeline_stages_b is array ( 0 to c_pipe_stages_b) of std_logic_vector(c_width_b-1 downto 0) ;
  signal pipelinea : pipeline_stages_a ;
  signal pipelineb : pipeline_stages_b ;
  signal sub_rdy_a : std_logic_vector( 0 to c_pipe_stages_a ) ;
  signal sub_rdy_b : std_logic_vector( 0 to c_pipe_stages_b ) ;

  signal DOUTA_prim   : std_logic_vector(c_width_a-1 downto 0) := (others => 'X');
  signal DOUTB_prim   : std_logic_vector(c_width_b-1 downto 0) := (others => 'X'); 

  signal ADDRA_ipd : std_logic_vector(c_addra_width-1 downto 0)  := (others => 'X');
  signal ADDRB_ipd : std_logic_vector(c_addrb_width-1 downto 0)  := (others => 'X');
  signal DIA_ipd   : std_logic_vector(c_width_a-1 downto 0) := (others => 'X');
  signal DIB_ipd   : std_logic_vector(c_width_b-1 downto 0) := (others => 'X');

  signal ENA_ipd, ENB_ipd   : std_logic := 'X';
  signal WEA_ipd, WEB_ipd   : std_logic := 'X';
  signal SSRA_ipd, SSRB_ipd : std_logic := 'X';
  signal NDA_ipd, NDB_ipd : std_logic := 'X';
  signal NDA_int, NDB_int : std_logic := 'X';
  signal CLKA_ipd, CLKB_ipd : std_logic := 'X';

  signal nda_q, ndb_q : std_logic := '0';
  signal addra_int : std_logic_vector(c_addra_width-1 downto 0)  := (others => 'X');
  signal addrb_int : std_logic_vector(c_addrb_width-1 downto 0)  := (others => 'X');
  signal dia_int   : std_logic_vector(c_width_a-1 downto 0) := (others => 'X');
  signal dib_int   : std_logic_vector(c_width_b-1 downto 0) := (others => 'X');
  signal wea_int, web_int   : std_logic := 'X';
  signal addra_q : std_logic_vector(c_addra_width-1 downto 0)  := (others => '0');
  signal addrb_q : std_logic_vector(c_addrb_width-1 downto 0)  := (others => '0');
  signal dia_q   : std_logic_vector(c_width_a-1 downto 0) := (others => '0');
  signal dib_q   : std_logic_vector(c_width_b-1 downto 0) := (others => '0');
  signal wea_q, web_q   : std_logic := '0';
  signal new_data_a, new_data_b : std_logic := 'X' ;
  signal new_data_a_q, new_data_b_q : std_logic := '0';
  signal rfda_int, rfdb_int : std_logic := 'X' ;
  signal rdya_int, rdyb_int : std_logic := 'X' ;


-- Constants used in VITAL timing calculation --------------------------------------

  constant   InstancePath:   STRING  := "*";
  constant     Xon:  Boolean := True;
  constant     MsgOn:  Boolean := False;
  constant     tsetup_CLKA_CLKB_posedge_posedge  : VitalDelayType := 1 ns;
  constant     tsetup_CLKB_CLKA_posedge_posedge  : VitalDelayType := 1 ns;

  -- When constant warning_on is set to True, all the warning of undefined
  -- input will be given.  To turn off the warning messages, set warning_on
  -- to False.  Ex.  constant warning_on : boolean := False;
  constant   warning_on : boolean := True;
      
begin -- architecture

   ADDRA_ipd <= ADDRA ;
   ADDRB_ipd <= ADDRB ;

   -- CLKA
   ca_h: IF (c_yclka_is_rising = 1) GENERATE
     CLKA_ipd <= CLKA;
   END GENERATE;
  
   ca_l: IF (c_yclka_is_rising = 0) GENERATE
     CLKA_ipd <= not(CLKA);
   END GENERATE;

   -- CLKB
   cb_h: IF (c_yclkb_is_rising = 1) GENERATE
     CLKB_ipd <= CLKB;
   END GENERATE;
  
   cb_l: IF (c_yclkb_is_rising = 0) GENERATE
     CLKB_ipd <= not(CLKB);
   END GENERATE;

   -- NDA
   nda_1 : IF (c_has_nda = 1) GENERATE
     NDA_ipd <= NDA;
   END GENERATE;    
   nda_0 : IF (c_has_nda = 0) GENERATE
     NDA_ipd <= '1';
   END GENERATE;    

   -- NDB
   ndb_1 : IF (c_has_ndb = 1) GENERATE
     NDB_ipd <= NDB;
   END GENERATE;    
   ndb_0 : IF (c_has_ndb = 0) GENERATE
     NDB_ipd <=  '1';
   END GENERATE; 
   
   -- DINA
   dina_1 : IF (c_has_dina = 1) GENERATE
     DIA_ipd <= DINA;
   END GENERATE;
   dina_0 : IF (c_has_dina = 0) GENERATE
     DIA_ipd <= (others => '0');
   END GENERATE;

   -- DINB
   dinb_1 : IF (c_has_dinb = 1) GENERATE
     DIB_ipd <= DINB;
   END GENERATE;    
   dinb_0 : IF (c_has_dinb = 0) GENERATE
     DIB_ipd <= (others => '0');
   END GENERATE;

   -- ENA
   ena_1 : IF (c_has_ena = 1) GENERATE
     h : IF (c_yena_is_high = 1) GENERATE
       ENA_ipd <= ENA;
     END GENERATE h;
    
     l : IF (c_yena_is_high = 0) GENERATE
       ENA_ipd <= not(ENA);
     END GENERATE l;
   END GENERATE;

   ena_0 : IF (c_has_ena = 0) GENERATE
     ENA_ipd <=  '1';
   END GENERATE;

   -- ENB
   enb_1 : IF (c_has_enb = 1) GENERATE
     h : IF (c_yenb_is_high = 1) GENERATE
       ENB_ipd <= ENB;
     END GENERATE h;
    
     l : IF (c_yenb_is_high = 0) GENERATE
       ENB_ipd <= not(ENB);
     END GENERATE l;
   END GENERATE;

   enb_0 : IF (c_has_enb = 0) GENERATE
     ENB_ipd <=  '1';
   END GENERATE;

   -- WEA
   wea_1 : IF (c_has_wea = 1) GENERATE
     h : IF (c_ywea_is_high = 1) GENERATE
       WEA_ipd <= WEA;
     END GENERATE h;
    
     l : IF (c_ywea_is_high = 0) GENERATE
       WEA_ipd <= not(WEA);
     END GENERATE l;
   END GENERATE;   
   wea_0 : IF (c_has_wea = 0) GENERATE
     WEA_ipd <=  '0';
   END GENERATE;    

   -- WEB
   web_1 : IF (c_has_web = 1) GENERATE
     h : IF (c_yweb_is_high = 1) GENERATE
       WEB_ipd <= WEB;
     END GENERATE h;
    
     l : IF (c_yweb_is_high = 0) GENERATE
       WEB_ipd <= not(WEB);
     END GENERATE l;
   END GENERATE;   
   web_0 : IF (c_has_web = 0) GENERATE
     WEB_ipd <=  '0';
   END GENERATE;

   -- SINITA
   sinita_1 : IF (c_has_sinita = 1) GENERATE
     h : IF (c_ysinita_is_high = 1) GENERATE
       SSRA_ipd <= SINITA;
     END GENERATE h;
    
     l : IF (c_ysinita_is_high = 0) GENERATE
       SSRA_ipd <= not(SINITA);
     END GENERATE l;
   END GENERATE;  
   sinita_0 : IF (c_has_sinita = 0) GENERATE
     SSRA_ipd <=  '0';
   END GENERATE;   

   -- SINITB
   sinitb_1 : IF (c_has_sinitb = 1) GENERATE
     h : IF (c_ysinitb_is_high = 1) GENERATE
       SSRB_ipd <= SINITB;
     END GENERATE h;
    
     l : IF (c_ysinitb_is_high = 0) GENERATE
       SSRB_ipd <= not(SINITB);
     END GENERATE l;
   END GENERATE;  
   sinitb_0 : IF (c_has_sinitb = 0) GENERATE
     SSRB_ipd <=  '0';
   END GENERATE;

------- Generate ouput control signals RFDA, RFDB, RDYA, RDYB ----------------------


  rfda_int <= ENA_ipd  ;
 
  rfda_1 : if (c_has_rfda = 1) generate
     RFDA <= rfda_int ;
  end generate ; 

  rfda_0 : if (c_has_rfda = 0) generate
     RFDA <= '0' ;
  end generate ; 
 
  rdya_process: process ( rdya_int)
  begin  
     if ( (c_has_rdya = 1) and (c_has_nda =1) and (c_has_rfda = 1) ) then
          RDYA <= rdya_int ;
     else
          RDYA <= '0' ;
     end if ;
  end process rdya_process ;


  rfdb_int <= ENB_ipd  ;
 
  rfdb_1 : if (c_has_rfdb = 1) generate
     RFDB <= rfdb_int ;
  end generate ;
 
  rfdb_0 : if (c_has_rfdb = 0) generate
     RFDB <= '0' ;
  end generate ;
 
  rdyb_process: process ( rdyb_int)
  begin
     if ( (c_has_rdyb = 1) and (c_has_ndb =1) and (c_has_rfdb = 1) ) then
          RDYB <= rdyb_int ;
     else
          RDYB <= '0' ;
     end if ;
  end process rdyb_process ;
 


-- Gate ND signals with EN

   NDA_int <= ENA_ipd and NDA_ipd ;
   NDB_int <= ENB_ipd and NDB_ipd ;

-- Register NDA handshaking input for port A

   register_NDA : process (CLKA_ipd )
   begin
     if ( CLKA_ipd'event and CLKA_ipd = '1') then
       if (ENA_ipd = '1') then
         if (SSRA_ipd = '1') then
           nda_q <= '0' ;
         else
           nda_q <= NDA_int;
         end if;
       end if ;
     end if ;
   end process register_NDA ;

-- Register NDB handshaking input for port B
 
   register_NDB : process (CLKB_ipd )
   begin
     if ( CLKB_ipd'event and CLKB_ipd = '1') then
       if (ENB_ipd = '1') then
         if (SSRB_ipd = '1') then
           ndb_q <= '0' ;
         else
           ndb_q <= NDB_int ;
         end if;
       end if ;
     end if ;
   end process register_NDB ;

-- Register data/address/we inputs for port A

   register_inputsa : process (CLKA_ipd )
   begin
     if ( CLKA_ipd'event and CLKA_ipd = '1') then
       if (ENA_ipd = '1') then
                  dia_q <= DIA_ipd ;
                  addra_q  <= ADDRA_ipd ;
                  wea_q <= WEA_ipd ;
       end if;
     end if ;
   end process register_inputsa ;

-- Register data/address/we inputs for port B

   register_inputsb : process (CLKB_ipd )
   begin
     if ( CLKB_ipd'event and CLKB_ipd = '1') then
       if (ENB_ipd = '1') then
                  dib_q <= DIB_ipd ;
                  addrb_q  <= ADDRB_ipd ;
                  web_q <= WEB_ipd ;
       end if;    
     end if ;
   end process register_inputsb ;

-- Select registered or non-registered inputs for port A


   select_inputsa : process (WEA_ipd, wea_q, DIA_ipd, dia_q, ADDRA_ipd, addra_q, NDA_int, nda_q )
   begin
     if ( c_reg_inputsa = 1) then
              wea_int <= wea_q ;
              dia_int <= dia_q ;
              addra_int <= addra_q ;
              new_data_a <= nda_q ;
     else 
              wea_int <= WEA_ipd ;
              dia_int <= DIA_ipd ;
              addra_int <= ADDRA_ipd ;
              new_data_a <= NDA_int ;
     end if ;
   end process select_inputsa ;

-- Select registered or no-registered inputs for port B

   select_inputsb : process (WEB_ipd, web_q, DIB_ipd, dib_q, ADDRB_ipd, addrb_q, NDB_int, ndb_q )
   begin
     if ( c_reg_inputsb = 1) then
              web_int <= web_q ;
              dib_int <= dib_q ;
              addrb_int <= addrb_q ;
              new_data_b <= ndb_q ;
     else
              web_int <= WEB_ipd ;
              dib_int <= DIB_ipd ;
              addrb_int <= ADDRB_ipd ;
              new_data_b <= NDB_int ;
     end if ;
   end process select_inputsb ;

-- Register new_data signals for Port A and B to track the synchronous RAM output

   register_newdataa : process (CLKA_ipd )
     VARIABLE first_newdataa : boolean := TRUE;
   begin
    if (first_newdataa = TRUE ) then
       new_data_a_q <= '0' ;
       first_newdataa := FALSE ;
    else
     if ( CLKA_ipd'event and CLKA_ipd = '1') then
       if (ENA_ipd = '1') then
           if (SSRA_ipd = '1') then
                new_data_a_q <= '0' ;
           else
                new_data_a_q <= new_data_a ;
           end if ;
       end if;
     end if ;
    end if;
   end process register_newdataa ;

   register_newdatab : process (CLKB_ipd )
     variable first_newdatab: boolean := TRUE ;
   begin
    if (first_newdatab = TRUE ) then
       new_data_b_q <= '0' ;
       first_newdatab := FALSE ;
    else
     if ( CLKB_ipd'event and CLKB_ipd = '1') then
       if (ENB_ipd = '1') then
           if (SSRB_ipd = '1') then
                new_data_b_q <= '0' ;
           else
                new_data_b_q <= new_data_b ;
           end if ;
       end if;
     end if ;
    end if;
   end process register_newdatab ;



  dp_primitive  : PROCESS


    -- Local constant  and variables used for functionality
    variable Violation : std_ulogic := '0';

    variable Tviol_CLKA_CLKB_posedge   : std_ulogic := '0';
    variable Tviol_CLKB_CLKA_posedge   : std_ulogic := '0';

    variable Tmkr_CLKA_CLKB_posedge     : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_CLKB_CLKA_posedge     : VitalTimingDataType := VitalTimingDataInit;

    constant mem_bits  : integer := c_depth_a * c_width_a;

    variable MEM       : std_logic_vector(mem_bits-1 downto 0) := (OTHERS => '0'); 
    variable ADDRESS_A, ADDRESS_B, OLP_LSB, OLP_MSB, OLPP_LSB, OLPP_MSB : integer;
    variable DOA_OV_LSB, DOA_OV_MSB, DOB_OV_LSB, DOB_OV_MSB : integer;
    variable DOPA_OV_LSB, DOPA_OV_MSB, DOPB_OV_LSB, DOPB_OV_MSB : integer;
    variable VALID_ADDRA, VALID_ADDRB, HAS_OVERLAP, HAS_OVERLAP_P : boolean := FALSE;
    variable WR_A_LATER, WR_B_LATER : boolean := FALSE;
    constant DIAW   : integer := c_width_a;
    constant DIAW_1 : integer := c_width_a - 1;
    constant DIBW   : integer := c_width_b;
    constant DIBW_1 : integer := c_width_b - 1;
    variable DOA_zd : std_logic_vector(c_width_a-1 downto 0) ; 
    variable DOB_zd : std_logic_vector(c_width_b-1 downto 0) ; 
    variable START_UP : boolean := TRUE;
    variable offset   : integer := 0 ;
    variable def_data : std_logic_vector(c_width_a-1 downto 0 );
    variable lineno    : integer := 0 ;
    variable sinita_value : std_logic_vector (c_width_a-1 downto 0) ;
    variable sinitb_value : std_logic_vector (c_width_b-1 downto 0) ;

    variable ADDRESS_Astr : STRING(1 TO c_addra_width);
    variable ADDRESS_Bstr : STRING(1 TO c_addrb_width);

  begin -- process

   if (START_UP = TRUE ) then

     sinita_value := (others => '0');
     sinitb_value := (others => '0');
     def_data := hexstr_to_std_logic_vec(c_default_data, c_width_a);

     if (c_has_sinita = 1) then
         sinita_value := hexstr_to_std_logic_vec(c_sinita_value, c_width_a);
     end if;
     if (c_has_sinitb = 1) then
         sinitb_value := hexstr_to_std_logic_vec(c_sinitb_value, c_width_b);
     end if;
     if( c_has_default_data = 0 ) THEN
       read_meminit_file(c_mem_init_file, c_depth_a, c_width_a, MEM, lineno);
     end if;
     offset := lineno*c_width_a;
     while (lineno < c_depth_a) loop
       for i in 0 to c_width_a-1 loop
         MEM(offset+i) := def_data(i);
       end loop;
       lineno := lineno+1;
       offset := offset+c_width_a;
     end loop;
     DOA_zd := sinita_value;
     DOB_zd := sinitb_value ;
     START_UP := FALSE;

   else  ---     behavior after start up 


    VALID_ADDRA := ADDR_IS_VALID(addra_int);
    VALID_ADDRB := ADDR_IS_VALID(addrb_int);

    if (VALID_ADDRA) then
        ADDRESS_A := SLV_TO_INT(addra_int);
        ADDRESS_Astr := SLV_TO_STR(addra_int);
    end if;

    if (VALID_ADDRB) then
        ADDRESS_B := SLV_TO_INT(addrb_int);
        ADDRESS_Bstr := SLV_TO_STR(addrb_int);
    end if;

    if (VALID_ADDRA AND VALID_ADDRB) then
        ADDR_OVERLAP (ADDRESS_A, ADDRESS_B, DIAW, DIBW, HAS_OVERLAP, 
        OLP_LSB, OLP_MSB, DOA_OV_LSB, DOA_OV_MSB, DOB_OV_LSB, DOB_OV_MSB);
    end if;

    if (HAS_OVERLAP = TRUE ) then
         VitalSetupHoldCheck (
          Violation               => Tviol_CLKB_CLKA_posedge,
          TimingData              => Tmkr_CLKB_CLKA_posedge,
          TestSignal              => CLKB_ipd,
          TestSignalName          => "CLKB",
          TestDelay               => 0 ns,
          RefSignal               => CLKA_ipd,
          RefSignalName           => "CLKA",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_CLKB_CLKA_posedge_posedge,
          CheckEnabled            => ((TO_X01(ENA_ipd) = '1' AND TO_X01(ENB_ipd) = '1') AND
                                      (TO_X01(wea_int) = '1' OR  TO_X01(web_int) = '1')),
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/blkmem_v4_0",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);

         VitalSetupHoldCheck ( 
          Violation               => Tviol_CLKA_CLKB_posedge, 
          TimingData              => Tmkr_CLKA_CLKB_posedge, 
          TestSignal              => CLKA_ipd, 
          TestSignalName          => "CLKA", 
          TestDelay               => 0 ns, 
          RefSignal               => CLKB_ipd, 
          RefSignalName           => "CLKB", 
          RefDelay                => 0 ns, 
          SetupHigh               => tsetup_CLKA_CLKB_posedge_posedge, 
          CheckEnabled            => ((TO_X01(ENA_ipd) = '1' AND TO_X01(ENB_ipd) = '1') AND
                                      (TO_X01(wea_int) = '1' OR  TO_X01(web_int) = '1')),
          RefTransition           => 'R',
          HeaderMsg               => InstancePath & "/blkmem_v4_0",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => WARNING);
     end if;

    --
    -- Port A
    --
    WR_A_LATER := FALSE;
    WR_B_LATER := FALSE;

    if (ENA_ipd = '1') then
        if (CLKA_ipd'event AND CLKA_ipd'last_value = '0') then
            if (CLKA_ipd = '1') then
               if (ADDRESS_A < c_depth_a ) then
                if (wea_int = '1') then
                    if (VALID_ADDRA) then
                        if(c_write_modea = c_write_first) then  ---   "WRITE_FIRST") then
                              DOA_zd := dia_int;
                        elsif(c_write_modea = c_read_first) then ---   "READ_FIRST") then
                              DOA_zd := MEM((ADDRESS_A*DIAW + DIAW_1) downto (ADDRESS_A*DIAW));
                        elsif(c_write_modea /= c_no_change) then ---   "NO_CHANGE") then
                              assert false report
                              " Wrong value for WRITE_MODE, assuming WRITE_FIRST "
                              severity warning;
                              DOA_zd := dia_int;
                        end if;
			if (c_write_modea /= c_read_first) then  ---  "READ_FIRST" ) then
                        MEM((ADDRESS_A*DIAW + DIAW_1) downto (ADDRESS_A*DIAW)) := dia_int;
                        else WR_A_LATER := TRUE;
			end if;

                        if (ENB_ipd = '1' AND VALID_ADDRB AND HAS_OVERLAP) then
                            if (Tviol_CLKB_CLKA_posedge = 'X') then
                                if (web_int /= '0') then
				 if (c_write_modea /= c_read_first AND c_write_modeb /= c_read_first) then
                                    COLLISION (addra_int,  OLP_LSB, OLP_MSB, "write", 
                                    "port A", "port B", InstancePath, MEM);
				  end if;
				  if (c_write_modea /= c_no_change AND c_write_modeb /= c_read_first ) then
                                    DOA_zd (DOA_OV_MSB downto DOA_OV_LSB) := (others =>'X');
				  end if;
				  if (c_write_modea /= c_read_first AND c_write_modeb /= c_no_change ) then
                                    DOB_zd (DOB_OV_MSB downto DOB_OV_LSB) := (others =>'X');
				  end if;
                                else
				  if (c_write_modea /= c_read_first ) then
                                    COLLISION (addra_int, OLP_LSB, OLP_MSB, "read",
                                    "port A", "port B", InstancePath, MEM);
                                    DOB_zd (DOB_OV_MSB downto DOB_OV_LSB) := (others =>'X');
				   end if;
                                end if;
                            end if;
                        end if;
                    else
                        SET_MEM_TO_X("ADDRA",addra_int, MEM);
			if (c_write_modea /= c_no_change) then
                          warn_out_undef("DOUTA", warning_on); --
                          DOA_zd := (others => 'X');
			end if;
                    end if;
                elsif (wea_int = 'X') then
                    warn_signout_undef("WEA","DOUTA", warning_on);
                    if (VALID_ADDRA) then
                        warn_memcontent_undef("A",ADDRESS_Astr,warning_on);
                        MEM((ADDRESS_A*DIAW + DIAW_1) downto (ADDRESS_A*DIAW)) := (others => 'X');
                    else
                        SET_MEM_TO_X("ADDRA",addra_int, MEM);
                    end if;
                    DOA_zd := (others => 'X');
                else
                    if (VALID_ADDRA) then
                        DOA_zd := MEM((ADDRESS_A*DIAW + DIAW_1) downto (ADDRESS_A*DIAW));
                    else
                        warn_signout_undef("ADDRA","DOUTA",warning_on);
                        DOA_zd := (others => 'X');
                    end if;
                end if;
                if (SSRA_ipd = '1') then
                    DOA_zd := sinita_value ;
                elsif (SSRA_ipd = 'X') then
                    warn_signout_undef("SINITA", "DOUTA", warning_on);
                    DOA_zd := (others => 'X');
                end if;
             else
                  ASSERT FALSE
                            REPORT " Memory address of port A is out of range. "
                            SEVERITY WARNING;
             end if;

            elsif (CLKA_ipd = 'X') then
                if (c_yclka_is_rising = 1) then
                  warn_oddclk_trans("CLKA", "0", "X", warning_on);
                else
                  warn_oddclk_trans("CLKA", "1", "X", warning_on);                  
                end if;
		if (c_write_modea /= c_no_change ) then
                  DOA_zd := (others => 'X');
                  warn_out_undef("DOUTA", warning_on);
		end if;
                if (wea_int /= '0') then
                    if (VALID_ADDRA) then
                        MEM((ADDRESS_A*DIAW + DIAW_1) downto (ADDRESS_A*DIAW)) := (others => 'X');
                        warn_memcontent_undef("A",ADDRESS_Astr, warning_on);
                    else
                        SET_MEM_TO_X("ADDRA",addra_int, MEM);
                    end if;
                end if;
            end if; 
        elsif (CLKA_ipd'event AND CLKA_ipd'last_value = 'X') then
            if (CLKA_ipd = '1') then
              if (c_yclka_is_rising = 1) then
                warn_oddclk_trans("CLKA", "X", "1", warning_on);
              else
                warn_oddclk_trans("CLKA", "X", "0", warning_on);                
              end if;
              warn_out_undef("DOUTA", warning_on);
              if (wea_int /= '0') then
                    if (VALID_ADDRA) then
                        warn_memcontent_undef("A", ADDRESS_Astr, warning_on);
                        MEM((ADDRESS_A*DIAW + DIAW_1) downto (ADDRESS_A*DIAW)) := (others => 'X');
                    else
                        SET_MEM_TO_X("ADDRA",addra_int, MEM);
                    end if;
                end if;
                DOA_zd := (others => 'X');
            end if;
        end if; 
    elsif (ENA_ipd = 'X') then
        if (CLKA_ipd'event AND CLKA_ipd'last_value /= '1') then
            if (CLKA_ipd /= '0') then
                warn_signout_undef("ENA","DOUTA", warning_on);
                if (wea_int /= '0') then
                    if (VALID_ADDRA) then
                        warn_memcontent_undef("A", ADDRESS_Astr, warning_on);
                        MEM((ADDRESS_A*DIAW + DIAW_1) downto (ADDRESS_A*DIAW)) := (others => 'X');
                    else
                        SET_MEM_TO_X("ADDRA", addra_int, MEM);
                        MEM := (others => 'X');
                    end if;
                end if;
                DOA_zd := (others => 'X');
            end if;
        end if; 
    end if; 
    
    --
    -- Port B
    --
    if (ENB_ipd = '1') then
        if (CLKB_ipd'event AND CLKB_ipd'last_value = '0') then
            if (CLKB_ipd = '1') then
               if (ADDRESS_B < c_depth_b) then
                if (web_int = '1') then
                    if (VALID_ADDRB) then
                        if(c_write_modeb = c_write_first) then
                             DOB_zd := dib_int;
                        elsif(c_write_modeb = c_read_first) then
                             DOB_zd := MEM((ADDRESS_B*DIBW + DIBW_1) downto (ADDRESS_B*DIBW)) ;
                        elsif(c_write_modeb /= c_no_change) then
                            assert false report
                            " Wrong value for WRITE_MODE, assuming WRITE_FIRST "
                            severity warning;
                            DOB_zd := dib_int;
                        end if;
			if (c_write_modeb /= c_read_first) then
                        MEM((ADDRESS_B*DIBW + DIBW_1) downto (ADDRESS_B*DIBW)) := dib_int;
			else WR_B_LATER := TRUE;
                        end if;
                        if (ENA_ipd = '1' AND VALID_ADDRA AND HAS_OVERLAP) then
                            if (Tviol_CLKA_CLKB_posedge = 'X') then
                                if (wea_int /= '0') then
				  if (c_write_modea /= c_read_first AND c_write_modeb /= c_read_first ) then
                                    COLLISION (addrb_int, OLP_LSB, OLP_MSB, "write",
                                    "port B", "port A", InstancePath, MEM);
				  end if;
				  if ( SSRA_ipd = '0' AND c_write_modea /= c_no_change AND c_write_modeb /= c_read_first ) then
                                    DOA_zd (DOA_OV_MSB downto DOA_OV_LSB) := (others => 'X');
                                  end if;
				  if (c_write_modea /= c_read_first AND c_write_modeb /= c_no_change ) then
                                    DOB_zd (DOB_OV_MSB downto DOB_OV_LSB) := (others => 'X');
				   end if;
                                else
				   if (c_write_modeb /= c_read_first ) then
                                    COLLISION (addrb_int, OLP_LSB, OLP_MSB, "read",
                                    "port B", "port A", InstancePath, MEM);
				   end if;
				  if ( SSRA_ipd = '0' AND c_write_modeb /= c_read_first  ) then
                                    DOA_zd (DOA_OV_MSB downto DOA_OV_LSB) := (others => 'X');
                                  end if;

                                end if;
                            end if;
                        end if;
                    else
                        SET_MEM_TO_X("ADDRB",addrb_int, MEM);
			if (c_write_modeb /= c_no_change ) then
                          warn_out_undef("DOUTB", warning_on);
                          DOB_zd := (others => 'X');
			end if;
                    end if;
                elsif (web_int = 'X') then
                    warn_signout_undef("WEB", "DOUTB", warning_on);
                    if (VALID_ADDRB) then
                        warn_memcontent_undef("B", ADDRESS_Bstr, warning_on);
                        MEM((ADDRESS_B*DIBW + DIBW_1) downto (ADDRESS_B*DIBW)) := (others => 'X');
                    else
                        SET_MEM_TO_X("ADDRB",addrb_int, MEM);
                    end if;
                    DOB_zd := (others => 'X');
                else 
                    if (VALID_ADDRB ) then
                        DOB_zd := MEM((ADDRESS_B*DIBW + DIBW_1) downto (ADDRESS_B*DIBW));
		     if (Tviol_CLKB_CLKA_posedge = 'X' AND HAS_OVERLAP = TRUE AND c_write_modea /= c_read_first) then
		      DOB_zd (DOB_OV_MSB downto DOB_OV_LSB) := (others => 'X');
                     end if;
                    else
                        warn_signout_undef("ADDRB","DOUTB", warning_on);
                        DOB_zd := (others => 'X');
                    end if;
                end if;
                if (SSRB_ipd = '1') then
                    DOB_zd := sinitb_value ;
                elsif (SSRB_ipd = 'X') then
                    warn_signout_undef("SINITB", "DOUTB", warning_on);
                    DOB_zd := (others => 'X');
                end if;
             else
                  ASSERT FALSE
                            REPORT " Memory address of port B is out of range. "
                            SEVERITY WARNING;
             end if;

            elsif (CLKB_ipd = 'X') then
               if (c_yclkb_is_rising = 1) then
                  warn_oddclk_trans("CLKB", "0", "X", warning_on);
                else
                  warn_oddclk_trans("CLKB", "1", "X", warning_on);                  
                end if;
                if (c_write_modeb /= c_no_change ) then
                  DOB_zd := (others => 'X');
                  warn_out_undef("DOUTB", warning_on);
                end if;
                if (web_int /= '0') then
                    if (VALID_ADDRB) then
                        warn_memcontent_undef("B", ADDRESS_Bstr, warning_on);    
                        MEM((ADDRESS_B*DIBW + DIBW_1) downto (ADDRESS_B*DIBW)) := (others => 'X');
                    else
                        SET_MEM_TO_X("ADDRB",addrb_int, MEM);
                    end if;
                end if;  
            end if; 
        elsif (CLKB_ipd'event AND CLKB_ipd'last_value = 'X') then
            if (CLKB_ipd = '1') then
              if (c_yclkb_is_rising = 1) then
                warn_oddclk_trans("CLKB", "0", "X", warning_on);
              else
                warn_oddclk_trans("CLKB", "1", "X", warning_on);                
              end if;
              warn_out_undef("DOUTB", warning_on);
              if (web_int /= '0') then
                    if (VALID_ADDRB) then
                        warn_memcontent_undef("B", ADDRESS_Bstr, warning_on);
                        MEM((ADDRESS_B*DIBW + DIBW_1) downto (ADDRESS_B*DIBW)) := (others => 'X');
                    else
                        SET_MEM_TO_X("ADDRB",addrb_int, MEM);
                    end if;
              end if;
              DOB_zd := (others => 'X');
            end if;
        end if; 
    elsif (ENB_ipd = 'X') then
        if (CLKB_ipd'event AND CLKB_ipd'last_value /= '1') then
            if (CLKB_ipd /= '0') then
              warn_signout_undef("ENB","DOUTB", warning_on);
              if (web_int /= '0') then
                    if (VALID_ADDRB) then
                        MEM((ADDRESS_B*DIBW + DIBW_1) downto (ADDRESS_B*DIBW)) := (others => 'X');
                        warn_memcontent_undef("B", ADDRESS_Bstr, warning_on);
                    else
                        SET_MEM_TO_X("ADDRB",addrb_int, MEM);
                        MEM := (others => 'X');
                    end if;
              end if;
              DOB_zd := (others => 'X');
            end if;
        end if; 
    end if;

    if (WR_A_LATER = TRUE ) then

        MEM((ADDRESS_A*DIAW + DIAW_1) downto (ADDRESS_A*DIAW)) := dia_int ;
    end if;

    if (WR_B_LATER = TRUE ) then

        MEM((ADDRESS_B*DIBW + DIBW_1) downto (ADDRESS_B*DIBW)) := dib_int;
    end if;

    if (WR_A_LATER AND WR_B_LATER AND HAS_OVERLAP AND Tviol_CLKB_CLKA_posedge =
 'X') then
        COLLISION (addrb_int, OLP_LSB, OLP_MSB, "write", "port B", "port A", InstancePath, MEM);
    end if;

    DOUTA_prim <= DOA_zd ;
    DOUTB_prim <= DOB_zd ;

   end if; --- start up



    wait on CLKA_ipd, CLKB_ipd, wea_int, web_int, ENA_ipd, ENB_ipd, 
          SSRA_ipd, SSRB_ipd, dia_int, dib_int, addra_int, addrb_int ;  

  end PROCESS dp_primitive;

--------- Output pipeline for Port A --------------------------------------------------------------------
 
  pipelinea_output:  process (CLKA_ipd , WEA_ipd, ENA_ipd, SSRA_ipd, DIA_ipd, ADDRA_ipd)
       variable sinita_value_int:  std_logic_vector(c_width_a-1 downto 0) ;
       variable first_time_a: boolean := TRUE ;
  begin
 
 
   if (first_time_a = TRUE ) then
     sinita_value_int := (others => '0');
     if (c_has_sinita = 1) then
         sinita_value_int := hexstr_to_std_logic_vec(c_sinita_value, c_width_a);
     end if;
     for i in 0 to c_pipe_stages_a loop
       pipelinea(i) <= sinita_value_int;
     end loop;
     for i in 0 to c_pipe_stages_a loop
       sub_rdy_a(i) <= '0' ;
     end loop;
     first_time_a := FALSE;
 
   else
 
     if ( CLKA_ipd'event and CLKA_ipd = '1') then
       if (ENA_ipd = '1') then
            if (SSRA_ipd = '1') then
            -- for i in 0 to c_pipe_stages_a loop
               pipelinea(0) <= sinita_value_int ; 
               sub_rdy_a(0) <= '0' ;
            -- end loop;
            else
            -- for i in 0 to c_pipe_stages_a loop
               pipelinea(0) <= DOUTA_prim ;
               sub_rdy_a(0)  <= new_data_a_q ;
            -- end loop;
            end if ;
        end if ;
      end if ;
    end if;
   end process pipelinea_output ;

--------- Output pipeline for Port B --------------------------------------------------------------------
 
  pipelineb_output:  process (CLKB_ipd , WEB_ipd, ENB_ipd, SSRB_ipd, DIB_ipd, ADDRB_ipd)
       variable sinitb_value_int:  std_logic_vector(c_width_b-1 downto 0) ;
       variable first_time_b: boolean := TRUE ;
  begin
 
 
   if (first_time_b = TRUE ) then
     sinitb_value_int := (others => '0');
     if (c_has_sinitb = 1) then
         sinitb_value_int := hexstr_to_std_logic_vec(c_sinitb_value, c_width_b);
     end if;
     for i in 0 to c_pipe_stages_b loop
       pipelineb(i) <= sinitb_value_int;
     end loop;
     for i in 0 to c_pipe_stages_b loop
       sub_rdy_b(i) <= '0';
     end loop;
     first_time_b := FALSE;
 
   else
 
     if ( CLKB_ipd'event and CLKB_ipd = '1') then
       if (ENB_ipd = '1') then
            if (SSRB_ipd = '1') then
               pipelineb(0) <= sinitb_value_int ;  
               sub_rdy_b(0) <= '0' ;
            else
               pipelineb(0) <= DOUTB_prim ;
               sub_rdy_b(0) <= new_data_b_q ;
            end if ;
        end if ;
      end if ;
    end if;
   end process pipelineb_output ;

-------- Select pipelined output or non-pipelined outputs for port A -----------------------------------


  select_outputa:  process (new_data_a_q, DOUTA_prim, pipelinea, sub_rdy_a)
  begin
       if (c_pipe_stages_a = 0) then
          DOUTA <= DOUTA_prim ;
          rdya_int <= new_data_a_q ;
       else
          DOUTA <= pipelinea(c_pipe_stages_a - 1) ;
          rdya_int <= sub_rdy_a(c_pipe_stages_a - 1) ;
      end if ;
   end process select_outputa ;

-------- Select pipelined output or non-pipelined outputs for port B -----------------------------------


  select_outputb:  process (new_data_b_q, DOUTB_prim, pipelineb, sub_rdy_b)
  begin
       if (c_pipe_stages_b = 0) then
          DOUTB <= DOUTB_prim ;
          rdyb_int <= new_data_b_q ;
       else
          DOUTB <= pipelineb(c_pipe_stages_b - 1) ;
          rdyb_int <= sub_rdy_b(c_pipe_stages_b - 1) ;
      end if ;
   end process select_outputb ;



 

end behavioral;

