-- $RCSfile: c_lut_v8_0.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:52 $
--------------------------------------------------------------------------------
--  Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
--  This text/file contains proprietary, confidential
--  information of Xilinx, Inc., is distributed under license
--  from Xilinx, Inc., and may be used, copied and/or
--  disclosed only pursuant to the terms of a valid license
--  agreement with Xilinx, Inc.  Xilinx hereby grants you
--  a license to use this text/file solely for design, simulation,
--  implementation and creation of design files limited
--  to Xilinx devices or technologies. Use with non-Xilinx
--  devices or technologies is expressly prohibited and
--  immediately terminates your license unless covered by
--  a separate agreement.
--
--  Xilinx is providing this design, code, or information
--  "as is" solely for use in developing programs and
--  solutions for Xilinx devices.  By providing this design,
--  code, or information as one possible implementation of
--  this feature, application or standard, Xilinx is making no
--  representation that this implementation is free from any
--  claims of infringement.  You are responsible for
--  obtaining any rights you may require for your implementation.
--  Xilinx expressly disclaims any warranty whatsoever with
--  respect to the adequacy of the implementation, including
--  but not limited to any warranties or representations that this
--  implementation is free from claims of infringement, implied
--  warranties of merchantability or fitness for a particular
--  purpose.
--
--  Xilinx products are not intended for use in life support
--  appliances, devices, or systems. Use in such applications are
--  expressly prohibited.
--
--  This copyright and support notice must be retained as part
--  of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 8.0
--  \   \        Filename: c_lut_v8_0.vhd 
--  /   /        
-- /___/   /\    
-- \   \  /  \
--  \___\/\___\
-- 
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

LIBRARY Xilinxcorelib;
USE xilinxcorelib.prims_constants_v8_0.ALL;
USE xilinxcorelib.prims_utils_v8_0.ALL;
USE Xilinxcorelib.pkg_baseblox_v8_0.ALL;

ENTITY c_lut_v8_0 IS
  GENERIC (
    eqn            : STRING  := "I0*I1*I2*I3";  -- Function of the LUT as an equation
    c_init         : INTEGER := 0;  -- Function of the LUT as a decimal integer of the INIT string
    c_enable_rlocs : INTEGER := 0
    );
  PORT(
    i0 : IN  STD_LOGIC;
    i1 : IN  STD_LOGIC := '0';
    i2 : IN  STD_LOGIC := '0';
    i3 : IN  STD_LOGIC := '0';
    o  : OUT STD_LOGIC
    );
END c_lut_v8_0;

