-- $Id: c_addsub_v4_0.vhd,v 1.10 2008/09/08 20:05:47 akennedy Exp $
--
-- Filename - c_addsub_v4_0.vhd
-- Author - Xilinx
-- Creation - 27 Oct 1998
--
-- Description - This file contains the behavior for
--				 the C_ADDSUB_V4_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v4_0.all;
Use XilinxCoreLib.prims_utils_v4_0.all;
Use XilinxCoreLib.c_reg_fd_v4_0_comp.all;

-- (A)Synchronous Adder/Subtractor
--

entity C_ADDSUB_V4_0 is
	generic (C_A_WIDTH  	   	: integer := 16; 				   
			 C_B_WIDTH  	   	: integer := 16; 				   
			 C_OUT_WIDTH   		: integer := 16;
			 C_LOW_BIT  	   	: integer := 0;  				   
			 C_HIGH_BIT    		: integer := 15;
			 C_ADD_MODE    		: integer := c_add; 
			 C_A_TYPE	   		: integer := c_unsigned; 
			 C_B_TYPE	   		: integer := c_unsigned; 
			 C_B_CONSTANT  		: integer := 0;  				   
			 C_B_VALUE  	   	: string  := ""; 
			 C_AINIT_VAL   		: string  := ""; 
			 C_SINIT_VAL   		: string  := ""; 
			 C_BYPASS_ENABLE	: integer := c_override;   
			 C_BYPASS_LOW  		: integer := 0; 
			 C_SYNC_ENABLE     	: integer := c_override; 	   
			 C_SYNC_PRIORITY	: integer := c_clear;
             C_PIPE_STAGES		: integer := 1;   
			 C_LATENCY 			: integer := 1;
			 C_HAS_S	   		: integer := 0;
			 C_HAS_Q	   		: integer := 1;
			 C_HAS_C_IN 		: integer := 1;
			 C_HAS_C_OUT 		: integer := 0;
			 C_HAS_Q_C_OUT 		: integer := 0;
			 C_HAS_B_IN 		: integer := 1;
			 C_HAS_B_OUT 		: integer := 0;
			 C_HAS_Q_B_OUT 		: integer := 0;
			 C_HAS_OVFL 		: integer := 0;
			 C_HAS_Q_OVFL 		: integer := 0;
			 C_HAS_CE 			: integer := 0;
			 C_HAS_ADD 			: integer := 0;
			 C_HAS_BYPASS 		: integer := 0;
			 C_HAS_A_SIGNED 	: integer := 0;
			 C_HAS_B_SIGNED 	: integer := 0;
			 C_HAS_ACLR 		: integer := 0;
			 C_HAS_ASET 		: integer := 0;
			 C_HAS_AINIT 		: integer := 0;
			 C_HAS_SCLR 		: integer := 0;
			 C_HAS_SSET 		: integer := 0;
			 C_HAS_SINIT 		: integer := 0;
			 C_ENABLE_RLOCS 	: integer := 1
			 ); 

    port (A : in std_logic_vector(C_A_WIDTH-1 downto 0) := (others => '0'); -- Input value
		  B : in std_logic_vector(C_B_WIDTH-1 downto 0) := (others => '0'); -- Input value
		  CLK : in std_logic := '0'; -- Clock
		  ADD : in std_logic := '1'; -- Valid when addsub mode selected. 1 = add, 0 = subtract
		  C_IN : in std_logic := '0'; -- Carry in
		  B_IN : in std_logic := '1'; -- Borrow in
		  CE : in std_logic := '1'; -- Clock Enable
		  BYPASS : in std_logic := '0'; -- Sync load of B into reg
		  ACLR : in std_logic := '0'; -- Asynch init.
		  ASET : in std_logic := '0'; -- Asynch set.
		  AINIT : in std_logic := '0'; -- Asynch init.
		  SCLR : in std_logic := '0'; -- Synch init.
		  SSET : in std_logic := '0'; -- Synch set.
		  SINIT : in std_logic := '0'; -- Synch init.
		  A_SIGNED : in std_logic := '0'; -- '0' = unsigned, '1' = signed.
		  B_SIGNED : in std_logic := '0'; -- '0' = unsigned, '1' = signed.
		  OVFL : out std_logic;
		  C_OUT : out std_logic;
		  B_OUT : out std_logic; -- Borrow out
		  Q_OVFL : out std_logic;
		  Q_C_OUT : out std_logic;
		  Q_B_OUT : out std_logic;
		  S : out std_logic_vector(C_HIGH_BIT downto C_LOW_BIT); -- Asynch Output value
		  Q : out std_logic_vector(C_HIGH_BIT downto C_LOW_BIT)); -- Synch Output value
