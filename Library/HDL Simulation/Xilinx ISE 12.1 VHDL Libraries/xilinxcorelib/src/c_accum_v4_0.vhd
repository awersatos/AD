-- $Id: c_accum_v4_0.vhd,v 1.10 2008/09/08 20:05:47 akennedy Exp $
--
-- Filename - c_accum_v4_0.vhd
-- Author - Xilinx
-- Creation - 24 Mar 1999
--
-- Description - This file contains the behavior for
--				 the C_ACCUM_V4_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v4_0.all;
Use XilinxCoreLib.prims_utils_v4_0.all;
Use XilinxCoreLib.c_addsub_v4_0_comp.all;
Use XilinxCoreLib.c_reg_fd_v4_0_comp.all;

-- (A)Synchronous Accumulator
--

entity C_ACCUM_V4_0 is
	generic (C_B_WIDTH 			: integer := 16; 					
			 C_OUT_WIDTH 		: integer := 16; 					
			 C_LOW_BIT 			: integer := 0; 					
			 C_HIGH_BIT 		: integer := 15;  					
			 C_ADD_MODE 		: integer := c_add; 
			 C_B_TYPE 			: integer := c_unsigned; 
			 C_B_CONSTANT 		: integer := 0; 					
			 C_B_VALUE 			: string  := ""; 			
			 C_SCALE 			: integer := 0; 			
			 C_SATURATE			: integer := 0;
			 C_AINIT_VAL 		: string  := ""; 			
			 C_SINIT_VAL 		: string  := ""; 			
			 C_BYPASS_ENABLE 	: integer := c_override; 
			 C_BYPASS_LOW		: integer := 0;		
			 C_SYNC_ENABLE 		: integer := c_override; 		
			 C_SYNC_PRIORITY 	: integer := c_clear; 
			 C_PIPE_STAGES		: integer := 1;		
			 C_HAS_S 			: integer := 0;
			 C_HAS_C_IN 		: integer := 0;
			 C_HAS_C_OUT 		: integer := 0;
			 C_HAS_Q_C_OUT 		: integer := 0;
			 C_HAS_B_IN 		: integer := 0;
			 C_HAS_B_OUT 		: integer := 0;
			 C_HAS_Q_B_OUT 		: integer := 0;
			 C_HAS_OVFL 		: integer := 0;
			 C_HAS_Q_OVFL 		: integer := 0;
			 C_HAS_CE 			: integer := 0;
			 C_HAS_ADD 			: integer := 0;
			 C_HAS_BYPASS 		: integer := 0;
			 C_HAS_B_SIGNED		: integer := 0;
			 C_HAS_ACLR 		: integer := 0;
			 C_HAS_ASET 		: integer := 0;
			 C_HAS_AINIT 		: integer := 0;
			 C_HAS_SCLR 		: integer := 0;
			 C_HAS_SSET 		: integer := 0;
			 C_HAS_SINIT 		: integer := 0;
			 C_ENABLE_RLOCS		: integer := 1
			 ); 

    port (B : in std_logic_vector(C_B_WIDTH-1 downto 0) := (others => '0'); -- Input value
		  CLK : in std_logic := '0'; -- Clock
		  ADD : in std_logic := '1'; 
		  OVFL : out std_logic;
		  Q_OVFL : out std_logic;
		  C_IN : in std_logic := '0'; -- Carry in
		  C_OUT : out std_logic;
		  Q_C_OUT : out std_logic;
		  B_IN : in std_logic := '0'; -- Borrow in
		  B_OUT : out std_logic;
		  Q_B_OUT : out std_logic;
		  CE : in std_logic := '1'; -- Clock Enable
		  B_SIGNED : in std_logic := '0'; 
		  BYPASS : in std_logic := '0'; -- Sync load of B into reg
		  ACLR : in std_logic := '0'; -- Asynch init.
		  ASET : in std_logic := '0'; -- Asynch set.
		  AINIT : in std_logic := '0'; -- Asynch init.
		  SCLR : in std_logic := '0'; -- Synch init.
		  SSET : in std_logic := '0'; -- Synch set.
		  SINIT : in std_logic := '0'; -- Synch init.
		  S : out std_logic_vector(C_HIGH_BIT downto C_LOW_BIT);
		  Q : out std_logic_vector(C_HIGH_BIT downto C_LOW_BIT)); -- Synch Output value
end C_ACCUM_V4_0;

