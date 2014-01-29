-- $RCSfile: c_lut_v8_0_xst.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:53 $
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
--  \   \        Filename: c_lut_v8_0_xst.vhd 
--  /   /        
-- /___/   /\    
-- \   \  /  \
--  \___\/\___\
-- 
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY Xilinxcorelib;
USE xilinxcorelib.c_lut_v8_0_comp.ALL;

-- c_family is not required as CoreGen removes it from the parameters on elaboration
-- c_enable_rlocs has changed to an integer as CoreGen does not support Boolean generics

ENTITY c_lut_v8_0_xst IS
  GENERIC (
    c_family       : STRING  := "virtex2";
    eqn            : STRING  := "I0*I1*I2*I3";  -- Function of the LUT as an equation
    c_init         : INTEGER := 0;  -- Function of the LUT as a decimal integer of the INIT string - deprecated
    c_enable_rlocs : BOOLEAN := false
    );
  PORT(i0 : IN  STD_LOGIC;
       i1 : IN  STD_LOGIC := '0';
       i2 : IN  STD_LOGIC := '0';
       i3 : IN  STD_LOGIC := '0';
       o  : OUT STD_LOGIC
       );
END c_lut_v8_0_xst;

ARCHITECTURE behavioural OF c_lut_v8_0_xst IS

  FUNCTION bool_to_int (c_enable_rlocs : BOOLEAN) RETURN INTEGER IS
  BEGIN  -- FUNCTION bool_to_int
    CASE c_enable_rlocs IS
      WHEN true   => RETURN 1;
      WHEN false  => RETURN 0;
      WHEN OTHERS => RETURN 0;
    END CASE;
  END FUNCTION bool_to_int;

  CONSTANT enable_rlocs : INTEGER := bool_to_int(c_enable_rlocs);

BEGIN
  i_behv : c_lut_v8_0
    GENERIC MAP(
      eqn            => eqn ,
      c_init         => c_init,
      c_enable_rlocs => enable_rlocs
      )
    PORT MAP(
      i0 => i0,
      i1 => i1,
      i2 => i2,
      i3 => i3,
      o  => o
      );
END behavioural;


