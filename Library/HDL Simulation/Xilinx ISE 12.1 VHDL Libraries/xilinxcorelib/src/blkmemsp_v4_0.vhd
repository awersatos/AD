--------------------------------------------------------------------------------
-- $Id: blkmemsp_v4_0.vhd,v 1.17 2008/09/08 20:06:34 akennedy Exp $
--------------------------------------------------------------------------------
-- Block Memory Compiler : VHDL Behavioral Model
--------------------------------------------------------------------------------
--                                                                       
-- This File is owned and controlled by Xilinx and must be used solely   
-- for design, simulation, implementation and creation of design files   
-- limited to Xilinx devices or technologies. Use with non-Xilinx        
-- devices or technologies is expressly prohibited and immediately       
-- terminates your license.                                              
--                                                                       
-- Xilinx products are not intended for use in life support              
-- appliances, devices, or systems. Use in such applications is          
-- expressly prohibited.                                                 
--                                                                       
--
--        ****************************
--        ** Copyright Xilinx, Inc. **
--        ** All rights reserved.   **
--        ****************************
--
--------------------------------------------------------------------------------
--  Filename:  blkmemsp_v4_0.vhd
--
--  Description: Single Port BRAM behavioral model. 
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.mem_init_file_pack_v4_0.all ;
use XilinxCoreLib.ul_utils.all ;
use XilinxCoreLib.blkmemsp_pkg_v4_0.all ;

entity blkmemsp_v4_0 is

  generic (

       c_addr_width           : integer := 11 ;
       c_default_data         : string  := "eca97af001f81a864c057d76" ;
       c_depth                : integer := 1034 ;
       c_enable_rlocs         : integer := 0 ;
       c_has_default_data     : integer := 1 ;     
       c_has_din              : integer := 1 ;
       c_has_en               : integer := 1 ;
       c_family               : string  := "virtex2" ;
       c_has_limit_data_pitch : integer := 0 ;
       c_has_nd               : integer := 1 ;
       c_has_rdy              : integer := 1 ;
       c_has_rfd              : integer := 1 ;
       c_has_sinit            : integer := 1 ;
       c_has_we               : integer := 1 ;
       c_limit_data_pitch     : integer := 18 ;
       ------------------------------------------------------------------------
       -- new generics
       --c_xmem_init_array    : MEM_ARRAY := ("123456", "123456", "123456", "123456", "123456", "123456");
       c_mem_init_file        : string := "mif_file_16_1" ;
       ------------------------------------------------------------------------
       c_pipe_stages          : integer := 1 ;
       c_reg_inputs           : integer := 0 ;
       c_sinit_value          : string := "dcd461da8bac14a2d0902993" ;
       c_width                : integer  := 96 ;
       c_write_mode           : integer := 2;
       c_ybottom_addr         : STRING := "1024" ;
       c_yclk_is_rising       : INTEGER := 1;
       c_yhierarchy           : STRING  := "hierarchy" ;
       c_ymake_bmm            : INTEGER := 1;
       c_yen_is_high          : INTEGER := 1;
       c_yprimitive_type      : STRING  := "4kx4";
       c_ysinit_is_high       : INTEGER := 1;
       c_ytop_addr            : STRING := "0" ;
       c_yuse_single_primitive: INTEGER := 0;
       c_ywe_is_high          : INTEGER := 1 
  );

  port (DIN    : in STD_LOGIC_VECTOR (c_width-1 downto 0) := (OTHERS => '0');
        EN     : in STD_LOGIC := '1';
        WE     : in STD_LOGIC := '0';
        SINIT  : in STD_LOGIC := '0';
        ND     : in STD_LOGIC := '0';
        CLK    : in STD_LOGIC;
        RFD    : out STD_LOGIC ;
        RDY    : out STD_LOGIC ;
        ADDR   : in STD_LOGIC_VECTOR (c_addr_width-1 downto 0);
        DOUT   : out STD_LOGIC_VECTOR (c_width-1 downto 0)
       ); 

end blkmemsp_v4_0;

-----------------------------------------------------------------------------