end C_ADDSUB_V4_0;

architecture behavioral of C_ADDSUB_V4_0 is

	constant timeunit : time := 1 ns;

	-- signals for optional pins...
	signal intS : std_logic_vector(C_HIGH_BIT downto C_LOW_BIT) := (others => 'X');
	signal intQ : std_logic_vector(C_HIGH_BIT downto C_LOW_BIT) := (others => 'X');
	signal intBconst : std_logic_vector(C_B_WIDTH-1 downto 0) := (others => 'X');
	signal intB : std_logic_vector(C_B_WIDTH-1 downto 0) := (others => 'X');
	signal intCE : std_logic := '1';
	signal intQCE : std_logic := '1';
	signal intADD : std_logic := '0';
	signal intBYPASS : std_logic := '0';
	signal intC_IN : std_logic := '0';
	signal intB_IN : std_logic := '1';
	signal intC_OUT : std_logic := '0';
	signal intB_OUT : std_logic := '1';
	signal intOVFL : std_logic := '0';
	signal intQ_C_OUT : std_logic := '0';
	signal intQ_B_OUT : std_logic := '1';
	signal intQ_OVFL : std_logic := '0';
	signal intA_SIGNED : std_logic := '0';
	signal intB_SIGNED : std_logic := '0';
	
	-- pipelining signals
	signal intQpipeend : std_logic_vector(C_HIGH_BIT downto C_LOW_BIT);
	type pipetype is array (C_LATENCY+2 downto 0) of std_logic_vector(C_HIGH_BIT-C_LOW_BIT downto 0);
	signal intQpipe : pipetype := (others => (others => 'X'));
	signal intQ_C_OUTpipe : std_logic_vector(C_LATENCY+2 downto 0) := (others => 'X');
	signal intQ_C_OUTpipeend : std_logic := '0';
	signal intQ_B_OUTpipe : std_logic_vector(C_LATENCY+2 downto 0) := (others => 'X');
	signal intQ_B_OUTpipeend : std_logic := '1';
	signal intQ_OVFLpipe : std_logic_vector(C_LATENCY+2 downto 0) := (others => 'X');
	signal intQ_OVFLpipeend : std_logic := '0';
    signal lastADD : std_logic := 'X';
	
	signal intACLR, intASET, intAINIT : std_logic := '0';
	signal intSCLR, intSSET, intSINIT : std_logic := '0';
	signal intACLR_INIT : std_logic := '0';
	signal intSCLR_INIT : std_logic := '0';

	function max(x, y : INTEGER) return integer is
	begin
		if x > y then
			return x;
		else
			return y;
		end if;
	end max;

