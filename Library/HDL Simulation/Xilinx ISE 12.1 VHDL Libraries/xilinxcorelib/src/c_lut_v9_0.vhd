-- $RCSfile: c_lut_v9_0.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:36:47 $
--------------------------------------------------------------------------------
--  Copyright(C) 2006 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2006 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 9.0
--  \   \        Filename: c_lut_v9_0.vhd 
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
USE xilinxcorelib.prims_constants_v9_0.ALL;
USE xilinxcorelib.prims_utils_v9_0.ALL;
USE Xilinxcorelib.pkg_baseblox_v9_0.ALL;

-- c_enable_rlocs is an integer here as CoreGen cannot handle Boolean generics

ENTITY c_lut_v9_0 IS
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
    i4 : IN  STD_LOGIC := '0';  -- Rainier support
    i5 : IN  STD_LOGIC := '0';  -- Rainier support
    o  : OUT STD_LOGIC
    );
END c_lut_v9_0;

ARCHITECTURE behavioral OF c_lut_v9_0 IS

--  CONSTANT device_family : T_DEVICE_FAMILY := fn_check_family(c_family);

-- purpose: Determines from the eqn string if a LUT4, LUT5 or LUT6 is to be modelled
  FUNCTION fn_get_lut_size_from_eqn(equation : STRING) RETURN INTEGER IS
    VARIABLE ret_val : INTEGER := 4;  -- default is a LUT4
  BEGIN  -- FUNCTION fn_get_lut_size_from_eqn
    
    FOR i IN 1 to equation'length LOOP
      IF equation(i) = '5' AND (equation(i-1) = 'I' OR equation(i-1) = 'i') THEN
        --ASSERT false REPORT "LUT6 behaviour" SEVERITY note;
        ret_val := 6;
        EXIT;
      END IF;
    END LOOP;  -- i

    IF ret_val /= 6 THEN  -- strings I5 or i5 not found - look for I4 or i4
      FOR i IN 1 to equation'length LOOP
        IF equation(i) = '4' AND (equation(i-1) = 'I' OR equation(i-1) = 'i') THEN
          ret_val := 5;
          --ASSERT false REPORT "LUT5 behaviour" SEVERITY note;
          EXIT;
        END IF;
      END LOOP;  -- i  
    END IF;

    IF ret_val /= 5 AND ret_val /= 6 THEN  -- Virtex-4, Spartan-3E and older devices 
      --ASSERT false REPORT "LUT4 behaviour" SEVERITY note;
    END IF;

    RETURN ret_val;
    
  END FUNCTION fn_get_lut_size_from_eqn;

  -- purpose: Returns a typical device name for a particular LUT size
  -- LUT4 - Virtex2
  -- LUT5 - Virtex5/Rainier
  -- LUT6 - Virtex5/Rainier
  -- Replaces the c_family that is present on the synthesisable model
  FUNCTION fn_get_family_from_lut_size(lut_size : integer) RETURN T_DEVICE_FAMILY IS
  BEGIN  -- FUNCTION fn_get_family_from_lut_size
    CASE lut_size IS
      WHEN 4 =>
        RETURN VIRTEX2;
      WHEN 5 | 6 =>
        RETURN VIRTEX5;
      WHEN OTHERS =>
        ASSERT false REPORT "invalid lut_size caught in c_lut_v9_0 behv model" SEVERITY failure;
        RETURN VIRTEX2;
    END CASE;
  END FUNCTION fn_get_family_from_lut_size;

  CONSTANT local_lut_size : INTEGER         := fn_get_lut_size_from_eqn(eqn);
  CONSTANT device_family  : T_DEVICE_FAMILY := fn_get_family_from_lut_size(local_lut_size);

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
        WHEN 5 =>  -- allow '4' but not '5' for the Rainier LUT
          CASE tmpchr IS
            WHEN 'i' | 'I' | '0' | '1' | '2' | '3' | '4' | '(' | ')' | '~' | '*' | '@' | '+' | ' ' | ht | cr | nul =>
              --null;                     -- these chars are OK -  do nothing
            WHEN OTHERS                                                                                            =>
              ASSERT false REPORT "ERROR: Illegal character in LUT5 equation string" SEVERITY failure;
              ASSERT false REPORT "Character" & tmpchr SEVERITY failure;
              RETURN 0;  -- return a default value to keep compiler happy - never used
          END CASE;
        WHEN 6 =>  -- allow '4' and '5' for the Rainier LUT
          CASE tmpchr IS
            WHEN 'i' | 'I' | '0' | '1' | '2' | '3' | '4' | '5' | '(' | ')' | '~' | '*' | '@' | '+' | ' ' | ht | cr | nul =>
              --null;                     -- these chars are OK -  do nothing
            WHEN OTHERS                                                                                                  =>
              ASSERT false REPORT "ERROR: Illegal character in LUT6 equation string" SEVERITY failure;
              ASSERT false REPORT "Character" & tmpchr SEVERITY failure;
              RETURN 0;  -- return a default value to keep compiler happy - never used
          END CASE;
        WHEN OTHERS => ASSERT false REPORT "ERROR: Illegal lut_size_value detected in checkEQN in c_lut_v9_0" SEVERITY failure;
      END CASE;
    END LOOP char_loop;
    RETURN 1;  -- indicate successful completion
  END checkEQN;

