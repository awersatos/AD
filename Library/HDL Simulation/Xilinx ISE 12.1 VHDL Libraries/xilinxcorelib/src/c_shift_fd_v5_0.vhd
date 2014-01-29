-- $Id: c_shift_fd_v5_0.vhd,v 1.17 2008/09/08 20:05:58 akennedy Exp $
--
-- Filename - c_shift_fd_v5_0.vhd
-- Author - Xilinx
-- Creation - 14 June 1999
--
-- Description - This file contains the behavior for
--				 the C_SHIFT_FD_V5_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v5_0.all;
Use XilinxCoreLib.c_reg_fd_v5_0_comp.all;
Use XilinxCoreLib.c_mux_bit_v5_0_comp.all;

entity C_SHIFT_FD_V5_0 is
	generic (C_WIDTH		: integer := 16;
			 C_SHIFT_TYPE	: integer := c_lsb_to_msb;
			 C_FILL_DATA 	: integer := c_sdin;
			 C_AINIT_VAL	: string  := "";
			 C_SINIT_VAL	: string  := "";
			 C_SYNC_PRIORITY: integer := c_clear;
			 C_SYNC_ENABLE	: integer := c_override;
			 C_HAS_LSB_2_MSB: integer := 0;
			 C_HAS_SDIN		: integer := 1;
			 C_HAS_D		: integer := 0;
			 C_HAS_SDOUT 	: integer := 0;
			 C_HAS_Q		: integer := 1;
			 C_HAS_CE		: integer := 0;
			 C_HAS_ACLR 	: integer := 0;
			 C_HAS_ASET 	: integer := 0;
			 C_HAS_AINIT	: integer := 0;
			 C_HAS_SCLR 	: integer := 0;
			 C_HAS_SSET 	: integer := 0;
			 C_HAS_SINIT	: integer := 0;
			 C_ENABLE_RLOCS : integer := 1
			 ); 

    port (LSB_2_MSB : in std_logic := '0';
		  SDIN : in std_logic := '0';
		  D : in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
		  P_LOAD : in std_logic := '0';
		  CLK : in std_logic := '0';
		  CE : in std_logic := '1';
		  ACLR : in std_logic := '0';
		  ASET : in std_logic := '0';
		  AINIT : in std_logic := '0';
		  SCLR : in std_logic := '0';
		  SSET : in std_logic := '0';
		  SINIT : in std_logic := '0';
		  SDOUT : out std_logic;
		  Q : out std_logic_vector(C_WIDTH-1 downto 0)		  
		  ); 
end c_shift_fd_v5_0;

architecture behavioral of c_shift_fd_v5_0 is

	signal regsin : std_logic_vector(C_WIDTH-1 downto 0);
	signal regsout : std_logic_vector(C_WIDTH-1 downto 0);
	signal MSBmuxi : std_logic_vector(3 downto 0);
	signal muxc : std_logic_vector(1 downto 0);
	signal LSBmuxi : std_logic_vector(3 downto 0);

--	type shmuxinputs is array (C_WIDTH-2 downto 1) of std_logic_vector(3 downto 0);
	type shmuxinputs is array (C_WIDTH downto 1) of std_logic_vector(3 downto 0);
	signal shmuxi : shmuxinputs;
	
	signal intLSB_2_MSB : std_logic := '0';
	signal intSDIN : std_logic := '0';
	signal intD : std_logic_vector(C_WIDTH - 1 downto 0) := (others => '0');
	signal intP_LOAD : std_logic := '0';
	signal intSDOUT : std_logic := 'X';
	signal intQ : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');

