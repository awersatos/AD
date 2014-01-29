-- Copyright(C) 2002 by Xilinx, Inc. All rights reserved.              
-- This text contains proprietary, confidential                        
-- information of Xilinx, Inc., is distributed                         
-- under license from Xilinx, Inc., and may be used,                   
-- copied and/or disclosed only pursuant to the terms                  
-- of a valid license agreement with Xilinx, Inc. This copyright       
-- notice must be retained as part of this text at all times.          

-- $Id: c_counter_binary_v6_0.vhd,v 1.16 2008/09/08 20:06:05 akennedy Exp $
--
-- Filename - c_counter_binary_v6_0.vhd
-- Author - Xilinx
-- Creation - 29 Dec 1998
--
-- Description - This file contains the behavior for
--				 the C_COUNTER_BINARY_V6_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v6_0.all;
Use XilinxCoreLib.prims_utils_v6_0.all;
Use XilinxCoreLib.c_reg_fd_v6_0_comp.all;
Use XilinxCoreLib.c_addsub_v6_0_comp.all;
Use XilinxCoreLib.c_compare_v6_0_comp.all;
Use XilinxCoreLib.c_mux_bus_v6_0_comp.all;
Use XilinxCoreLib.c_gate_bit_v6_0_comp.all;

-- Synchronous binary counter
--

entity C_COUNTER_BINARY_V6_0 is
	generic (
			 C_WIDTH 		: integer := 16;
			 C_OUT_TYPE		: integer := c_signed;
			 C_RESTRICT_COUNT:integer := 0;
			 C_COUNT_TO 	: string  := "1111111111111111";
			 C_COUNT_BY 	: string  := "";
			 C_COUNT_MODE 	: integer := c_up;
			 C_THRESH0_VALUE: string  := "1111111111111111";
			 C_THRESH1_VALUE: string  := "1111111111111111";
			 C_THRESH_EARLY : integer := 1;
			 C_AINIT_VAL 	: string  := "";
			 C_SINIT_VAL 	: string  := "";
			 C_LOAD_ENABLE 	: integer := c_no_override;
			 C_SYNC_ENABLE 	: integer := c_override;
			 C_SYNC_PRIORITY: integer := c_clear;
			 C_PIPE_STAGES	: integer := 1;
			 C_HAS_THRESH0	: integer := 0;
			 C_HAS_Q_THRESH0: integer := 0;
			 C_HAS_THRESH1	: integer := 0;
			 C_HAS_Q_THRESH1: integer := 0;
			 C_HAS_CE 		: integer := 0;
			 C_HAS_UP 		: integer := 0;
			 C_HAS_IV 		: integer := 0;
			 C_HAS_L 		: integer := 0;
			 C_HAS_LOAD 	: integer := 0;
			 C_LOAD_LOW		: integer := 0;
			 C_HAS_ACLR 	: integer := 0;
			 C_HAS_ASET 	: integer := 0;
			 C_HAS_AINIT 	: integer := 0;
			 C_HAS_SCLR 	: integer := 0;
			 C_HAS_SSET 	: integer := 0;
			 C_HAS_SINIT 	: integer := 0;
			 C_ENABLE_RLOCS : integer := 1
			 ); 
			 
    port (CLK : in std_logic := '0'; -- Optional clock
		  UP : in std_logic := '1';  -- Controls direction of count - '1' = up.
		  CE : in std_logic := '1';  -- Optional Clock enable
		  LOAD : in std_logic := '0';  -- Optional Synch load trigger
		  L : in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');  -- Optional Synch load value
		  IV : in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');  -- Optional Increment value
		  ACLR : in std_logic := '0'; -- Asynch init.
		  ASET : in std_logic := '0'; -- optional asynch set to '1'
		  AINIT : in std_logic := '0'; -- optional asynch reset to init_val
		  SCLR : in std_logic := '0'; -- Synch init.
		  SSET : in std_logic := '0'; -- optional synch set to '1'
		  SINIT : in std_logic := '0'; -- Optional synch reset to init_val
		  THRESH0 : out std_logic := '1';  
		  Q_THRESH0 : out std_logic := '1';  
		  THRESH1 : out std_logic := '1';  
		  Q_THRESH1 : out std_logic := '1';  
		  Q : out std_logic_vector(C_WIDTH-1 downto 0)); -- Output value

end C_COUNTER_BINARY_V6_0;