ARCHITECTURE behavioral OF c_lut_v8_0 IS

  -- purpose: Verifies valid combinations of generics
  FUNCTION check_generics(equation : STRING; init_val : INTEGER; rlocs : INTEGER) RETURN INTEGER IS
  BEGIN  -- FUNCTION check_generics
    ASSERT equation'length /= 0 REPORT "ERROR: c_lut_v8_0_xst - Empty equation string" SEVERITY failure;
    ASSERT init_val = 0 REPORT "ERROR: c_lut_v8_0_xst - Initialisation by integer is not supported in this version" SEVERITY failure;
    ASSERT rlocs = 0 REPORT "WARNING: c_lut_v8_0_xst - RLOCs are obsolete in BaseBlox v8" SEVERITY warning;
    RETURN 0;
  END FUNCTION check_generics;

  CONSTANT verify_generics : INTEGER RANGE 0 TO 0 := check_generics(eqn, c_init, c_enable_rlocs);
  
  -- Simple check to ensure no invalid chars in equation STRING
  -- Valid for all families
  FUNCTION checkEQN(eqn : STRING; lut_size : INTEGER) RETURN INTEGER IS
    VARIABLE tmpchr : CHARACTER;
  BEGIN
    IF (eqn'length = 0) THEN
      RETURN 0;  -- indicate that eqn is a null string
    END IF;
    char_loop : FOR i IN 1 TO eqn'length LOOP
      tmpchr := eqn(i);
      CASE lut_size IS
        WHEN 4 =>
          CASE tmpchr IS
            WHEN 'i' | 'I' | '0' | '1' | '2' | '3' | '(' | ')' | '~' | '*' | '@' | '+' | ' ' | ht | cr | nul =>
              --null;                     -- these chars are OK -  do nothing
            WHEN OTHERS                                                                                      =>
              ASSERT false REPORT "ERROR: Illegal character in LUT4 equation string" SEVERITY failure;
              ASSERT false REPORT "Character" & tmpchr SEVERITY failure;
              RETURN 0;  -- return a default value to keep compiler happy - never used
          END CASE;
        WHEN OTHERS => ASSERT false REPORT "ERROR: Illegal lut_size_value detected in checkEQN in c_lut_v8_0" SEVERITY failure;
      END CASE;
    END LOOP char_loop;
    RETURN 1;  -- indicate successful completion
  END checkEQN;

  -- purpose: converts an equation from ordinary form
  -- to postfix (reverse Polish) notation
  -- eg postfixeqn("~I0 @ ((I1 + I2) * I3)") = "0~12+3*@"
  FUNCTION postfixeqn(eqn : STRING; lut_size : INTEGER) RETURN STRING IS
    VARIABLE tok     : CHARACTER;
    VARIABLE peektok : CHARACTER;
    VARIABLE prefix  : STRING(1 TO eqn'length+1);
    VARIABLE temp    : STRING(1 TO eqn'length+1);
    VARIABLE postfix : STRING(1 TO eqn'length+1);
    VARIABLE i       : INTEGER := 1;
    VARIABLE prefixi : INTEGER := 0;
    VARIABLE tempi   : INTEGER := 0;
  BEGIN
    cloop : WHILE (i <= eqn'length) LOOP
      tok := eqn(i);
      IF (tok = '(' OR tok = '~') THEN
            tempi             := tempi+1;
            temp(tempi)       := tok;
          ELSIF (tok = 'i' OR tok = 'I') THEN
            i                 := i + 1;
            tok               := eqn(i);
            IF lut_size = 4 THEN
              IF (tok /= '0' AND tok /= '1' AND
                  tok /= '2' AND tok /= '3') THEN
                ASSERT(false)
                  REPORT("c_lut_v8_0 - Missing port number in LUT4 equation : " & eqn)
                  SEVERITY failure;
                RETURN "";
              END IF;
            ELSE
              ASSERT false REPORT "ERROR: c_lut_v8_0 - Illegal value detected for lut_ports in postfixeqn" SEVERITY failure;
            END IF;
            prefixi           := prefixi + 1;
            prefix(prefixi)   := tok;
          ELSIF (tok = '+' OR tok = '@') THEN
            IF tempi > 0 THEN
              peektok         := temp(tempi);
            ELSE
              peektok         := nul;
            END IF;
            WHILE (peektok = '~' OR
                   peektok = '*' OR
                   peektok = '+' OR
                   peektok = '@') LOOP
              prefixi         := prefixi + 1;
              prefix(prefixi) := peektok;
              tempi           := tempi - 1;
              IF tempi > 0 THEN
                peektok       := temp(tempi);
              ELSE
                peektok       := nul;
              END IF;
            END LOOP;
            tempi             := tempi + 1;
            temp(tempi)       := tok;
          ELSIF (tok = '*') THEN
            IF tempi > 0 THEN
              peektok         := temp(tempi);
            ELSE
              peektok         := nul;
            END IF;
            WHILE (peektok = '~' OR
                   peektok = '*') LOOP
              prefixi         := prefixi + 1;
              prefix(prefixi) := peektok;
              tempi           := tempi - 1;
              IF tempi > 0 THEN
                peektok       := temp(tempi);
              ELSE
                peektok       := nul;
              END IF;
            END LOOP;
            tempi             := tempi + 1;
            temp(tempi)       := tok;
          ELSIF (tok = ')') THEN
        IF tempi > 0 THEN
          tok   := temp(tempi);
          tempi := tempi - 1;
        ELSE
          ASSERT false
            REPORT("c_lut_v8_0 - Missing opening parenthesis in LUT equation : " & eqn)
            SEVERITY failure;
          RETURN "";
        END IF;
        while ( tok /= '(' ) loop
                  prefixi         := prefixi + 1;
                  prefix(prefixi) := tok;
                  IF tempi > 0 THEN
                    tok   := temp(tempi);
                    tempi := tempi - 1;
                  ELSE
                    ASSERT(false)
                      REPORT("c_lut_v8_0 - Missing opening parenthesis in LUT equation : " & eqn)
                      SEVERITY failure;
                    RETURN "";
                  END IF;
                  END LOOP;
                  ELSIF (tok /= ' ' AND tok /= ht AND
                         tok /= cr AND tok /= lf AND
                         tok /= nul) THEN
                    ASSERT (false)
                      REPORT("c_lut_v8_0 - Illegal character in Eqn string : " & tok)
                      SEVERITY failure;
                    RETURN "";
                  END IF;
                  i := i + 1;
                  END LOOP cloop;
                  WHILE tempi > 0 LOOP
                    if temp(tempi) = '(' then 
                                         assert false
                                           REPORT("c_lut_v8_0 - Missing closing parenthesis in Eqn : " & eqn )
                                           SEVERITY FAILURE;
                                         RETURN "";
                                       END IF;
                                       prefixi         := prefixi + 1;
                                       prefix(prefixi) := temp(tempi);
                                       tempi           := tempi - 1;
                                       END LOOP;
                                       tempi           := 1;
                                       WHILE tempi     <= prefixi LOOP
                                         postfix(tempi) := prefix(tempi);
                                         tempi          := tempi + 1;
                                       END LOOP;
                                       RETURN postfix;
                                       END postfixeqn;

                                       -- purpose: evaluate a postfix equation using a given truth-value mapping
                                       -- format of addr: 2#dcba# where a = I0, b = I1, c = I2, d = I3
                                       -- eg: evalpfeqn ( "0~12+3*@", 2#1000#) = '1'
                                       FUNCTION evalpfeqn ( pfeqn : STRING; addr : INTEGER; input_ports : integer ) RETURN STD_LOGIC IS
                                         VARIABLE addr_slv : STD_LOGIC_VECTOR( input_ports-1 DOWNTO 0 );
                                         VARIABLE tempchr  : CHARACTER;
                                         VARIABLE i        : INTEGER := 1;
                                         VARIABLE stack    : STD_LOGIC_VECTOR( 1 TO pfeqn'LENGTH );
                                         VARIABLE stacki   : INTEGER := 0;
                                       BEGIN
                                         IF pfeqn = "" THEN
                                           RETURN 'X';
                                         END IF;
                                         addr_slv := STD_LOGIC_VECTOR( to_unsigned( addr, input_ports ));                                             
                                         tempchr  := pfeqn(i);
                                         WHILE i  <= pfeqn'LENGTH AND tempchr /= nul LOOP
                                           CASE tempchr IS
                                             WHEN '0' =>
                                               stacki        := stacki + 1;
                                               stack(stacki) := addr_slv(0);
                                             WHEN '1' =>
                                               stacki        := stacki + 1;
                                               stack(stacki) := addr_slv(1);
                                             WHEN '2' =>
                                               stacki        := stacki + 1;
                                               stack(stacki) := addr_slv(2);
                                             WHEN '3' =>
                                               stacki        := stacki + 1;
                                               stack(stacki) := addr_slv(3);
                                             WHEN '~' =>
                                               IF stacki > 0 THEN
                                                 stack(stacki) := NOT stack(stacki);
                                               ELSE
                                                 ASSERT(false)
                                                   REPORT("Malformed Postfix Eqn at ~ : " & pfeqn)
                                                   SEVERITY failure;
                                                 RETURN 'X';
                                               END IF;
                                             WHEN '*' =>
                                               IF stacki > 1 THEN
                                                 stack(stacki-1) := IEEE.std_logic_1164."and"(stack(stacki-1), stack(stacki));
                                                 stacki          := stacki - 1;
                                               ELSE
                                                 ASSERT(false)
                                                   REPORT("Malformed Postfix Eqn at * : " & pfeqn)
                                                   SEVERITY failure;
                                                 RETURN 'X';
                                               END IF;
                                             WHEN '+' =>
                                               IF stacki > 1 THEN
                                                 stack(stacki-1) := IEEE.std_logic_1164."or"(stack(stacki-1), stack(stacki));
                                                 stacki          := stacki - 1;
                                               ELSE
                                                 ASSERT(false)
                                                   REPORT("Malformed Postfix Eqn at + : " & pfeqn)
                                                   SEVERITY failure;
                                                 RETURN 'X';
                                               END IF;
                                             WHEN '@' =>
                                               IF stacki > 1 THEN
                                                 stack(stacki-1) := IEEE.std_logic_1164."xor"(stack(stacki-1), stack(stacki));
                                                 stacki          := stacki - 1;
                                               ELSE
                                                 ASSERT(false)
                                                   REPORT("Malformed Postfix Eqn at @ : " & pfeqn)
                                                   SEVERITY failure;
                                                 RETURN 'X';
                                               END IF;
                                             WHEN OTHERS =>
                                               ASSERT(false)
                                                 REPORT("Malformed Postfix Eqn at " & tempchr & " : " & pfeqn)
                                                 SEVERITY failure;
                                               RETURN 'X';
                                           END CASE;
                                           i       := i + 1;
                                           tempchr := pfeqn(i);
                                         END LOOP;
                                         IF stacki > 1 THEN
                                           ASSERT (false)
                                             REPORT("Incomplete Postfix Eqn : " & pfeqn)
                                             SEVERITY failure;
                                           RETURN 'X';
                                         ELSIF stack(1) = 'U' THEN
                                           RETURN 'X';
                                         ELSE
                                           RETURN stack(1);
                                         END IF;
                                       END evalpfeqn;

                                       -- purpose: generate an initialisation value to pass to a LUT primitive
                                       -- from a postfix equation
                                       -- eg: pfeqn2init("0~12+3*@") = "1010100101010101"
                                       FUNCTION pfeqn2init (pfeqn : STRING; lut_size : INTEGER) RETURN STD_LOGIC_VECTOR IS
                                         VARIABLE lut_initval : STD_LOGIC_VECTOR((2**lut_size)-1 DOWNTO 0);
                                       BEGIN
                                         FOR i IN 0 TO (2**lut_size)-1 LOOP
                                           lut_initval(i) := evalpfeqn(pfeqn, i, lut_size);
                                         END LOOP;  -- i
                                         RETURN lut_initval;
                                       END pfeqn2init;
                                       
                                       CONSTANT lut_size : INTEGER := 4;

                                       SIGNAL init4sig : STD_LOGIC_VECTOR(15 DOWNTO 0);
                                       SIGNAL once    : STD_LOGIC := '0';

                                       SIGNAL lut_out : STD_LOGIC := '0';

                                       CONSTANT eqn_i : STRING := eqn;
                                       
                                       BEGIN  -- architecture

                                         ASSERT c_init = 0 REPORT "ERROR: c_init generic is not used in version 8 - initialisation by integer is disabled" SEVERITY failure;

                                         gen_fourinput_behv : IF lut_size = 4 GENERATE
                                           one : PROCESS
                                             VARIABLE init4eqn : STD_LOGIC_VECTOR(15 DOWNTO 0);
                                           BEGIN
                                             IF(once = '0') THEN
                                               IF (eqn_i'length = 0) THEN
                                                 ASSERT false REPORT "ERROR: No LUT eqn specified" SEVERITY failure;
                                               ELSE
                                                 ASSERT checkEQN(eqn_i, lut_size) = 1
                                                   REPORT "ERROR: Invalid characters found in eqn string"
                                                   SEVERITY failure;
                                                 init4eqn := pfeqn2init(postfixeqn(eqn_i, lut_size), lut_size);
                                                 ASSERT NOT Is_X(init4eqn)
                                                   SEVERITY failure;
                                                 init4sig <= init4eqn;
                                               END IF;
                                               once <= '1';
                                             END IF;
                                             WAIT;
                                           END PROCESS one;

                                           p : PROCESS
                                             VARIABLE addr_slv            : STD_LOGIC_VECTOR(3 DOWNTO 0);
                                             VARIABLE addr                : INTEGER RANGE 0 TO 15;
                                             VARIABLE poss_addrs0         : STD_LOGIC_VECTOR(0 TO 15) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs1         : STD_LOGIC_VECTOR(0 TO 15) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs2         : STD_LOGIC_VECTOR(0 TO 15) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs3         : STD_LOGIC_VECTOR(0 TO 15) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs_combined : STD_LOGIC_VECTOR(0 TO 15) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE tmpsig              : STD_LOGIC                 := '0';
                                             VARIABLE i, j                : INTEGER;
                                           BEGIN
                                             IF(once = '0') THEN
                                               WAIT ON init4sig;
                                             END IF;
                                             addr_slv := (I3, I2, I1, I0);
                                             IF((I0 /= '1' AND I0 /= '0') OR
                                                (I1 /= '1' AND I1 /= '0') OR
                                                (I2 /= '1' AND I2 /= '0') OR
                                                (I3 /= '1' AND I3 /= '0')) THEN
                                        -- pessimistically, the output should be 'X' but imagine an OR gate with any one input = 1 for example!
                                        -- O <= 'X' after 1 ns;

                                        -- Realistic solution: Build up an array of possible addr values for given inputs and check all possible outputs
                                        -- If all possible outputs are equal then that output should appear!

                                               CASE I0 IS
                                                 WHEN '0'    => poss_addrs0 := (0|2|4|6|8|10|12|14 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs0 := (1|3|5|7|9|11|13|15 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs0 := (OTHERS => '1');
                                               END CASE;
                                               CASE I1 IS
                                                 WHEN '0'    => poss_addrs1 := (0|1|4|5|8|9|12|13 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs1 := (2|3|6|7|10|11|14|15 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs1 := (OTHERS => '1');
                                               END CASE;
                                               CASE I2 IS
                                                 WHEN '0'    => poss_addrs2 := (0|1|2|3|8|9|10|11 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs2 := (4|5|6|7|12|13|14|15 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs2 := (OTHERS => '1');
                                               END CASE;
                                               CASE I3 IS
                                                 WHEN '0'    => poss_addrs3 := (0|1|2|3|4|5|6|7 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs3 := (8|9|10|11|12|13|14|15 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs3 := (OTHERS => '1');
                                               END CASE;
                                        -- Now gather all the addresses which are possible
                                               FOR i IN 0 TO 15 LOOP
                                                 IF(poss_addrs0(i) = '1' AND poss_addrs1(i) = '1' AND poss_addrs2(i) = '1' AND poss_addrs3(i) = '1') THEN
                                                   poss_addrs_combined(i) := '1';
                                                 ELSE
                                                   poss_addrs_combined(i) := '0';
                                                 END IF;
                                               END LOOP;
                                        -- Now find the first possible address and the initsig at that address
                                               i := 0;
                                               WHILE poss_addrs_combined(i) /= '1' LOOP
                                                 i := i + 1;
                                               END LOOP;
                                        -- i is the lowest possible address
                                               tmpsig := init4sig(i);
                                               j      := i;
                                        -- now check all the other possible addresses
                                               FOR i IN j+1 TO 15 LOOP
                                                 IF poss_addrs_combined(i) = '1' THEN
                                                   IF(tmpsig /= init4sig(i)) THEN
                                                     tmpsig := 'X';
                                                   END IF;
                                                 END IF;
                                               END LOOP;
                                               lut_out <= tmpsig;        
                                             ELSE
                                               addr := to_integer(UNSIGNED('0' & addr_slv));
                                               lut_out    <= init4sig(addr) AFTER 1 ns;
                                             END IF;
                                             WAIT ON I0, I1, I2, I3;
                                           END PROCESS;
                                         END GENERATE gen_fourinput_behv;

                                        -- Assign output signal to the port
                                         o <= lut_out;
                                         
                                       END behavioral;


