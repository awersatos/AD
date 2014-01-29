-- $Id: xcc_utils_v9_1.vhd,v 1.7 2008/09/08 19:36:39 akennedy Exp $
-------------------------------------------------------------------------------
--  Copyright(C) 1995-2006 by Xilinx, Inc. All rights reserved.
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
-------------------------------------------------------------------------------
--LIBRARY IEEE;
--USE IEEE.std_logic_1164.ALL;
--
--LIBRARY std;
--USE std.standard.ALL;
package xcc_utils_v9_1 is

  function sel_lines_reqd (
    p_width : integer)
    return integer;

end xcc_utils_v9_1;

package body xcc_utils_v9_1 is

  -- purpose: Returns the number of mux address lines needed to address a bus of the width input. Log2 rounded up
  --Note: deliberately returns 1 for width = 1 or 0, so that exception code is
  --not required for extremely small buses
  function sel_lines_reqd (
    p_width : integer)
    return integer is
    variable ret_val : integer := 0;
    variable max_bus : integer := 0;
  begin  -- sel_lines_reqd
    assert p_width >= 0 report "Illegal (negative) value input to sel_lines_reqd (xcc_utils)" severity ERROR;
    ret_val := 1;
    max_bus := 2;
    while ret_val < 1000 loop
      if max_bus >= p_width then
        return ret_val;
      end if;
      ret_val := ret_val +1;
      max_bus := max_bus + max_bus;     --*2, but + should be faster to execute.      
    end loop;
    return ret_val;                         --unnecessary, but silences an xst warning
  end sel_lines_reqd;

end xcc_utils_v9_1;