architecture behavioral of C_COUNTER_BINARY_V6_0 is

	constant timeunit : time := 1 ns;

	signal intB : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
	signal intQ : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
	signal intFBs : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
	signal intFBs_or_q : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
	signal intFBq : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
	signal intFBq_or_zero : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
	signal intCount_by : std_logic_vector(C_WIDTH-1 downto 0) := str_to_slv_0(C_COUNT_BY, C_WIDTH);
	signal all_zeros : std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
	-- signals for optional pins...
	signal intUP : std_logic;
	signal intUPbar : std_logic;
	signal intT0 : std_logic;
	signal intQT0 : std_logic;
	signal intT1 : std_logic;
	signal intQT1 : std_logic;
	signal intCE : std_logic;
	signal intLOAD : std_logic;
	signal intL : std_logic_vector(C_WIDTH-1 downto 0);
	signal intIV : std_logic_vector(C_WIDTH-1 downto 0);
	signal intSCLR : std_logic;
	signal intSCLR_RESET : std_logic;
    signal intSCLR_RESET_for_thresh : std_logic;
    signal intSCLR_for_th_to : std_logic;
	signal intCount_to_reached : std_logic := '0';
	signal intB_or_load : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
	
	signal intXLOAD : std_logic;
	signal intXL : std_logic_vector(C_WIDTH-1 downto 0);
	signal intALOAD : std_logic;

    signal ACLR_for_th_to : std_logic;
    signal ASET_for_th_to : std_logic;

    signal GND : std_logic := '0';
	
	function tostdlogic(s : string) return std_logic_vector
	is
		variable logic : std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
	begin
		for i in 1 to s'length loop
			if s(i) = '1' then
				logic(s'length-i) := '1';
			else
				logic(s'length-i) := '0';
			end if;
		end loop;
		return logic;
	end;
	
	signal intSINITVAL : std_logic_vector(C_WIDTH-1 downto 0) := tostdlogic(C_SINIT_VAL);
	
	function lower_case(c : character) return character
    is
    begin
	if c >= 'A' and c <= 'Z' then
	    return character'val(character'pos(c) + 32);
	else return c;
	end if;
    end;

    -- compare two strings ignoring case
    function strcmp(a, b : string) return boolean
    is
	alias a_val : string(1 to a'length) is a;
	alias b_val : string(1 to b'length) is b;
	variable a_char, b_char : character;
    begin
	if a'length /= b'length then
	    return false;
	elsif a = b then
	    return true;
	end if;
	for i in 1 to a'length loop
	    a_char := lower_case(a_val(i));
	    b_char := lower_case(b_val(i));
	    if a_char /= b_char then
		return false;
	    end if;
	end loop;
	return true;
    end;

    function get_ainit_val(C_COUNT_TO : string; C_AINIT_VAL : string; C_HAS_AINIT : integer) return string is
    begin
      if (C_HAS_AINIT = 1) and (C_COUNT_TO = C_AINIT_VAL) then
        return "1";
      else
        return "0";
      end if;
    end;

    function stringZero(test:string) return boolean is
	variable zero : string(test'range);
	begin
		for i in test'range loop
			zero(i):= '0';
		end loop;
		return strcmp(test,zero);
	end stringZero;
	
begin

	-- Deal with optional pins...
	ce1: if C_HAS_CE = 1 generate
		intCE <= CE;
	end generate;
	ce0: if not (C_HAS_CE = 1) generate
		intCE <= '1';
	end generate;
	
	up1: if C_HAS_UP = 1 generate -- UP pin only valid for an up/down counter
		intUP <= UP;
	end generate;
	up0: if not (C_HAS_UP = 1) generate
		up00 : if C_COUNT_MODE = c_up generate
			intUP <= '1';
		end generate;
		up01 : if C_COUNT_MODE = c_down generate
			intUP <= '0';
		end generate;
	end generate;
	
	intUPbar <= not intUP;
	
	l1: if C_HAS_L = 1 generate
		intL <= L;
	end generate;
	l0: if not (C_HAS_L = 1) generate
		intL <= (others => '0');
	end generate;
	
	iv1: if C_HAS_IV = 1 generate
		intB <= IV;
	end generate;
	iv0: if not (C_HAS_IV = 1) generate
		intB <= intCount_by;
	end generate;
	
	load1: if C_HAS_LOAD = 1 generate
		load1_low : if C_LOAD_LOW = 1 generate
				intLOAD <= not LOAD;
		end generate;
		load1_high : if C_LOAD_LOW = 0 generate
				intLOAD <= LOAD;
		end generate;
	end generate;
	load0: if not (C_HAS_LOAD = 1) generate
		intLOAD <= '0';
	end generate;
	
	sclr1: if C_HAS_SCLR = 1 generate
		intSCLR <= SCLR;
	end generate;
	sclr0: if not (C_HAS_SCLR = 1) generate
		intSCLR <= '0';
	end generate;

    sclrthto3: if C_HAS_SCLR = 1 and C_HAS_SSET = 1 generate
		intSCLR_for_th_to <= SCLR or SSET;
	end generate;
	sclrthto2: if not(C_HAS_SCLR = 1) and C_HAS_SSET = 1 generate
		intSCLR_for_th_to <= SSET;
	end generate;
    sclrthto1: if (C_HAS_SCLR = 1 and not(C_HAS_SSET = 1)) generate --or 
		intSCLR_for_th_to <= SCLR;
	end generate;
	sclrthto0: if not(C_HAS_SCLR = 1) and not(C_HAS_SSET = 1) generate
		intSCLR_for_th_to <= '0';
	end generate;

    aclrforthtogen1 : if (C_HAS_AINIT = 1 and C_AINIT_VAL /= C_COUNT_TO) generate
    begin
      ii1 : if (C_HAS_ACLR = 1) generate
        ACLR_for_th_to <= ACLR or AINIT;
      end generate;
      ii2 : if (C_HAS_ACLR = 0) generate
        ACLR_for_th_to <= AINIT;
      end generate;
	  ASET_for_th_to <= '0';
    end generate;
    aclrforthtogen2 : if (C_HAS_AINIT = 1 and C_AINIT_VAL = C_COUNT_TO) generate
      ACLR_for_th_to <= ACLR;
      ASET_for_th_to <= AINIT;
    end generate;
    aclrforthtogen3 : if (C_HAS_AINIT = 0) generate
      ACLR_for_th_to <= ACLR;
      ASET_for_th_to <= '0';
    end generate;

	intSCLR_RESET <= (intSCLR or (intCount_to_reached and intCE)) and not(intXLOAD);
    intSCLR_RESET_for_thresh <= intSCLR; --((intSCLR and CE) or (intCount_to_reached and CE)) and not(intXLOAD);

	tcearly1: if C_THRESH_EARLY = 1 generate
		intFBs_or_q <= intFBs;
	end generate;
	tcearly0: if not (C_THRESH_EARLY = 1) generate
		intFBs_or_q <= intFBq;
	end generate;

	cnt1: if (C_RESTRICT_COUNT = 1 and C_HAS_SINIT = 1) generate
		cnt1load1: if C_HAS_LOAD = 1 generate
			cntmux : C_MUX_BUS_V6_0
					generic map(C_WIDTH => C_WIDTH,
								C_INPUTS => 2,
								C_SEL_WIDTH => 1,
								C_HAS_O => 1,
								C_HAS_Q => 1,
								C_HAS_CE => 0,
								C_HAS_EN => 0,
								C_ENABLE_RLOCS => C_ENABLE_RLOCS)
						port map(MA => intSINITVAL,
								 MB => intL,
								 S(0) => intLOAD,
								 O => intXL);
								 
			cnt1load1ce1: if (C_HAS_CE = 1) generate
				cnt1load1or1: if (C_LOAD_ENABLE /= C_SYNC_ENABLE) generate
					cnt1load1or1e1: if (C_SYNC_ENABLE = 0) generate
						intXLOAD <= SINIT or (intLOAD and CE);
						-- Instance an addsub module	
						the_addsub : C_ADDSUB_V6_0
		   					generic map(C_A_WIDTH 		=> C_WIDTH,
	    		   				C_B_WIDTH 		=> C_WIDTH,
	    		   				C_OUT_WIDTH 		=> C_WIDTH,
	    		   				C_LOW_BIT 		=> 0,
	    		   				C_HIGH_BIT 		=> C_WIDTH-1,
	    		   				C_ADD_MODE		=> C_COUNT_MODE,
	    		   				C_A_TYPE 		=> C_OUT_TYPE,
	    		   				C_B_TYPE 		=> C_OUT_TYPE,
	    		   				C_B_CONSTANT 	=> 0,
	    		   				C_B_VALUE		=> "",
	    		   				C_AINIT_VAL  	=> C_AINIT_VAL,
	    		   				C_SINIT_VAL  	=> C_SINIT_VAL,
	    		   				C_BYPASS_ENABLE  => 0,
	    		   				C_BYPASS_LOW 	=> C_LOAD_LOW,	-- DLUNN CHANGED FROM 0,
	    		   				C_SYNC_ENABLE	=> C_SYNC_ENABLE,
	    		   				C_SYNC_PRIORITY  => C_SYNC_PRIORITY,
	    		   				C_PIPE_STAGES	=> C_PIPE_STAGES,
	    		   				C_HAS_S  		=> 1,
	    		   				C_HAS_Q  		=> 1,
	    		   				C_HAS_C_IN		=> 1,
	    		   				C_HAS_C_OUT  	=> 0,
	    		   				C_HAS_Q_C_OUT	=> 0,
	    		   				C_HAS_B_IN		=> 0,
	    		   				C_HAS_B_OUT  	=> 0,
	    		   				C_HAS_Q_B_OUT	=> 0,
	    		   				C_HAS_OVFL		=> 0,
	    		   				C_HAS_Q_OVFL 	=> 0,
	    		   				C_HAS_CE 		=> C_HAS_CE,
	    		   				C_HAS_ADD		=> C_HAS_UP,
	    		   				C_HAS_BYPASS 	=> 1,
	    		   				C_HAS_A_SIGNED	=> 0,
	    		   				C_HAS_B_SIGNED	=> 0,
	    		   				C_HAS_ACLR		=> C_HAS_ACLR,
	    		   				C_HAS_ASET		=> C_HAS_ASET,
	    		   				C_HAS_AINIT  	=> C_HAS_AINIT,
	    		   				C_HAS_SCLR		=> boolean'pos((C_HAS_SCLR = 1) or (C_RESTRICT_COUNT = 1)),
	    		   				C_HAS_SSET		=> C_HAS_SSET,
	    		   				C_HAS_SINIT  	=> boolean'pos((C_HAS_SINIT = 1) and not(C_RESTRICT_COUNT = 1)),
	    		   				C_ENABLE_RLOCS	=> C_ENABLE_RLOCS
	    						)
	   					port map(A => intFBq_or_zero, 
	   						B => intB_or_load,
	    	 					CLK => CLK,
	    	 					ADD => intUP,
	           					CE => CE,
							C_IN => intUPbar, -- In ADD mode we get a '0' and in SUB mode we get a '1' (for the active-low borrow signal)
	           					ACLR => ACLR,
	           					ASET => ASET,
	           					AINIT => AINIT,
	           					SCLR => intSCLR_RESET,
	           					SSET => SSET,
	           					SINIT => SINIT,
							BYPASS => intALOAD,	-- DLUNN CHANGED FROM intLOAD,
							S => intFBs,
	           					Q => intFBq); -- Synch Output value

		

					end generate;
					cnt1load1or0e0: if not (C_SYNC_ENABLE = 0) generate
						intXLOAD <= intLOAD or (SINIT and CE);
					end generate;
				end generate;
				cnt1load1or0: if not (C_LOAD_ENABLE /= C_SYNC_ENABLE) generate
					intXLOAD <= intLOAD or SINIT;
				end generate;
			end generate;
			cnt1load1ce0: if not (C_HAS_CE = 1) generate
				intXLOAD <= intLOAD or SINIT;
			end generate;
			cnt1load1x: if not ((C_HAS_CE = 1) and (C_LOAD_ENABLE = 1) and (C_SYNC_ENABLE = 1)) generate
				-- Instance an addsub module	
				the_addsub : C_ADDSUB_V6_0
		   		generic map(C_A_WIDTH 		=> C_WIDTH,
	    		   C_B_WIDTH 		=> C_WIDTH,
	    		   C_OUT_WIDTH 		=> C_WIDTH,
	    		   C_LOW_BIT 		=> 0,
	    		   C_HIGH_BIT 		=> C_WIDTH-1,
	    		   C_ADD_MODE		=> C_COUNT_MODE,
	    		   C_A_TYPE 		=> C_OUT_TYPE,
	    		   C_B_TYPE 		=> C_OUT_TYPE,
	    		   C_B_CONSTANT 	=> 0,
	    		   C_B_VALUE		=> "",
	    		   C_AINIT_VAL  	=> C_AINIT_VAL,
	    		   C_SINIT_VAL  	=> C_SINIT_VAL,
	    		   C_BYPASS_ENABLE  => 0, --C_LOAD_ENABLE,	-- DLUNN CHANGED FROM 0,
	    		   C_BYPASS_LOW 	=> C_LOAD_LOW,	-- DLUNN CHANGED FROM 0,
	    		   C_SYNC_ENABLE	=> C_SYNC_ENABLE,
	    		   C_SYNC_PRIORITY  => C_SYNC_PRIORITY,
	    		   C_PIPE_STAGES	=> C_PIPE_STAGES,
	    		   C_HAS_S  		=> 1,
	    		   C_HAS_Q  		=> 1,
	    		   C_HAS_C_IN		=> 1,
	    		   C_HAS_C_OUT  	=> 0,
	    		   C_HAS_Q_C_OUT	=> 0,
	    		   C_HAS_B_IN		=> 0,
	    		   C_HAS_B_OUT  	=> 0,
	    		   C_HAS_Q_B_OUT	=> 0,
	    		   C_HAS_OVFL		=> 0,
	    		   C_HAS_Q_OVFL 	=> 0,
	    		   C_HAS_CE 		=> C_HAS_CE,
	    		   C_HAS_ADD		=> C_HAS_UP,
	    		   C_HAS_BYPASS 	=> 1,
	    		   C_HAS_A_SIGNED	=> 0,
	    		   C_HAS_B_SIGNED	=> 0,
	    		   C_HAS_ACLR		=> C_HAS_ACLR,
	    		   C_HAS_ASET		=> C_HAS_ASET,
	    		   C_HAS_AINIT  	=> C_HAS_AINIT,
	    		   C_HAS_SCLR		=> boolean'pos((C_HAS_SCLR = 1) or (C_RESTRICT_COUNT = 1)),
	    		   C_HAS_SSET		=> C_HAS_SSET,
	    		   C_HAS_SINIT  	=> boolean'pos((C_HAS_SINIT = 1) and not(C_RESTRICT_COUNT = 1)),
	    		   C_ENABLE_RLOCS	=> C_ENABLE_RLOCS
	    		)
	   port map(A => intFBq_or_zero, 
	   			B => intB_or_load,
	    	 	CLK => CLK,
	    	 	ADD => intUP,
	           	CE => CE,
				C_IN => intUPbar, -- In ADD mode we get a '0' and in SUB mode we get a '1' (for the active-low borrow signal)
	           	ACLR => ACLR,
	           	ASET => ASET,
	           	AINIT => AINIT,
	           	SCLR => intSCLR_RESET,
	           	SSET => SSET,
	           	SINIT => SINIT,
				BYPASS => intALOAD,	-- DLUNN CHANGED FROM intLOAD,
				S => intFBs,
	           	Q => intFBq); -- Synch Output value
			
			end generate;

		
		end generate;
		
		cnt1load0: if not (C_HAS_LOAD = 1) generate
			intXL <= intSINITVAL;
			intXLOAD <= SINIT;
			-- Instance an addsub module	
		the_addsub : C_ADDSUB_V6_0
		   generic map(C_A_WIDTH 		=> C_WIDTH,
	    		   C_B_WIDTH 		=> C_WIDTH,
	    		   C_OUT_WIDTH 		=> C_WIDTH,
	    		   C_LOW_BIT 		=> 0,
	    		   C_HIGH_BIT 		=> C_WIDTH-1,
	    		   C_ADD_MODE		=> C_COUNT_MODE,
	    		   C_A_TYPE 		=> C_OUT_TYPE,
	    		   C_B_TYPE 		=> C_OUT_TYPE,
	    		   C_B_CONSTANT 	=> 0,
	    		   C_B_VALUE		=> "",
	    		   C_AINIT_VAL  	=> C_AINIT_VAL,
	    		   C_SINIT_VAL  	=> C_SINIT_VAL,
	    		   C_BYPASS_ENABLE  => C_SYNC_ENABLE,	-- DLUNN CHANGED FROM 0,
	    		   C_BYPASS_LOW 	=> C_LOAD_LOW,
	    		   C_SYNC_ENABLE	=> C_SYNC_ENABLE,
	    		   C_SYNC_PRIORITY  => C_SYNC_PRIORITY,
	    		   C_PIPE_STAGES	=> C_PIPE_STAGES,
	    		   C_HAS_S  		=> 1,
	    		   C_HAS_Q  		=> 1,
	    		   C_HAS_C_IN		=> 1,
	    		   C_HAS_C_OUT  	=> 0,
	    		   C_HAS_Q_C_OUT	=> 0,
	    		   C_HAS_B_IN		=> 0,
	    		   C_HAS_B_OUT  	=> 0,
	    		   C_HAS_Q_B_OUT	=> 0,
	    		   C_HAS_OVFL		=> 0,
	    		   C_HAS_Q_OVFL 	=> 0,
	    		   C_HAS_CE 		=> C_HAS_CE,
	    		   C_HAS_ADD		=> C_HAS_UP,
	    		   C_HAS_BYPASS 	=> 1,
	    		   C_HAS_A_SIGNED	=> 0,
	    		   C_HAS_B_SIGNED	=> 0,
	    		   C_HAS_ACLR		=> C_HAS_ACLR,
	    		   C_HAS_ASET		=> C_HAS_ASET,
	    		   C_HAS_AINIT  	=> C_HAS_AINIT,
	    		   C_HAS_SCLR		=> boolean'pos((C_HAS_SCLR = 1) or (C_RESTRICT_COUNT = 1)),
	    		   C_HAS_SSET		=> C_HAS_SSET,
	    		   C_HAS_SINIT  	=> boolean'pos((C_HAS_SINIT = 1) and not(C_RESTRICT_COUNT = 1)),
	    		   C_ENABLE_RLOCS	=> C_ENABLE_RLOCS
	    		)
	   port map(A => intFBq_or_zero, 
	   			B => intB_or_load,
	    	 	CLK => CLK,
	    	 	ADD => intUP,
	           	CE => CE,
				C_IN => intUPbar, -- In ADD mode we get a '0' and in SUB mode we get a '1' (for the active-low borrow signal)
	           	ACLR => ACLR,
	           	ASET => ASET,
	           	AINIT => AINIT,
	           	SCLR => intSCLR_RESET,
	           	SSET => SSET,
	           	SINIT => SINIT,
				BYPASS => intALOAD,	-- DLUNN CHANGED FROM intLOAD,
				S => intFBs,
	           	Q => intFBq); -- Synch Output value

		
		end generate;
	
		cntload1: if (C_LOAD_LOW = 1) generate
			intALOAD <= not intXLOAD;
		end generate;
	
		cntload0: if not (C_LOAD_LOW = 1) generate
			intALOAD <= intXLOAD;
		end generate;
		
		mux1 : C_MUX_BUS_V6_0
					generic map(C_WIDTH => C_WIDTH,
								C_INPUTS => 2,
								C_SEL_WIDTH => 1,
								C_HAS_O => 1,
								C_HAS_Q => 1,
								C_HAS_CE => 0,
								C_HAS_EN => 0,
								C_ENABLE_RLOCS => C_ENABLE_RLOCS)
						port map(MA => intB,
								 MB => intXL,
								 S(0) => intXLOAD,
							 	O => intB_or_load);
				
	end generate;
	
	cnt0: if not (C_RESTRICT_COUNT = 1 and C_HAS_SINIT = 1) generate
		intXL <= intL;
		intXLOAD <= intLOAD;
		-- Instance an addsub module	
		the_addsub : C_ADDSUB_V6_0
	  	 generic map(C_A_WIDTH 		=> C_WIDTH,
	    		   C_B_WIDTH 		=> C_WIDTH,
	    		   C_OUT_WIDTH 		=> C_WIDTH,
	    		   C_LOW_BIT 		=> 0,
	    		   C_HIGH_BIT 		=> C_WIDTH-1,
	    		   C_ADD_MODE		=> C_COUNT_MODE,
	    		   C_A_TYPE 		=> C_OUT_TYPE,
	    		   C_B_TYPE 		=> C_OUT_TYPE,
	    		   C_B_CONSTANT 	=> 0,
	    		   C_B_VALUE		=> "",
	    		   C_AINIT_VAL  	=> C_AINIT_VAL,
	    		   C_SINIT_VAL  	=> C_SINIT_VAL,
	    		   C_BYPASS_ENABLE  => C_LOAD_ENABLE,	-- DLUNN CHANGED FROM 0,
	    		   C_BYPASS_LOW 	=> C_LOAD_LOW,	-- DLUNN CHANGED FROM 0,
	    		   C_SYNC_ENABLE	=> C_SYNC_ENABLE,
	    		   C_SYNC_PRIORITY  => C_SYNC_PRIORITY,
	    		   C_PIPE_STAGES	=> C_PIPE_STAGES,
	    		   C_HAS_S  		=> 1,
	    		   C_HAS_Q  		=> 1,
	    		   C_HAS_C_IN		=> 1,
	    		   C_HAS_C_OUT  	=> 0,
	    		   C_HAS_Q_C_OUT	=> 0,
	    		   C_HAS_B_IN		=> 0,
	    		   C_HAS_B_OUT  	=> 0,
	    		   C_HAS_Q_B_OUT	=> 0,
	    		   C_HAS_OVFL		=> 0,
	    		   C_HAS_Q_OVFL 	=> 0,
	    		   C_HAS_CE 		=> C_HAS_CE,
	    		   C_HAS_ADD		=> C_HAS_UP,
	    		   C_HAS_BYPASS 	=> C_HAS_LOAD,
	    		   C_HAS_A_SIGNED	=> 0,
	    		   C_HAS_B_SIGNED	=> 0,
	    		   C_HAS_ACLR		=> C_HAS_ACLR,
	    		   C_HAS_ASET		=> C_HAS_ASET,
	    		   C_HAS_AINIT  	=> C_HAS_AINIT,
	    		   C_HAS_SCLR		=> boolean'pos((C_HAS_SCLR = 1) or (C_RESTRICT_COUNT = 1)),
	    		   C_HAS_SSET		=> C_HAS_SSET,
	    		   C_HAS_SINIT  	=> boolean'pos((C_HAS_SINIT = 1) and not(C_RESTRICT_COUNT = 1)),
	    		   C_ENABLE_RLOCS	=> C_ENABLE_RLOCS
	    		)
	  	 port map(A => intFBq_or_zero, 
	   			B => intB_or_load,
	    	 	CLK => CLK,
	    	 	ADD => intUP,
	           	CE => CE,
				C_IN => intUPbar, -- In ADD mode we get a '0' and in SUB mode we get a '1' (for the active-low borrow signal)
	           	ACLR => ACLR,
	           	ASET => ASET,
	           	AINIT => AINIT,
	           	SCLR => intSCLR_RESET,
	           	SSET => SSET,
	           	SINIT => SINIT,
				BYPASS => LOAD,
				S => intFBs,
	           	Q => intFBq); -- Synch Output value
	
		loadcnt1: if (C_HAS_LOAD = 1) generate	
			mux1 : C_MUX_BUS_V6_0
					generic map(C_WIDTH => C_WIDTH,
								C_INPUTS => 2,
								C_SEL_WIDTH => 1,
								C_HAS_O => 1,
								C_HAS_Q => 1,
								C_HAS_CE => 0,
								C_HAS_EN => 0,
								C_ENABLE_RLOCS => C_ENABLE_RLOCS)
						port map(MA => intB,
								 MB => intXL,
								 S(0) => intXLOAD,
							 	O => intB_or_load);
		end generate;
	
		loadcnt0: if not (C_HAS_LOAD = 1) generate
			intB_or_load <= intB;
		end generate;
	
	
	end generate;
	
	
	mxfb : C_MUX_BUS_V6_0
				generic map(C_WIDTH => C_WIDTH,
							C_INPUTS => 2,
							C_SEL_WIDTH => 1,
							C_HAS_O => 1,
							C_HAS_Q => 0,
						    C_HAS_EN => 0,
							C_ENABLE_RLOCS => C_ENABLE_RLOCS)
					port map(MA => intFBq,
							 MB => all_zeros,
							 S(0) => intXLOAD,
							 O => intFBq_or_zero);
				
	th0 : if(C_HAS_THRESH0 = 1 or C_HAS_Q_THRESH0 = 1) generate
		th00: if (stringZero(C_THRESH0_VALUE)) generate
			comp0 : C_COMPARE_V6_0
				generic map(C_WIDTH => C_WIDTH,
							C_AINIT_VAL => "0",
							C_DATA_TYPE => C_OUT_TYPE,
							C_B_CONSTANT => 1,
							C_B_VALUE => C_THRESH0_VALUE,
							C_HAS_CE => C_HAS_CE,
							C_HAS_ACLR => C_HAS_ACLR,
							C_HAS_SCLR => 0,	-- DLUNN CHANGED FROM C_HAS_SCLR,
							C_HAS_A_EQ_B => C_HAS_THRESH0,
							C_HAS_QA_EQ_B => C_HAS_Q_THRESH0)
					port map(A => intFBs_or_q,
							 CLK => CLK,
							 CE => CE,
							 ACLR => ACLR,
							 SCLR => intSCLR_RESET,	-- DLUNN CHANGED FROM SCLR,
							 A_EQ_B => THRESH0,
							 QA_EQ_B => Q_THRESH0);
		end generate;
		th01: if not (stringZero(C_THRESH0_VALUE)) generate
			comp0 : C_COMPARE_V6_0
				generic map(C_WIDTH => C_WIDTH,
							C_AINIT_VAL => "0",
							C_DATA_TYPE => C_OUT_TYPE,
							C_B_CONSTANT => 1,
							C_B_VALUE => C_THRESH0_VALUE,
                            C_SYNC_ENABLE => 1,
							C_HAS_CE => C_HAS_CE,
							C_HAS_ACLR => C_HAS_ACLR,
							C_HAS_SCLR => C_HAS_SCLR,
							C_HAS_A_EQ_B => C_HAS_THRESH0,
							C_HAS_QA_EQ_B => C_HAS_Q_THRESH0)
					port map(A => intFBs_or_q,
							 CLK => CLK,
							 CE => CE,
							 ACLR => ACLR,
							 SCLR => intSCLR_RESET_for_thresh,	-- DLUNN CHANGED FROM SCLR,
							 A_EQ_B => THRESH0,
							 QA_EQ_B => Q_THRESH0);
            --comp0 : C_GATE_BIT_V6_0
            --generic map (C_GATE_TYPE      => c_and,
            --             C_INPUTS         => C_WIDTH,
            --             C_INPUT_INV_MASK => C_THRESH0_VALUE,
            --             C_PIPE_STAGES    => 0,
            --             C_AINIT_VAL      => "0",
            --             C_SINIT_VAL      => "0",
            --             C_SYNC_PRIORITY  => 1,
            --             C_SYNC_ENABLE    => 1,
            --             C_HAS_O          => 1,
            --             C_HAS_Q          => 1,
            --             C_HAS_CE         => C_HAS_CE,
            --             C_HAS_ACLR       => C_HAS_ACLR,
            --             C_HAS_ASET       => 0,
            --             C_HAS_AINIT      => 0,
            --             C_HAS_SCLR       => C_HAS_SCLR,
            --             C_HAS_SSET       => 0,
            --             C_HAS_SINIT      => 0,
            --             C_ENABLE_RLOCS   => 0)
            --port map    (I                => intFBs_or_q,
            --             CLK              => CLK,
            --             CE               => CE,
            --             ACLR             => ACLR,
            --             ASET             => ASET, 
            --             AINIT            => AINIT,
            --             SCLR             => SCLR,
            --             SSET             => SSET, 
            --             SINIT            => SINIT,
            --             O                => THRESH0,
            --             Q                => Q_THRESH0,
            --             T                => GND,
			--			 EN               => GND);
		end generate;			
	end generate; -- th0
								 
	th1 : if(C_HAS_THRESH1 = 1 or C_HAS_Q_THRESH1 = 1) generate
		th10: if (stringZero(C_THRESH1_VALUE)) generate
			comp1 : C_COMPARE_V6_0
				generic map(C_WIDTH => C_WIDTH,
							C_AINIT_VAL => "0",
							C_DATA_TYPE => C_OUT_TYPE,
							C_B_CONSTANT => 1,
							C_B_VALUE => C_THRESH1_VALUE,
							C_HAS_CE => C_HAS_CE,
							C_HAS_ACLR => C_HAS_ACLR,
							C_HAS_SCLR => 0,	-- DLUNN CHANGED FROM C_HAS_SCLR,
							C_HAS_A_EQ_B => C_HAS_THRESH1,
							C_HAS_QA_EQ_B => C_HAS_Q_THRESH1)
					port map(A => intFBs_or_q,
							 CLK => CLK,
							 CE => CE,
							 ACLR => ACLR,
							 SCLR => intSCLR_RESET,	-- DLUNN CHANGED FROM SCLR,
							 A_EQ_B => THRESH1,
							 QA_EQ_B => Q_THRESH1);
							 
		end generate;
		th11: if not (stringZero(C_THRESH1_VALUE)) generate
			comp1 : C_COMPARE_V6_0
				generic map(C_WIDTH => C_WIDTH,
							C_AINIT_VAL => "0",
							C_DATA_TYPE => C_OUT_TYPE,
							C_B_CONSTANT => 1,
							C_B_VALUE => C_THRESH1_VALUE,
                            C_SYNC_ENABLE => 1,
							C_HAS_CE => C_HAS_CE,
							C_HAS_ACLR => C_HAS_ACLR,
							C_HAS_SCLR => C_HAS_SCLR,
							C_HAS_A_EQ_B => C_HAS_THRESH1,
							C_HAS_QA_EQ_B => C_HAS_Q_THRESH1)
					port map(A => intFBs_or_q,
							 CLK => CLK,
							 CE => CE,
							 ACLR => ACLR,
							 SCLR => intSCLR_RESET_for_thresh,	-- DLUNN CHANGED FROM SCLR,
							 A_EQ_B => THRESH1,
							 QA_EQ_B => Q_THRESH1);
							 
		end generate;
	end generate; -- th1
	
	th_to : if(C_RESTRICT_COUNT = 1) generate
		comp_to : C_COMPARE_V6_0
				generic map(C_WIDTH => C_WIDTH,
							C_DATA_TYPE => C_OUT_TYPE,
							C_B_CONSTANT => 1,
							C_B_VALUE => C_COUNT_TO,
							C_SYNC_ENABLE => C_SYNC_ENABLE,
							C_HAS_CE => C_HAS_CE,
							C_HAS_ACLR => boolean'pos((C_HAS_ACLR = 1) or (C_HAS_AINIT = 1 and C_AINIT_VAL /= C_COUNT_TO)),
                            C_HAS_ASET => boolean'pos((C_HAS_AINIT = 1) and (C_AINIT_VAL = C_COUNT_TO)),
							C_HAS_SCLR => boolean'pos((C_HAS_SCLR = 1) or ((C_HAS_SSET = 1))),
							C_HAS_A_EQ_B => 0,
							C_HAS_QA_EQ_B => 1)
					port map(A => intFBs,
							 CLK => CLK,
                             CE => CE,
							 ACLR => ACLR_for_th_to,
							 ASET => ASET_for_th_to,
							 SCLR => intSCLR_for_th_to,
							 QA_EQ_B => intCount_to_reached);
							 
	end generate; -- th_to
	
	intQ <= intFBq;
	
	Q <= intQ after timeunit;
			
end behavioral;