architecture behavioral of C_ACCUM_V4_0 is

	constant timeunit : time := 1 ns;

	-- signals for optional pins...

	signal intS : std_logic_vector(C_OUT_WIDTH-1 downto 0);
	signal intFB : std_logic_vector(C_OUT_WIDTH-1 downto 0);
	signal intFBq : std_logic_vector(C_OUT_WIDTH-1 downto 0);
	signal intB_SIGNED : std_logic;
	signal intC_OUT : std_logic;
	signal intB_OUT : std_logic;
	signal intSCLR : std_logic;
	signal intSSET : std_logic;
	signal intSCLR_TO_ADDER : std_logic;
	signal intSSET_TO_ADDER : std_logic;
	signal intSCLR_TO_MSB : std_logic;
	signal intSSET_TO_MSB : std_logic;
	signal intSCLR_TO_REST : std_logic;
	signal intSSET_TO_REST : std_logic;
    signal intSCLRbase : std_logic ;
    signal intSSETbase : std_logic ;
    signal intCE : std_logic ;
    signal intB : std_logic ;
	-- pipelining signals
	
	FUNCTION getAType(C_TYPE : integer) RETURN integer IS
    BEGIN
    	IF C_TYPE = c_pin THEN
        	RETURN c_signed;
        ELSE
        	RETURN C_TYPE;
        END IF;
    END getAType;
    