architecture behavioral of blkmemsp_v4_0 is

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

  procedure warn_memcontent_undef ( addr: IN STRING; warning_on: IN BOOLEAN ) is
  begin
    IF (warning_on = TRUE) THEN
      assert false report
      "Setting contents of memory at ADDR "& addr &
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

  function SLV_TO_STR ( SLV : in std_logic_vector
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

  procedure SET_MEM_TO_X ( ADDRESS : in std_logic_vector;
                           MEM     : inout std_logic_vector
                         ) is
  begin
    assert false report
      "Invalid ADDRESS: "& SLV_TO_STR(ADDRESS) & ". Memory contents will be set to 'X'."
    severity warning;
    for I in MEM'high downto MEM'low loop
      MEM(I) := 'X';
     end loop;
   end SET_MEM_TO_X;

   function SLV_TO_INT( SLV: in std_logic_vector
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

   function ADDR_IS_VALID ( SLV : in std_logic_vector
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

   FUNCTION hexstr_to_std_logic_vec( arg1 : STRING ; 
                                     size : INTEGER 
                                   ) RETURN STD_LOGIC_VECTOR IS
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

-------------------------------------------------------------------------------
-- Signal Declaration
-------------------------------------------------------------------------------

-------------- Local signals used to propagate input wire delay ---------------

type pipeline_stages is array ( 0 to c_pipe_stages) of std_logic_vector(c_width-1 downto 0) ;

signal ADDR_ipd : std_logic_vector(c_addr_width-1 downto 0)  := (others => 'X');
signal DI_ipd   : std_logic_vector(c_width-1 downto 0) := (others => 'X');
signal DOUT_prim   : std_logic_vector(c_width-1 downto 0) := (others => 'X');

signal EN_ipd   : std_logic := 'X';
signal WE_ipd   : std_logic := 'X';
signal SSR_ipd  : std_logic := 'X';
signal CLK_ipd  : std_logic := 'X';

signal rfd_int  : std_logic := '0';
signal rdy_int  : std_logic := '0';

signal ND_ipd : std_logic := 'X';
signal ND_int : std_logic := 'X';
signal nd_q       : std_logic := '0';
signal addr_int   : std_logic_vector(c_addr_width-1 downto 0)  := (others => 'X');
signal di_int     : std_logic_vector(c_width-1 downto 0) := (others => 'X');
signal we_int     : std_logic := 'X';
signal addr_q     : std_logic_vector(c_addr_width-1 downto 0)  :=(others => '0');   
signal di_q       : std_logic_vector(c_width-1 downto 0) := (others => '0');
signal we_q       : std_logic := '0';
signal new_data   : std_logic := 'X';
signal new_data_q : std_logic := '0';
signal sub_rdy    : std_logic_vector(0 to c_pipe_stages) := (others => '0');
signal pipeline   : pipeline_stages ;

-- When constant warning_on is set to True, all the warnings of undefined
-- input will be given.  To turn off the warning messages, set warning_on
-- to False.  Ex.  constant warning_on : boolean := False;
constant   warning_on : boolean := True;
      
      
begin -- architecture

  ADDR_ipd <= ADDR ;

  c_h: IF (c_yclk_is_rising = 1) GENERATE
    CLK_ipd <= CLK;
  END GENERATE;
  
  c_l: IF (c_yclk_is_rising = 0) GENERATE
    CLK_ipd <= not(CLK);
  END GENERATE;  
  
  nd_1 : IF (c_has_nd = 1) GENERATE
    ND_ipd <= ND;
  END GENERATE;
  nd_0 : IF (c_has_nd = 0) GENERATE
    ND_ipd <= '1';
  END GENERATE;

  di_1 : IF (c_has_din = 1) GENERATE
    DI_ipd <= DIN;
  END GENERATE;
  di_0 : IF (c_has_din = 0) GENERATE
    DI_ipd <= (others => '0');
  END GENERATE;

  en_1 : IF (c_has_en = 1) GENERATE
    
   h : IF (c_yen_is_high = 1) GENERATE
    EN_ipd <= EN;
   END GENERATE h;
    
   l : IF (c_yen_is_high = 0) GENERATE
    EN_ipd <= not(EN);
   END GENERATE l;
    
  END GENERATE;
  en_0 : IF (c_has_en = 0) GENERATE
    EN_ipd <=  '1';
  END GENERATE;

  we_1 : IF (c_has_we = 1) GENERATE
   h : IF (c_ywe_is_high = 1) GENERATE
    WE_ipd <= WE;
   END GENERATE h;
    
   l : IF (c_ywe_is_high = 0) GENERATE
    WE_ipd <= not(WE);
   END GENERATE l;

  END GENERATE;
  we_0 : IF (c_has_we = 0) GENERATE
    WE_ipd <=  '0';
  END GENERATE;

  sinit_1 : IF (c_has_sinit = 1) GENERATE

   h : IF (c_ysinit_is_high = 1) GENERATE
    SSR_ipd <= SINIT;
   END GENERATE h;
    
   l : IF (c_ysinit_is_high = 0) GENERATE
    SSR_ipd <= not(SINIT);
   END GENERATE l;

  END GENERATE;
  sinit_0 : IF (c_has_sinit = 0) GENERATE
    SSR_ipd <=  '0';
  END GENERATE;
------ Generate ouput control signals RFD and RDY -----------------------------

  rfd_int <= EN_ipd  ;

  rfd_1 : if (c_has_rfd = 1) generate
     RFD <= rfd_int ;
  end generate ;

  rfd_0 : if (c_has_rfd = 0) generate 
     RFD <= '0' ;
  end generate ;

  rdy_process: process ( rdy_int)
  begin
     if ( (c_has_rdy = 1) and (c_has_nd =1) and (c_has_rfd = 1) ) then
          RDY <= rdy_int ;
     else
          RDY <= '0' ;
     end if ;
  end process rdy_process ; 


------- Gate ND signal with EN------------------------------------------------

  ND_int <= EN_ipd and ND_ipd ;

------- Register ND handshaking input----------------------------------------- 
 
   register_ND : process (CLK_ipd )
   begin
     if ( CLK_ipd'event and CLK_ipd = '1') then
       if (EN_ipd = '1') then
         if (SSR_ipd = '1') then
           nd_q <= '0' ;
         else
           nd_q <= ND_int ;
         end if;
       end if ;
     end if ;
   end process register_ND ;

------ Register data/address/we inputs ---------------------------------------- 
 
   register_inputs : process (CLK_ipd )
   begin
     if ( CLK_ipd'event and CLK_ipd = '1') then
       if (EN_ipd = '1') then
         di_q   <= DI_ipd ;
         addr_q <= ADDR_ipd ;
         we_q   <= WE_ipd ;
       end if;
     end if ;
   end process register_inputs ;

------ Select registered or non-registered inputs ----------------------------- 
 
 
   select_inputs : process (WE_ipd, we_q, DI_ipd, di_q, ADDR_ipd, addr_q, ND_int, nd_q )
   begin
     if ( c_reg_inputs = 1) then
       we_int <= we_q ;
       di_int <= di_q ;
       addr_int <= addr_q ;
       new_data <= nd_q ;
     else
       we_int <= WE_ipd ;
       di_int <= DI_ipd ;
       addr_int <= ADDR_ipd ;
       new_data <= ND_int ;
     end if ;
   end process select_inputs ;

------- Register the new_data signal to track the synchronous RAM output -------

   register_newdata : process (CLK_ipd )
      variable first_newdata:  boolean := TRUE ;
   begin
    if (first_newdata = TRUE ) then
       new_data_q <= '0' ;
       first_newdata := FALSE;
    else
     if ( CLK_ipd'event and CLK_ipd = '1') then
       if (EN_ipd = '1') then
         if (SSR_ipd  = '1' ) then
           new_data_q <= '0' ;
         else
           new_data_q <= new_data ;
         end if;
       end if;
     end if ;
    end if;
   end process register_newdata ;

--------- Behavior process for V2 single port ram primitive --------------------
  
  sp_primitive : PROCESS


    -- Local variables used for functionality
    variable Violation : std_ulogic := '0';
    constant mem_bits : integer := c_depth * c_width ;

    variable MEM       : std_logic_vector(mem_bits-1 downto 0) := ( others => '0' ); 
    variable ADDRESS : integer;
    variable ADDRESSstr : STRING(1 TO c_addr_width);
    variable VALID_ADDR : boolean := FALSE;
    constant DIW   : integer := c_width;
    constant DIW_1 : integer := c_width - 1;
    variable DO_zd  : std_logic_vector(c_width-1 downto 0) ;

    variable START_UP : boolean := TRUE;
    variable offset   : integer := 0 ;
    variable def_data : std_logic_vector(c_width-1 downto 0 );
    variable lineno    : integer := 0 ;
    variable sinit_value : std_logic_vector (c_width-1 downto 0) ;


  begin -- process

   if (START_UP = TRUE ) then
     sinit_value := (others => '0');
         def_data := hexstr_to_std_logic_vec(c_default_data, c_width);
     if (c_has_sinit = 1) then
         sinit_value := hexstr_to_std_logic_vec(c_sinit_value, c_width);
     end if;

     if( c_has_default_data = 0 ) THEN
       read_meminit_file(c_mem_init_file, c_depth, c_width, MEM, lineno);
     end if;
     offset := lineno*c_width;
     while (lineno < c_depth) loop
       for i in 0 to c_width-1 loop
         MEM(offset+i) := def_data(i);
       end loop;
       lineno := lineno+1;
       offset := offset+c_width;
     end loop;
     DO_zd := sinit_value;
     START_UP := FALSE;
     DOUT_prim <= DO_zd;
     
   else -- normal behavior after start up

    VALID_ADDR := ADDR_IS_VALID(addr_int);

    if (VALID_ADDR) then
        ADDRESS := SLV_TO_INT(addr_int);
        ADDRESSstr := SLV_TO_STR(addr_int);
    end if;

    if (EN_ipd = '1') then
        if (CLK_ipd'event AND CLK_ipd'last_value = '0') then
            if (CLK_ipd = '1') then
               if (ADDRESS < c_depth ) then
                if (we_int = '1') then
                    if (VALID_ADDR) then
                        if(c_write_mode = c_write_first ) then --  "WRITE_FIRST") then
                              DO_zd := di_int;
                        elsif (c_write_mode = c_read_first) then --  (WRITE_MODE = "READ_FIRST") then
                              DO_zd := MEM((ADDRESS*DIW + DIW_1) downto (ADDRESS*DIW));
                        elsif(c_write_mode /= c_no_change ) then --   WRITE_MODE /= "NO_CHANGE") then
                              assert false report
                              " Wrong value for WRITE_MODE, assuming WRITE_FIRST "
                              severity warning;
                              DO_zd := di_int;
                        end if;

                        MEM((ADDRESS*DIW + DIW_1) downto (ADDRESS*DIW)) := di_int;
                    else
                        SET_MEM_TO_X(addr_int, MEM);
                        DO_zd := (others => 'X');
                        warn_out_undef("DOUT", warning_on);
                    end if;
                elsif (we_int = 'X') then
                    warn_signout_undef("WE", "DOUT", warning_on);
                    if (VALID_ADDR) then
                        MEM((ADDRESS*DIW + DIW_1) downto (ADDRESS*DIW)) := (others => 'X');
                        warn_memcontent_undef(ADDRESSstr, warning_on);
                    else
                        SET_MEM_TO_X(addr_int, MEM);
                    end if;
                    DO_zd := (others => 'X');
                else 
                    if (VALID_ADDR) then
                        DO_zd := MEM((ADDRESS*DIW + DIW_1) downto (ADDRESS*DIW));
                    else
                        warn_signout_undef("ADDR", "DOUT", warning_on);
                        DO_zd := (others => 'X');
                    end if;
                end if;
                if (SSR_ipd = '1') then
                    DO_zd := sinit_value;
                elsif (SSR_ipd = 'X') then
                   warn_signout_undef("SINIT", "DOUT", warning_on);
                   DO_zd := (others => 'X');
                end if;
             else
                  ASSERT FALSE
                            REPORT " Memory address is out of range. "
                            SEVERITY WARNING;
             end if;

            elsif (CLK_ipd = 'X') then
                if (c_yclk_is_rising=1) then
                  warn_oddclk_trans("CLK", "0", "X", warning_on);
                elsif (c_yclk_is_rising=0) then
                  warn_oddclk_trans("CLK", "1", "X", warning_on);
                end if;
                warn_out_undef("DOUT", warning_on);
                if (we_int /= '0') then
                    if (VALID_ADDR) then
                        MEM((ADDRESS*DIW + DIW_1) downto (ADDRESS*DIW)) := (others => 'X');
                    else
                        SET_MEM_TO_X(addr_int, MEM);
                    end if;
                end if;
                DO_zd := (others => 'X');
            end if; 
        elsif (CLK_ipd'event AND CLK_ipd'last_value = 'X') then
            if (CLK_ipd = '1') then
                if (c_yclk_is_rising=1) then
                  warn_oddclk_trans("CLK", "X", "1", warning_on);
                elsif (c_yclk_is_rising=0) then
                  warn_oddclk_trans("CLK", "X", "0", warning_on);                  
                end if;
                
                warn_out_undef("DOUT", warning_on);
                if (we_int /= '0') then
                    if (VALID_ADDR) then
                        MEM((ADDRESS*DIW + DIW_1) downto (ADDRESS*DIW)) := (others => 'X');
                    else
                        SET_MEM_TO_X(addr_int, MEM);
                    end if;
                end if;
                DO_zd := (others => 'X');
            end if;
        end if; 
    elsif (EN_ipd = 'X') then
        if (CLK_ipd'event AND CLK_ipd'last_value /= '1') then
            if (CLK_ipd /= '0') then
                warn_signout_undef("EN", "DOUT", warning_on);
                if (we_int /= '0') then
                    if (VALID_ADDR) then
                        MEM((ADDRESS*DIW + DIW_1) downto (ADDRESS*DIW)) := (others => 'X');
                    else
                        SET_MEM_TO_X(addr_int, MEM);
                    end if;
                end if;
                DO_zd := (others => 'X');
            end if;
        end if; 
    end if;
    DOUT_prim <= DO_zd ;

   end if ; --  START_UP 



    wait on CLK_ipd, we_int, EN_ipd, SSR_ipd, di_int,  addr_int;

  end PROCESS sp_primitive;


-------------------------- Output pipeline-------------------------------------

  pipeline_output:  process (CLK_ipd , WE_ipd, EN_ipd, SSR_ipd, DI_ipd, ADDR_ipd)
    variable sinit_value_int:  std_logic_vector(c_width-1 downto 0) := ( others => '0' ) ;
    variable first_time: boolean := TRUE ;
  begin

   if (first_time = TRUE ) then
     sinit_value_int := (others => '0');
     if (c_has_sinit = 1) then
         sinit_value_int := hexstr_to_std_logic_vec(c_sinit_value, c_width);
     end if; 
     for i in 0 to c_pipe_stages loop
       pipeline(i) <=  sinit_value_int;
     end loop;
     for i in 0 to c_pipe_stages loop
       sub_rdy(i) <= '0';
     end loop;
     first_time := FALSE;
   else
     if ( CLK_ipd'event and CLK_ipd = '1') then
       if (EN_ipd = '1') then
            if (SSR_ipd = '1') then
--              for i in 0 to c_pipe_stages loop
              pipeline(0) <= sinit_value_int ;  -- sinit_value ;
              sub_rdy(0)  <= '0' ;
--              end loop;
            else
--              for i in 0 to c_pipe_stages loop
              pipeline(0) <= DOUT_prim ;
              sub_rdy(0)  <= new_data_q ;
--              end loop;
            end if ;
        end if ;
      end if ;
    end if;
  end process pipeline_output ;

------------ Select pipelined output or non-pipelined outputs -----------------

 
  select_output:  process ( new_data_q, DOUT_prim, pipeline, sub_rdy)
  begin
       if (c_pipe_stages = 0) then
          DOUT <= DOUT_prim ;
          rdy_int <= new_data_q ;
       else
          DOUT <= pipeline(c_pipe_stages - 1) ;
          rdy_int <= sub_rdy(c_pipe_stages - 1) ;
      end if ;
   end process select_output ;

end behavioral;