begin

	ac1: if C_HAS_ACLR = 1 generate
		intACLR <= ACLR;
	end generate;
	ac0: if C_HAS_ACLR = 0 generate
		intACLR <= '0';
	end generate;

	as1: if C_HAS_ASET = 1 generate
		intASET <= ASET;
	end generate;
	as0: if C_HAS_ASET = 0 generate
		intASET <= '0';
	end generate;

	ai1: if C_HAS_AINIT = 1 generate
		intAINIT <= AINIT;
	end generate;
	ai0: if C_HAS_AINIT = 0 generate
		intAINIT <= '0';
	end generate;

	sc1: if C_HAS_SCLR = 1 generate
		intSCLR <= SCLR;
	end generate;
	sc0: if C_HAS_SCLR = 0 generate
		intSCLR <= '0';
	end generate;

	ss1: if C_HAS_SSET = 1 generate
		intSSET <= SSET;
	end generate;
	ss0: if C_HAS_SSET = 0 generate
		intSSET <= '0';
	end generate;

	si1: if C_HAS_SINIT = 1 generate
		intSINIT <= SINIT;
	end generate;
	si0: if C_HAS_SINIT = 0 generate
		intSINIT <= '0';
	end generate;

	ce1: if C_HAS_CE = 1 generate
		intCE <= CE;
	end generate;
	ce0: if not (C_HAS_CE = 1) generate
		intCE <= '1';
	end generate;
		
	asig1: if C_HAS_A_SIGNED = 1 generate
		intA_SIGNED <= A_SIGNED;
	end generate;
	asig0: if not (C_HAS_A_SIGNED = 1) generate
		intA_SIGNED <= '0';
	end generate;
	
	bsig1: if C_HAS_B_SIGNED = 1 generate
		intB_SIGNED <= B_SIGNED;
	end generate;
	bsig0: if not (C_HAS_B_SIGNED = 1) generate
		intB_SIGNED <= '0';
	end generate;
	
	b1: if C_B_CONSTANT = 1 generate
		intBconst <= str_to_slv_0(C_B_VALUE, C_B_WIDTH);
	end generate;
	b0: if not (C_B_CONSTANT = 1) generate
		intBconst <= B;
	end generate;
	
	ad1: if C_HAS_ADD = 1 generate -- add_sub mode implied!
		intADD <= ADD;
	end generate;
	ad0: if not (C_HAS_ADD = 1) generate
		ad00 : if C_ADD_MODE = c_add generate
			intADD <= '1';
		end generate;
		ad01 : if C_ADD_MODE = c_sub generate
			intADD <= '0';
		end generate;
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
	
	cin1: if C_HAS_C_IN = 1 generate
		intC_IN <= C_IN;
	end generate;
	cin0: if not (C_HAS_C_IN = 1) generate
		cin0_addsub : if (C_HAS_ADD = 1) generate -- add_sub mode!
			intC_IN <= not intADD;
		end generate;
		cin0_add_or_sub : if not (C_HAS_ADD = 1) generate
			intC_IN <= '0';
		end generate;
	end generate;
	
	bin1: if C_HAS_B_IN = 1 generate
		intB_IN <= B_IN;
	end generate;
	bin0: if not (C_HAS_B_IN = 1) generate
		intB_IN <= '1';
	end generate;
	
	p1 : process(A, B, intBconst, intB, intADD, intBYPASS, intC_IN, intB_IN, intA_SIGNED, intB_SIGNED, intACLR, intASET, intAINIT, intSCLR, intSSET, intSINIT)
	
		variable tmpWidth : integer := max(A'length, intB'length) + 2;
		variable tmpA : std_logic_vector(tmpWidth - 1 downto 0);
		variable tmpB : std_logic_vector(tmpWidth - 1 downto 0);
		variable tmpC : std_logic_vector(tmpWidth - 1 downto 0);
		variable tmpBC : std_logic_vector(tmpWidth - 1 downto 0);
		variable tmpABC : std_logic_vector(tmpWidth - 1 downto 0);
		variable tmpD : std_logic_vector(tmpWidth - 2 downto 0);
		variable tmpE : std_logic_vector(tmpWidth - 2 downto 0);
		variable tmpF : std_logic_vector(tmpWidth - 2 downto 0);
		
	
	begin
	
		if intBYPASS = '1' then
			intB <= B;
		else
			intB <= intBconst;
		end if;
		
		intACLR_INIT <= intACLR or intAINIT;
		intSCLR_INIT <= intSCLR or intSINIT;
		
		tmpC := (others => '0');
		
		if intC_IN /= '0' then -- Active high carry in to an adder?
			if ((C_ADD_MODE = c_add_sub and intADD = '1') or C_ADD_MODE = c_add) then
				tmpC := (others => '0');
				tmpC(0) := intC_IN;
			end if;
		elsif intC_IN /= '1' and C_ADD_MODE = c_add_sub and intADD = '0' then -- Active low borrow in to a subtractor?
			tmpC := (others => '0');
			tmpC(0) := not intC_IN;
		elsif intB_IN /= '1' and C_ADD_MODE = c_sub then -- Subtractor with active low borrow
			tmpC := (others => '0');
			tmpC(0) := not intB_IN;
		end if;
		
		-- Set up the internal (variable) signals to be signed versions of
		-- the inputs. This allows simpler use of the addition functions
		
		if C_A_TYPE = c_signed or (C_A_TYPE = c_pin and intA_SIGNED = '1') then -- Sign extend tmpA
			l1 : for i in tmpA'length - 1 downto A'length loop
				tmpA(i) := A(A'length-1);
			end loop; -- l1
		elsif C_A_TYPE = c_unsigned or (C_A_TYPE = c_pin and intA_SIGNED = '0') then -- pad with zeros
			l2 : for i in tmpA'length - 1 downto A'length loop
				tmpA(i) := '0';
			end loop; -- l1
		elsif C_A_TYPE = c_pin and intA_SIGNED = 'X' then -- pad with zeros
			l2a : for i in tmpA'length - 1 downto A'length loop
				tmpA(i) := 'X';
			end loop; -- l1
		end if;
		
		tmpA(A'length-1 downto 0) := A;
		
		if C_B_TYPE = c_signed or (C_B_TYPE = c_pin and intB_SIGNED = '1') then -- Sign extend tmpB
			l3 : for i in tmpB'length - 1 downto intB'length loop
				tmpB(i) := intB(intB'length-1);
			end loop; -- l3
		elsif C_B_TYPE = c_unsigned or (C_B_TYPE = c_pin and intB_SIGNED = '0') then -- pad with zeros
			l4 : for i in tmpB'length - 1 downto intB'length loop
				tmpB(i) := '0';
			end loop; -- l4
		elsif C_B_TYPE = c_pin and intB_SIGNED = 'X' then -- pad with zeros
			l4a : for i in tmpB'length - 1 downto intB'length loop
				tmpB(i) := 'X';
			end loop; -- l4
		end if;

		tmpB(intB'length-1 downto 0) := intB;
		
		
		-- Examine the BYPASS signal and the inputs for 'X's, 
		-- before doing the addition/subtraction as required.
		if intBYPASS = '1' then
			intS <= tmpB(C_HIGH_BIT downto C_LOW_BIT) after timeunit;
            if is_X(tmpB) and C_LATENCY > 1 then
            	intC_OUT <= 'X';
                intB_OUT <= 'X';
                intOVFL <= 'X';
            else
				intC_OUT <= '0';
				intB_OUT <= '0';
				intOVFL <= '0';
            end if;
		elsif is_X(tmpA) or is_X(tmpB) or is_X(intADD) 
				or is_X(intBYPASS) or is_X(tmpC) then
			intS <= (others => 'X') after timeunit;
			intC_OUT <= 'X';
			intB_OUT <= 'X';
			intOVFL <= 'X';
		else
			-- Handle Carry In here by adding the carry to the tmpB value.
			if (C_ADD_MODE = c_add_sub and intADD = '1') or
					C_ADD_MODE = c_add then
				tmpBC := std_logic_vector( signed(tmpB) + signed(tmpC) );
			elsif (C_ADD_MODE = c_add_sub and intADD = '0') or
					C_ADD_MODE = c_sub then
				tmpBC := std_logic_vector( signed(tmpB) + signed(tmpC) );
			end if;
			
			if (C_ADD_MODE = c_add_sub and intADD = '1')
					or C_ADD_MODE = c_add then
				tmpABC := std_logic_vector( signed(tmpA) + signed(tmpBC) );
			elsif (C_ADD_MODE = c_add_sub and intADD = '0')
					or C_ADD_MODE = c_sub then
				tmpABC := std_logic_vector( signed(tmpA) - signed(tmpBC) );
			end if;

			intS <= tmpABC(C_HIGH_BIT downto C_LOW_BIT) after timeunit;

			if C_HAS_C_OUT = 1 or C_HAS_Q_C_OUT = 1 then -- No extra output bit, but there IS a c_out pin
				if (C_ADD_MODE = c_add_sub and intADD = '1') or
						C_ADD_MODE = c_add then
					intC_OUT <= tmpABC(tmpWidth-2) after timeunit;
				elsif (C_ADD_MODE = c_add_sub and intADD = '0') then
					intC_OUT <= not tmpABC(tmpWidth-2) after timeunit;
				end if;
			end if;
			
			if C_HAS_B_OUT = 1 or C_HAS_Q_B_OUT = 1 then
				intB_OUT <= not tmpABC(tmpWidth-2) after timeunit;
			end if;
			
			if C_HAS_OVFL = 1 or C_HAS_Q_OVFL = 1 then
			-- We need to get hold of the carry into the final bit
			-- and xor it with the carry OUT of the final bit.
				tmpD(tmpWidth-3 downto 0) := tmpA(tmpWidth-3 downto 0);
				if(C_A_TYPE = c_signed) or (C_A_TYPE = c_pin and intA_SIGNED = '1') then
					tmpD(tmpWidth-2) := tmpA(tmpWidth-1);
				else
					tmpD(tmpWidth-2) := '0';
				end if;
				tmpE(tmpWidth-3 downto 0) := tmpBC(tmpWidth-3 downto 0);
				if(C_B_TYPE = c_signed) or (C_B_TYPE = c_pin and intB_SIGNED = '1') then
					tmpE(tmpWidth-2) := tmpBC(tmpWidth-1);
				else
					tmpE(tmpWidth-2) := '0';
				end if;
				if (C_ADD_MODE = c_add_sub and intADD = '1')
						or C_ADD_MODE = c_add then
					tmpF := std_logic_vector( signed(tmpD) + signed(tmpE) );
				elsif (C_ADD_MODE = c_add_sub and intADD = '0')
						or C_ADD_MODE = c_sub then
					tmpF := std_logic_vector( signed(tmpD) - signed(tmpE) );
				end if;
				-- Now xor the carry out from tmpF
				intOVFL <= tmpF(tmpWidth-3) xor tmpABC(tmpWidth-2) after timeunit;
			end if;
			
		end if;
	
	
	end process; -- p1
	
	g1: if C_HAS_Q = 1 generate -- Need a register on the output
		opreg : c_reg_fd_v4_0 generic map(C_WIDTH => (C_HIGH_BIT-C_LOW_BIT)+1,
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
	
   	ha1 : process(CLK)
    begin
    	if intCE = '1' and CLK = '1' and CLK'last_value = '0' then
        	lastADD <= intADD;
        end if;
    end process; -- ha1

	pipeq : process (CLK)
	begin
		if intCE = '1' and CLK = '1' and CLK'last_value = '0' and C_LATENCY > 1 then
        	if lastADD = intADD then
				pipeloop : for p in 2 to C_LATENCY-1 loop
					intQpipe(p) <= intQpipe(p+1);
				end loop; -- pipeloop
            else
            	pipeloopaddx : for p in 2 to C_LATENCY-1 loop
                	intQpipe(p) <= (others => 'X');
                end loop; -- pipeloopaddx
            end if;
			intQpipe(C_LATENCY) <= intS;
		elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_LATENCY > 1 then
			pipeloopx : for p in 2 to C_LATENCY-1 loop
				pipeloopxinner : for p1 in 0 to C_HIGH_BIT-C_LOW_BIT loop
					if intQpipe(p)(p1) /= intQpipe(p+1)(p1) then
						intQpipe(p)(p1) <= 'X';
					end if;
				end loop; -- pipeloopxinner
			end loop; -- pipeloopx
			pipeloopxlast : for p1 in 0 to C_HIGH_BIT-C_LOW_BIT loop
				if intQpipe(C_LATENCY)(p1) /= intS(p1) then
					intQpipe(C_LATENCY)(p1) <= 'X';	
				end if;		
			end loop; -- pipeloopxlast
		end if;
	end process; -- pipeq
	
	ps1 : if C_LATENCY < 2 generate
		intQpipeend <= intS;
	end generate;
	ps1b : if C_LATENCY > 1 generate
    	pipeqtox: process(intADD, lastADD, intQpipe(2))
        begin
        	if (intADD = lastADD) then
            	intQpipeend <= intQpipe(2);
            else
            	intQpipeend <= (others => 'X');
            end if;
        end process; -- pipeqtox
	end generate;
    
	
	q1 : if C_HAS_Q = 1 generate
		Q <= intQ;
	end generate;
	q0 : if not (C_HAS_Q = 1) generate
		Q <= (others => 'X');
	end generate;
	
	s0: if not (C_HAS_S = 1) generate
		S <= (others => 'X');
	end generate;
	s1: if C_HAS_S = 1 generate
		S <= intS;
	end generate;
	
	g2a1 : if C_HAS_Q_C_OUT = 1 generate
		coutreg : c_reg_fd_v4_0 generic map(C_WIDTH => 1,
									 C_AINIT_VAL => "0",
									 C_SINIT_VAL => "0",
									 C_SYNC_PRIORITY => C_SYNC_PRIORITY,
							    	 C_SYNC_ENABLE => C_SYNC_ENABLE,
									 C_HAS_CE => C_HAS_CE,
									 C_HAS_ACLR => C_HAS_ACLR,
									 C_HAS_SCLR => C_HAS_SCLR,
									 C_HAS_ASET => C_HAS_ASET,
									 C_HAS_SSET => C_HAS_SSET,
									 C_HAS_AINIT => C_HAS_AINIT,
									 C_HAS_SINIT => C_HAS_SINIT,
									 C_ENABLE_RLOCS => C_ENABLE_RLOCS)
							port map(D(0) => intQ_C_OUTpipeend,
									 CLK => CLK,
									 CE => intQCE,
									 ACLR => intACLR_INIT,
									 SCLR => intSCLR_INIT,
									 AINIT => AINIT,
									 SINIT => SINIT,
									 ASET => ASET,
									 SSET => SSET,
									 Q(0) => intQ_C_OUT);
									 
	end generate;
	pipeq_c_out : process (CLK)
	begin
		if intCE = '1' and CLK = '1' and CLK'last_value = '0' and C_LATENCY > 1 then
        	if lastADD = intADD then
				pipeloop : for p in 2 to C_LATENCY-1 loop
					intQ_C_OUTpipe(p) <= intQ_C_OUTpipe(p+1);
				end loop; -- pipeloop
            else
            	pipeloopaddx : for p in 2 to C_LATENCY-1 loop
                	intQ_C_OUTpipe(p) <= 'X';
                end loop;
            end if;
			intQ_C_OUTpipe(C_LATENCY) <= intC_OUT;
		elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_LATENCY > 1 then
			pipeloopx : for p in 2 to C_LATENCY-1 loop
				if intQ_C_OUTpipe(p) /= intQ_C_OUTpipe(p+1) then
					intQ_C_OUTpipe(p) <= 'X';
				end if;
			end loop; -- pipeloopx
			if intQ_C_OUTpipe(C_LATENCY) /= intC_OUT then
				intQ_C_OUTpipe(C_LATENCY) <= 'X';	
			end if;		
		end if;
	end process; -- pipeq_c_out
	
	ps2 : if C_LATENCY < 2 generate
		intQ_C_OUTpipeend <= intC_OUT;
	end generate;
	ps2b : if C_LATENCY > 1 generate
    	pipeqctox: process(intADD, lastADD, intQ_C_OUTpipe(2))
        begin
        	if (intADD = lastADD) then
            	intQ_C_OUTpipeend <= intQ_C_OUTpipe(2);
            else
            	intQ_C_OUTpipeend <= 'X';
            end if;
        end process;
	end generate;
	
	qcout1 : if C_HAS_Q_C_OUT = 1 generate
		Q_C_OUT <= intQ_C_OUT;
	end generate;
	qcout0 : if not (C_HAS_Q_C_OUT = 1) generate
		Q_C_OUT <= 'X';
	end generate;
	
	
	g2b1 : if C_HAS_C_OUT = 1 generate
		C_OUT <= intC_OUT;
	end generate;
	g2b0 : if not(C_HAS_C_OUT = 1) generate
		C_OUT <= 'X';
	end generate;

	g3a1 : if C_HAS_Q_OVFL = 1 generate
		coutreg : c_reg_fd_v4_0 generic map(C_WIDTH => 1,
									 C_AINIT_VAL => "0",
									 C_SINIT_VAL => "0",
									 C_SYNC_PRIORITY => C_SYNC_PRIORITY,
							    	 C_SYNC_ENABLE => C_SYNC_ENABLE,
									 C_HAS_CE => C_HAS_CE,
									 C_HAS_ACLR => C_HAS_ACLR,
									 C_HAS_SCLR => C_HAS_SCLR,
									 C_HAS_ASET => C_HAS_ASET,
									 C_HAS_SSET => C_HAS_SSET,
									 C_HAS_AINIT => C_HAS_AINIT,
									 C_HAS_SINIT => C_HAS_SINIT,
									 C_ENABLE_RLOCS => C_ENABLE_RLOCS)
							port map(D(0) => intQ_OVFLpipeend,
									 CLK => CLK,
									 CE => intQCE,
									 ACLR => intACLR_INIT,
									 SCLR => intSCLR_INIT,
									 AINIT => AINIT,
									 SINIT => SINIT,
									 ASET => ASET,
									 SSET => SSET,
									 Q(0) => intQ_OVFL);
									 
	end generate;
	pipeq_ovfl : process (CLK)
	begin
		if intCE = '1' and CLK = '1' and CLK'last_value = '0' and C_LATENCY > 1 then
        	if (intADD = lastADD) then
				pipeloop : for p in 2 to C_LATENCY-1 loop
					intQ_OVFLpipe(p) <= intQ_OVFLpipe(p+1);
				end loop; -- pipeloop
            else
            	pipeloopaddx : for p in 2 to C_LATENCY-1 loop
                	intQ_OVFLpipe(p) <= 'X';
                end loop; -- pipeloopaddx
            end if;
			intQ_OVFLpipe(C_LATENCY) <= intOVFL;
		elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_LATENCY > 1 then
			pipeloopx : for p in 2 to C_LATENCY-1 loop
				if intQ_OVFLpipe(p) /= intQ_OVFLpipe(p+1) then
					intQ_OVFLpipe(p) <= 'X';
				end if;
			end loop; -- pipeloopx
			if intQ_OVFLpipe(C_LATENCY) /= intOVFL then
				intQ_OVFLpipe(C_LATENCY) <= 'X';	
			end if;		
		end if;
	end process; -- pipeq_ovfl
	
	ps3 : if C_LATENCY < 2 generate
		intQ_OVFLpipeend <= intOVFL;
	end generate;
	ps3b : if C_LATENCY > 1 generate
    	pipeqovfltox : process(intADD, lastADD, intQ_OVFLpipe(2))
        begin
        	if (intADD = lastADD) then
            	intQ_OVFLpipeend <= intQ_OVFLpipe(2);
            else
            	intQ_OVFLpipeend <= 'X';
            end if;
        end process;
	end generate;
	
	qovfl1 : if C_HAS_Q_OVFL = 1 generate
		Q_OVFL <= intQ_OVFL;
	end generate;
	qovfl0 : if not (C_HAS_Q_OVFL = 1) generate
		Q_OVFL <= 'X';
	end generate;
	
	g3b1 : if C_HAS_OVFL = 1 generate
		OVFL <= intOVFL;
	end generate;
	g3b0 : if not (C_HAS_OVFL = 1) generate
		OVFL <= 'X';
	end generate;


	g4a1 : if C_HAS_Q_B_OUT = 1 generate
		coutreg : c_reg_fd_v4_0 generic map(C_WIDTH => 1,
									 C_AINIT_VAL => "0",
									 C_SINIT_VAL => "0",
									 C_SYNC_PRIORITY => C_SYNC_PRIORITY,
							    	 C_SYNC_ENABLE => C_SYNC_ENABLE,
									 C_HAS_CE => C_HAS_CE,
									 C_HAS_ACLR => C_HAS_ACLR,
									 C_HAS_SCLR => C_HAS_SCLR,
									 C_HAS_ASET => C_HAS_ASET,
									 C_HAS_SSET => C_HAS_SSET,
									 C_HAS_AINIT => C_HAS_AINIT,
									 C_HAS_SINIT => C_HAS_SINIT,
									 C_ENABLE_RLOCS => C_ENABLE_RLOCS)
							port map(D(0) => intQ_B_OUTpipeend,
									 CLK => CLK,
									 CE => intQCE,
									 ACLR => intACLR_INIT,
									 SCLR => intSCLR_INIT,
									 AINIT => AINIT,
									 SINIT => SINIT,
									 ASET => ASET,
									 SSET => SSET,
									 Q(0) => intQ_B_OUT);
									 
	end generate;
	pipeq_b_out : process (CLK)
	begin
		if intCE = '1' and CLK = '1' and CLK'last_value = '0' and C_LATENCY > 1 then
        	if (intADD = lastADD) then
				pipeloop : for p in 2 to C_LATENCY-1 loop
					intQ_B_OUTpipe(p) <= intQ_B_OUTpipe(p+1);
				end loop; -- pipeloop
            else
            	pipeloopaddx : for p in 2 to C_LATENCY-1 loop
                	intQ_B_OUTpipe(p) <= 'X';
                end loop; -- pipeloopaddx
            end if;
			intQ_B_OUTpipe(C_LATENCY) <= intB_OUT;
		elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_LATENCY > 1 then
			pipeloopx : for p in 2 to C_LATENCY-1 loop
				if intQ_B_OUTpipe(p) /= intQ_B_OUTpipe(p+1) then
					intQ_B_OUTpipe(p) <= 'X';
				end if;
			end loop; -- pipeloopx
			if intQ_B_OUTpipe(C_LATENCY) /= intB_OUT then
				intQ_B_OUTpipe(C_LATENCY) <= 'X';	
			end if;		
		end if;
		
	end process; -- pipeq_b_out
	
	ps4 : if C_LATENCY < 2 generate
		intQ_B_OUTpipeend <= intB_OUT;
	end generate;
	ps4b : if C_LATENCY > 1 generate
    	pipeqbtox : process(intADD, lastADD, intQ_B_OUTpipe(2))
        begin
        	if (intADD = lastADD) then
            	intQ_B_OUTpipeend <= intQ_B_OUTpipe(2);
            else
            	intQ_B_OUTpipeend <= 'X';
            end if;
        end process;
	end generate;
	
	qbout1 : if C_HAS_Q_B_OUT = 1 generate
		Q_B_OUT <= intQ_B_OUT;
	end generate;
	qbout0 : if not (C_HAS_Q_B_OUT = 1) generate
		Q_B_OUT <= 'X';
	end generate;
	
	g4b1 : if C_HAS_B_OUT = 1 generate
		B_OUT <= intB_OUT;
	end generate;
	g4b0 : if not(C_HAS_B_OUT = 1) generate
		B_OUT <= 'X';
	end generate;

	
end behavioral;
	