begin

	-- Deal with optional pins...
	bs1: if C_HAS_B_SIGNED = 1 generate
		intB_SIGNED <= B_SIGNED;
	end generate;
	bs0: if not (C_HAS_B_SIGNED = 1) generate
		intB_SIGNED <= '0';
	end generate;
	
	sclr1: if C_HAS_SCLR = 1 generate
		intSCLR <= SCLR;
	end generate;
	sclr0: if not(C_HAS_SCLR = 1) generate
		intSCLR <= '0';
	end generate;
	
	ss1: if C_HAS_SSET = 1 generate
		intSSET <= SSET;
	end generate;
	ss0: if not(C_HAS_SSET = 1) generate
		intSSET <= '0';
	end generate;
	
	-- Deal with the saturation logic. 
	-- The adder ALWAYS has SCLR and SSET inputs and C_OUT and B_OUT outputs.
	-- The correct values must be placed on the inputs depending on the
	-- Saturation setting and the availability of those signals from outside.
	sat0: if not(C_SATURATE = 1) generate
	-- Instanciate an addsub module
		addsub : c_addsub_v4_0 generic map (C_A_WIDTH => C_OUT_WIDTH,
										C_B_WIDTH => C_B_WIDTH,
										C_OUT_WIDTH => C_OUT_WIDTH,
										C_LOW_BIT => 0,
										C_HIGH_BIT => C_OUT_WIDTH-1,
										C_ADD_MODE => C_ADD_MODE,
										C_A_TYPE => getAType(C_B_TYPE),
										C_B_TYPE => C_B_TYPE,
										C_B_CONSTANT => C_B_CONSTANT,
										C_B_VALUE => C_B_VALUE,
										C_AINIT_VAL => C_AINIT_VAL,
										C_SINIT_VAL => C_SINIT_VAL,
										C_BYPASS_ENABLE => C_BYPASS_ENABLE,
										C_BYPASS_LOW => C_BYPASS_LOW,
										C_SYNC_ENABLE => C_SYNC_ENABLE,
										C_SYNC_PRIORITY => C_SYNC_PRIORITY,
										C_PIPE_STAGES => C_PIPE_STAGES,
										C_HAS_S => C_HAS_S,
										C_HAS_Q => 1,
										C_HAS_C_IN => C_HAS_C_IN,
										C_HAS_C_OUT => C_HAS_C_OUT,
										C_HAS_Q_C_OUT => C_HAS_Q_C_OUT,
										C_HAS_B_IN => C_HAS_B_IN,
										C_HAS_B_OUT => C_HAS_B_OUT,
										C_HAS_Q_B_OUT => C_HAS_Q_B_OUT,
										C_HAS_OVFL => C_HAS_OVFL,
										C_HAS_Q_OVFL => C_HAS_Q_OVFL,
										C_HAS_CE => C_HAS_CE,
										C_HAS_ADD => C_HAS_ADD,
										C_HAS_BYPASS => C_HAS_BYPASS,
										C_HAS_A_SIGNED => C_HAS_B_SIGNED,
										C_HAS_B_SIGNED => C_HAS_B_SIGNED,
										C_HAS_ACLR => C_HAS_ACLR,
										C_HAS_ASET => C_HAS_ASET,
										C_HAS_AINIT => C_HAS_AINIT,
										C_HAS_SCLR => C_HAS_SCLR,
										C_HAS_SSET => C_HAS_SSET,
										C_HAS_SINIT => C_HAS_SINIT,
										C_ENABLE_RLOCS => C_ENABLE_RLOCS)
							port map (A => intFB,
									  B => B,
									  CLK => CLK,
									  ADD => ADD,
									  C_IN => C_IN,
									  B_IN => B_IN,
									  CE => CE,
									  BYPASS => BYPASS,
									  ACLR => ACLR,
									  ASET => ASET,
									  AINIT => AINIT,
									  SCLR => SCLR,
									  SSET => SSET,
									  SINIT => SINIT,
									  A_SIGNED => B_SIGNED,
									  B_SIGNED => B_SIGNED,
									  OVFL => OVFL,
									  C_OUT => intC_OUT,
									  B_OUT => intB_OUT,
									  Q_OVFL => Q_OVFL,
									  Q_C_OUT => Q_C_OUT,
									  Q_B_OUT => Q_B_OUT,
									  S => intS,
									  Q => intFBq);
	end generate; -- sat0
	
	sat1: if C_SATURATE = 1 generate -- We DO want saturation logic
		unsinsat1: if C_B_TYPE = c_unsigned and C_ADD_MODE = c_add generate -- Unsigned adder
			sata: if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
				intSSET_TO_ADDER <= intC_OUT;
				intSCLR_TO_ADDER <= intSCLR;
			end generate;
			satb: if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
				intSSET_TO_ADDER <= intC_OUT and not(intSCLR);
				intSCLR_TO_ADDER <= intSCLR;
			end generate;
			satc: if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
				intSSET_TO_ADDER <= intC_OUT or intSSET;
				intSCLR_TO_ADDER <= intSCLR;
			end generate;
			satd: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
				intSSET_TO_ADDER <= not(intSCLR) and (intC_OUT or intSSET);
				intSCLR_TO_ADDER <= intSCLR;
			end generate;
			sate: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
				intSSET_TO_ADDER <= intSSET or (intC_OUT and not(intSCLR));
				intSCLR_TO_ADDER <= intSCLR and not(intSSET);
			end generate;
		end generate; -- unsinsat1
		unsinsat2: if C_B_TYPE = c_unsigned and C_ADD_MODE = c_sub generate -- Unsigned adder
			sata: if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
				intSSET_TO_ADDER <= intSSET;
				intSCLR_TO_ADDER <= not(intB_OUT);
			end generate;
			satb: if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
				intSSET_TO_ADDER <= intSSET;
				intSCLR_TO_ADDER <= not(intB_OUT) or intSCLR;
			end generate;
			satc: if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
				intSSET_TO_ADDER <= intSSET;
				intSCLR_TO_ADDER <= not(intB_OUT) and not(intSSET);
			end generate;
			satd: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
				intSSET_TO_ADDER <= intSSET and not(intSCLR);
				intSCLR_TO_ADDER <= intSCLR or (not(intB_OUT) and not(intSSET)) ;
			end generate;
			sate: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
				intSSET_TO_ADDER <= intSSET;
				intSCLR_TO_ADDER <= (not intSSET) and (intSCLR or not(intB_OUT));
			end generate;
		end generate; -- unsinsat2
		unsinsat3: if C_B_TYPE = c_unsigned and C_ADD_MODE = c_add_sub generate -- Unsigned adder
			sata: if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
				intSSET_TO_ADDER <= intC_OUT and ADD;
				intSCLR_TO_ADDER <= not(intC_OUT) and not(ADD);
			end generate;
			satb: if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
				intSSET_TO_ADDER <= intC_OUT and not(intSCLR) and ADD;
				intSCLR_TO_ADDER <= intSCLR or (not(intC_OUT) and not(ADD));
			end generate;
			satc: if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
				intSSET_TO_ADDER <= (intC_OUT and ADD) or intSSET;
				intSCLR_TO_ADDER <= not(intSSET) and (not(intC_OUT) and not(ADD));
			end generate;
			satd: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
				intSSET_TO_ADDER <= (not(intSCLR) and intC_OUT and ADD) or (intSSET and not(intSCLR));
				intSCLR_TO_ADDER <= intSCLR or (not(intSSET) and not(intC_OUT) and not(ADD));
			end generate;
			sate: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
				intSSET_TO_ADDER <= intSSET or (intC_OUT and ADD and not(intSCLR));
				intSCLR_TO_ADDER <= (intSCLR and not(intSSET)) or (not(intSSET) and not(intC_OUT) and not(ADD));
			end generate;
		end generate; -- unsinsat3
		unsinsatadder: if C_B_TYPE = c_unsigned generate
		-- Instanciate an addsub module
			addsub : c_addsub_v4_0 
						   generic map (C_A_WIDTH => C_OUT_WIDTH,
										C_B_WIDTH => C_B_WIDTH,
										C_OUT_WIDTH => C_OUT_WIDTH,
										C_LOW_BIT => 0,
										C_HIGH_BIT => C_OUT_WIDTH-1,
										C_ADD_MODE => C_ADD_MODE,
										C_A_TYPE => C_B_TYPE,
										C_B_TYPE => C_B_TYPE,
										C_B_CONSTANT => C_B_CONSTANT,
										C_B_VALUE => C_B_VALUE,
										C_AINIT_VAL => "",
										C_SINIT_VAL => "",
										C_BYPASS_ENABLE => C_BYPASS_ENABLE,
										C_BYPASS_LOW => C_BYPASS_LOW,
										C_SYNC_ENABLE => C_SYNC_ENABLE,
										C_SYNC_PRIORITY => C_SYNC_PRIORITY,
										C_PIPE_STAGES => C_PIPE_STAGES,
										C_HAS_S => C_HAS_S,
										C_HAS_Q => 1,
										C_HAS_C_IN => C_HAS_C_IN,
										C_HAS_C_OUT => 1,
										C_HAS_Q_C_OUT => C_HAS_Q_C_OUT,
										C_HAS_B_IN => C_HAS_B_IN,
										C_HAS_B_OUT => 1,
										C_HAS_Q_B_OUT => C_HAS_Q_B_OUT,
										C_HAS_OVFL => C_HAS_OVFL,
										C_HAS_Q_OVFL => C_HAS_Q_OVFL,
										C_HAS_CE => C_HAS_CE,
										C_HAS_ADD => C_HAS_ADD,
										C_HAS_BYPASS => C_HAS_BYPASS,
										C_HAS_A_SIGNED => C_HAS_B_SIGNED,
										C_HAS_B_SIGNED => C_HAS_B_SIGNED,
										C_HAS_ACLR => 0,
										C_HAS_ASET => 0,
										C_HAS_AINIT => 0,
										C_HAS_SCLR => 1,
										C_HAS_SSET => 1,
										C_HAS_SINIT => 0,
										C_ENABLE_RLOCS => C_ENABLE_RLOCS)
							port map (A => intFB,
									  B => B,
									  CLK => CLK,
									  ADD => ADD,
									  C_IN => C_IN,
									  B_IN => B_IN,
									  CE => CE,
									  BYPASS => BYPASS,
									  ACLR => ACLR,
									  ASET => ASET,
									  AINIT => AINIT,
									  SCLR => intSCLR_TO_ADDER,
									  SSET => intSSET_TO_ADDER,
									  SINIT => SINIT,
									  A_SIGNED => B_SIGNED,
									  B_SIGNED => B_SIGNED,
									  OVFL => OVFL,
									  C_OUT => intC_OUT,
									  B_OUT => intB_OUT,
									  Q_OVFL => Q_OVFL,
									  Q_C_OUT => Q_C_OUT,
									  Q_B_OUT => Q_B_OUT,
									  S => intS,
									  Q => intFBq);
		end generate; -- unsinsatadder
		sinsat1: if C_B_TYPE = c_signed or C_B_TYPE = c_pin generate -- signed accum wanted - we need to pull the register out of the adder to get at the 
												 -- MSB register which has different control to the rest
		
			-- Instanciate an addsub module
			addsub : c_addsub_v4_0 generic map (C_A_WIDTH => C_OUT_WIDTH,
										C_B_WIDTH => C_B_WIDTH,
										C_OUT_WIDTH => C_OUT_WIDTH,
										C_LOW_BIT => 0,
										C_HIGH_BIT => C_OUT_WIDTH-1,
										C_ADD_MODE => C_ADD_MODE,
										C_A_TYPE => C_B_TYPE,
										C_B_TYPE => C_B_TYPE,
										C_B_CONSTANT => C_B_CONSTANT,
										C_B_VALUE => C_B_VALUE,
										C_AINIT_VAL => "",
										C_SINIT_VAL => "",
										C_BYPASS_ENABLE => C_BYPASS_ENABLE,
										C_BYPASS_LOW => C_BYPASS_LOW,
										C_SYNC_ENABLE => C_SYNC_ENABLE,
										C_SYNC_PRIORITY => C_SYNC_PRIORITY,
										C_PIPE_STAGES => C_PIPE_STAGES,
										C_HAS_S => 1,
										C_HAS_Q => 0,
										C_HAS_C_IN => C_HAS_C_IN,
										C_HAS_C_OUT => 1,
										C_HAS_Q_C_OUT => C_HAS_Q_C_OUT,
										C_HAS_B_IN => C_HAS_B_IN,
										C_HAS_B_OUT => 1,
										C_HAS_Q_B_OUT => C_HAS_Q_B_OUT,
										C_HAS_OVFL => C_HAS_OVFL,
										C_HAS_Q_OVFL => C_HAS_Q_OVFL,
										C_HAS_CE => C_HAS_CE,
										C_HAS_ADD => C_HAS_ADD,
										C_HAS_BYPASS => C_HAS_BYPASS,
										C_HAS_A_SIGNED => C_HAS_B_SIGNED,
										C_HAS_B_SIGNED => C_HAS_B_SIGNED,
										C_HAS_ACLR => C_HAS_ACLR,
										C_HAS_ASET => C_HAS_ASET,
										C_HAS_AINIT => 0,
										C_HAS_SCLR => C_HAS_SCLR,
										C_HAS_SSET => C_HAS_SSET,
										C_HAS_SINIT => 0,
										C_ENABLE_RLOCS => C_ENABLE_RLOCS)
							port map (A => intFB,
									  B => B,
									  CLK => CLK,
									  ADD => ADD,
									  C_IN => C_IN,
									  B_IN => B_IN,
									  CE => CE,
									  BYPASS => BYPASS,
									  ACLR => ACLR,
									  ASET => ASET,
									  AINIT => AINIT,
									  SCLR => SCLR,
									  SSET => SSET,
									  SINIT => SINIT,
									  A_SIGNED => B_SIGNED,
									  B_SIGNED => B_SIGNED,
									  OVFL => OVFL,
									  C_OUT => intC_OUT,
									  B_OUT => intB_OUT,
									  Q_OVFL => Q_OVFL,
									  Q_C_OUT => Q_C_OUT,
									  Q_B_OUT => Q_B_OUT,
									  S => intS);
	
			-- A single bit register for the MSB
			msb_reg : C_REG_FD_V4_0
					generic map(C_WIDTH => 1,
								C_AINIT_VAL => "",
								C_SINIT_VAL => "",
								C_SYNC_ENABLE => C_SYNC_ENABLE,
								C_SYNC_PRIORITY => C_SYNC_PRIORITY,
								C_HAS_CE => C_HAS_CE,
								C_HAS_ACLR => 0,
								C_HAS_ASET => 0,
								C_HAS_AINIT => 0,
								C_HAS_SCLR => 1,
								C_HAS_SSET => 1,
								C_HAS_SINIT => 0,
								C_ENABLE_RLOCS => C_ENABLE_RLOCS)
						port map(D(0) => intS(C_OUT_WIDTH-1),
								 CLK => CLK,
								 CE => intCE, 
								 ACLR => ACLR,
								 ASET => ASET,
								 AINIT => AINIT,
								 SCLR => intSCLR_TO_MSB,
								 SSET => intSSET_TO_MSB,
								 SINIT => SINIT,
								 Q(0) => intFBq(C_OUT_WIDTH-1));
								 
								 
			-- A register for lower bits
			cbwidthgt1 : if C_B_WIDTH > 1 generate
				rest_reg : C_REG_FD_V4_0
						generic map(C_WIDTH => C_OUT_WIDTH-1,
									C_AINIT_VAL => "",
									C_SINIT_VAL => "",
									C_SYNC_ENABLE => C_SYNC_ENABLE,
									C_SYNC_PRIORITY => C_SYNC_PRIORITY,
									C_HAS_CE => C_HAS_CE,
									C_HAS_ACLR => 0,
									C_HAS_ASET => 0,
									C_HAS_AINIT => 0,
									C_HAS_SCLR => 1,
									C_HAS_SSET => 1,
									C_HAS_SINIT => 0,
									C_ENABLE_RLOCS => C_ENABLE_RLOCS)
							port map(D => intS(C_OUT_WIDTH-2 downto 0),
									 CLK => CLK,
									 CE => intCE, 
									 ACLR => ACLR,
									 ASET => ASET,
									 AINIT => AINIT,
									 SCLR => intSCLR_TO_REST,
									 SSET => intSSET_TO_REST,
									 SINIT => SINIT,
									 Q => intFBq(C_OUT_WIDTH-2 downto 0));
			end generate;

		    s1: if C_B_CONSTANT = 1 generate
				s2:	if C_B_VALUE(1) = '0' generate
					intB <= '0' ;
				end generate ;
				s4: if C_B_VALUE(1) = '1' generate
					intB <= '1' ;
				end generate ;
			end generate ;
			s3: if C_B_CONSTANT = 0 generate
					intB <= B(C_B_WIDTH-1) ;
			end generate ;
			bissigned: if C_B_TYPE = c_signed generate
					satadd: if C_ADD_MODE = c_add generate
						sata: intSCLRbase <= intS(C_HIGH_BIT) and not(intFBq(C_HIGH_BIT)) and not(intB) ;
						satb: intSSETbase <= not(intS(C_HIGH_BIT)) and intFBq(C_HIGH_BIT) and intB ;
					end generate ;
					satsub: if C_ADD_MODE = c_sub generate
						satc: intSCLRbase <= intS(C_HIGH_BIT) and not(intFBq(C_HIGH_BIT)) and intB ;
						satd: intSSETbase <= not(intS(C_HIGH_BIT)) and intFBq(C_HIGH_BIT) and not(intB) ; --was not(intB) ;
					end generate ;
					satads: if C_ADD_MODE = c_add_sub generate
						sate: intSCLRbase <= (not(ADD) and intS(C_HIGH_BIT) and not(intFBq(C_HIGH_BIT)) and intB) or (ADD and intS(C_HIGH_BIT) and not(intFBq(C_HIGH_BIT)) and not(intB)) ;
						satf: intSSETbase <= (not(ADD) and not(intS(C_HIGH_BIT)) and intFBq(C_HIGH_BIT) and not(intB)) or (ADD and not(intS(C_HIGH_BIT)) and intFBq(C_HIGH_BIT) and intB) ;
					end generate ;
			end generate ;
			bispin: if C_B_TYPE = c_pin generate
					satadd: if C_ADD_MODE = c_add generate
						sata: intSCLRbase <= (not(intB_SIGNED) and not(intFBq(C_HIGH_BIT)) and intS(C_HIGH_BIT)) or (intB_SIGNED and not(intFBq(C_HIGH_BIT)) and intS(C_HIGH_BIT) and not(intB)) ;
						satb: intSSETbase <= intB_SIGNED and intFBq(C_HIGH_BIT) and not(intS(C_HIGH_BIT)) and intB ;
					end generate ;
					satsub: if C_ADD_MODE = c_sub generate
						satc: intSCLRbase <= intB_SIGNED and not(intFBq(C_HIGH_BIT)) and intS(C_HIGH_BIT) and intB ;
						satd: intSSETbase <= (not(intB_SIGNED) and intFBq(C_HIGH_BIT) and not(intS(C_HIGH_BIT))) or (intB_SIGNED and intFBq(C_HIGH_BIT) and not(intS(C_HIGH_BIT)) and not(intB)) ;
					end generate ;
					satads: if C_ADD_MODE = c_add_sub generate
						sate: intSCLRbase <= (not(ADD) and intB_SIGNED and not(intFBq(C_HIGH_BIT)) and intS(C_HIGH_BIT) and intB) 
                        				  or (ADD and ((not(intB_SIGNED) and not(intFBq(C_HIGH_BIT)) and intS(C_HIGH_BIT)) 
                                                      or (intB_SIGNED and not(intFBq(C_HIGH_BIT)) and intS(C_HIGH_BIT) and not(intB))));
						satf: intSSETbase <= (not(ADD) and ((not(intB_SIGNED) and intFBq(C_HIGH_BIT) and not(intS(C_HIGH_BIT)))
                        								 or (intB_SIGNED and intFBq(C_HIGH_BIT) and not(intS(C_HIGH_BIT)) and not(intB)))) 
                        				  or (ADD and intB_SIGNED and intFBq(C_HIGH_BIT) and not(intS(C_HIGH_BIT)) and intB) ;
					end generate ;
			end generate ;

			bplow: if (C_HAS_BYPASS = 1) and (C_BYPASS_LOW = 1) generate
   			    byce: if (C_BYPASS_ENABLE = c_no_override) generate
					intCE <= (not BYPASS) or CE ;
				end generate ;
				bycn: if (C_BYPASS_ENABLE /= c_no_override) generate
					intCE <= CE ;
				end generate ;
				satg: if (C_HAS_SSET = 0) and (C_HAS_SCLR = 0) generate
					intSCLR_TO_MSB <= intSCLRbase and BYPASS ;
					intSSET_TO_MSB <= intSSETbase and BYPASS ;
					intSCLR_TO_REST <= intSSET_TO_MSB ;
					intSSET_TO_REST <= intSCLR_TO_MSB ;
				end generate ;
				sath: if (C_HAS_SSET = 0) and (C_HAS_SCLR = 1) generate
					intSCLR_TO_MSB <= (intSCLRbase and BYPASS) or SCLR ;
					intSSET_TO_MSB <= (intSSETbase and BYPASS) and not(SCLR) ;
					intSCLR_TO_REST <= (intSSETbase and BYPASS) or SCLR ;
					intSSET_TO_REST <= (intSCLRbase and BYPASS) and not(SCLR) ;
				end generate ;
				sati: if (C_HAS_SSET = 1) and (C_HAS_SCLR = 0) generate
					intSCLR_TO_MSB <= (intSCLRbase and BYPASS) and not(SSET) ;
					intSSET_TO_MSB <= (intSSETbase and BYPASS) or SSET ;
					intSCLR_TO_REST <= (intSSETbase and BYPASS) and not (SSET) ;
					intSSET_TO_REST <= (intSCLRbase and BYPASS) or SSET ;
				end generate ;
				satj: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
					intSCLR_TO_MSB <= (intSCLRbase and BYPASS) or SCLR ;
					intSSET_TO_MSB <= ((intSSETbase and BYPASS) or SSET) and not(SCLR) ;
					intSCLR_TO_REST <= (intSSETbase and BYPASS) or SCLR ;
					intSSET_TO_REST <= ((intSCLRbase and BYPASS) or SSET) and not(SCLR) ;
				end generate ;
				satk: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
					intSCLR_TO_MSB <= ((intSCLRbase and BYPASS) or SCLR) and not(SSET) ;
					intSSET_TO_MSB <= (intSSETbase and BYPASS) or SSET ;
					intSCLR_TO_REST <= ((intSSETbase and BYPASS) or SCLR) and not(SSET) ;
					intSSET_TO_REST <= (intSCLRbase and BYPASS) or SSET ;
				end generate ;
			end generate ;
			bphigh: if (C_HAS_BYPASS = 1) and (C_BYPASS_LOW = 0) generate
				byce: if (C_BYPASS_ENABLE = c_no_override) generate
					intCE <= BYPASS or CE ;
				end generate ;
				bycn: if (C_BYPASS_ENABLE /= c_no_override) generate
					intCE <= CE ;
				end generate ;
				satl: if (C_HAS_SSET = 0) and (C_HAS_SCLR = 0) generate
					intSCLR_TO_MSB <= intSCLRbase and not(BYPASS) ;
					intSSET_TO_MSB <= intSSETbase and not(BYPASS) ;
					intSCLR_TO_REST <= intSSET_TO_MSB ;
					intSSET_TO_REST <= intSCLR_TO_MSB ;
				end generate ;
				satm: if (C_HAS_SSET = 0) and (C_HAS_SCLR = 1) generate
					intSCLR_TO_MSB <= (intSCLRbase and not(BYPASS)) or SCLR ;
					intSSET_TO_MSB <= (intSSETbase and not(BYPASS)) and not(SCLR) ;
					intSCLR_TO_REST <= (intSSETbase and not(BYPASS)) or SCLR ;
					intSSET_TO_REST <= (intSCLRbase and not(BYPASS)) and not(SCLR) ;
				end generate ;
				satn: if (C_HAS_SSET = 1) and (C_HAS_SCLR = 0) generate
					intSCLR_TO_MSB <= (intSCLRbase and not(BYPASS)) and not(SSET) ;
					intSSET_TO_MSB <= (intSSETbase and not(BYPASS)) or SSET ;
					intSCLR_TO_REST <= (intSSETbase and not(BYPASS)) and not (SSET) ;
					intSSET_TO_REST <= (intSCLRbase and not(BYPASS)) or SSET ;
				end generate ;
				sato: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
					intSCLR_TO_MSB <= (intSCLRbase and not(BYPASS)) or SCLR ;
					intSSET_TO_MSB <= ((intSSETbase and not(BYPASS)) or SSET) and not(SCLR) ;
					intSCLR_TO_REST <= (intSSETbase and not(BYPASS)) or SCLR ;
					intSSET_TO_REST <= ((intSCLRbase and not(BYPASS)) or SSET) and not(SCLR) ;
				end generate ;
				satp: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
					intSCLR_TO_MSB <= ((intSCLRbase and not(BYPASS)) or SCLR) and not(SSET) ;
					intSSET_TO_MSB <= (intSSETbase and not(BYPASS)) or SSET ;
					intSCLR_TO_REST <= ((intSSETbase and not(BYPASS)) or SCLR) and not(SSET) ;
					intSSET_TO_REST <= (intSCLRbase and not(BYPASS)) or SSET ;
				end generate ;
			end generate ;
			bpnot: if (C_HAS_BYPASS = 0) generate
				byce: intCE <= CE ;
				satq: if (C_HAS_SSET = 0) and (C_HAS_SCLR = 0) generate
					intSCLR_TO_MSB <= intSCLRbase ;
					intSSET_TO_MSB <= intSSETbase ;
					intSCLR_TO_REST <= intSSET_TO_MSB ;
					intSSET_TO_REST <= intSCLR_TO_MSB ;
				end generate ;
				satr: if (C_HAS_SSET = 0) and (C_HAS_SCLR = 1) generate
					intSCLR_TO_MSB <= intSCLRbase or SCLR ;
					intSSET_TO_MSB <= intSSETbase and not(SCLR) ;
					intSCLR_TO_REST <= intSSETbase or SCLR ;
					intSSET_TO_REST <= intSCLRbase and not(SCLR) ;
				end generate ;
				sats: if (C_HAS_SSET = 1) and (C_HAS_SCLR = 0) generate
					intSCLR_TO_MSB <= intSCLRbase and not(SSET) ;
					intSSET_TO_MSB <= intSSETbase or SSET ;
					intSCLR_TO_REST <= intSSETbase and not (SSET) ;
					intSSET_TO_REST <= intSCLRbase or SSET ;
				end generate ;
				satt: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
					intSCLR_TO_MSB <= intSCLRbase or SCLR ;
					intSSET_TO_MSB <= (intSSETbase or SSET) and not(SCLR) ;
					intSCLR_TO_REST <= intSSETbase or SCLR ;
					intSSET_TO_REST <= (intSCLRbase or SSET) and not(SCLR) ;
				end generate ;
				satu: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
					intSCLR_TO_MSB <= (intSCLRbase or SCLR) and not(SSET) ;
					intSSET_TO_MSB <= intSSETbase or SSET ;
					intSCLR_TO_REST <= (intSSETbase or SCLR) and not(SSET) ;
					intSSET_TO_REST <= intSCLRbase or SSET ;
				end generate ;
			end generate ;

			-- Now generate the signals to feed to the registers above
