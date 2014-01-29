-- $Id: c_twos_comp_v5_0.vhd,v 1.17 2008/09/08 20:05:58 akennedy Exp $
--
-- Filename - c_twos_comp_v5_0.vhd
-- Author - Xilinx
-- Creation - 2 Feb 1999
--
-- Description - This file contains the behavior for
--				 the C_TWOS_COMP_V5_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v5_0.all;
Use XilinxCoreLib.prims_utils_v5_0.all;
Use XilinxCoreLib.c_reg_fd_v5_0_comp.all;

-- (A)synchronous 2's complimenter
--

entity C_TWOS_COMP_V5_0 is
	generic(
			 C_WIDTH 		: integer := 16;
			 C_AINIT_VAL 	: string  := ""; 		
			 C_SINIT_VAL 	: string  := ""; 		
			 C_BYPASS_ENABLE: integer := c_override;
			 C_BYPASS_LOW	: integer := 0;
			 C_SYNC_PRIORITY: integer := c_clear; 	
			 C_SYNC_ENABLE 	: integer := c_override;
			 C_PIPE_STAGES	: integer := 0;
			 C_HAS_BYPASS	: integer := 0;
			 C_HAS_CE 		: integer := 0;
			 C_HAS_ACLR 	: integer := 0;
			 C_HAS_ASET 	: integer := 0;
			 C_HAS_AINIT 	: integer := 0;
			 C_HAS_SCLR 	: integer := 0;
			 C_HAS_SSET 	: integer := 0;
			 C_HAS_SINIT 	: integer := 0;
			 C_HAS_S 		: integer := 0;
			 C_HAS_Q 		: integer := 1;
			 C_ENABLE_RLOCS : integer := 1
			);

    port (A : in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- SIGNED input value!
		  BYPASS : in std_logic := '0'; -- Control of negation : '0' = Negate input
		  CLK : in std_logic := '0'; -- Clock
		  CE : in std_logic := '1'; -- Clock Enable
		  ACLR : in std_logic := '0'; -- Asynch init.
		  ASET : in std_logic := '0'; -- Asynch set.
		  AINIT : in std_logic := '0'; -- Asynch init.
		  SCLR : in std_logic := '0'; -- Synch init.
		  SSET : in std_logic := '0'; -- Synch set.		  
		  SINIT : in std_logic := '0'; -- Synch init.
		  S : out std_logic_vector(C_WIDTH downto 0); -- Asynch output
		  Q : out std_logic_vector(C_WIDTH downto 0)); -- Registered output value
		  	
end C_TWOS_COMP_V5_0;

architecture behavioral of C_TWOS_COMP_V5_0 is

	constant timeunit : time := 1 ns;

	-- signals for optional pins...
	signal intBYPASS : std_logic;
	signal intCE : std_logic;
	signal intQCE : std_logic;
	signal intS : std_logic_vector(C_WIDTH downto 0);
	signal intQ : std_logic_vector(C_WIDTH downto 0);	

	-- pipelining signal
	signal intQpipeend : std_logic_vector(C_WIDTH downto 0);
	type pipetype is array (C_PIPE_STAGES+2 downto 0) of std_logic_vector(C_WIDTH downto 0);
	signal intQpipe : pipetype := (others => (others => '0'));

begin

	ce1: if C_HAS_CE = 1 generate
		intCE <= CE;
	end generate;
	ce0: if not (C_HAS_CE = 1) generate
		intCE <= '1';
	end generate;
		
	bypass1: if C_HAS_BYPASS = 1 generate
		byp0 : if C_BYPASS_LOW = 1 generate
			intBYPASS <= not BYPASS;
		end generate;
		byp1 : if C_BYPASS_LOW = 0 generate
				intBYPASS <= BYPASS;
		end generate;
	end generate;
	bypass0: if not (C_HAS_BYPASS = 1) generate
		intBYPASS <= '0';
	end generate;

	qce1: if C_HAS_CE = 1 generate
		byp1 : if C_HAS_BYPASS = 1 generate
			bypov0 : if C_BYPASS_ENABLE = c_override generate
				intQCE <= CE or intBYPASS;
			end generate;
			bypov1 : if C_BYPASS_ENABLE = c_no_override generate
				intQCE <= CE;
			end generate;
		end generate;
		byp0 : if C_HAS_BYPASS = 0 generate
			intQCE <= CE;
		end generate;
	end generate;
	qce0 : if C_HAS_CE = 0 generate
		intQCE <= '1';
	end generate;
	
	p1 : process
		variable tmpS : unsigned(C_WIDTH downto 0);
		variable Aone : unsigned(C_WIDTH downto 0) := (others => '0');
	begin
	    Aone(0) := '1';
		if intBYPASS = '1' then
			intS(C_WIDTH-1 downto 0) <= A after timeunit;
			intS(C_WIDTH) <= A(C_WIDTH-1) after timeunit;
		elsif intBYPASS = 'X' or is_X(A) then
			intS <= (others => 'X') after timeunit;
		else -- intBYPASS = 0
			tmpS := unsigned(not(A(C_WIDTH-1) & A)) + Aone;
			intS <= std_logic_vector(tmpS) after timeunit;
		end if;
		
		wait on A, intBYPASS;		 	
	end process; 
	
	s1: if C_HAS_S = 1 generate
		S <= intS;
	end generate;
	s0: if not (C_HAS_S = 1) generate
		S <= (others => 'X');
	end generate;
	
	qreg1 : if C_HAS_Q = 1 generate
		reg1 : c_reg_fd_v5_0 generic map (C_WIDTH => C_WIDTH+1,
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
							port map(D => intQpipeend,
									 CLK => CLK,
									 CE => intQCE,
									 ACLR => ACLR,
									 SCLR => SCLR,
									 ASET => ASET,
									 SSET => SSET,
									 AINIT => AINIT,
									 SINIT => SINIT,
									 Q => intQ);
	end generate;

	pipeq : process (CLK)
	begin
		
		if intCE = '1' and CLK = '1' and CLK'last_value /= 'X' and C_PIPE_STAGES > 1 then
			pipeloop : for p in 2 to C_PIPE_STAGES-1 loop
				intQpipe(p) <= intQpipe(p+1);
			end loop; -- pipeloop
			intQpipe(C_PIPE_STAGES) <= intS;
		elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_PIPE_STAGES > 1 then
			pipeloopx : for p in 2 to C_PIPE_STAGES-1 loop
				pipeloopxinner : for p1 in 0 to C_WIDTH-1 loop
					if intQpipe(p)(p1) /= intQpipe(p+1)(p1) then
						intQpipe(p)(p1) <= 'X';
					end if;
				end loop; -- pipeloopxinner
			end loop; -- pipeloopx
			pipeloopxlast : for p1 in 0 to C_WIDTH-1 loop
				if intQpipe(C_PIPE_STAGES)(p1) /= intS(p1) then
					intQpipe(C_PIPE_STAGES)(p1) <= 'X';	
				end if;		
			end loop; -- pipeloopxlast
		end if;
		
	end process; -- pipeq
	
	ps1 : if C_PIPE_STAGES < 2 generate
		intQpipeend <= intS;
	end generate;
	ps1b : if C_PIPE_STAGES > 1 generate
		intQpipeend <= intQpipe(2);
	end generate;
	
	q1 : if C_HAS_Q = 1 generate
		Q <= intQ;
	end generate;
	q0 : if not (C_HAS_Q = 1) generate
		Q <= (others => 'X');
	end generate;
	
end behavioral;