-- purpose: Determines from the eqn string if the Rainier LUT is to be a LUT5 or a LUT6
  FUNCTION fn_get_lut_size_from_eqn(family : T_DEVICE_FAMILY; equation : STRING) RETURN INTEGER IS
    VARIABLE ret_val : INTEGER := 4;  -- default is a LUT4
  BEGIN  -- FUNCTION fn_get_lut_size_from_eqn
    CASE family IS
      WHEN VIRTEX5 =>
        FOR i IN 1 to equation'length LOOP
          IF equation(i) = '5' AND (equation(i-1) = 'I' OR equation(i-1) = 'i') THEN
            ret_val := 6;
            EXIT;
          END IF;
        END LOOP;  -- i
        IF ret_val /= 6 THEN  -- strings I5 or i5 not found - look for I4 or i4
          FOR i IN 1 to equation'length LOOP
            IF equation(i) = '4' AND (equation(i-1) = 'I' OR equation(i-1) = 'i') THEN
              ret_val := 5;
              EXIT;
            END IF;
          END LOOP;  -- i  
        END IF;
        RETURN ret_val;
      WHEN OTHERS =>  -- Virtex-4, Spartan-3E and older devices
        RETURN ret_val;
    END CASE;
    RETURN ret_val;
  END FUNCTION fn_get_lut_size_from_eqn;

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
                  REPORT("c_lut_v9_0 - Missing port number in LUT4 equation : " & eqn)
                  SEVERITY failure;
                RETURN "";
              END IF;
            ELSIF lut_size = 5 THEN
              IF (tok /= '0' AND tok /= '1' AND
                  tok /= '2' AND tok /= '3' AND
                  tok /= '4') THEN
                ASSERT(false)
                  REPORT("c_lut_v9_0 - Missing port number in LUT5 equation : " & eqn)
                  SEVERITY failure;
                RETURN "";
              END IF;
            ELSIF lut_size = 6 THEN
              IF (tok /= '0' AND tok /= '1' AND
                  tok /= '2' AND tok /= '3' AND
                  tok /= '4' and tok /= '5') THEN
                ASSERT(false)
                  REPORT("c_lut_v9_0 - Missing port number in LUT6 equation : " & eqn)
                  SEVERITY failure;
                RETURN "";
              END IF;
            ELSE
              ASSERT false REPORT "ERROR: c_lut_v9_0 - Illegal value detected for lut_ports in postfixeqn" SEVERITY failure;
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
            REPORT("c_lut_v9_0 - Missing opening parenthesis in LUT equation : " & eqn)
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
                      REPORT("c_lut_v9_0 - Missing opening parenthesis in LUT equation : " & eqn)
                      SEVERITY failure;
                    RETURN "";
                  END IF;
                  END LOOP;
                  ELSIF (tok /= ' ' AND tok /= ht AND
                         tok /= cr AND tok /= lf AND
                         tok /= nul) THEN
                    ASSERT (false)
                      REPORT("c_lut_v9_0 - Illegal character in Eqn string : " & tok)
                      SEVERITY failure;
                    RETURN "";
                  END IF;
                  i := i + 1;
                  END LOOP cloop;
                  WHILE tempi > 0 LOOP
                    if temp(tempi) = '(' then 
                                         assert false
                                           REPORT("c_lut_v9_0 - Missing closing parenthesis in Eqn : " & eqn )
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
                                             WHEN '4' =>  -- Added for rainier support
                                               stacki        := stacki + 1;
                                               stack(stacki) := addr_slv(4);
                                             WHEN '5' =>  -- Added for rainier support
                                               stacki        := stacki + 1;
                                               stack(stacki) := addr_slv(5);
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
                                       
                                       CONSTANT lut_size : INTEGER := fn_get_lut_size_from_eqn(device_family, eqn);

                                       SIGNAL init4sig : STD_LOGIC_VECTOR(15 DOWNTO 0);
                                       SIGNAL init5sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
                                       SIGNAL init6sig : STD_LOGIC_VECTOR(63 DOWNTO 0);
                                       SIGNAL once    : STD_LOGIC := '0';

                                       SIGNAL lut_out : STD_LOGIC := '0';

                                       CONSTANT eqn_i : STRING := eqn;
                                       
                                       BEGIN  -- architecture

                                         ASSERT c_init = 0 REPORT "ERROR: c_init generic is not used in version 9 - initialisation by integer is disabled" SEVERITY failure;

                                         gen_fourinput_behv : IF lut_size = 4 GENERATE
                                           one : PROCESS
                                             VARIABLE init4eqn : STD_LOGIC_VECTOR(15 DOWNTO 0);
                                           BEGIN
                                             IF(once = '0') THEN
                                               IF (eqn_i'length = 0) THEN
                                                 ASSERT false REPORT "ERROR: No LUT eqn specified" SEVERITY failure;
--                                                 ASSERT c_init /= 0
--                                                   REPORT ("Constant 0 output. Use c_init or c_eqn generics to set xlut function.")
--                                                   SEVERITY warning;
--                                                 init4sig <= STD_LOGIC_VECTOR(to_unsigned(c_init, 16));
                                               ELSE
--                                                 ASSERT c_init = 0
--                                                   REPORT ("Both c_eqn and c_init generics set. Using c_eqn.")
--                                                   SEVERITY warning;
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

                                         gen_fiveinput_behv : IF lut_size = 5 GENERATE
                                           one : PROCESS
                                             VARIABLE init5eqn : STD_LOGIC_VECTOR(31 DOWNTO 0);
                                           BEGIN
                                             IF(once = '0') THEN
                                               IF (eqn_i'length = 0) THEN
                                                 ASSERT false REPORT "ERROR: No LUT eqn specified" SEVERITY failure;
                                               ELSE
                                                 ASSERT checkEQN(eqn_i, lut_size) = 1
                                                   REPORT "ERROR: Invalid characters found in eqn string"
                                                   SEVERITY failure;
                                                 init5eqn := pfeqn2init(postfixeqn(eqn_i, lut_size), lut_size);
                                                 ASSERT NOT Is_X(init5eqn)
                                                   SEVERITY failure;
                                                 init5sig <= init5eqn;
                                               END IF;
                                               once <= '1';
                                             END IF;
                                             WAIT;
                                           END PROCESS one;

                                           p : PROCESS
                                             VARIABLE addr_slv            : STD_LOGIC_VECTOR(4 DOWNTO 0);
                                             VARIABLE addr                : INTEGER RANGE 0 TO 31;
                                             VARIABLE poss_addrs0         : STD_LOGIC_VECTOR(0 TO 31) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs1         : STD_LOGIC_VECTOR(0 TO 31) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs2         : STD_LOGIC_VECTOR(0 TO 31) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs3         : STD_LOGIC_VECTOR(0 TO 31) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs4         : STD_LOGIC_VECTOR(0 TO 31) := (OTHERS => '0');  -- '0' signals impossible address    
                                             VARIABLE poss_addrs_combined : STD_LOGIC_VECTOR(0 TO 31) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE tmpsig              : STD_LOGIC                 := '0';
                                             VARIABLE i, j                : INTEGER;
                                           BEGIN
                                             IF(once = '0') THEN
                                               WAIT ON init5sig;
                                             END IF;
                                             addr_slv := (I4, I3, I2, I1, I0);
                                             IF((I0 /= '1' AND I0 /= '0') OR
                                                (I1 /= '1' AND I1 /= '0') OR
                                                (I2 /= '1' AND I2 /= '0') OR
                                                (I3 /= '1' AND I3 /= '0') OR
                                                (I4 /= '1' AND I4 /= '0')) THEN
                                        -- pessimistically, the output should be 'X' but imagine an OR gate with any one input = 1 for example!
                                        -- O <= 'X' after 1 ns;

                                        -- Realistic solution: Build up an array of possible addr values for given inputs and check all possible outputs
                                        -- If all possible outputs are equal then that output should appear!

                                               CASE I0 IS
                                                 WHEN '0'    => poss_addrs0 := (0|2|4|6|8|10|12|14|16|18|20|22|24|26|28|30 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs0 := (1|3|5|7|9|11|13|15|17|19|21|23|25|27|29|31 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs0 := (OTHERS => '1');
                                               END CASE;
                                               CASE I1 IS
                                                 WHEN '0'    => poss_addrs1 := (0|1|4|5|8 |9 |12|13|16|17|20|21|24|25|28|29 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs1 := (2|3|6|7|10|11|14|15|18|19|22|23|26|27|30|31 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs1 := (OTHERS => '1');
                                               END CASE;
                                               CASE I2 IS
                                                 WHEN '0'    => poss_addrs2 := (0|1|2|3|8 |9 |10|11|16|17|18|19|24|25|26|27 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs2 := (4|5|6|7|12|13|14|15|20|21|22|23|28|29|30|31 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs2 := (OTHERS => '1');
                                               END CASE;
                                               CASE I3 IS
                                                 WHEN '0'    => poss_addrs3 := (0|1| 2|3 |4 |5 |6 |7 |16|17|18|19|20|21|22|23 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs3 := (8|9|10|11|12|13|14|15|24|25|26|27|28|29|30|31 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs3 := (OTHERS => '1');
                                               END CASE;
                                               CASE I4 IS
                                                 WHEN '0'    => poss_addrs4 := (0 |1 |2 |3 |4 |5 |6 |7 |8 |9 |10|11|12|13|14|15 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs4 := (16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs4 := (OTHERS => '1');
                                               END CASE;
                                        -- Now gather all the addresses which are possible
                                               FOR i IN 0 TO 31 LOOP
                                                 IF(poss_addrs0(i) = '1' AND poss_addrs1(i) = '1' AND poss_addrs2(i) = '1' AND poss_addrs3(i) = '1' AND poss_addrs4(i) = '1') THEN
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
                                               tmpsig := init5sig(i);
                                               j      := i;
                                        -- now check all the other possible addresses
                                               FOR i IN j+1 TO 31 LOOP
                                                 IF poss_addrs_combined(i) = '1' THEN
                                                   IF(tmpsig /= init5sig(i)) THEN
                                                     tmpsig := 'X';
                                                   END IF;
                                                 END IF;
                                               END LOOP;
                                               lut_out <= tmpsig;        
                                             ELSE
                                               addr := to_integer(UNSIGNED('0' & addr_slv));
                                               lut_out    <= init5sig(addr) AFTER 1 ns;
                                             END IF;
                                             WAIT ON I0, I1, I2, I3, I4;
                                           END PROCESS;
                                         END GENERATE gen_fiveinput_behv;
                                         
                                         gen_sixinput_behv : IF lut_size = 6 GENERATE
                                           one : PROCESS
                                             VARIABLE init6eqn : STD_LOGIC_VECTOR(63 DOWNTO 0);
                                           BEGIN
                                             IF(once = '0') THEN
                                               IF (eqn_i'length = 0) THEN
                                                 ASSERT false REPORT "ERROR: No LUT eqn specified" SEVERITY failure;
                                               ELSE
                                                 ASSERT checkEQN(eqn_i, lut_size) = 1
                                                   REPORT "ERROR: Invalid characters found in eqn string"
                                                   SEVERITY failure;
                                                 init6eqn := pfeqn2init(postfixeqn(eqn_i, lut_size), lut_size);
                                                 ASSERT NOT Is_X(init6eqn)
                                                   SEVERITY failure;
                                                 init6sig <= init6eqn;
                                               END IF;
                                               once <= '1';
                                             END IF;
                                             WAIT;
                                           END PROCESS one;

                                           p : PROCESS
                                             VARIABLE addr_slv            : STD_LOGIC_VECTOR(5 DOWNTO 0);
                                             VARIABLE addr                : INTEGER RANGE 0 TO 63;
                                             VARIABLE poss_addrs0         : STD_LOGIC_VECTOR(0 TO 63) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs1         : STD_LOGIC_VECTOR(0 TO 63) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs2         : STD_LOGIC_VECTOR(0 TO 63) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs3         : STD_LOGIC_VECTOR(0 TO 63) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs4         : STD_LOGIC_VECTOR(0 TO 63) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE poss_addrs5         : STD_LOGIC_VECTOR(0 TO 63) := (OTHERS => '0');  -- '0' signals impossible address      
                                             VARIABLE poss_addrs_combined : STD_LOGIC_VECTOR(0 TO 63) := (OTHERS => '0');  -- '0' signals impossible address
                                             VARIABLE tmpsig              : STD_LOGIC                 := '0';
                                             VARIABLE i, j                : INTEGER;
                                           BEGIN
                                             IF(once = '0') THEN
                                               WAIT ON init6sig;
                                             END IF;
                                             addr_slv := (I5, I4, I3, I2, I1, I0);
                                             IF((I0 /= '1' AND I0 /= '0') OR
                                                (I1 /= '1' AND I1 /= '0') OR
                                                (I2 /= '1' AND I2 /= '0') OR
                                                (I3 /= '1' AND I3 /= '0') OR
                                                (I4 /= '1' AND I4 /= '0') OR
                                                (I5 /= '1' AND I5 /= '0')) THEN
                                        -- pessimistically, the output should be 'X' but imagine an OR gate with any one input = 1 for example!
                                        -- O <= 'X' after 1 ns;

                                        -- Realistic solution: Build up an array of possible addr values for given inputs and check all possible outputs
                                        -- If all possible outputs are equal then that output should appear!

                                               CASE I0 IS
                                                 WHEN '0'    => poss_addrs0 := (0|2|4|6|8|10|12|14|16|18|20|22|24|26|28|30|32|34|36|38|40|42|44|46|48|50|52|54|56|58|60|62 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs0 := (1|3|5|7|9|11|13|15|17|19|21|23|25|27|29|31|33|35|37|39|41|43|45|47|49|51|53|55|57|59|61|63 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs0 := (OTHERS => '1');
                                               END CASE;
                                               CASE I1 IS
                                                 WHEN '0'    => poss_addrs1 := (0|1|4|5|8 |9 |12|13|16|17|20|21|24|25|28|29|32|33|36|37|40|41|44|45|48|49|52|53|56|57|60|61 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs1 := (2|3|6|7|10|11|14|15|18|19|22|23|26|27|30|31|34|35|38|39|42|43|46|47|50|51|54|55|58|59|62|63 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs1 := (OTHERS => '1');
                                               END CASE;
                                               CASE I2 IS
                                                 WHEN '0'    => poss_addrs2 := (0|1|2|3|8 |9 |10|11|16|17|18|19|24|25|26|27|32|33|34|35|40|41|42|43|48|49|50|51|56|57|58|59 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs2 := (4|5|6|7|12|13|14|15|20|21|22|23|28|29|30|31|36|37|38|39|44|45|46|47|52|53|54|55|60|61|62|63 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs2 := (OTHERS => '1');
                                               END CASE;
                                               CASE I3 IS
                                                 WHEN '0'    => poss_addrs3 := (0|1| 2|3 |4 |5 |6 |7 |16|17|18|19|20|21|22|23|32|33|34|35|36|37|38|39|48|49|50|51|52|53|54|55 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs3 := (8|9|10|11|12|13|14|15|24|25|26|27|28|29|30|31|40|41|42|43|44|45|46|47|56|57|58|59|60|61|62|63 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs3 := (OTHERS => '1');
                                               END CASE;
                                               CASE I4 IS
                                                 WHEN '0'    => poss_addrs4 := (0 |1 |2 |3 |4 |5 |6 |7 |8 |9 |10|11|12|13|14|15|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs4 := (16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs4 := (OTHERS => '1');
                                               END CASE;
                                               CASE I5 IS
                                                 WHEN '0'    => poss_addrs5 := (0 |1 |2 |3 |4 |5 |6 |7 |8 |9 |10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31 => '1', OTHERS => '0');
                                                 WHEN '1'    => poss_addrs5 := (32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63 => '1', OTHERS => '0');
                                                 WHEN OTHERS => poss_addrs5 := (OTHERS => '1');
                                               END CASE;
                                        -- Now gather all the addresses which are possible
                                               FOR i IN 0 TO 63 LOOP
                                                 IF(poss_addrs0(i) = '1' AND poss_addrs1(i) = '1' AND poss_addrs2(i) = '1' AND poss_addrs3(i) = '1' AND poss_addrs4(i) = '1' AND poss_addrs5(i) = '1') THEN
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
                                               tmpsig := init6sig(i);
                                               j      := i;
                                        -- now check all the other possible addresses
                                               FOR i IN j+1 TO 63 LOOP
                                                 IF poss_addrs_combined(i) = '1' THEN
                                                   IF(tmpsig /= init6sig(i)) THEN
                                                     tmpsig := 'X';
                                                   END IF;
                                                 END IF;
                                               END LOOP;
                                               lut_out <= tmpsig;        
                                             ELSE
                                               addr := to_integer(UNSIGNED('0' & addr_slv));
                                               lut_out    <= init6sig(addr) AFTER 1 ns;
                                             END IF;
                                             WAIT ON I0, I1, I2, I3, I4, I5;
                                           END PROCESS;
                                         END GENERATE gen_sixinput_behv;

                                        -- Assign output signal to the port
                                         o <= lut_out;
                                         
                                       END behavioral;