--			bplow1: if C_BYPASS_LOW = 1 generate
--				sata: if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
--					intSSET_TO_MSB <= intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)));
--					intSCLR_TO_MSB <= not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)));
--					intSSET_TO_REST <= intSCLR_TO_MSB;
--					intSCLR_TO_REST <= intSSET_TO_MSB;
--				end generate;
--				satb: if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
--					intSSET_TO_MSB <= intSCLR or (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--					intSCLR_TO_MSB <= intSCLR nand (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--					intSSET_TO_REST <= intSCLR or (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--					intSCLR_TO_REST <= intSCLR nand (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--				end generate;
--				satc: if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
--					intSSET_TO_MSB <= intSSET nand (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--					intSCLR_TO_MSB <= intSSET or (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--					intSSET_TO_REST <= intSSET nand (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--					intSCLR_TO_REST <= intSSET or (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--				end generate;
--				satd: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
--					intSSET_TO_MSB <= intSCLR nand (intSSET or (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--					intSCLR_TO_MSB <= intSCLR or (intSSET nand (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--					intSSET_TO_REST <= intSCLR nand (intSSET or (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--					intSCLR_TO_REST <= intSCLR or (intSSET nand (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--				end generate;
--				sate: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
--					intSSET_TO_MSB <= intSSET or (intSCLR nand (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--					intSCLR_TO_MSB <= intSSET nand (intSCLR or (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--					intSSET_TO_REST <= intSSET or (intSCLR nand (not(intFBq(C_B_WIDTH-1)) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--					intSCLR_TO_REST <= intSSET nand (intSCLR or (intFBq(C_B_WIDTH-1) and (BYPASS and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--				end generate;
--			end generate; -- bplow1
--			bplow0: if not(C_BYPASS_LOW = 1) generate
--				sata: if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
--					intSSET_TO_MSB <= intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)));
--					intSCLR_TO_MSB <= not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)));
--					intSSET_TO_REST <= intSCLR_TO_MSB;
--					intSCLR_TO_REST <= intSSET_TO_MSB;
--				end generate;
--				satb: if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
--					intSSET_TO_MSB <= intSCLR or (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--					intSCLR_TO_MSB <= intSCLR nand (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--					intSSET_TO_REST <= intSCLR or (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--					intSCLR_TO_REST <= intSCLR nand (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--				end generate;
--				satc: if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
--					intSSET_TO_MSB <= intSSET nand (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--					intSCLR_TO_MSB <= intSSET or (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--					intSSET_TO_REST <= intSSET nand (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--					intSCLR_TO_REST <= intSSET or (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1))));
--				end generate;
--				satd: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
--					intSSET_TO_MSB <= intSCLR nand (intSSET or (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--					intSCLR_TO_MSB <= intSCLR or (intSSET nand (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--					intSSET_TO_REST <= intSCLR nand (intSSET or (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--					intSCLR_TO_REST <= intSCLR or (intSSET nand (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--				end generate;
--				sate: if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
--					intSSET_TO_MSB <= intSSET or (intSCLR nand (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--					intSCLR_TO_MSB <= intSSET nand (intSCLR or (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--					intSSET_TO_REST <= intSSET or (intSCLR nand (not(intFBq(C_B_WIDTH-1)) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--					intSCLR_TO_REST <= intSSET nand (intSCLR or (intFBq(C_B_WIDTH-1) and (not(BYPASS) and (intFBq(C_B_WIDTH-1) xor intS(C_B_WIDTH-1)))));
--				end generate;
--			end generate; -- bplow0
		end generate; -- sinsat1
	end generate; -- sat1

	-- Feed the asynch output out if necessary
	s1: if C_HAS_S = 1 generate
		S <= intS(C_HIGH_BIT downto C_LOW_BIT);
	end generate;
	s0 : if not (C_HAS_S = 1) generate
		S <= (others => 'X');
	end generate;
	
	co1: if C_HAS_C_OUT = 1 generate
		C_OUT <= intC_OUT;
	end generate;
	co0: if not (C_HAS_C_OUT = 1) generate
		C_OUT <= 'X';
	end generate;
	
	bo1: if C_HAS_B_OUT = 1 generate
		B_OUT <= intB_OUT;
	end generate;
	bo0: if not (C_HAS_B_OUT = 1) generate
		B_OUT <= 'X';
	end generate;
	
									  
	-- Feedback the correct signals, conditioned by C_SCALE
	
	scaling_s: if(C_B_TYPE = c_signed) generate
	 	intFB(C_OUT_WIDTH-1-C_SCALE downto 0) <= intFBq(C_OUT_WIDTH-1 downto C_SCALE);
		scgt0 : if C_SCALE > 0 generate
			intFB(C_OUT_WIDTH-1 downto C_OUT_WIDTH-C_SCALE) <= (others => intFBq(C_OUT_WIDTH-1));
		end generate;
	end generate;
	scaling_u: if(C_B_TYPE = c_unsigned) generate		
		intFB(C_OUT_WIDTH-1-C_SCALE downto 0) <= intFBq(C_OUT_WIDTH-1 downto C_SCALE);
		scgt0 : if C_SCALE > 0 generate
			intFB(C_OUT_WIDTH-1 downto C_OUT_WIDTH-C_SCALE) <= (others => '0');
		end generate;
	end generate;
	scaling_p: if(C_B_TYPE = c_pin) generate
	 	intFB(C_OUT_WIDTH-1-C_SCALE downto 0) <= intFBq(C_OUT_WIDTH-1 downto C_SCALE);
		scgt0 : if C_SCALE > 0 generate
			intFB(C_OUT_WIDTH-1 downto C_OUT_WIDTH-C_SCALE) <= (others => intFBq(C_OUT_WIDTH-1)) ; -- and intB_SIGNED));
		end generate;
	end generate;
	
	Q <= intFBq;
	
end behavioral;
	