begin

	-- Sort out the optional pins..
	bidi1 : if(C_SHIFT_TYPE = c_bidirectional) generate
		l2m2: if ((C_HAS_LSB_2_MSB = 1) and (C_WIDTH = 1)) generate
			intLSB_2_MSB <= '1';
		end generate;
		l2m1 : if((C_HAS_LSB_2_MSB = 1) and (C_WIDTH > 1)) generate
			intLSB_2_MSB <= LSB_2_MSB;
		end generate;
		l2m0 : if not(C_HAS_LSB_2_MSB = 1) generate
			intLSB_2_MSB <= 'X'; -- Problem!!!
		end generate;
	end generate; -- bidi1
	l2m1 : if((C_SHIFT_TYPE = c_lsb_to_msb) or ((C_SHIFT_TYPE = c_msb_to_lsb) and (C_WIDTH = 1))) generate
		intLSB_2_MSB <= '1';
	end generate;
	m2l1 : if((C_SHIFT_TYPE = c_msb_to_lsb) and (C_WIDTH > 1)) generate
		intLSB_2_MSB <= '0';
	end generate;
	
	sdinproc : process(SDIN, regsout, intLSB_2_MSB)
	begin
	   if(C_HAS_SDIN = 1) then
	       intSDIN <= SDIN; -- C_FILL_DATA must be c_sdin!!!
	   else
	       if(C_FILL_DATA = c_zeros) then
	    	   intSDIN <= '0';
	       end if;
	       if(C_FILL_DATA = c_ones) then
	    	   intSDIN <= '1';
	       end if;
	       if(C_FILL_DATA = c_lsb) then
	    	   intSDIN <= regsout(0);
	       end if;
	       if(C_FILL_DATA = c_msb) then
	    	   intSDIN <= regsout(C_WIDTH-1);
	       end if;
	       if(C_FILL_DATA = c_wrap) then
				if(intLSB_2_MSB = '0') then
					intSDIN <= regsout(0);
				elsif(intLSB_2_MSB = '1') then
					intSDIN <= regsout(C_WIDTH-1);
				elsif(regsout(0) /= regsout(C_WIDTH-1)) then -- direction is unknown, values are different
					intSDIN <= 'X';
				else
					intSDIN <= regsout(0);
				end if;
	       end if;
	   end if;
	end process;
		
	d1 : if(C_HAS_D = 1) generate
		intD <= D;
		intP_LOAD <= P_LOAD;
	end generate;
	d0 : if not(C_HAS_D = 1) generate
		intD <= (others => 'X');
		intP_LOAD <= '0';
	end generate;

	-- Start off with the registers which will make up the SR
	shreg : C_REG_FD_V5_0 generic map(C_WIDTH => C_WIDTH,
									  C_AINIT_VAL => C_AINIT_VAL,
									  C_SINIT_VAL => C_SINIT_VAL,
									  C_SYNC_PRIORITY => C_SYNC_PRIORITY,
									  C_SYNC_ENABLE => C_SYNC_ENABLE,
									  C_HAS_CE => C_HAS_CE,
									  C_HAS_ACLR => C_HAS_ACLR,									  
									  C_HAS_ASET => C_HAS_ASET,
									  C_HAS_AINIT => C_HAS_AINIT,
									  C_HAS_SCLR => C_HAS_SCLR,									  
									  C_HAS_SSET => C_HAS_SSET,
									  C_HAS_SINIT => C_HAS_SINIT,
									  C_ENABLE_RLOCS => C_ENABLE_RLOCS)
							port map(D => regsin,
									 CLK => CLK,
									 CE => CE,
									 ACLR => ACLR,
									 ASET => ASET,
									 AINIT => AINIT,
									 SCLR => SCLR,
									 SSET => SSET,
									 SINIT => SINIT,
									 Q => regsout);

	-- Now the muxes which steer the data
	
	-- First the muxes which are needed at the ends of the SR:
	muxwgt1 : if (C_WIDTH>1) generate
		MSBmux : C_MUX_BIT_V5_0 generic map(C_INPUTS => 4,
											C_SEL_WIDTH => 2,
											C_HAS_Q => 0,
											C_HAS_O => 1)
									port map(M => MSBmuxi,
											 S => muxc,
											 O => regsin(C_WIDTH-1));
	end generate;
										 
	LSBmux : C_MUX_BIT_V5_0 generic map(C_INPUTS => 4,
										C_SEL_WIDTH => 2,
										C_HAS_Q => 0,
										C_HAS_O => 1)
								port map(M => LSBmuxi,
										 S => muxc,
										 O => regsin(0));
										 
	-- Now the rest of the muxes which are identical:
	muxwgt2 : if (C_WIDTH>2) generate
		muxloop : for i in C_WIDTH-2 downto 1 generate
			shmux : C_MUX_BIT_V5_0 generic map(C_INPUTS => 4,
											C_SEL_WIDTH => 2,
											C_HAS_Q => 0,
											C_HAS_O => 1)
									port map(M => shmuxi(i),
											 S => muxc,
											 O => regsin(i));

		end generate; -- muxloop
	end generate;
	
	-- Now connect up the wires to the mux and reg inputs and outputs 
	lsbw1: if (C_WIDTH = 1) generate
		LSBmuxi(0) <= regsout(0);
	end generate;
	lsbwgt1: if (C_WIDTH > 1) generate
		LSBmuxi(0) <= regsout(1);
	end generate;
	LSBmuxi(1) <= intSDIN;
	LSBmuxi(2) <= intD(0);
	LSBmuxi(3) <= intD(0);
	
	MSBmuxi(0) <= intSDIN;
	msbw1: if(C_WIDTH = 1) generate
		MSBmuxi(1) <= 'X';
	end generate;
	msbwgt1: if(C_WIDTH > 1) generate
		MSBmuxi(1) <= regsout(C_WIDTH-2);
	end generate;
	MSBmuxi(2) <= intD(C_WIDTH-1);
	MSBmuxi(3) <= intD(C_WIDTH-1);
	
	mlwgt2 : if (C_WIDTH > 2) generate
		muxloop2 : for i in C_WIDTH-2 downto 1 generate
			shmuxi(i)(0) <= regsout(i+1);
			shmuxi(i)(1) <= regsout(i-1);
			shmuxi(i)(2) <= intD(i);
			shmuxi(i)(3) <= intD(i);
		end generate;
	end generate;
	
	-- Next the control connections to the muxes
	muxc(1) <= intP_LOAD; -- Both MSBs of mux inputs are connected to the parallel D in.
	muxc(0) <= intLSB_2_MSB; -- The LSB of the mux inputs are connected to shift from MSB to LSB

	-- Finally the connections to the outputs
	q1 : if (C_HAS_Q = 1) generate
		intQ <= regsout;
	end generate;
	q0 : if not(C_HAS_Q = 1) generate
		intQ <= (others => 'X');
	end generate;
	
	sdout1 : if(C_HAS_SDOUT = 1) generate
		sdoutmsb : if(C_SHIFT_TYPE = c_lsb_to_msb or C_SHIFT_TYPE = c_bidirectional) generate
	    	intSDOUT <= regsout(C_WIDTH-1);
		end generate;
		sdoutlsb : if(C_SHIFT_TYPE = c_msb_to_lsb) generate
	    	intSDOUT <= regsout(0);
		end generate;
	end generate;

	sdout0 : if not(C_HAS_SDOUT = 1) generate
		intSDOUT <= 'X';
	end generate;
	
	SDOUT <= intSDOUT;
	
	Q <= intQ;
	
		
end behavioral;
	
	
	
	
	
	
	
	
	
	
	
	
